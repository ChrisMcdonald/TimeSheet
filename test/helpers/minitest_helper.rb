require 'simplecov'
Simplecov.start

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "minitest/rails"
require "minitest/pride"
require 'database_cleaner'
require "minitest/rails/capybara"

require "minitest-mongoid"

DatabaseCleaner[:mongoid].strategy = :truncation
#OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:identity, {
	:uid => '12345'

})


class MiniTest::Spec
	before :each do
		DatabaseCleaner.start
	end

	after :each do
		DatabaseCleaner.clean
	end
end