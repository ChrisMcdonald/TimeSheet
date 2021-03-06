# frozen_string_literal: true

require 'test_helper'

class WorkTest < ActiveSupport::TestCase
  test 'valid work' do
    work = works(:one)
    assert work.valid?
  end
  test 'new work is valid' do
    work = works(:one)
    work.project = Project.first
    work.time_sheet = TimeSheet.first
    assert work.valid?
  end

  test 'un invoiced work for project' do
    project = Project.first
    work = Work.select(:hour, :id, :user, :time_sheet_id)
               .where('works.project_id = ?', project.id).where('works.invoice_id IS ?', nil)
    work
  end

  test 'work between dates' do
    work_arr = []
    start_time = 2.weeks.ago
    end_time = Date.today
    time = TimeSheet.where(time_period: start_time..end_time)

    ap time
  end

  test ' all work for project' do
    work = works(:one)
    works = Project.includes(:works).find(work.id)

    works.works
  end

  # test 'work time_sheets ' do
  #   start_time = 2.weeks.ago
  #   end_time = Date.today
  #   # work = Work.first
  #   # w = Work.joins(:time_sheet_work).where(time_sheet: {time_period: start_time..end_time })
  #   Work.from(Work.with_time_sheet_work, :works).joins(:project_work).merge(Work.first)
  # end
end
