require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
	test 'customer to be valid' do
		customer = customers(:one)
		assert customer.valid?
	end
end
