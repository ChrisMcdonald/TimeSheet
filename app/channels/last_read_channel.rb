# frozen_string_literal: true

class LastReadChannel < ApplicationCable::Channel
  def subscribed
    current_user.chatrooms.each do |chatroom|
      stream_from "chatrooms:#{chatroom.id}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def update(data)
    chatroom_user = current_user.chatroom_users.find_by(chatroom_id: data['chatroom_id'])
    chatroom_user.update(last_read_at: Time.zone.now)
  end

  def send_animation(data)
    # chatroom_user = ChatroomUser.where(data['chatroom_id'])

    SendAnimationJob.perform_later(data)
  end
end
