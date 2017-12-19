require "test_helper"

class TravelTest < ActiveSupport::TestCase

  test 'all travel' do
    travel = Travel.all
    assert_equal 2, travel.count
  end

  test 'travel for vehicle' do
    vehicle = vehicles(:one)
    assert vehicle.valid?
    ap vehicle.travels

  end

  test 'odometer validation' do
    travel = Travel.new(od_start: 5, od_finish: 6, vehicle: vehicles(:one), time_sheet: time_sheets(:one))
    travel2 = Travel.new(od_start: 5, od_finish: 6, vehicle: vehicles(:one), time_sheet: time_sheets(:one))
    ap travel.previous_od_finish
    ap travel.save!
    ap travel2.save!

    # assert travel.valid?
  end

  test 'od_start should be greater that previous od_finish' do
    travel = Travel.last
    pre = travel.previous_od_finish
    ap pre
    ap travel.od_finish

  end


end