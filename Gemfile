source 'http://rubygems.org'

# Core
gem 'rails'#, '3.1'
gem 'pg'  # For Heroku. Do they override config/database.yml?

# Asset template engines
gem 'jquery-rails'
gem 'haml-rails'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

# Authentication
gem 'devise', '1.5.0.rc1'
gem 'omniauth'
gem 'omniauth-github'

# Deployment
gem 'heroku'

# Development only.
group :development do
  gem 'rails-footnotes'
  gem 'growl_notify'
  gem 'pry'
  gem 'gist'
end

# Development and test.
group :development, :test do
  gem 'rb-fsevent'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'sqlite3'
  gem 'minitest'
  gem 'guard-minitest'
  gem 'cucumber-rails'
end
