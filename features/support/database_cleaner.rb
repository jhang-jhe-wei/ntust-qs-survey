begin
  DatabaseCleaner.clean_with :truncation, except: %w[ntust_departments]
  DatabaseCleaner.strategy = :transaction
  Around do |scenario, block|
    DatabaseCleaner.cleaning(&block)
  end
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end
