
$(document).on "turbolinks:load", ->
  $('#Pproperties').sortable 
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
		dataType: 'script'