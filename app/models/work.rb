class Work < ApplicationRecord
  belongs_to :time_sheets
  # belongs_to :projects

	def self.total_hours_for_project(project_id)
		self.where(project_id: project_id).sum(:hour)
	end

end
