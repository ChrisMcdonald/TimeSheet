# frozen_string_literal: true

module Calculate
  extend ActiveSupport::Concern

  def sum_time_sheet(time_sheet)
    time_sheet.sum(:hour)
  end

  def total_for_users(work)
    total = []
    work.each do |w|
      rate = w.time_sheet.user.rate(w.time_sheet.time_period.to_date)
      total << rate * w.hour
    end
    total
  end

  def total(row_totals)
    row_totals.inject(0) { |sum, x| sum + x }
  end

  def total_hash(row_totals)
    row_totals.inject(0) { |sum, x| sum + x }
  end
end
