

document.addEventListener("turbolinks:before-cache", function() {
  $("[class^=admin_normal_select]").select2("destroy"); 
  $("[class='checkbox_[false]']").bootstrapSwitch("destroy");
  $("[class='checkbox_[true]']").bootstrapSwitch("destroy");
  $("[class='order_payment_Paid']").bootstrapSwitch("destroy");
  $("[class='order_payment_Pending']").bootstrapSwitch("destroy");
  $("[class='order_shipment_Shipped']").bootstrapSwitch("destroy");
  $("[class='order_shipment_Pending']").bootstrapSwitch("destroy");
  $("select#product_option_type_ids").select2("destroy");
  $("select#product_category_ids").select2("destroy");
  $("select#order_states").select2("destroy");
});


$(document).on('turbolinks:load', function() {

	$("img").mousedown(function(){
	    return false;
	});

	$('input#line_item_quantity').keypress(function(event){
    	event.preventDefault();
	});

	$("[class^=normal_select]").select2({
  		minimumResultsForSearch: Infinity,
  		width: 'resolve',

	});

	$("[class^=admin_normal_select]").select2({
		allowClear: true,
		placeholder: "Please Select",
  		minimumResultsForSearch: Infinity,
  		width: 'resolve',

	});




	var seen = {};
	$('#my li').each(function() {
	    var txt = $(this).text();
	    if (seen[txt])
	        $(this).remove();
	    else
	        seen[txt] = true;
	});

	$('.other_images img').on('click', function(e) { //e refers to event and is an optional parameter
   		$(".browse_show_image img").attr('src', $(this).attr('src'));
 	});


 	//$("img").bind('contextmenu', function(e) {
    //	return false;
	//}); 

 	//color boxes
   	$('<div id="color_selection"></div>').insertAfter('select.colorized');
   	
   	$(".colorized option").each(function(i, e) {

		$("<input type='radio' class='color' data-color='' />")
		.attr("value", $(this).val())
		.attr("data-color", $(this).text())
		.attr("checked", i == 0)
		.click(function () {
   			$(".colorized").val($(this).val());
   			$(".colorized").trigger("onchange");
		})
		.appendTo('#color_selection');
	});

	$('.color').each(function(i, e) {
		$(this).wrap("<label class='label_color' ></label>");
		var the_color = $(this).attr('data-color');
		$(this).parent().css('background-color', the_color);
	});

	$(".label_color").click(function() {
		$(".label_color").css('box-shadow', "0px 0px 0px 0px rgba(0,0,0,0.2)"); 
		$(this).css('box-shadow', "0px 4px 8px 2px rgba(0,0,0,0.2)");  
	});


			
});


  function update_product() {
	var option_value = [];
	var product_id = $("#line_item_product_id").val();
	$("[id^=line_item_option_value_ids] option:selected").each(function(){
		option_value.push($(this).val());
	});

	$.ajax({
		type: "GET",
		dataType: "json",
		url: "/checkstock",
		data: {id: product_id, option_values: option_value},
		success: function(data){ 
			var QI = document.getElementById("quantity_info");
			var PI = document.getElementById("price_info");
			QI.innerHTML = data.quantity + " unit(s) in stock";
			PI.innerHTML = "RM" + parseFloat(data.price).toFixed(2);
			QI.style.backgroundColor = data.color;
			document.getElementById("variant_description").innerHTML = data.description;



			if (data.quantity == 0) {
				$('#selection_submit, #line_item_quantity').attr('disabled', true);
				$("#line_item_quantity").val(0);
				$("#line_item_quantity").attr({
		       		"max" : 0, 
		       		"min" : 0,
		       	});
			}
			else {	
				$("#line_item_quantity").val(1)
				$("#line_item_quantity").attr({
		       		"max" : data.quantity, 
		       		"min" : 1,
		       	});
       			$('#selection_submit, #line_item_quantity').attr('disabled', false);
			}


	      	var input = $('#quantity_selection').find('#line_item_quantity');
	        var min = $('#line_item_quantity').attr('min');
	        var max = $('#line_item_quantity').attr('max');

	      	$(".quantity-up").unbind().click(function() {
	        	var oldValue = parseFloat(input.val());

	        	if (oldValue >= max) {
	         		var newVal = oldValue;
	        	} else {
	          		var newVal = oldValue + 1;
	        	}

		        $('#line_item_quantity').val(newVal);
		        $('#line_item_quantity').trigger("change");
	      	});

	       	$(".quantity-down").unbind().click(function() {
	       		var oldValue = parseFloat(input.val());
	        	if (oldValue <= min) {
	          		var newVal = oldValue;
	        	} else {
	          		var newVal = oldValue - 1;
	        	}
	        	$('#line_item_quantity').val(newVal);
	        	$('#line_item_quantity').trigger("change");
	      	});
		} //success
	});//ajax
}//function





$(document).on('turbolinks:load', function() {
  $('[data-toggle="tooltip"]').tooltip({
  }); 
});

