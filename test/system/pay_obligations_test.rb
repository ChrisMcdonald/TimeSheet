require 'application_system_test_case'
class PayObligationsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers


  test 'pay obligation' do
    user = users(:usersone)

    visit user_pay_obligations_path @user.id
    assert_current_path "/users/#{@user.id}/pay_obligations"
    find('.btn', text: 'NEW PAY RATE').click

    fill_in 'user_pay_obligation[superannuation]', with: 9.5
    fill_in 'user_pay_obligation[hourly_rate]', with: 9.5
    fill_in 'user_pay_obligation[holiday]', with: 9.5
    find('input[name="commit"]').click
    first('.fa-edit').click


    fill_in 'user_pay_obligation[superannuation]', with: 9.5
    fill_in 'user_pay_obligation[hourly_rate]', with: 9.5
    fill_in 'user_pay_obligation[holiday]', with: 9.5
    find('input[name="commit"]').click
    # first('.fa-trash').click

    find('.btn', text: 'NEW PAY RATE').click
    find('input[name="commit"]').click
    find('h2', text: '3 errors prohibited this users_pay_obligation from being saved:')

    visit user_pay_obligations_path @user.id
    first('.fa-edit').click
    fill_in 'user_pay_obligation[superannuation]', with: ''

    fill_in 'user_pay_obligation[hourly_rate]', with: ''
    fill_in 'user_pay_obligation[holiday]', with: ''
    find('input[name="commit"]').click
    sleep 1
    # find('h2', text:'3 errors prohibited this users_pay_obligation from being saved:')

  end

end
