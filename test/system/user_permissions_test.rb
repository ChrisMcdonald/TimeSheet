# frozen_string_literal: true

require 'application_system_test_case'
class UserPermissionTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  CHROME_DRIVER = if ENV['HEADLESS']
                    :selenium_chrome_headless
                  else
                    :selenium_chrome
          end
  setup do
    user = users(:one)
    sign_in user

    @routes = Rails.application.routes
  end
  after do
    Warden.test_reset!
  end
  test 'user no permission' do
    user = users(:one)
    user.add_role(:read, TimeSheet)
    user.add_role(:read, User)
    user.add_role(:edit, User)
    user.save!
    # user2 = users(:two)
    visit user_path(user)
    find('.btn', text: 'USER PERMISSION').click

    sleep 1
    assert user.has_role? :edit, User
    assert_not user.has_role? :read, Project
    assert_not user.has_role? :edit, Project
    assert_not user.has_role? :edit, TimeSheet
    assert_not user.has_role? :read, Customer
    assert_not user.has_role? :edit, Customer
    assert_not user.has_role? :read, Invoice
    assert_not user.has_role? :edit, Invoice
    assert_not user.has_role? :read, Travel
    assert_not user.has_role? :edit, Travel
    assert_not user.has_role? :read, User::PayObligation
    assert_not user.has_role? :edit, User::PayObligation
    page.check 'User_edit'
    page.check 'User_read'
    page.check 'Project_edit'
    page.check 'Project_read'
    page.check 'Customer_read'
    page.check 'Customer_edit'
    page.check 'Invoice_read'
    page.check 'Invoice_edit'
    page.check 'TimeSheet_read'
    page.check 'TimeSheet_edit'
    page.check 'Travel_read'
    page.check 'Travel_edit'
    page.check 'User::PayObligation_read'
    page.check 'User::PayObligation_edit'
    find('input[name="commit"]').click
    sleep 1

    assert user.has_role? :read, User
    assert user.has_role? :edit, User
    assert user.has_role? :read, Project
    assert user.has_role? :edit, Project
    assert user.has_role? :read, TimeSheet
    assert user.has_role? :edit, TimeSheet
    assert user.has_role? :read, Customer
    assert user.has_role? :edit, Customer
    assert user.has_role? :read, Invoice
    assert user.has_role? :edit, Invoice
    assert user.has_role? :read, Travel
    assert user.has_role? :edit, Travel
    assert user.has_role? :read, User::PayObligation
    assert user.has_role? :edit, User::PayObligation
  end

  test 'user full permissions' do
    user = users(:one)
    user.add_role :admin
    visit root_path
    menu_button = find('.btn', text: 'MENU')
    assert menu_button
    sleep 1
  end

  test 'user no permission path' do
    user = users(:two)
    user.add_role(:read, TimeSheet)
    # user2 = users(:two)

    # visit user_path(User.second)
    # assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit root_path
    sleep 1
    visit projects_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')

    visit edit_project_path(Project.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')

    visit new_project_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit project_path(Project.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')

    visit invoices_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit new_invoice_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit invoice_path(Invoice.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')

    visit works_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit edit_work_path(Work.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit new_work_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit work_path(Work.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')

    # visit pay_rates_path
    # assert_selector('h1', text: 'You are not authorized to access this web page.')
    # visit edit_pay_rate_path(PayRate.first)
    # assert_selector('h1', text: 'You are not authorized to access this web page.')
    # visit new_pay_rate_path
    # assert_selector('h1', text: 'You are not authorized to access this web page.')
    # visit pay_rate_path(PayRate.first)
    # assert_selector('h1', text: 'You are not authorized to access this web page.')

    visit customers_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit edit_customer_path(Customer.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit new_customer_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit customer_path(Customer.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit customer_details_path(Customer.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')

    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit edit_user_path(User.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit new_user_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit user_path(User.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')

    visit travels_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit edit_travel_path(Travel.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit new_travel_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit travel_path(Travel.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')

    visit user_pay_obligations_path User.first
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit edit_user_pay_obligation_path(User.first, User::PayObligation.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit new_user_pay_obligation_path User.first
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit user_pay_obligation_path(User.first, User::PayObligation.first)
    assert_selector('h1', text: 'You are not authorized to access this web page.')
  end
  test 'user with no permission redirected to 401' do
    text = 'You are not authorized to access this web page.'
    user = User.new
    user.remove_role(TimeSheet)
    sign_out(user)
    visit root_path
    visit root_path
    page.all('h1', text: text)
  end
end
