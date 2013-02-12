ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
end

require "mocha"  # becomes "mocha/setup" when updated to 0.13.x or higher.
