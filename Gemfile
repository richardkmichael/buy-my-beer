source 'http://rubygems.org'

# Core
gem 'rails', '3.1'
gem 'pg'  # Heroku. Do they override config/database.yml?

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

# Development and test only.
gem 'rails-footnotes', '>= 3.7', :group => :development

# Continue using sqlite3 in development and test for now.
group :development, :test do
  gem 'sqlite3'
  gem 'minitest-rails'
  gem 'minitest'
  gem 'cucumber-rails'
end

group :test do
  gem 'turn', :require => false
  gem 'capybara'
  gem 'guard-minitest'
  gem 'growl_notify'
  gem 'rb-fsevent'
  gem 'database_cleaner'
end
