# frozen_string_literal: true

require 'application_system_test_case'
class RootTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  test 'root page' do
    user = users(:usersone)
    visit root_path
    find('li', text: 'My Projects').click
    assert_current_path "/projects"
    find('li', text: 'My Timesheets').click
    assert_current_path "/time_sheets.#{user.id}"
    find('li', text: 'My Invoices').click
    assert_current_path "/invoices.#{user.id}"
    find('li', text: 'My Customers').click
    assert_current_path '/customers'
    find('li', text: 'My Users').click
    assert_current_path '/users'
    find('li', text: 'Chat Rooms').click
    assert_current_path '/chatrooms'
  end
end
