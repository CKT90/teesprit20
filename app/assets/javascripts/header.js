

$(document).on('turbolinks:load', function() {
	
	$('.header_icon').click(function(event){
		event.preventDefault();
		$('body').toggleClass('with--sidebar');
	});	

	$('a.dropbtn').click(function(event){
		event.preventDefault();
	});		

    $('#site-cache').click(function(e){
      $('body').removeClass('with--sidebar');
    });
});


$(document).on('turbolinks:load', function() {

	$("select#product_option_type_ids").select2();
	$("select#product_category_ids").select2();
  });



$(document).on('turbolinks:load', function() {

	$('.cart_drop').click(function(event){
		var minHeight = $("div.cart_box").css('min-height');
        $("div.cart_box").css('min-height',0).slideToggle(100, function() {
            $(this).css('min-height', minHeight);
        });
    });	

$(document).click(function() {
 $('div.cart_box').slideUp(100);
});	

$(".cart_drop").click(function(e) { // Wont toggle on any click in the div
e.stopPropagation();
});


});

function header_home() {
	var windowWidth = $(document).width();
	var os = $('.image_switch').offset().top; 
	var h = 200;
	var $w = $(window).scroll(function() {


			if($w.scrollTop() > os +  h){
				$('.head.home_header').removeClass('home_header');
				$('.head').addClass('header');  
				$('a.login_button').removeClass('ghost-button-transition'); 

			}
			else {   
				$('.head.header').removeClass('header');
				$('.head').addClass('home_header'); 
				$('a.login_button').addClass('ghost-button-transition');
			}
		
	});
}