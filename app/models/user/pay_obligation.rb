class User::PayObligation < ApplicationRecord
  belongs_to :user
  resourcify

  def calculate
    superannuation = self.superannuation / 10
    holiday = self.holiday / 10
    charge_out_rate = self.hourly_rate
    charge_out_rate +=   charge_out_rate * holiday
    charge_out_rate +=   charge_out_rate * superannuation
    charge_out_rate
  end
end
