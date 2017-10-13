# require 'test_helper'
#
# class InvoicesControllerTest < ActionDispatch::IntegrationTest
# 	include Devise::Test::IntegrationHelpers
# 	include Warden::Test::Helpers
#   setup do
# 	  sign_in users(:one)
# 	  @user = users(:one)
# 	  @invoice = Invoice.new
# 	  @customer = Customer.first
#   end
#
#   test "should get index" do
#     get invoices_url
#     assert_response :success
#   end
#
#   test "should get new" do
#     get new_invoice_url
#     assert_response :success
#   end
#
#   test "should create invoice" do
#     assert_difference('Invoice.count') do
#       post invoices_url, params: { invoice: { id: @invoice.id } }
#     end
#
#     assert_redirected_to invoice_url(Invoice.last)
#   end
#
#   test "should show invoice" do
#     get invoice_url(@invoice)
#     assert_response :success
#   end
#
#   test "should get edit" do
#     get edit_invoice_url(@invoice)
#     assert_response :success
#   end
#
#   test "should update invoice" do
#     patch invoice_url(@invoice), params: { invoice: { id: @invoice.id } }
#     assert_redirected_to invoice_url(@invoice)
#   end
#
#   test "should destroy invoice" do
#     assert_difference('Invoice.count', -1) do
#       delete invoice_url(@invoice)
#     end
#
#     assert_redirected_to invoices_url
#   end
# end
