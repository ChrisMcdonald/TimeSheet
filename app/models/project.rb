class Project < ApplicationRecord
	# has_many :invoices belongs_to :time_sheet
	attr_accessor :start_date, :end_date
	has_many :works, dependent: :destroy
	belongs_to :customer
	belongs_to :user
	has_many :pay_rates, dependent: :destroy



	def self.select_attributes
		result = Array.new
		Project.all.select(:id, :name).each do |p|

			result.append([p.name, p.id])
		end
		result
	end

	def time_sheets_for_week(start_time, end_time)
		TimeSheet.where(time_period: start_time..end_time)
			.joins(:works).select('works.hour', :user_id, :time_period, :id)
			.where('works.project_id = ?', self.id)
	end

	def sum_time_sheet(time_sheet)
		time_sheet.sum(:hour)
	end

	def hours_by_user_by_project
		TimeSheet.select(:id, :user_id).group(:user_id).joins(:works).where(works: {project_id: self.id}).select(:hour).sum(:hour)
	end

	def hours_by_date_range(start_time, end_time)
		TimeSheet.where(time_period: start_time..end_time).joins(:works).group(:time_period).where('works.project_id = ?', self.id).sum(:hour)
	end

	def hours_by_day
		TimeSheet.joins(:works).group(:time_period).where('works.project_id = ?', self.id).sum(:hour)
	end


	def all_time_sheets
		TimeSheet.joins(:works).select('works.hour', :id, :user_id, :time_period)
			.where('works.project_id = ?', self.id)
	end

	def info_for_invoice
		time = TimeSheet.joins(:works).select(:id)
				   .where('works.project_id = ?', self.id)
	end

	def info_for_invoice_range(start_time, end_time)
		TimeSheet.where(time_period: start_time..end_time)
			.joins(:works).group(:time_period)
			.where('works.project_id = ?', self.id)
			.sum(:hour)
	end

	def total_for_users(time)
		total = Array.new
		time.each do |t|
			puts t.time_period.to_datetime
			rate =  t.user.rate(t.time_period.to_date)
			puts " #{rate} here"
			total << rate * t.hour
			puts total
		end
		total
	end

	def total(row_totals)
		row_totals.inject(0) {|sum, x| sum + x}
	end

end
