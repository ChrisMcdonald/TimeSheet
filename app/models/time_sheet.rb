class TimeSheet < ApplicationRecord
  belongs_to :user
  has_many :works, inverse_of: :time_sheets, dependent: :destroy
	accepts_nested_attributes_for :works,
								  allow_destroy: true
  has_many :projects
  validates_presence_of :time_period


  def self.to_csv(options={})
	  CSV.generate(options) do |csv|
		  csv << ['user_name' ,'date Worked' , 'hours']
		  all.each do |p|
			  p.works.each do |w|
			  @hour = w.hour
			end
			  csv << [p.user.full_name , p.time_period, @hour ]
		  end
	  end
  end

end
