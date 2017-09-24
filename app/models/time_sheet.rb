class TimeSheet < ApplicationRecord
  belongs_to :user
  has_many :works, inverse_of: :time_sheets, dependent: :destroy
	accepts_nested_attributes_for :works,
								  allow_destroy: true

  validates_presence_of :time_period

end
