
// show the order-details with ajax
function showOrder(mode, var_content, file)
{
	$.get(
		file,
		((mode === 1) ? {'id_order': var_content, 'ajax': true} : {'id_order_return': var_content, 'ajax': true}),
		function(data)
		{
			$('#block-order-detail').fadeOut('slow', function()
			{
				$(this).html(data);
				$('.footab').footable();
				/* if return is allowed */
				if ($('#order-detail-content .order_cb').length > 0)
				{
					//return slip : check or uncheck every checkboxes
					$('#order-detail-content th input[type=checkbox]').click(function()
					{
							$('#order-detail-content td input[type=checkbox]').each(function()
							{
								this.checked = $('#order-detail-content th input[type=checkbox]').is(':checked');
								updateOrderLineDisplay(this);
							});
					});
					// return slip : enable or disable 'global' quantity editing
					$('#order-detail-content td input[type=checkbox]').click(function()
					{
						updateOrderLineDisplay(this);
					});
					// return slip : limit quantities
					$('#order-detail-content td .order_qte_input').keyup(function()
					{
						var maxQuantity = parseInt($(this).parent().find('.order_qte_span').text());
						var quantity = parseInt($(this).val());
						if (isNaN($(this).val()) && $(this).val() !== '')
						{
							$(this).val(maxQuantity);
						}
						else
						{
							if (quantity > maxQuantity)
								$(this).val(maxQuantity);
							else if (quantity < 1)
								$(this).val(1);
						}
					});
					// The button to increment the product return value
					$(document).on('click', '.return_quantity_down', function(e){
						e.preventDefault();
						var $input = $(this).parent().parent().find('input');
						var count = parseInt($input.val()) - 1;
						count = count < 1 ? 1 : count;
						$input.val(count);
						$input.change();
					});
					// The button to decrement the product return value
					$(document).on('click', '.return_quantity_up', function(e){
						e.preventDefault();
						var maxQuantity = parseInt($(this).parent().parent().find('.order_qte_span').text());
						var $input = $(this).parent().parent().find('input');
						var count = parseInt($input.val()) + 1;
						count = count > maxQuantity ? maxQuantity : count;
						$input.val(count);
						$input.change();
					});
				}
				//catch the submit event of sendOrderMessage form
				$('form#sendOrderMessage').submit(function(){
					return sendOrderMessage();
			});
				$("#order-list").hide();
				$("#my-details").show();
				$("#show_tab_history").show();
				var context = $(this);
				$(this).fadeIn('slow', function() {
				//$.scrollTo(this, 1200);
			});
			 $( "#show_tab_history" ).on( "click", function(e) {
			 		$("#my-details").hide();
			 		$("#order-list").show();
			 		$(this).hide();
			 		context.hide();
			 });
		});
	});
}

function updateOrderLineDisplay(domCheckbox)
{
	var lineQuantitySpan = $(domCheckbox).parent().parent().find('.order_qte_span');
	var lineQuantityInput = $(domCheckbox).parent().parent().find('.order_qte_input');
	var lineQuantityButtons = $(domCheckbox).parent().parent().find('.return_quantity_up, .return_quantity_down');
	if($(domCheckbox).is(':checked'))
	{
		lineQuantitySpan.hide();
		lineQuantityInput.show();
		lineQuantityButtons.show();
	}
	else
	{
		lineQuantityInput.hide();
		lineQuantityButtons.hide();
		lineQuantityInput.val(lineQuantitySpan.text());
		lineQuantitySpan.show();
	}
}

//send a message in relation to the order with ajax
function sendOrderMessage()
{
	paramString = "ajax=true";
	$('#sendOrderMessage').find('input, textarea, select').each(function(){
		paramString += '&' + $(this).attr('name') + '=' + encodeURIComponent($(this).val());
	});

	$.ajax({
		type: "POST",
		headers: { "cache-control": "no-cache" },
		url: $('#sendOrderMessage').attr("action") + '?rand=' + new Date().getTime(),
		data: paramString,
		beforeSend: function(){
			$(".button[name=submitMessage]").prop("disabled", "disabled");
		},
		success: function(msg){
			$('#block-order-detail').fadeOut('slow', function() {
				$(this).html(msg);
				//catch the submit event of sendOrderMessage form
				$('#sendOrderMessage').submit(function(){
					return sendOrderMessage();
				});
				$(this).fadeIn('slow');
	        	$(".button[name=submitMessage]").prop("disabled", false);
			});
		},
		error: function(){
			$(".button[name=submitMessage]").prop("disabled", false);
		}
	});
	return false;
}