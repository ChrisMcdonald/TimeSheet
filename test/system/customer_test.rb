# frozen_string_literal: true

require 'application_system_test_case'
class CustomerTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  test 'create a new customer' do
    user = users(:usersone)

    visit customers_path

    find('#new-project').click
    within('#NewProject') do
      fill_in 'customer_first_name', with: 'bob'
      fill_in 'customer_last_name', with: 'smith'
      fill_in 'customer_street_no', with: 1
      fill_in 'customer_street', with: 'street'
      fill_in 'customer_state', with: 'state'
      fill_in 'customer_city', with: 'city'
      fill_in 'customer_country', with: 'country'
      fill_in 'customer_post_code', with: 4000
      fill_in 'customer_abn', with: 1_223_456
    end

    find('input[name="commit"]').click
  end
end
