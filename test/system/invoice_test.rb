# frozen_string_literal: true

require 'application_system_test_case'

class InvoiceTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  test 'blank  invoice' do
    user = users(:usersone)
    # visit root_path
    visit("/invoices.#{user.id}")
    find_link(href: '/invoices/new').click
    find('input[name="commit"]').click
    page.driver.browser.switch_to.alert.accept

    # find('li', text: 'My Invoices').click
  end

  test 'valid  invoice' do

    user = users(:usersone)

    visit root_path
    sleep 1
    # find_link(href: "/current_day/#{Date.today}").click
    # find('a.add_fields').click
    # first('input', class: 'hours-field').set(5)
    # first('textarea', class: 'description-field').set('this is the description')
    # find('input[name="commit"]').click
    find('li', text: 'My Invoices').click
    find('.btn' , text: 'NEW INVOICE').click
    # find_link(href: '/invoices/new').click
    assert_current_path '/invoices/new'
    find('select').click
    find('option', text: 'PROJECTTWO').click
    find('select').click
    find('option', text: 'PROJECTONE').click
    find('input[name="commit"]').click
    page.driver.browser.switch_to.alert.accept
    find('button', text: 'DOWNLOAD INVOICE').click
    sleep 1

  end
end
