class ChatroomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @chatrooms = Chatroom.all
  end

  def new
    @chatroom = Chatroom.new
  end

  def show
    @chatroom = Chatroom.includes(:messages).find_by(id: params[:id])
    @messages = @chatroom.messages.reverse_order.limit(50)
    @message = Message.new

  end


  def create
    @chatroom = current_user.chatrooms.build(chatroom_params)
    if @chatroom.save
      flash[:success] = 'Chat room added!'

    else
      render 'new'
    end
  end

  def destroy
    @chatroom.destroy
    redirect_to chatrooms_path
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:title)
  end
end