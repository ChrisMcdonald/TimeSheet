# frozen_string_literal: true

module Calculate
  extend ActiveSupport::Concern

  def sum_time_sheet(time_sheet)
    time_sheet.sum(:hour)
  end

  def total_for_users(work)
    total = []
    work.each do |w|
      rate = w.user.rate(w.time_period.to_date)
      rate = 0.0 unless rate.present?
      total << w.hour * rate rescue 0
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
