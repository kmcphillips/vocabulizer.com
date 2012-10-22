source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'mysql2'
gem 'json'
gem 'jquery-rails'
gem 'capistrano'
gem 'haml'
gem 'haml-rails'
gem 'sass'
gem 'kaminari'
gem 'devise'

# Datasources
gem 'wordnik'
gem 'urban_dictionary', '0.0.2'  # This is fragile because it parses the web interface HTML, but they don't have an official API.

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'

  gem 'execjs'
  gem 'therubyracer'
  gem 'barista'
end

group :development, :test do
  gem 'thin'
  gem 'rspec', '>= 2.0.0'
  gem 'rspec-rails', '>= 2.0.0'
  gem 'spork'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'haml-rails'
  gem 'awesome_print'
  gem 'pry'
  gem 'pry-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'quiet_assets'
end

group :linux do
  gem 'rb-inotify'
end
