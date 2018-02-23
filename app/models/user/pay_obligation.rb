class User::PayObligation < ApplicationRecord
  belongs_to :user
  resourcify

  def calculate
    superannuation = self.superannuation / 100
    holiday = self.holiday / 100
    gross = self.hourly_rate
    percentage = 0.0
    percentage +=   gross * holiday
    percentage +=   gross * superannuation
    gross +=  percentage
    gross
  end
end
