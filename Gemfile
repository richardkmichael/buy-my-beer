source 'http://rubygems.org'

# Core
gem 'rails', '3.1.0.rc4'
gem 'pg'  # Heroku: They override config/database.yml ?

# Asset template engines
gem 'jquery-rails'
gem 'coffee-script'
gem 'uglifier'
gem 'sass-rails', "~> 3.1.0.rc"
gem 'haml'

# Authentication
gem 'devise'
gem 'omniauth'  # Can I require only oauth?  Rip out OpenID, all the XML stuff, etc.?

# Deployment
gem 'heroku'

# Continue using sqlite3 in development and test for now.
group :development, :test do
  gem 'sqlite3'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end