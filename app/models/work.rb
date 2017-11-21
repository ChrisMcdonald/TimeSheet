class Work < ApplicationRecord
	belongs_to :time_sheet
	belongs_to :project
	belongs_to :invoice
	resourcify
	validates_presence_of :hour

	def self.total_hours_for_project(project_id)
		self.where(project_id: project_id).sum(:hour)
	end

	def self.uninvoiced_work(project_id)

		self.select(:hour, :id, :time_sheet_id)
			.where('works.project_id = ?', project_id).where('works.invoice_id IS ?', nil)
	end


end

