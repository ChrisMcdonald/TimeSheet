# frozen_string_literal: true

source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end
gem 'rails', '6.0.0'
ruby '2.6.3'
gem 'rack'
gem 'figaro'
gem 'active_median'
gem 'autoprefixer-rails'
gem 'axlsx'
# gem 'axlsx', git: 'https://github.com/randym/axlsx.git', ref: 'c8ac844'
# gem 'axlsx_rails'
gem 'bootstrap-sass'
gem 'breadcrumbs_on_rails'
gem 'cancancan'
gem 'carrierwave'
gem 'chartkick'
gem 'devise'
gem 'font-awesome-rails'
gem 'groupdate'
gem 'loofah'
gem 'nokogiri'
gem 'oj'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-twitter'
gem 'pdfkit'
gem 'pundit'
gem 'remotipart'
gem 'rolify'
gem 'rubyzip', '~> 2.0'
gem 'sass-rails'
gem 'simple_calendar'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'zip-zip'
gem 'webpacker'

# gem "uniform_notifier"
# gem 'honeybadger'
# gem 'airbrake'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.4'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer', platforms: :ruby
# gem 'therubyracer', platforms: :ruby
gem 'will_paginate'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.3'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'capistrano'
gem 'capistrano-passenger'
gem 'capistrano-rails'
gem 'capistrano-rails-console'
gem 'capistrano-rbenv'
gem 'loofah-activerecord'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # gem 'figaro'
  gem 'debase'
  gem 'pry'
  gem 'pry-nav'
  gem 'rubocop'
end

group :development do
  gem 'yard'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen'
  gem 'web-console'
  gem 'awesome_print'


  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring

  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem "minitest-rails-capybara"

  # gem 'capybara'
  gem 'chromedriver-helper'
  gem 'database_cleaner'
  gem 'faker'
  gem 'selenium-webdriver'
  gem 'simplecov'
  # gem 'sqlite3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
