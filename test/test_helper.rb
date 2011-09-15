require "minitest/autorun"
#require "minitest/rails"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'database_cleaner'
DatabaseCleaner.strategy = :transaction
DatabaseCleaner.clean_with(:truncation)

#class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
#  fixtures :all

  # Add more helper methods to be used by all tests here...
#end
