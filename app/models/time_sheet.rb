class TimeSheet < ApplicationRecord

	include Calculate


	belongs_to :user
  has_many :works, inverse_of: :time_sheet, dependent: :destroy
	accepts_nested_attributes_for :works,
								  allow_destroy: true
  validates_presence_of :time_period



  def self.to_csv(options={})
	  CSV.generate(options) do |csv|
		  csv << ['user_name' ,'date Worked' , 'hours','rate']
		  all.each do |p|
			  csv << [p.user.full_name , p.time_period, p.hour ,p.user.rate(p.time_period),]
		  end
	  end
  end

	def self.has_time_sheet(day,user)
		Work.joins(:time_sheet).where('time_sheets.time_period = ?',day).where('time_sheets.user_id =?', user).exists?
	end


end
