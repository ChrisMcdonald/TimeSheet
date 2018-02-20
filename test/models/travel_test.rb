# frozen_string_literal: true

require 'test_helper'

class TravelTest < ActiveSupport::TestCase
  test 'all travel' do
    travel = Travel.all
    assert_equal 2, travel.count
  end

  test 'travel for vehicle' do
    vehicle = vehicles(:one)
    assert vehicle.valid?
  end

  test 'odometer validation' do
    travel = Travel.new(od_start: 5, od_finish: 6, vehicle: vehicles(:one), time_sheet: time_sheets(:one))
    travel2 = Travel.new(od_start: 5, od_finish: 6, vehicle: vehicles(:one), time_sheet: time_sheets(:one))
    assert(travel.save!)
    assert_raises ActiveRecord::RecordInvalid do
      travel2.save!
    end

    # assert travel.valid?
  end

  test 'od_start should be greater that previous od_finish' do
    travel = Travel.last
    pre = travel.previous_od_finish
    ap pre
    ap travel.od_finish
  end
end
