class Project < ApplicationRecord
	# has_many :invoices
	belongs_to :time_sheet
	
	def self.to_csv(options={})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |p|
				csv << p.attributes.values_at(*column_names)
			end
		end
	end
	def self.select_attributes
		result = Array.new
		Project.all.select(:id,:name).each do |p|

			result.append([p.name,p.id])
		end
		result
	end


	def time_sheets_for_week
		TimeSheet.group(:user_id, 'time_sheets.id')
			.joins(:works).where('works.project_id = ?', self.id)
			.where(time_period: Time.now.beginning_of_week..Time.now.end_of_week)
	end

	def sum_time_sheet( time_sheet)
		sum = 0
		time_sheet.each do |t|
			t.works.each do |w|
				sum +=w.hour
			end

		end
		sum
	end
	def hours_by_user_by_project
		TimeSheet.select(:user_id).group(:user_id).joins(:works).where(works: {project_id: self.id}).select(:hour).sum(:hour)
	end

	def hours_by_day
		 TimeSheet.joins(:works).group(:time_period).where('works.project_id = ?', self.id).sum(:hour)
	end


end
