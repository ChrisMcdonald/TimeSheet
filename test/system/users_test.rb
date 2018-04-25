# frozen_string_literal: true

require 'application_system_test_case'
class UsersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  test 'user income ' do
    visit user_path(@user)
    find('.btn', text: 'USER INCOME').click
    fill_in 'start_date', with: 1.week.ago.to_s
    fill_in 'end_date', with: Date.tomorrow.to_s
    find('.btn', text: 'SEARCH').click

  end

  test 'create a new User' do
    visit users_path

    find('#new-project').click
    within('#NewProject') do
      fill_in 'user_first_name', with: 'bob'
      fill_in 'user_email', with: 'bob2@email.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      fill_in 'user_last_name', with: 'smith'
      fill_in 'user_street_no', with: 1
      fill_in 'user_street', with: 'street'
      fill_in 'user_state', with: 'state'
      fill_in 'user_city', with: 'city'
      fill_in 'user_country', with: 'country'
      fill_in 'user_post_code', with: 4000
      fill_in 'user_abn', with: 1_223_456
    end
    find('.btn', text: 'ADD PAY RATE').click
    find('.pay_rate').set(24)
    # find(".create-user").click
    find('input', class: 'create-user').click

  end
end
