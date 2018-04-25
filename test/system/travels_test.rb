# frozen_string_literal: true

require 'application_system_test_case'

class TravelsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers


  test 'visiting the index' do
    time_sheet = time_sheets(:one)
    visit time_sheet_travels_path(time_sheet)
    find('.btn', text: 'ADD TRAVEL').click
    fill_in 'travel_od_start', with: 4
    fill_in 'travel_od_finish', with: 5
    find('input[name="commit"]').click


  end
end
