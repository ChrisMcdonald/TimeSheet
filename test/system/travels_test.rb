# frozen_string_literal: true

require 'application_system_test_case'

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

  test 'visiting the index' do
    time_sheet = time_sheets(:one)
    visit time_sheet_travels_path(time_sheet)
    find('.btn', text: 'ADD TRAVEL').click
    fill_in 'travel_od_start' , with: 4
    fill_in 'travel_od_finish', with: 5
    sleep 1
    find('input[name="commit"]').click
    sleep 1
    sleep 1

  end
end
