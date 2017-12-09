class ChatroomsChannel < ApplicationCable::Channel

  # identified_by :current_user

  def subscribed
    current_user.chatrooms.each do |chatroom|
      stream_from "chatrooms:#{chatroom.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def send_message(data)
    # current_user.messages.create!(body: data['message'], chatroom_id: data['chatroom_id'])
    @chatroom = Chatroom.find(data["chatroom_id"])
    message = @chatroom.messages.create(body: data["body"], user: current_user)
    MessageBroadcastJob.perform_later(message)

    Rails.logger.info data

  end
end