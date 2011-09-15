source 'http://rubygems.org'

# Core
gem 'rails', '3.1'
gem 'pg'  # For Heroku. Do they override config/database.yml?

# Asset template engines
gem 'jquery-rails'
gem 'haml-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

# Authentication
gem 'devise'
gem 'omniauth'

# Deployment
gem 'heroku'

# Development only.
gem 'rails-footnotes', '>= 3.7', :group => :development

# Continue using sqlite3 in development and test for now.
group :development, :test do
  gem 'sqlite3'
  gem 'minitest'
  gem 'guard-minitest'
  gem 'mini_specunit'
  gem 'cucumber-rails'
  gem 'pry'
  gem 'gist'
end

group :test do
  gem 'turn', :require => false
  gem 'capybara'
  gem 'growl_notify'
  gem 'rb-fsevent'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end
