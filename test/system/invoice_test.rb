# frozen_string_literal: true

require 'application_system_test_case'

class InvoiceTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  test 'blank  invoice' do

    visit root_path
    find_link(href: "/invoices.#{@user.id}").click
    find_link(href: '/invoices/new').click
    find('input[name="commit"]').click
    find_link(href: '/invoices').click
  end

  test 'valid  invoice' do


    visit root_path
    # find_link(href: "/current_day/#{Date.today}").click
    # find('a.add_fields').click
    # first('input', class: 'hours-field').set(5)
    # first('textarea', class: 'description-field').set('this is the description')
    # find('input[name="commit"]').click
    find_link(href: "/invoices.#{@user.id}").click
    find_link(href: '/invoices/new').click
    find('select').click
    find('option', text: 'PROJECTTWO').click
    find('select').click
    find('option', text: 'PROJECTONE').click
    find('input[name="commit"]').click
    find('button', text: 'DOWNLOAD INVOICE').click

  end
end
