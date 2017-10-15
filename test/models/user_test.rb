require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test 'should return pay rate' do
		user = User.first
		assert_equal 2,user.rate(Date.yesterday)
	end
end
