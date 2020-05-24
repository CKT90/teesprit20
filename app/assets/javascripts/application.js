//= require jquery
//= require turbolinks
//= require jquery-ui
//= require chartkick
//= require Chart.bundle
//= require moment
//= require bootstrap-sprockets
//= require bootstrap-datetimepicker
//= require bootstrap-switch
//= require jquery-ui/effects/effect-blind
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.turbolinks
//= require jquery_ujs
//= require select2
//= require sweetalert
//= require best_in_place
//= require best_in_place.purr
//= require jquery.purr
//= require jquery.remotipart
//= require bootstrap
//= require_self 
//= require_tree .


$(document).on('turbolinks:load', function() {

  setTimeout(function(){
  	$('#flash').remove();
  }, 5000);

  setTimeout(function(){
    $('.flash_message').remove();
  }, 5000);

  $(".disable_link").bind("contextmenu",function(){
	return false;
  });

  $(document).on("click", function(e) {
	if($(e.target).is(".disable_link") && e.button === 1) {
      e.preventDefault();
    }
  });
  
});


