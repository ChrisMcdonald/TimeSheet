source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem 'awesome_print'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'devise'
gem 'redis'
gem 'carrierwave'
gem "pundit"
gem "breadcrumbs_on_rails"
gem 'groupdate'
gem "chartkick"
gem 'active_median'
gem "simple_calendar"
gem 'wkhtmltopdf-binary'
gem 'wicked_pdf'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'
gem 'rubyzip'
gem 'axlsx'
gem 'axlsx_rails'
gem 'remotipart'
gem 'cancancan'
gem 'rolify'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.1.3'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'will_paginate'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'simple_form'

gem 'capistrano-rbenv'
gem 'capistrano'
gem 'capistrano-rails'
gem 'capistrano-passenger'
gem 'capistrano-rails-console'
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  # gem 'figaro'

end

group :development  do
	gem 'capistrano-rbenv'
	gem 'capistrano'
	gem 'capistrano-rails'
	gem 'capistrano-passenger'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
	gem 'web-console'
	gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
	gem 'spring-watcher-listen'
  gem "minitest-rails"

end

group :test do
	gem 'faker'
	gem 'sqlite3'
	gem 'simplecov'
	gem 'capybara'
	gem 'selenium-webdriver'
	gem 'capybara-puma'


end
group :assets do

	gem 'uglifier'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
