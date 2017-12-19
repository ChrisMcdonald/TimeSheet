handleVisiblityChange = ->
  $strike = $(".strike")
  if $strike.length > 0
    chatroom_id = $("[data-behavior='messages']").data("chatroom-id")
    App.last_read.update(chatroom_id)
    $strike.remove()

#set_message_side = (element) ->
##  console.log element.data('userId')
#  element.addClass('pull-left')
#  console.element


$(document).on "turbolinks:load", ->
  $(document).on "click", handleVisiblityChange
  message_list_scroll_heigth = $('ul#messages').prop('scrollHeight')
  $('ul#messages').scrollTop(message_list_scroll_heigth)


  $("#new_message").on "keypress", (e) ->
    if e && e.keyCode == 13
      e.preventDefault()
      $(this).submit()

  $("#new_message").on "submit", (e) ->
    e.preventDefault()

    chatroom_id = $("[data-behavior='messages']").data("chatroom-id")
    body = $("#message_body")
    console.log body.val()
    App.chatrooms.send_message(chatroom_id, body.val())
  #    body.val("")

  $("#new_message").on "keypress", (e) ->
    chatroom_id = $("[data-behavior='messages']").data("chatroom-id")
    App.last_read.send_animation(chatroom_id)

  $('li.stuff').each () ->
    user = $('body').attr('data-user')
    element = $(this)
    if user == element.attr('data-user-id')
      element.addClass("pull-left")


