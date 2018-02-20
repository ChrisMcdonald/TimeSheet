# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  test 'pay rate valid' do
    pay = pay_rates(:one)
    assert pay.valid?
  end

  test 'weekly pay calculation' do
    # hours = 40
    # pay = pay_rates(:one)
    # user = users(:one)
    #
    # holiday = pay.holiday
    # superannation = pay.superannuation
    # pay_rate = user.rate
    #
    # income = hours * rate
    assert_equal 4027.0, Payg.new(38_400.0).calucate_tax
  end
end
