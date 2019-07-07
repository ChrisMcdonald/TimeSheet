# frozen_string_literal: true

class TimeSheet < ApplicationRecord
  include Calculate
  resourcify
  validates_presence_of :time_period, :hour
  has_many :travels, dependent: :destroy
  accepts_nested_attributes_for :travels, allow_destroy: true
  # has_many :works, dependent: :destroy
  belongs_to :project
  belongs_to :invoices, required: false
  # accepts_nested_attributes_for :works, allow_destroy: true, :reject_if => lambda {|a| a[:hour].blank?}
  # validates_presence_of :time_period
  belongs_to :user

  scope :date_range, ->(start_date, end_date) { where(time_period: start_date..end_date) }
  scope :for_project,->(project) { where(projects: project) }
  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['user_name', 'date Worked', 'hours', 'rate']
      all.each do |p|
        csv << [p.user.full_name, p.time_period, p.hour, p.user.rate(p.time_period)]
      end
    end
  end

  def has_invoice?
    self.invoice_id.present?
  end

  def self.uninvoiced_work(project_id)
    # select(:hour, :id, :time_sheet_id)
    where('invoice_id IS ?', nil)
  end

  def self.filter_buy_date(start_date, end_date)
    where('time_period 	BETWEEN ? AND ? ', start_date.to_s, end_date.to_s)
  end

  # def self.has_time_sheet(day, user)
  #   Work.joins(:time_sheet).where('time_sheets.time_period = ?', day).where('time_sheets.user_id =?', user).exists?
  # end

  # def has_time_sheet?
  #   # Work.joins(:time_sheet).where('time_sheets.time_period = ?', day).where('time_sheets.user_id =?', user).exists?
  #   self.present?
  # end

  def self.for_project(project)
    where(projects: project)
  end
end
