class MyCalendar
	class SimpleCalendar::BusinessWeekCalendar < SimpleCalendar::Calendar

		def timesheet_param
			options.fetch(:timesheet_param, :timesheet).to_sym
		end

		def start_date
			if options.has_key?(:timesheet)
				options.fetch(:timesheet)
			else
				view_context.params.fetch(start_date_param, Date.current).to_date
			end
		end
		private

		def date_range
			(start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week).to_a
		end
	end
end