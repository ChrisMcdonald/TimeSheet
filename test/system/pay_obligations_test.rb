
require 'application_system_test_case'
class PayObligationTest < ApplicationSystemTestCase
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

  test 'pay obligation' do
    visit user_pay_obligations_path @user.id
    find('.btn', text: 'NEW PAY RATE').click

    fill_in 'user_pay_obligation[superannuation]',with: 9.5
    fill_in 'user_pay_obligation[hourly_rate]',with: 9.5
    fill_in 'user_pay_obligation[holiday]',with: 9.5
    find('input[name="commit"]').click
    first('.fa-edit').click


    fill_in 'user_pay_obligation[superannuation]',with: 9.5
    fill_in 'user_pay_obligation[hourly_rate]',with: 9.5
    fill_in 'user_pay_obligation[holiday]',with: 9.5
    find('input[name="commit"]').click
    first('.fa-trash').click

    find('.btn', text: 'NEW PAY RATE').click
    sleep 1
    find('input[name="commit"]').click
    find('h2', text:'3 errors prohibited this users_pay_obligation from being saved:')

    visit user_pay_obligations_path @user.id
    first('.fa-edit').click
    sleep 1
    fill_in 'user_pay_obligation[superannuation]',with: ''

    fill_in 'user_pay_obligation[hourly_rate]',with: ''
    fill_in 'user_pay_obligation[holiday]',with: ''
    find('input[name="commit"]').click
    find('h2', text:'3 errors prohibited this users_pay_obligation from being saved:')
    sleep 0.5
    sleep 0.5
  end

end
