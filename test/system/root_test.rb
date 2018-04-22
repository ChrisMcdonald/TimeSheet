# frozen_string_literal: true

require 'application_system_test_case'
class RootTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  setup do
    user = users(:one)
    user.add_role :admin
    sign_in user
    @routes = Rails.application.routes
  end
  after do
    Warden.test_reset!
  end
  test 'root page' do
    user = users(:one)
    visit root_path
    find_link(href: "/invoices.#{user.id}").click
    find_link(href: '/projects').click
    find_link(href: '/customers').click
    find_link(href: '/users').click
    find_link(href: "/time_sheets.#{user.id}").click

  end
end
