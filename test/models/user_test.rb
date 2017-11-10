require 'test_helper'

class UserTest < ActiveSupport::TestCase
	test 'should return pay rate' do
		user = User.first
		assert_equal 2,user.rate(Date.yesterday)
	end

	test 'should be admin' do
		user = User.first
		user.add_role :admin
		result = user.has_role? :admin
		assert_equal true, result
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
		user = User.first
		pararr = Array.new
		time_sheet = 	TimeSheet.joins(works: :project)
							.select('works.hour',:project_id, :id, :user_id, :time_period)
							.where(user_id: self.id)


		time_sheet.each do |t|
			pay = t.hour * t.user.rate(t.time_period)
			pararr << { date:t.time_period,pay: pay,project: t.project_id}
		end
		pararr

	end





end
