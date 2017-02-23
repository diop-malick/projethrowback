/*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/
$(document).ready(function(){

	if (!!$.prototype.fancybox)
		$("a.iframe").fancybox({
			'type': 'iframe',
			'width': 600,
			'height': 600
		});

	if (typeof cart_gift != 'undefined' && cart_gift && $('input#gift').is(':checked'))
		$('p#gift_div').show();

	$(document).on('change', 'input.delivery_option_radio', function(){
		var key = $(this).data('key');
		var id_address = parseInt($(this).data('id_address'));
		if (orderProcess == 'order' && key && id_address)
			updateExtraCarrier(key, id_address);
		else if(orderProcess == 'order-opc' && typeof updateCarrierSelectionAndGift !== 'undefined')
			updateCarrierSelectionAndGift();
	});

	$(document).on('submit', 'form[name=carrier_area]', function(){
		return acceptCGV();
	});

	

});

function acceptCGV()
{
	if (typeof msg_order_carrier != 'undefined' && $('#cgv').length && !$('input#cgv:checked').length)
	{
		if (!!$.prototype.fancybox)
		    $.fancybox.open([
	        {
	            type: 'inline',
	            autoScale: true,
	            minHeight: 30,
	            content: '<p class="fancybox-error">' + msg_order_carrier + '</p>'
	        }],
			{
		        padding: 0
		    });
		else
		    alert(msg_order_carrier);
	}
	else
		return true;
	return false;
}

function ajaxAddressSetup()
{
	$('.resp-tab-content').on('click','.addresses a',function(event){
		var $target = event.delegateTarget;	
		var $link = $(this);
		event.preventDefault();
		$('.addresses .waitimage',$target).show();
		$.ajax({
			url: $link.attr('href') +  '&ajax=true' ,
			type: 'get',
			success: function(data) {
				$('.addresses .waitimage',$target).hide();
				var $box = $('.box',data);
				$('#address',$target).html($box).removeClass('hidden');
				$('.addresses',$target).addClass('hidden');
				$('#address .submit2',$target).prepend('<a class="btn btn-default button button-medium reset-form"><span><i class="icon-chevron-left left"></i> Annuler</span></a>');
				$('#address .submit2 .reset-form',$target).click(function(){
					resetForm($target);
				});
				$('#address form',$target).submit(function(event){
					/*event.preventDefault();
					var $form = $( this );
					$.ajax({
						url: $form.attr('action') +  '&ajax=true' ,
						type: $form.attr('method'),
						data : $form.serialize(),
						success: function(data) {
							console.log('success')
							console.log(data)

						}
					});*/

				});
				setCountries();
				bindStateInputAndUpdate();				
				bindZipcode();
				bindCheckbox();
				/*$.validate({
			            lang : 'fr',
			            modules : 'html5,sanitize,toggleDisabled,security',
			            form : '#address form',

			    });	*/
				$("#firstname").focus();				
						
			}
		});		
	});
	if($('.resp-tab-content .addresses .none').length){
		$('.resp-tab-content .addresses .address_add a').trigger('click');
	}
}

function resetForm($target){
	$('#address',$target).addClass('hidden');
	$('.addresses',$target).removeClass('hidden');
}
