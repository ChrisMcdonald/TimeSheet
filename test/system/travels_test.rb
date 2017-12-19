require "application_system_test_case"

class TravelsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  setup do
    @user = users(:one)
    @user.add_role :admin
    sign_in @user
    @routes = Rails.application.routes

  end
  after do
    Warden.test_reset!
  end

  test "visiting the index" do
    visit travels_url

  end
end
