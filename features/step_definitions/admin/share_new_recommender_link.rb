# frozen_string_literal: true

When('I can see new recommender link') do
  expect(page).to have_text(%r{https?://.*/recommenders/new\?user_token=#{@user.token}})
end
