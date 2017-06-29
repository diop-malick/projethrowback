/*
*  @author Abdou khadre
*/


$(document).on('click', '.attribute_radio', function(e){
	e.preventDefault();
	var ids = $(this).attr('id');
	var keyTab = ids.split('-');
	var id = keyTab[0]
	var idCombinaison = parseInt(getProductAttribute(id));
	$('.combinaison_'+id+' input[name=combinaison_default]').val(idCombinaison);

	// enable validate button buttons_modify
	$('.update_line').removeClass('disabled');
	// ligth selected attributes
	$('.attribute_list ul li > label').removeClass('selected');
    $('.attribute_list ul li > label[for="' + ids + '"]').addClass('li_attribute_list selected');
	// reset quatity to 1, when size changed
    $('#quantity_wanted_'+id).val(1);

});


function getProductAttribute(id)
{
	var radio_choice = parseInt($('.attributes_to_modify_'+id+' .checked input[type=radio]').val());
	for (var i in attributesCombinations[id]){
		  var list_attribute = attributesCombinations[id][i]['list'];
		  tab = list_attribute.split(',');
		  if (typeof(tab[0]) !== 'undefined')
		   		taille_attribute = parseInt(tab[0].replace(/'/g,""));
		  
		  if( taille_attribute==radio_choice)
				return(i);
	}
}



// The button to increment the product value
$(document).on('click', '.product_quantity_up', function(e){
	e.preventDefault();
	var id = $(this).attr('id');
	var ids = id.split('-');
	var keyTab = ids[1];

	fieldName = $(this).data('field-qty');
	var currentVal = parseInt($('input[name='+fieldName+']').val());
	if (!allowBuyWhenOutOfStock && quantityAvailable[keyTab] > 0) {	
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

	// enable validate button buttons_modify
	$('.update_line').removeClass('disabled')

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

	// enable validate button buttons_modify
	$('.update_line').removeClass('disabled')
});