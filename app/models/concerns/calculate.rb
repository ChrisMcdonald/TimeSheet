module Calculate
	extend ActiveSupport::Concern

	def all_time_sheets(project_id)
		TimeSheet.joins(:works).select('works.hour', :id, :user_id, :time_period, :invoice_id)
			.where('works.project_id = ?', project_id)
	end

	def sum_time_sheet(time_sheet)
		time_sheet.sum(:hour)
	end
	def total_for_users(time)
		total = Array.new
		time.each do |t|
			rate =  t.user.rate(t.time_period.to_date)
			total << rate * t.hour
		end
		total
	end

	def total(row_totals)
		row_totals.inject(0) {|sum, x| sum + x}
	end

end