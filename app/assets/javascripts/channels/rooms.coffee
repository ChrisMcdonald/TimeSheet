
App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id }']")

    if active_chatroom.length > 0

      if document.hidden
        if $('.strike').length == 0
          active_chatroom.prepend('<li class="strike"><span>Unread Messages</span></li>')

        if Notification.permission == "granted"
          new Notification(data.username, {body: data.body, icon: data.avatar})
          $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold").addClass('fa fa-envelope');

      else
#        App.last_read.update(data.chatroom_id)
#      set_message_side(data.message)
      user = (Number) $('body').attr('data-user')
      active_chatroom.append(data.message)
      if user == data.message_user.id
        $("[data-id='#{data.message_id}']").css('float': 'left');


      $("[data-id='#{data.message_id}']").css({'background-color': "lightgrey"});
      $("[data-id='#{data.message_id}']").animate({'background-color': ""}, 1200);
      message_list_scroll_heigth = $('ul#messages').prop('scrollHeight');
      $('ul#messages').scrollTop(message_list_scroll_heigth);

    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold").addClass('fa fa-envelope');


  send_message: (chatroom_id, message) ->
    @perform "send_message", {chatroom_id: chatroom_id, body: message}

