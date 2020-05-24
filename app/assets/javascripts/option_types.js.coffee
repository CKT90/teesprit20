# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on 'click', 'form .add_fields', (event) ->
  event.preventDefault()
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('fields').replace(regexp, time))

$(document).on 'click', 'form .remove_fields', (event) ->
  event.preventDefault()
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('li').hide()
  

$(document).on "turbolinks:load", ->
  $('#option_types_sortable').sortable 
    axis: 'y'
    handle: '.handle'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
		dataType: 'script'

  