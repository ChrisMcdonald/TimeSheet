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
    sign_in user
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
  end

  test 'user full permissions' do
    user = users(:one)
    user.add_role :admin
    sign_in user
    visit root_path
    menu_button = find('.btn', text: 'MENU')
    assert menu_button
    sleep 1
  end

  test 'user no permission path' do
    user = users(:two)
    user.add_role(:read, TimeSheet)
    # user2 = users(:two)
    sign_in user
    # visit user_path(User.second)
    # assert_current_path('/')

    visit projects_path
    assert_selector('h1', text: 'You are not authorized to access this web page.')
    visit edit_project_path(Project.first)
    assert_current_path('/')
    assert_matches_selector('h1', text: 'You are not authorized to access this web page.')

    visit new_project_path
    assert_current_path('/')
    visit project_path(Project.first)
    assert_current_path('/')

    visit invoices_path
    assert_current_path('/')
    visit new_invoice_path
    assert_current_path('/')
    visit invoice_path(Invoice.first)
    assert_current_path('/')

    visit works_path
    assert_current_path('/')
    visit edit_work_path(Work.first)
    assert_current_path('/')
    visit new_work_path
    assert_current_path('/')
    visit work_path(Work.first)
    assert_current_path('/')

    visit pay_rates_path
    assert_current_path('/')
    visit edit_pay_rate_path(PayRate.first)
    assert_current_path('/')
    visit new_pay_rate_path
    assert_current_path('/')
    visit pay_rate_path(PayRate.first)
    assert_current_path('/')

    visit customers_path
    assert_current_path('/')
    visit edit_customer_path(Customer.first)
    assert_current_path('/')
    visit new_customer_path
    assert_current_path('/')
    visit customer_path(Customer.first)
    assert_current_path('/')
    visit customer_details_path(Customer.first)
    assert_current_path('/')

    assert_current_path('/')
    visit edit_user_path(User.first)
    assert_current_path('/')
    visit new_user_path
    assert_current_path('/')
    visit user_path(User.first)
    assert_current_path('/')

    visit travels_path
    assert_current_path('/')
    visit edit_travel_path(Travel.first)
    assert_current_path('/')
    visit new_travel_path
    assert_current_path('/')
    visit travel_path(Travel.first)
    assert_current_path('/')
  end
  test 'user with no permission redirected to 401' do
    text = 'You are not authorized to access this web page.'
    user = User.new
    user.remove_role(TimeSheet)
    sign_out(user)
    visit root_path
    sign_in user
    visit root_path
    page.all('h1', text: text)

  end
end
