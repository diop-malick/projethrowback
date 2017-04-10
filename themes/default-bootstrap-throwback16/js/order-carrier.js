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

	
	$(document).on('submit', 'form[name=carrier_area]', function(e){
		if(acceptCGV()){
			$('.resp-tab-content').not('.resp-tab-content-active').each(function(){
				$('#id_address_delivery',this).empty();
			});
			return true;
		}		
		return false;
	});

	// Active button checkout only if carrer is seleted
	$('input[type=radio]').click(function(event){
		$(this).attr("checked","checked");
		$(this).parent().addClass('checked');
		$('button.standard-checkout').removeAttr('disabled');
		event.stopPropagation();
	});

	// COLAPSE TABS
	// TODO - MOVE ON ORDER-custom
	$('.collapse').on('shown.bs.collapse', function() {
	    $(this).parent().find(".resp-arrow").addClass("resp-arrow-active");
	    $('input[type=radio]', this).first().click();
	    if (this.id == "collapse0") { initMap(); }
	}).on('hidden.bs.collapse', function() {
	    $('.resp-arrow').removeClass("resp-arrow-active");
	});

	if(nb_adresses==0)
		$('#delivery_list').addClass('hidden');
	else if(nb_adresses > 1){
		$('#select_invoice_adresse').removeClass("hidden");
		$('#message_invoice_adresse').addClass("hidden");
	}
		
	ajaxAddressSetup(); 	

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

function initMap() {
    if (document.getElementById('map')) {
        var latLong = {
            lat: 48.873509,
            lng: 2.382527
        };
        var center = {
            lat: 48.873499,
            lng: 2.382627
        };
        var map = new google.maps.Map(document.getElementById('map'), {
            center: center,
            zoom: 20
        });
        // listen for the window resize event & trigger Google Maps to update too
        $(window).resize(function() {
            // (the 'map' here is the result of the created 'var map = ...' above)
            google.maps.event.trigger(map, "resize");
        });


        var marker = new google.maps.Marker({
            position: latLong,
            map: map
        });


    }
}



function ajaxAddressSetup()
{
	if (typeof formatedAddressFieldsValuesList === 'undefined' || !formatedAddressFieldsValuesList){		
		// $('.resp-tab-content:last-of-type').addClass('hidden');
		// $('h2.resp-accordion:last-of-type').addClass('hidden');
	}
	$('.resp-tab-content').each(function(){
		var tab = this;	
		// Ajouter adresse
		$('.addresses a',tab).click(function(event){
			var $link = $(this);
			event.preventDefault();
			$('.addresses .waitimage',tab).show();				
			$.ajax({
				url: $link.attr('href') ,
				type: 'GET',
				headers: { "cache-control": "no-cache" },
				async: true,
				cache: false,
				data: {
					processAddress: true,
					ajax: 'true',					
				},
				success: function(data) {					
					$('.addresses .waitimage',tab).hide();
					var $box = $('.box',data);
					$('#address',tab).html($box).removeClass('hidden');
					$('.addresses',tab).addClass('hidden');
					$('#address .submit2',tab).prepend('<a class="btn btn-default button button-medium reset-form"><span><i class="icon-chevron-left left"></i> Annuler</span></a>');
					$('#address .submit2 .reset-form',tab).click(function(){
						resetForm(tab);
					});					
					$('#address form',tab).submit(function(event){
						event.preventDefault();
						var $form = $( this );						
						$.ajax({
							type: 'POST',
							headers: { "cache-control": "no-cache" },
							async: true,
							cache: false,
							dataType : "json",
							url: $form.attr('action') +  '&ajax=true&submitAddress=true' ,
							data : $form.serialize(),							
							success: function(data) {								
								if(data.formatedAddressFieldsValuesList){
									formatedAddressFieldsValuesList = data.formatedAddressFieldsValuesList;
									$('.resp-tab-content:last-of-type').removeClass('hidden');
									$('h2.resp-accordion:last-of-type').removeClass('hidden');
									$('.express',tab).removeClass('hidden');
									$('.addresses .address',tab).removeClass('hidden');
									if(data.id_address == 0){
										var address = formatedAddressFieldsValuesList[Object.keys(formatedAddressFieldsValuesList)[Object.keys(formatedAddressFieldsValuesList).length - 1]];
										$('.addresses .none',tab).removeClass('none').addClass('hidden');
										$('#id_address_delivery',tab).append('<option selected="selected" value=' + Object.keys(formatedAddressFieldsValuesList)[Object.keys(formatedAddressFieldsValuesList).length - 1] + '>' + address['alias'] + '</option>').trigger("change");
										$('#id_address_invoice',tab).append('<option selected="selected" value=' + Object.keys(formatedAddressFieldsValuesList)[Object.keys(formatedAddressFieldsValuesList).length - 1] + '>' + address['alias'] + '</option>').trigger("change");
										// if($('#id_address_delivery option',tab).length >= 1){
										// 	$('.addresses .address_add a',tab).addClass('hidden');
										// }
										$('#delivery_list').removeClass('hidden');
										if($('#id_address_delivery option',tab).length < 3){
											$('.address_add').removeClass('hidden');
											if($('#id_address_delivery option',tab).length > 1){
												$('#select_invoice_adresse').removeClass("hidden");
												$('#message_invoice_adresse').addClass("hidden");
											}
										}
										else
											 $('.address_add').addClass('hidden');
									}else{
										$('#id_address_delivery option[value=' + data.id_address + ']',tab).html(data.formatedAddressFieldsValuesList[data.id_address]['alias']).attr("selected","selected");
										$('#id_address_delivery',tab).trigger('change');

										$('#id_address_invoice option[value=' + data.id_address + ']',tab).html(data.formatedAddressFieldsValuesList[data.id_address]['alias']).attr("selected","selected");
										$('#id_address_invoice',tab).trigger('change');

									}
								}								
								resetForm(tab);
								$(tab).trigger('resize');
								if(!$('.resp-tab-content-active #id_address_delivery option').length){
							  		$('button.standard-checkout').attr('disabled','disabled');
							  	}else{
							  		$('button.standard-checkout').removeAttr('disabled');
							  	}
							}
							
						});

					});
					setCountries();
					bindStateInputAndUpdate();				
					bindZipcode(tab);
					bindCheckbox();
					$.validate({
				            lang : 'fr',
				            modules : 'html5,sanitize,toggleDisabled,security',
				            form : '#address form',

				    });
					$("#select-civility").focus();				
							
				}
			});		
		});
		if($('.addresses .none',tab).length){
			$('.addresses .address_add a',tab).trigger('click');
		}
	});
	
}

function resetForm(tab){
	$('#address',tab).addClass('hidden');
	$('.addresses',tab).removeClass('hidden');
}
