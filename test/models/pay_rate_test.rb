require "test_helper"

describe PayRate do
  let(:pay_rate) { PayRate.new }

  it "must be valid" do
    value(pay_rate).must_be :valid?
  end
end
