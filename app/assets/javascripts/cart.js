$(document).on('turbolinks:load', function() {

	$(".cart_quantity").each(function() {
		var self = $(this)
		var max = self.attr('max');
		var oldValue = parseFloat(self.val());

		if (oldValue > max) {
          	var newVal = max;
        } else {
        	var newVal = oldValue;
        }

	    self.val(newVal);
	});


	$('input.cart_quantity').keypress(function(event){
    	event.preventDefault();
	});

	$("#selection_submit").click(function() {
		swal({
		  title: 'Item added to cart!',
		  showCloseButton: true,
		  showCancelButton: true,
		  confirmButtonText:' Go To Cart',
		  cancelButtonText: 'Continue Shopping',
		  type: "success",
		  closeOnConfirm: false
			}, function() {
  				location.href="/cart"
			});
	});

	$(".cart-quantity-down").unbind().each(function() {
		$(this).click(function() {
		var idhere = $(this).attr("id");

		var line_id = "#line_item_" + idhere + "_quantity";
		var qs_id = "#cart_quantity_selection_" + idhere;
		var max = $(line_id).attr('max');
		var input = $(qs_id).find(line_id);
        var min = $(line_id).attr('min');
        
		var oldValue = parseFloat(input.val());

        if (oldValue <= min) {
          	var newVal = oldValue;
        } else {
          	var newVal = oldValue - 1;
        }
	        $(line_id).val(newVal);
	        $(line_id).trigger("change");
 		});
 	});

	$(".cart-quantity-up").unbind().each(function() {
		$(this).click(function() {
		var idhere = $(this).attr("id");

		var line_id = "#line_item_" + idhere + "_quantity";
		var qs_id = "#cart_quantity_selection_" + idhere;
		var max = $(line_id).attr('max');
		var input = $(qs_id).find(line_id);
        var min = $(line_id).attr('min');
        
    	var oldValue = parseFloat(input.val());

    	if (oldValue >= max) {
     		var newVal = oldValue;
    	} else {
      		var newVal = oldValue + 1;
    	}
	        $(line_id).val(newVal);
	        $(line_id).trigger("change");
  		});
 	});
});

