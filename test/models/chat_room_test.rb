require "test_helper"

describe Chatroom do
  let(:chatroom) {Chatroom.new}

  it "must be valid" do
    value(chat_room).must_be :valid?
  end
end
