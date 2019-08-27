# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '>= 4.0.x'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-passenger'
gem 'capistrano-rvm'
gem 'capistrano-sidekiq'

# recommended security updates
gem 'loofah', '>= 2.2.3'
gem 'rack', '>= 2.0.6'

# monitoring, etc
gem 'skylight'
gem 'sentry-raven'

# my gems
gem 'administrate'
gem 'administrate-field-shrine', github: 'haiafara/administrate-field-shrine'
gem 'aws-sdk-s3'
gem 'devise'
gem 'friendly_id', '~> 5.2.0'
gem 'fast_jsonapi'
gem 'image_processing', '~> 1.0'
gem 'rgeo-geojson'
gem 'sitemap_generator'
gem 'sidekiq'
gem 'shrine'

gem 'underpass'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 3.8'
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 5.0'
  gem 'pry'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop'
  gem 'rubocop-rails'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  # gem 'chromedriver-helper'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'codacy-coverage', require: false
  gem 'shrine-memory'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'activerecord-postgis-adapter'
