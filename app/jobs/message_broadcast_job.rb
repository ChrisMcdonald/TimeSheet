class MessageBroadcastJob < ApplicationJob
	queue_as :default


	def perform(message)
		puts message
		ActionCable.server.broadcast "chat_rooms_#{message.project_id}_channel",
									 message: render_message(message)
	end

	private

	def render_message(message)
		MessagesController.render partial: 'messages/message', locals: {message: message}
	end
end
