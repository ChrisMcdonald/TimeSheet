class MessageBroadcastJob < ApplicationJob
	queue_as :default

	def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}", {
        username: message.user.full_name,
        message_id: message.id,
        body: message.body,
        avatar: message.user.avatar,
        message: MessagesController.render(message),
        chatroom_id: message.chatroom.id
    }
	end

	private

	def render_message(message)
		MessagesController.render partial: 'messages/message', locals: {message: message}
	end
end