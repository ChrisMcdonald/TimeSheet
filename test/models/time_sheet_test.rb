require 'test_helper'

class TimeSheetTest < ActiveSupport::TestCase

	test 'valid time_sheet' do
		time_sheet = TimeSheet.first
		time_sheet.user = User.first
		assert time_sheet.valid?
	end

	test 'has time sheet' do
		user = users(:one)
		assert TimeSheet.has_time_sheet(Date.today, user)
	end

	test 'time sheet has work' do

		# assert ap Work.joins(:time_sheet).where('time_sheets.time_period = ?', Time.now).exists?
		time = Time.now
		assert  ap Work.joins(:time_sheet)
					   .where('time_sheets.time_period = ?',Date.today)
					   .where('time_sheets.user_id =?',1).exists?
	end
	# test 'show project and hours for day' do
	# 	time = TimeSheet.find_by(time_period: Time.now)
	# 	# ap time.projects
	# 	# time.each do |t|
	# 	# 	ap t.project
	# 	# end
	# end
end
