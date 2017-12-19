require "test_helper"

class VehicleTest < ActiveSupport::TestCase

  test 'is a valid vehicle' do
    vehicle = vehicles(:one)
    assert vehicle.valid?
  end
end
