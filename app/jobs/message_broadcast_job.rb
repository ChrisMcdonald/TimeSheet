# frozen_string_literal: true

class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}",
                                 message_id: message.id,
                                 message_user: message.user,
                                 message: MessagesController.render(message),
                                 chatroom_id: message.chatroom.id
  end

  private

  def render_message(message)
    MessagesController.render partial: 'messages/message', locals: { message: message }
  end
end
