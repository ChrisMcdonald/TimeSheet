require 'test_helper'

class InvoiceRowsControllerTest < ActionDispatch::IntegrationTest
	include Devise::Test::IntegrationHelpers
	include Warden::Test::Helpers
  setup do
	  sign_in users(:one)
    @invoice_row = invoice_rows(:one)
  end


end
