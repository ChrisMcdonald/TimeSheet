App.last_read = App.cable.subscriptions.create "LastReadChannel",
  connected: ->


  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
    console.log data.animation
    $(".ana[data-message-id='#{data.animation['chatroom_id']}']").show();
    $(".ana[data-message-id='#{data.animation['chatroom_id']}']").fadeOut(50);
    $("textarea[id='#{data.animation['chatroom_id']}']").css({'background-color': "lightgrey"});
    $("textarea[id='#{data.animation['chatroom_id']}']").animate({'background-color': ""}, 50);

  update: (chatroom_id) ->
    @perform "update", {chatroom_id: chatroom_id}

  send_animation: (chatroom_id) ->
    @perform "send_animation", {chatroom_id: chatroom_id}