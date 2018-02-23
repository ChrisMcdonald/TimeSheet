
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
    # sleep 0.5
    fill_in 'user_pay_obligation[superannuation]',with: 9.5
    fill_in 'user_pay_obligation[hourly_rate]',with: 9.5
    fill_in 'user_pay_obligation[holiday]',with: 9.5
    find('input[name="commit"]').click
    find('h1', text: '36.12375')
    sleep 1
    sleep 1
  end

end
