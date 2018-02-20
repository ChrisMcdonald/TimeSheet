require "test_helper"

describe Users::PayObligation do
  let(:pay_obligation) {User::PayObligation.new}

  it "must be valid" do
    value(pay_obligation).must_be :valid?
  end
end
