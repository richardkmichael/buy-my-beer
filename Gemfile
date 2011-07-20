source 'http://rubygems.org'

# Core
gem 'rails', '3.1.0.rc4'
gem 'pg'  # Heroku: They override config/database.yml ?

# Asset template engines
gem 'jquery-rails'
gem 'haml-rails'
gem 'sass-rails', "~> 3.1.0.rc"

# Turn these off until Rails 3.1.0.rc5 gets execjs fixed to use node.js (available on Heroku).
# http://stackoverflow.com/questions/6075961/problem-deploying-rails-3-1-project-to-heroku-could-not-find-a-javascript-runtim/6076852#6076852
gem 'coffee-script'
gem 'uglifier', "1.0.0"

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
end
