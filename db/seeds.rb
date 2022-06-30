# frozen_string_literal: true

Rails.logger.debug 'load seed'
Dir[Rails.root.join('db/seeds/*.rb')].each do |seed|
  load seed
end
