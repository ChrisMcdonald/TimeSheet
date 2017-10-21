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
	test 'un invoiced work for project' do
		project = Project.first
		work = Work.select(:hour, :id, :user, :time_sheet_id)
				   .where('works.project_id = ?', project.id).where('works.invoice_id IS ?' , nil)
		ap work
	end

	test 'work between dates' do
		work_arr = Array.new
		start_time = 2.weeks.ago
		end_time = Date.today
		time = TimeSheet.where(time_period: start_time..end_time)

		ap time
	end



	test 'asdf' do

		time = Project.joins(:time_sheets).where(:time_sheets => 2)

		time.each do |t|
			ap t
		end
	end


	test ' all work for project' do
		works = Project.includes(:works).find( 1)

		ap works.works
	end

	test "work time_sheets " do
		start_time = 2.weeks.ago
		end_time = Date.today
		# work = Work.first
		# w = Work.joins(:time_sheet_work).where(time_sheet: {time_period: start_time..end_time })
		ap Work.from(Work.with_time_sheet_work , :works).joins(:project_work).merge(Work.first)

	end

end
