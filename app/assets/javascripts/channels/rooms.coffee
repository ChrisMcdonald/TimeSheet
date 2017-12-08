jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages

    messages_to_bottom()
    App.global_chat = App.cable.subscriptions.create {
      channel: "ChatRoomsChannel"
      chat_room_id: messages.data('chat-room-id')
    },
      connected: ->
# Called when the subscription is ready for use on the server

      disconnected: ->
# Called when the subscription has been terminated by the server

      received: (data) ->
        messages.prepend data['message']
        messages_to_bottom()

      send_message: (message, chat_room_id) ->
        @perform 'send_message', message: message, chat_room_id: chat_room_id
    #        change_stuff(message)

    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      if $.trim(textarea.val()).length > 1
        App.global_chat.send_message textarea.val(), messages.data('chat-room-id')
        textarea.val('')


      e.preventDefault()

      return false


    $('#message_body').keypress (e) ->
      $this = $(this)
      textarea = $this.find('#message_body')
      if e.keyCode == 13
        $('#new_message').submit();
        textarea.val('')


#      var user = <%= current_user.id %>
#        $(document).on('turbolinks:load', function () {
#          change_stuff()
#      });
#
#    $(document).on('click', function () {
#      change_stuff()
#    });

#    change_stuff(message): ->
#      user: <%= current_user.id %>
#      console.log(message)
#      $('.stuff').each ->
#        if $(this).attr('data-user-id') == user
#          $(this).addClass 'pull-left'
#        else
#          $(this).removeClass 'pull-left'
#        return
#      return