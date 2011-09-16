require "minitest/autorun"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'database_cleaner'
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

# https://github.com/metaskills/mini_specunit/issues/1
class << ActiveSupport::TestCase
  remove_method :describe
end
