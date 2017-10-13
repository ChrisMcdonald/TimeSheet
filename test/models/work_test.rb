require 'test_helper'

class WorkTest < ActiveSupport::TestCase

	test 'valid work' do
		work = Work.first
		assert work.valid?
	end
	test 'new work is valid' do
		work = Work.new
		work.project = Project.first
		work.time_sheet = TimeSheet.first
		assert work.valid?
	end

end
