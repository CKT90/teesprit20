$(document).on('turbolinks:load', function() { //pay type change to boxes

   	$('<div id="paytype_selection"></div>').insertAfter('div.selection_pay_box_restruct');

   	$("#order_pay_type option").each(function(i, e) {
		$("<input type='radio' class='paybox' id='paybox' />")
		.attr("value", $(this).val())
		.click(function () {

       			$("#order_pay_type").val($(this).val());
       			$("#order_pay_type").trigger("onchange");
    		})
		.appendTo('#paytype_selection');
	});

	$('.paybox').each(function(i, e) {
		//var wordings = $(this).val();
		//$(this).wrap("<label class='label_word' >" + wordings + "</label>");
		$(this).wrap("<label class='label_word'></label>");
		$(this).attr("checked", i == 0)
		$(this).parent().addClass('option' + (i+1));
	});

	$(".label_word").click(function() {
		$(".label_word").css('border', "0px"); 
		$(this).css('border', "4px solid #bf5b40 ");
	});
	
	$("#order_states").select2({
  		minimumResultsForSearch: Infinity,
  		width: 'resolve',
	});

});



$(document).on('turbolinks:load', function() {

	$(".order_table span:contains('Paid')").css({'background-color': '#5cb85c',
												'padding' : '2px 5px 2px 5px',
												'border-radius' : '3px',
												'color' : '#fff'});

	$(".order_table span:contains('Pending')").css({'background-color': '#ffd500',
												'padding' : '2px 5px 2px 5px',
												'border-radius' : '3px',
												'color' : '#fff'});

	$(".order_table span:contains('Shipped')").css({'background-color': '#5cb85c',
												'padding' : '2px 5px 2px 5px',
												'border-radius' : '3px',
												'color' : '#fff'});

	$(".order_table span:contains('Canceled')").css({'background-color': '#ff371c',
												'padding' : '2px 5px 2px 5px',
												'border-radius' : '3px',
												'color' : '#fff'});

	$(".order_table span:contains('Approved')").css({'background-color': '#5cb85c',
												'padding' : '2px 5px 2px 5px',
												'border-radius' : '3px',
												'color' : '#fff'});
});



function update_selection() {
	var state = $("#select2-order_states-container").attr('title');
	var star1 = document.getElementById("product_t").innerHTML;
	var selection = $("#order_pay_type").val();

	if (selection == 'Cash on Delivery (COD)') {
		$.ajax({
			success: function(data){
			 	var star = "0.00";
				var add1 = parseInt(0);
				var add2 = parseFloat((star1).replace(/,/g, ''));
				$(".delivery").html(star);

				var add3 = (add1 + add2).toFixed(2);
				$(".total_p").html(add3);
			}
		});

		if (['Kuala Lumpur', 'Selangor'].indexOf(state) > -1) {
			$('.submit_button').attr('disabled', false);
		}

		else {
			$('.submit_button').attr('disabled', true);
		}
	}

	else if (selection == 'Bank-in (Delivery)' || selection == 'Credit Card'){
		$('.submit_button').attr('disabled', false);
		if (['Kuala Lumpur', 'Selangor'].indexOf(state) > -1) {
			$.ajax({
				success: function(data){ 

					var star = "0.00";
					var add1 = parseInt(0);
					var add2 = parseFloat((star1).replace(/,/g, ''));
					$(".delivery").html(star);

					var add3 = (add1 + add2).toFixed(2);
					$(".total_p").html(add3);
				}
			});
		}

		else if (['Perlis', 'Penang', 'Perak', 'Kedah', 'Terengganu', 'Johor', 'Melaka', 'Negeri Sembilan', 'Pahang', 'Kelantan'].indexOf(state) > -1) {
			$.ajax({
				success: function(data){ 

					var star = "10.00";
					var add1 = parseInt(10);
					var add2 = parseFloat((star1).replace(/,/g, ''));
					$(".delivery").html(star);

					var add3 = (add1 + add2).toFixed(2);
					$(".total_p").html(add3);
				}
			});
		}

		else if (['Sabah', 'Sarawak', 'Labuan'].indexOf(state) > -1) {
			$.ajax({
				success: function(data){ 

					var star = "12.00";
					var add1 = parseInt(12);
					var add2 = parseFloat((star1).replace(/,/g, ''));
					$(".delivery").html(star);

					var add3 = (add1 + add2).toFixed(2);
					$(".total_p").html(add3);
				}
			});
		}
		}
	}

	function update_delivery() {
		var selection = $("#order_pay_type").val();
		var state = $("#select2-order_states-container").attr('title');
		var star1 = document.getElementById("product_t").innerHTML;

		if (selection == 'Cash on Delivery (COD)') {
			if (['Kuala Lumpur', 'Selangor'].indexOf(state) > -1) {
				$.ajax({
					success: function(data){ 

						var star = "0.00";
						var add1 = parseInt(0);
						var add2 = parseFloat((star1).replace(/,/g, ''));
						$(".delivery").html(star);

						var add3 = (add1 + add2).toFixed(2);
						$(".total_p").html(add3);
						$('.submit_button').attr('disabled', false);
					}
				});
			}

			else if (['Perlis', 'Penang', 'Perak', 'Kedah', 'Terengganu', 'Johor', 'Melaka', 'Negeri Sembilan', 'Pahang', 'Kelantan', 'Sabah', 'Sarawak', 'Labuan'].indexOf(state) > -1) {
				$.ajax({
					success: function(data){ 

						var star = "0.00";
						var add1 = parseInt(0);
						var add2 = parseFloat((star1).replace(/,/g, ''));
						$(".delivery").html(star);

						var add3 = (add1 + add2).toFixed(2);
						$(".total_p").html(add3);
						$('.submit_button').attr('disabled', true);
					}
				});
			}	
		}		

		else if (selection == 'Bank-in (Delivery)' || selection == 'Credit Card'){
			if (['Kuala Lumpur', 'Selangor'].indexOf(state) > -1) {
				$.ajax({
					success: function(data){ 

						var star = "0.00";
						var add1 = parseInt(0);
						var add2 = parseFloat((star1).replace(/,/g, ''));
						$(".delivery").html(star);

						var add3 = (add1 + add2).toFixed(2);
						$(".total_p").html(add3);
					}
				});
			}

			else if (['Perlis', 'Penang', 'Perak', 'Kedah', 'Terengganu', 'Johor', 'Melaka', 'Negeri Sembilan', 'Pahang', 'Kelantan'].indexOf(state) > -1) {
				$.ajax({
					success: function(data){ 

						var star = "10.00";
						var add1 = parseInt(10);
						var add2 = parseFloat((star1).replace(/,/g, ''));
						$(".delivery").html(star);

						var add3 = (add1 + add2).toFixed(2);
						$(".total_p").html(add3);

					}
				});
			}

			else if (['Sabah', 'Sarawak', 'Labuan'].indexOf(state) > -1) {
				$.ajax({
					success: function(data){ 

						var star = "12.00";
						var add1 = parseInt(12);
						var add2 = parseFloat((star1).replace(/,/g, ''));
						$(".delivery").html(star);

						var add3 = (add1 + add2).toFixed(2);
						$(".total_p").html(add3);

					}
				});
			}
		}
	}//function



$(document).on('turbolinks:load', function() {

	  // hide spinner
	  $(".spinner").hide();

	  $(document).ajaxStart(function(){
	    $(".spinner").show();
	     $('#loading').show();
	  });
	  $(document).ajaxStop(function(){
	    $(".spinner").hide();
	     $('#loading').hide();
	  });

	  $(".submit_button").click(function(){
	    $(".spinner").show();
	     $('#loading').show();
	  });


	$('#q_created_at_gteq').datetimepicker({
	format: 'DD/MM/YYYY'
	});
	$('#q_created_at_lteq').datetimepicker({
		format: 'DD/MM/YYYY',
	    useCurrent: false //Important! See issue #1075
	});
	$("#q_created_at_gteq").on("dp.change", function (e) {
	    $('#q_created_at_lteq').data("DateTimePicker").minDate(e.date);
	});
	$("#q_created_at_lteq").on("dp.change", function (e) {
	    $('#q_created_at_gteq').data("DateTimePicker").maxDate(e.date);
	});
});