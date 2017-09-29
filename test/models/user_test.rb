require 'test_helper'

class UserTest < ActiveSupport::TestCase

	test 'total_hour_for_project' do
		assert_equal 2, Work.total_hours_for_project(1)
	end
end
