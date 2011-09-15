require "minitest/autorun"
#require "minitest/rails"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
