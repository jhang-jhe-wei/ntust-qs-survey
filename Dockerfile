ARG APP_ROOT=/srv/app
ARG RUBY_VERSION=3.1.2
ARG NODE_VERSION=14.18
FROM ruby:${RUBY_VERSION}-alpine AS gem
ARG APP_ROOT

RUN apk add --no-cache build-base mariadb-dev git

RUN mkdir -p ${APP_ROOT}
COPY Gemfile Gemfile.lock ${APP_ROOT}/

WORKDIR ${APP_ROOT}
RUN gem install bundler:2.3.7 \
    && bundle config --local deployment 'true' \
    && bundle config --local frozen 'true' \
    && bundle config --local no-cache 'true' \
    && bundle config --local without 'development test' \
    && bundle install -j "$(getconf _NPROCESSORS_ONLN)" \
    && find ${APP_ROOT}/vendor/bundle -type f -name '*.c' -delete \
    && find ${APP_ROOT}/vendor/bundle -type f -name '*.h' -delete \
    && find ${APP_ROOT}/vendor/bundle -type f -name '*.o' -delete \
    && find ${APP_ROOT}/vendor/bundle -type f -name '*.gem' -delete

FROM node:${NODE_VERSION}-alpine as node
FROM ruby:${RUBY_VERSION}-alpine as assets
ARG APP_ROOT
ARG RAILS_MASTER_KEY

ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

RUN apk add --no-cache shared-mime-info tzdata mariadb-connector-c yarn

COPY --from=node /usr/local/bin/node /usr/local/bin/node

COPY --from=gem /usr/local/bundle/config /usr/local/bundle/config
COPY --from=gem /usr/local/bundle /usr/local/bundle
COPY --from=gem ${APP_ROOT}/vendor/bundle ${APP_ROOT}/vendor/bundle

RUN mkdir -p ${APP_ROOT}
COPY . ${APP_ROOT}

ENV RAILS_ENV production
WORKDIR ${APP_ROOT}
RUN bundle exec rake assets:precompile

FROM ruby:${RUBY_VERSION}-alpine
ARG APP_ROOT

RUN apk add --no-cache shared-mime-info tzdata mariadb-connector-c

COPY --from=gem /usr/local/bundle/config /usr/local/bundle/config
COPY --from=gem /usr/local/bundle /usr/local/bundle
COPY --from=gem ${APP_ROOT}/vendor/bundle ${APP_ROOT}/vendor/bundle

RUN mkdir -p ${APP_ROOT}

ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=yes
ENV APP_ROOT=$APP_ROOT

COPY . ${APP_ROOT}
COPY --from=assets /${APP_ROOT}/public /${APP_ROOT}/public
COPY --from=node /usr/local/bin/node /usr/local/bin/node

ARG REVISION
ENV REVISION $REVISION
RUN echo $REVISION > ${SERVER_ROOT}/REVISION

# Apply Execute Permission
RUN adduser -h ${APP_ROOT} -D -s /bin/nologin ruby ruby && \
    chown ruby:ruby ${APP_ROOT} && \
    chown -R ruby:ruby ${APP_ROOT}/log && \
    chown -R ruby:ruby ${APP_ROOT}/tmp && \
    chmod -R +r ${APP_ROOT}

USER ruby
WORKDIR ${APP_ROOT}

EXPOSE 3000
ENTRYPOINT ["bin/openbox"]
CMD ["server"]
