require "test_helper"

describe ChatRoomUser do
  let(:chatroom_user) {ChatRoomUser.new}

  it "must be valid" do
    value(chat_room_user).must_be :valid?
  end
end
