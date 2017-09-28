class TimeSheet < ApplicationRecord
  belongs_to :user
  has_many :works, inverse_of: :time_sheets, dependent: :destroy
	accepts_nested_attributes_for :works,
								  allow_destroy: true

  validates_presence_of :time_period

	def self.time_sheets_for_week(project_id)
		TimeSheet.group(:user_id, 'time_sheets.id')
			.joins(:works).where('works.project_id = ?', project_id)
			.where(time_period: Time.now.beginning_of_week..Time.now.end_of_week)
	end
	def self.hours_by_day
		self.joins(:works).group(:time_period).sum(:hour)
	end

	def self.hours_by_user_by_project(project_id)
		TimeSheet.select(:user_id).group(:user_id).joins(:works).where(works: {project_id: project_id}).select(:hour).sum(:hour)
	end

end
