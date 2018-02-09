# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should return pay rate' do
    user = User.first
    assert_equal 2, user.rate(Date.yesterday)
  end

  test 'should be admin' do
    user = User.first
    user.add_role :admin
    result = user.has_role? :admin
    assert_equal true, result
  end

  test 'user work table' do
    @user = users(:one)
    @user.add_role :admin
    @user_table = @user.time_work
    @user_table = @user_table.filter_buy_date Date.yesterday, Date.tomorrow

    # @user_table = @user_table.where(time_sheet: {time_period: Date.yesterday..Date.tomorrow}) if params[:start_date] && params[:end_date]
    ap @user_table
  end

  test 'user tax'

  test 'user super '

  test 'user total income' do
    user = users(:one)
    work = user.works.includes(:project)
    work.each do |w|
      puts Project.find w.project_id
      puts w.time_sheet.time_period
    end
  end

  test 'user total income ' do
    user = User.first
    pay = user.total_pay(user.pay_for_user)
  end

  test 'pay user all projects ' do
    user = User.first
    arr = user.pay_for_user
  end

  test 'project select' do
    user_arr = []
    user = User.first
    arr = user.pay_per_project(2)
    user_arr
  end

  test 'pay per project' do
    user = User.first
    pararr = []
    time_sheet =	TimeSheet.joins(works: :project)
                          .select('works.hour', :project_id, :id, :user_id, :time_period)
                          .where(user_id: id)

    time_sheet.each do |t|
      pay = t.hour * t.user.rate(t.time_period)
      pararr << { date: t.time_period, pay: pay, project: t.project_id }
    end
    pararr
  end
end
