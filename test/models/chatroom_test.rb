require "test_helper"

describe Chatroom do
  let(:chatroom) {Chatroom.new}

  it "must be valid" do
    value(chatroom).must_be :valid?
  end
end
