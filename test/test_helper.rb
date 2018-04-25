# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"
# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

Capybara.javascript_driver = :chrome
# Capybara.asset_host = "http://earth-broken.bnr.la"
Capybara.asset_host = 'http://localhost:3001'
Capybara.default_max_wait_time = 20
# Capybara.clear_web_storage_when_clearing_session = true

# Capybara.server = :puma # Until your setup is working
Capybara.configure do |config|
  config.server = :puma
end
class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
  #
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  CHROME_DRIVER = if ENV['HEADLESS']
                    :selenium_chrome_headless
                  else
                    :selenium_chrome
                  end
  setup do


    @user = users(:one)
    @user.add_role :admin
    sign_in @user

    @routes = Rails.application.routes
  end

  after do
    reset!
    Warden.test_reset!
    DatabaseCleaner.clean_with(:truncation)
    sleep 2
  end
end
