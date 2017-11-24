require "application_system_test_case"
class CustomerTest < ApplicationSystemTestCase
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


	test 'create a new timesheet' do
		visit root_path
		find_link(href: "/current_day/#{Date.today}").click
		find('a.add_fields').click
		first('input', class: 'hours-field').set(5)
		first('textarea', class: 'description-field').set('this is the description')
		find('input[name="commit"]').click
		find_link(href: "/current_day/#{Date.tomorrow}").click
		find('a.add_fields').click
		first('input', class: 'hours-field').set(5)
		first('textarea', class: 'description-field').set('this is the description')
		find('input[name="commit"]').click
		find_link(href: "/current_day/#{Date.yesterday}").click
		find('a.add_fields').click
		first('input', class: 'hours-field').set(5)
		first('textarea', class: 'description-field').set('this is the description')
		find('input[name="commit"]').click

		find_link(href: "/invoices.#{@user.id}").click
		find_link(href: '/invoices/new').click
		sleep 1
		find('input[name="commit"]').click
		sleep 1
		find('.btn', text: 'DOWNLOAD INVOICE').click

		sleep 1

		visit user_path(@user)
		find('.btn', text: 'USER INCOME').click
		fill_in 'start_date', with: 1.week.ago.to_s
		fill_in 'end_date', with: Date.tomorrow.to_s
		find('input[name="commit"]').click
		sleep 1

		sleep 1

	end
end