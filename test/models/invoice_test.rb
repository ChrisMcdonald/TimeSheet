require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers

	test 'total for each user' do
		invoice = Invoice.first
		assert_equal [200,200],invoice.total_for_user
	end

	test 'total for invoice' do
		invoice = Invoice.first

		assert_equal 400, invoice.invoice_total(invoice.total_for_user)
	end

end
