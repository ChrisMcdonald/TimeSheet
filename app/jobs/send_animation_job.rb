class SendAnimationJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message["chatroom_id"]}", {
        animation: message
    }
  end

  private
  def render_animation
    renderer=ApplicationController.renderer.new
    renderer.render(partial: 'animation')
  end
end
