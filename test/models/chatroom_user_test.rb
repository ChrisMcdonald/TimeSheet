# frozen_string_literal: true

require 'test_helper'

describe ChatroomUser do
  let(:chatroom_user) { ChatroomUser.new }

  it 'must be valid' do
    value(chatroom_user).must_be :valid?
  end
end
