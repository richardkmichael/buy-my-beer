source 'http://rubygems.org'

# Core
gem 'rails', '3.1.0.rc5'
gem 'pg'  # Heroku: They override config/database.yml ?

# Asset template engines
gem 'jquery-rails'
gem 'haml-rails'
gem 'sass-rails', '~> 3.1.0.rc'
gem 'coffee-rails', '~> 3.1.0.rc'
gem 'uglifier'

# Authentication
gem 'devise'
gem 'omniauth'  # Can I require only oauth?  Rip out OpenID, all the XML stuff, etc.?

# Deployment
gem 'heroku'

# Development and test only.
gem 'rails-footnotes', '>= 3.7', :group => :development
gem 'turn', :require => false, :group => :test

# Continue using sqlite3 in development and test for now.
group :development, :test do
  gem 'sqlite3'
  gem 'minitest-rails'
  gem 'cucumber-rails'
  gem 'autotest-rails'
  gem 'autotest-rails-pure'
  gem 'autotest-fsevent'
  gem 'autotest-growl'
end
