class SendAnimationJob < ApplicationJob
  queue_as :default

  def perform(message)
    ap message["chatroom_id"]
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
