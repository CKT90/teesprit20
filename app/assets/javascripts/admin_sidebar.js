

$(document).on('turbolinks:load', function() {

	$(".menu-toggle").click(function(e) {
	    e.preventDefault();
	    $("#wrapper").toggleClass("toggled");
	});

	$("a.prevent").click(function (e) { 
	    e.preventDefault(); 
	})

	$('#dash, #products, #messages, #report, #users').on('shown.bs.collapse', function() {
	    $(this).prev().find(".toggle-icon").addClass('fa-angle-down ').removeClass('fa-angle-left');
	});

	$('#dash, #products, #messages, #report, #users').on('hidden.bs.collapse', function() {
	   $(this).prev().find(".toggle-icon").addClass('fa-angle-left ').removeClass('fa-angle-down');
	});

});






