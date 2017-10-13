require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
	test 'time sheets for week' do
		project = Project.first
		time = project.time_sheets_for_week(2.week.ago, Time.now)
		assert_equal 1, time.first.id
		end


	test 'sum hours for week' do
		project = Project.first
		time = project.time_sheets_for_week(1.week.ago, Time.now)
		sum =  project.sum_time_sheet(time)
		assert_equal 1, sum
	end


	test 'hour_by_day by project' do
		project = Project.first
		time = project.hours_by_user_by_project
		assert_equal 1, time[1]
	end


	test 'hours by day' do
		project = Project.first
		time = project.hours_by_day
		assert_equal 1, time.count
	end

	test 'info for invoice' do
		project = Project.first
		invoice =  project.info_for_invoice
		assert_equal 1,invoice.count

	end

	def info_for_invoice_range(start_time, end_time)
		TimeSheet.where(time_period: start_time..end_time).joins(:works).group(:time_period).where('works.project_id = ?', self.id).sum(:hour)
	end

	test 'total timesheet query'do
		project = Project.first
		time = project.all_time_sheets
		assert_equal ["20.0","20.0"] , project.total_for_users(time)
	end

	test 'total cost for timesheet search ' do
		total = 0
		time_array = Array.new
		project = Project.first
		time = project.all_time_sheets
		time_array =  project.total_for_users(time)
		total = project.total(time_array)
		assert_equal 40 , total
	end


end
