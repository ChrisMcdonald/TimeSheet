# frozen_string_literal: true

require 'test_helper'

describe User::PayObligation do
  let(:pay_obligation) { User::PayObligation.new }

  it 'must be valid' do
    value(pay_obligation).must_be :valid?
  end

  it 'calculate user charge rate' do
    pay_o = User::PayObligation.first
    puts GrossPay.new(pay_o).calculate
  end
end
