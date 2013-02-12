ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # fixtures :all
  # self.use_transactional_fixtures = true   # This does not do what I expect it to do.

  DatabaseCleaner.strategy = :truncation   # Transaction does not work here either. Possibly is related to why transactional_fixtures do not work

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

end
