require "test_helper"

describe ChatRoomsUser do
  let(:chat_rooms_user) {ChatRoomsUser.new}

  it "must be valid" do
    value(chat_rooms_user).must_be :valid?
  end
end
