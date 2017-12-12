class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chatroom, only: [:show, :edit, :update, :destroy]

  def index
    @chatrooms = Chatroom.all
  end

  def new
    @chatroom = Chatroom.new
  end

  def show
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)

  end


  def create
    @chatroom = current_user.chatrooms.build(chatroom_params)
    if @chatroom.save
      flash[:success] = 'Chat room added!'
      redirect_to chatrooms_path
    else
      render 'new'
    end
  end

  def destroy
    @chatroom.destroy
    redirect_to chatrooms_path
  end

  private
  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end

  def chatroom_params
    params.require(:chatroom).permit(:title)
  end
end