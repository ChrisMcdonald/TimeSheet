require "test_helper"

class ProjectTest < ActiveSupport::TestCase

	test 'pay rate valid' do
		pay = pay_rates(:one)
		assert pay.valid?
	end
end