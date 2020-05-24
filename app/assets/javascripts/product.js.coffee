$(document).on "turbolinks:load", ->
  $('#product_available_on').datepicker
    dateFormat: 'yy-mm-dd'
    minDate: '0'

$(document).on "turbolinks:load", ->
  $('#product_discontinue_on').datepicker
    dateFormat: 'yy-mm-dd'
    minDate: '0'

jQuery ->
  $(window).scroll ->
    if $(window).scrollTop > $(document).height() - $(window).height() - 150
      alert "near bottom"

