App.last_read = App.cable.subscriptions.create "LastReadChannel",
  connected: ->


  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.animation.chatroom_id }']")
    message_user = data.message.user.id
    user = $('body').attr('data-user')
    if active_chatroom.length > 0 && message_user != user
      $(".ana[data-message-id='#{data.animation['chatroom_id']}']").show();
      $(".ana[data-message-id='#{data.animation['chatroom_id']}']").fadeOut(50);
      $("#message_body").css({'background-color': "lightgrey"});
      $("#message_body").animate({'background-color': ""}, 50);

  update: (chatroom_id) ->
    @perform "update", {chatroom_id: chatroom_id}

  send_animation: (chatroom_id) ->
    @perform "send_animation", {chatroom_id: chatroom_id}