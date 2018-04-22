# frozen_string_literal: true

require 'application_system_test_case'

class InvoiceTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  setup do
    user = users(:one)
    user.add_role :admin
    user.save!
    sign_in user
    @routes = Rails.application.routes
  end
  after do
    Warden.test_reset!
  end
  test 'blank  invoice' do
    user = users(:one)
    user.add_role(:admin)

    visit root_path
    find_link(href: "/invoices.#{user.id}").click
    find_link(href: '/invoices/new').click
    find('input[name="commit"]').click
    find_link(href: '/invoices').click
  end

  test 'valid  invoice' do
    user = users(:one)
    user.add_role(:admin)
    p1 = projects(:one)
    p2 = projects(:two)
    visit root_path
    # find_link(href: "/current_day/#{Date.today}").click
    # find('a.add_fields').click
    # first('input', class: 'hours-field').set(5)
    # first('textarea', class: 'description-field').set('this is the description')
    # find('input[name="commit"]').click
    find_link(href: "/invoices.#{user.id}").click
    find_link(href: '/invoices/new').click
    find('select').click
    find('option', text: 'PROJECTTWO').click
    find('select').click
    find('option', text: 'PROJECTONE').click
    find('input[name="commit"]').click
    find('button', text: 'DOWNLOAD INVOICE').click
    invoice = Invoice.last
    visit invoices_path
    find(".invoice-#{invoice.id}").click
  end
end
