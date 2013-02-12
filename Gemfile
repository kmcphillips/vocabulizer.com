source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'pg'
gem 'json'
gem 'jquery-rails'
gem 'capistrano'
gem 'haml'
gem 'haml-rails'
gem 'sass'
gem 'kaminari'
gem 'devise'
gem 'rails_config'

# Datasources
gem 'wordnik'
gem 'urban_dictionary', '0.0.2'  # This is fragile because it parses the web interface HTML, but they don't have an official API.

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'execjs'
  gem 'therubyracer'
end

group :development, :test do
  gem 'thin'
  gem 'test-unit'
  gem 'mocha', '~> 0.12.8', require: false  # Staying below 0.13.x until the deprication warnings are fixed.
  gem 'spork'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-test'
  gem 'ruby-prof'
  gem 'awesome_print'
  gem 'pry'
  gem 'pry-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'quiet_assets'
end

group :darwin do
  gem 'rb-fsevent'
  gem 'growl'
  # gem 'ruby_gntp'
  # gem 'growl_notify'
end

group :linux do
  gem 'rb-inotify', '~> 0.8.8'
  gem 'libnotify'
end
