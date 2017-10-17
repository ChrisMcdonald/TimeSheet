# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('tr').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $("#hours").after($(this).data('fields').replace(regexp, time))
  event.preventDefault()

$ document.addEventListener 'turbolinks:load', ->
  $('td.day').on 'click', ->
    Turbolinks.visit($(this).find("a").attr("href"))