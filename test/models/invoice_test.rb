require 'test_helper'

class InvoiceTest < ActiveSupport::TestCase
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers

	test 'invoice to be valid' do
		invoice = invoices(:one)
		assert invoice.valid?
	end

	test 'total for each user' do
		invoice = Invoice.first
		assert_equal [200,200],invoice.total_for_user
	end

	test 'total for invoice' do
		invoice = Invoice.first

		assert_equal 400, invoice.invoice_total(invoice.total_for_user)
	end

	test ' invoice show ' do
		invoice = Invoice.first
		work =  invoice.works << Work.first
		work.each do |w|
			ap w
		end
		# end
	end

	test 'all invoices for current user' do
		invoices = Invoice.all.where(user: User.first) #.paginate(:page => params[:page], :per_page => 10).reverse_order
		ap invoices
	end



end
