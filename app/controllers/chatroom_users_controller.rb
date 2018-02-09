# frozen_string_literal: true

class ChatroomUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom

  def create
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).first_or_create
    redirect_to @chatroom
  end

  def destroy
    @chatroom_user = @chatroom.chatroom_users.where(user_id: current_user.id).destroy_all
    redirect_to chatrooms_path
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end

  def chatroom_params
    params.require(:chatroom_users).permit(:id, :user_id, :chatroom_id)
  end
end
