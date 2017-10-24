require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test 'should return pay rate' do
		user = User.first
		assert_equal 2,user.rate(Date.yesterday)
	end

	test 'user holidays' do

	end

	test 'user tax'

	test 'user super '

	test 'user total income' do
		pararr = Array.new
		user = User.first
		pararr = user.pay_for_user
	ap	pararr
	end


	test 'user total income '  do
		user = User.first
	ap	pay = user.total_pay(user.pay_for_user)

	end

	test 'pay user all projects ' do
		user = User.first
		ap arr = user.pay_for_user
	end

	test "project select" do
		user_arr = Array.new
		user = User.first
		arr = user.pay_per_project(2)
		ap user_arr
	end

	test 'pay per project' do

	end

end
