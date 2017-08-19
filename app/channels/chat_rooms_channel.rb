class ChatRoomsChannel < ApplicationCable::Channel

	 # identified_by :current_user

	def subscribed
		stream_from "chat_rooms_#{params['chat_room_id']}_channel"
	end

	def unsubscribed
		# Any cleanup needed when channel is unsubscribed
	end

	def send_message(data)
		current_user.messages << Message.create(message: data['message'], project_id: data['chat_room_id'])
	end
end