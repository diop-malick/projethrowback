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

// The button to increment the product value
$(document).on('click', '.product_quantity_up', function(e){
	e.preventDefault();
	var id = $(this).attr('id');
	var ids = id.split('-');
	var keyTab = ids[1];

	fieldName = $(this).data('field-qty');
	var currentVal = parseInt($('input[name='+fieldName+']').val());
	if (!allowBuyWhenOutOfStock && quantityAvailable[keyTab] > 0) {	
		console.log(quantityAvailable[keyTab]);
		if (typeof quantityLimitedAvailable[keyTab] !== 'undefined' && parseInt(quantityLimitedAvailable[keyTab]) > 0 && parseInt(quantityLimitedAvailable[keyTab]) < parseInt(quantityAvailable[keyTab]) ) {
			quantityAvailableT = parseInt(quantityLimitedAvailable[keyTab]);
		} else {
			quantityAvailableT = parseInt(quantityAvailable[keyTab]);
		}
	}
	else
		quantityAvailableT = 100000000;
	if (!isNaN(currentVal) && currentVal < quantityAvailableT)
		$('input[name='+fieldName+']').val(currentVal + 1).trigger('keyup');
	else
		$('input[name='+fieldName+']').val(quantityAvailableT);

	$('#quantity_wanted').change();
});
 // The button to decrement the product value
$(document).on('click', '.product_quantity_down', function(e){
	e.preventDefault();
	fieldName = $(this).data('field-qty');
	var currentVal = parseInt($('input[name='+fieldName+']').val());
	if (!isNaN(currentVal) && currentVal > 1)
		$('input[name='+fieldName+']').val(currentVal - 1).trigger('keyup');
	else
		$('input[name='+fieldName+']').val(1);

	$('#quantity_wanted').change();
});