# frozen_string_literal: true

require 'application_system_test_case'
class CustomerTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers

  test 'add hour ' do
    user = users(:usersone)

    visit root_path
    sleep 1
    # expect(page).to have_field("Username", with: "Joe")
    page.has_css?('.navbar')
    page.has_text?('Time Sheet')

    find('td', text: Date.today.strftime("%d %b")).click
    page.has_css?('.navbar')
    page.has_text?('Time Sheet')
    find('#time_sheet_hour', class: 'hours-field').set(5)
    find('textarea', class: 'description-field').set('this is the description')
    find('.btn', text: 'SAVE').click
    # find('input[name="commit"]').click
    assert_current_path root_path


    # end
    #
    # test 'add hours' do
    #   user = users(:usersone)
    #
    #   sign_in user
    #   visit root_path
    #   sleep 1
    # find_link(href: "/current_day/#{Date.today.iso8601}").click
    # visit("/current_day/#{Date.today.iso8601}")
    find('td', text: Date.today.strftime("%d %b")).click
    # find('.btn', text: 'TRAVEL').click
    find('.btn', text: 'ADD TRAVEL').click
    find('#travel_od_start').set(5)
    find('#travel_od_finish').set(10)
    find('input[name="commit"]').click
    # sleep 1
    # find('.btn', text: 'HOURS').click
    # find('#time_sheet_hour', class: 'hours-field').set(5)
    # find('textarea', class: 'description-field').set('this is the description')
    #
    # find('input[name="commit"]').click

    # find('td', text: Date.tomorrow.strftime("%d %b")).click

    # find('a.add_fields').click
    # find('#time_sheet_hour', class: 'hours-field').set(5)
    # find('textarea', class: 'description-field').set('this is the description')
    # find('input[name="commit"]').click
    # find_link(href: "/current_day/#{Date.yesterday.iso8601}").click
    # first('#time_sheet_works_attributes_0_hour', class: 'hours-field').set(5)
    # first('textarea', class: 'description-field').set('this is the description')
    # find('input[name="commit"]').click

    # find_link(href: "/invoices.#{@user.id}").click
    # find_link(href: '/invoices/new').click
    # sleep 1
    # find('input[name="commit"]').click
    # sleep 1
    # find('.btn', text: 'DOWNLOAD INVOICE').click
    #
    # sleep 1
  end


end
