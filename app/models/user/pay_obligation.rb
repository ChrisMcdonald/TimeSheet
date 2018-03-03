# frozen_string_literal: true

class User::PayObligation < ApplicationRecord
  resourcify
  belongs_to :user

  def calculate
    superannuation = self.superannuation / 100
    holiday = self.holiday / 100
    gross = hourly_rate
    percentage = 0.0
    percentage +=   gross * holiday
    percentage +=   gross * superannuation
    gross += percentage
    gross
  end
end
