# frozen_string_literal: true

require 'test_helper'

class TimeSheetTest < ActiveSupport::TestCase
  test 'valid time_sheet' do
    time_sheet = TimeSheet.first
    time_sheet.user = User.first
    assert time_sheet.valid?
  end

  test "timesheets for project" do
    timesheet = time_sheets(:timesheetsone)
    project = projects(:projectsone)
    timesheet_for_project = timesheet.send('for_project', project)

    assert(timesheet_for_project.count ,2)

  end

  # test 'has time sheet' do
  # 	user = users(:one)
  # 	assert TimeSheet.has_time_sheet(Date.today, user)
  # end

  # test 'show project and hours for day' do
  # 	time = TimeSheet.find_by(time_period: Time.now)
  # 	# ap time.projects
  # 	# time.each do |t|
  # 	# 	ap t.project
  # 	# end
  # end
end
