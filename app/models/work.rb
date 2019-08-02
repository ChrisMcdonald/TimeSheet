# frozen_string_literal: true

class Work < ApplicationRecord
  resourcify

  include Calculate
  belongs_to :time_sheet, dependent: :destroy
  belongs_to :project, dependent: :destroy
  belongs_to :invoice, dependent: :destroy
  validates_presence_of :hour

  def self.total_hours_for_project(project_id)
    where(project_id: project_id).sum(:hour)
  end

  def self.uninvoiced_work(project_id)
    # select(:hour, :id, :time_sheet_id)
    where('works.project_id = ?', project_id).where('works.invoice_id IS ?', nil)
  end

  def self.filter_buy_date(start_date, end_date)
    joins(:time_sheet).where('time_sheets.time_period 	BETWEEN ? AND ? ', start_date.to_s, end_date.to_s)
  end

  def has_invoice?
    invoice_id.present?
  end

end
