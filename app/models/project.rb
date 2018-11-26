# frozen_string_literal: true

class Project < ApplicationRecord
  resourcify
  include Calculate
  # has_many :invoices belongs_to :time_sheet
  attr_accessor :start_date, :end_date
  has_many :time_sheets, dependent: :destroy
  belongs_to :customer , dependent: :destroy
  belongs_to :user, dependent: :destroy


  def total_project_users(time)
    total = []
    time.each do |t|
      rate = t.user.rate(t.time_period.to_date)
      total << rate * t.hour
    end
    total
  end

  def self.select_attributes
    result = []
    project = all.select(:id, :name).order(:created_at).reverse
    project.each do |p|
      result.append([p.name, p.id, { class: 'dropdown-item overflow-hidden' }])
    end
    result
  end

  def time_sheets_for_week(start_time, end_time)
    TimeSheet.where(time_period: start_time..end_time)
             .joins(:works).select('works.hour', 'works.project_id', :user_id, :time_period, :id, :invoice_id)
             .where('works.project_id = ?', id)
  end

  def hours_by_user_by_project
    TimeSheet.select(:id, :user_id).group(:user_id).joins(:works).where(works: { project_id: id }).select(:hour).sum(:hour)
  end

  def hours_by_date_range(start_time, end_time)
    TimeSheet.where(time_period: start_time..end_time).joins(:works).group(:time_period).where('works.project_id = ?', id).sum(:hour)
  end

  def hours_by_day
    TimeSheet.joins(works: :project).group(:time_period).where('works.project_id = ?', id).sum(:hour)
  end

  def all_time_sheets
    TimeSheet.where('project_id = ?', id)
    end

  def info_for_invoice
    time = TimeSheet.joins(:works).select(:id)
                    .where('works.project_id = ?', id)
  end

  def info_for_invoice_range(start_time, end_time)
    TimeSheet.where(time_period: start_time..end_time)
             .joins(:works).group(:time_period)
             .where('works.project_id = ?', id)
             .sum(:hour)
  end
end
