# frozen_string_literal: true

class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: %i[show edit update destroy]

  def index
    @chatrooms = Chatroom.all
  end

  def new
    @chatroom = Chatroom.new
  end

  def show
    @messages = @chatroom.messages.last(20)
    @chatroom_user = current_user #.chatroom_users.find_by(chatroom_id: @chatroom.id)
  end

  def create
    @chatroom = current_user.chatrooms.build(chatroom_params)
    @chatroom_user = @chatroom.users << current_user

    if @chatroom.save
      flash[:success] = 'Chat room added!'
      respond_to do |format|
        format.html { redirect_to chatroom_path(@chatroom) }
        format.js
      end
    end
  end

  def destroy
    @chatroom.destroy
    redirect_to chatrooms_path
  end

  private

  def set_chatroom
    @chatroom = current_user.chatrooms.find(params[:id])
  end

  def chatroom_params
    params.require(:chatroom).permit(:title)
  end
end
