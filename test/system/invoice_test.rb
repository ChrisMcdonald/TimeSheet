require "application_system_test_case"

class InvoiceTest < ApplicationSystemTestCase
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
	test 'blank  invoice' do
		user = users(:one)

		visit root_path
		find_link(href: "/invoices.#{user.id}").click
		find_link(href: '/invoices/new').click
		sleep 1
		find('input[name="commit"]').click
		sleep 1
		find_link(href: '/invoices').click
		sleep 1
	end

	test 'valid  invoice' do
		user = users(:one)
		visit root_path
		find_link(href: "/current_day/#{Date.today}").click
		find('a.add_fields').click
		first('input', class: 'hours-field').set(5)
		first('textarea', class: 'description-field').set('this is the description')
		find('input[name="commit"]').click

		find_link(href: "/invoices.#{user.id}").click
		find_link(href: '/invoices/new').click
		sleep 1
		find('select', 'name=search').click
		find('option[value="2"]').click
		sleep 1
		find('select', 'name=search').click
		find('option[value="1"]').click
		sleep 1
		find('input[name="commit"]').click
		sleep 1
		find('button', text: 'DOWNLOAD INVOICE').click
		sleep 1
		invoice = Invoice.last
		visit invoices_path
		find(".invoice-#{invoice.id}").click
		sleep 1
		sleep 1
	end

end