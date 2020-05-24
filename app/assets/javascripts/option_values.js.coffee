

$(document).on "turbolinks:load", ->
  $('#option_values').sortable 
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
		dataType: 'script'


    
