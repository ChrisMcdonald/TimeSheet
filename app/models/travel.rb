# frozen_string_literal: true

class Travel < ApplicationRecord
  resourcify
  belongs_to :user , dependent: :destroy
  belongs_to :project , dependent: :destroy
  belongs_to :time_sheet , dependent: :destroy
  belongs_to :vehicle , dependent: :destroy

  validates_presence_of :od_finish, :od_start, :vehicle
  validate :od_start_cannot_be_greater_than_od_finish
  validate :od_start_greater_than_previous_od_finish

  def previous_od_finish
    begin
      result = self.class.where(vehicle: vehicle).last.od_finish
    rescue StandardError
      result = 0
    end
    result
  end

  private

  def od_start_greater_than_previous_od_finish
    if od_start.present? && od_finish.present?
      if od_start < previous_od_finish
        errors.add(:od_start, 'odometer start must be greater then the previous finish odometer reading')
      end
    end
  end

  def od_start_cannot_be_greater_than_od_finish
    if od_start.present? && od_finish.present?
      if od_start > od_finish
        errors.add(:od_finish, 'od finish should be greater than od start ')
      end
    end
  end
end
