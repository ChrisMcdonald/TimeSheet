class Work < ApplicationRecord
  belongs_to :time_sheet
  belongs_to :project

	def self.total_hours_for_project(project_id)
		self.where(project_id: project_id).sum(:hour)
	end

end
