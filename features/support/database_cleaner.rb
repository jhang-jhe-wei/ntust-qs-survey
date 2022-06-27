begin
  DatabaseCleaner.strategy = [:truncation, except: %w[ntust_departments countries institutions industries]]

  Before do |_|
    DatabaseCleaner.strategy = [:truncation, except: %w[ntust_departments countries institutions industries]]
  end

  After do |_|
    DatabaseCleaner.clean
  end
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end
