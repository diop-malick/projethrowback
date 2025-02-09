
$(document).ready(function(){
	if (typeof formatedAddressFieldsValuesList !== 'undefined')
		updateAddressesDisplay(true);
	else if($('form[name=carrier_area]').length)
		ajaxAddressSetup();

	$(document).on('change', 'select[name=id_address_delivery], select[name=id_address_invoice]', function(){
		updateAddressesDisplay();
		if (typeof opc !=='undefined' && opc)
			updateAddressSelection();

		// hide laoder when select adresse change
		$('.addresses .waitimage').show();
		$('.addresses .waitimage').hide();
        $('#address_invoice_form .waitimage').show();
        $('#address_invoice_form .waitimage').hide();

	});

	$(document).on('click', 'input[name=same]', function(){
		updateAddressesDisplay();
		if (typeof opc !=='undefined' && opc)
			updateAddressSelection();
	});

	
	// hide laoder when select adresse change
	 $('#addressesAreEquals').click(function(event) {
	 	$('.waitimage').hide();
	 	$('#address_invoice_form .waitimage').show().delay(5000).hide(); 

		 // hide zone adresse de facturation
		 $('.invoice-adresse').show();
	 });

});

//update the display of the addresses
function updateAddressesDisplay(first_view)
{	
	// update content of delivery address
	updateAddressDisplay('delivery');
	var txtInvoiceTitle = "";
	try{
		var adrs_titles = getAddressesTitles();
		txtInvoiceTitle = adrs_titles.invoice;
	}
	catch (e)
	{}
	// update content of invoice address
	//if addresses have to be equals...
	if ($('#addressesAreEquals:checked').length === 1 && ($('#multishipping_mode_checkbox:checked').length === 0))
	{
		// show zone adresse de facturation
		$('.invoice-adresse').hide('fast');

		if ($('#multishipping_mode_checkbox:checked').length === 0) {
			$('#address_invoice_form:visible').hide('fast');
		}
		$('ul#address_invoice').html($('ul#address_delivery').html());
		$('ul#address_invoice li.address_title').html(txtInvoiceTitle);
	}
	else
	{
		$('#address_invoice_form:hidden').show('fast');
		if ($('#id_address_invoice').val())
			updateAddressDisplay('invoice');
		else
		{
			$('ul#address_invoice').html($('ul#address_delivery').html());
			$('ul#address_invoice li.address_title').html(txtInvoiceTitle);
		}
	}
	if(!first_view)
	{
		if (orderProcess === 'order')
			updateAddresses();
	}
	ajaxAddressSetup();
	return true;
}

function updateAddressDisplay(addressType)
{
	if (typeof formatedAddressFieldsValuesList == 'undefined' || !formatedAddressFieldsValuesList || formatedAddressFieldsValuesList.length <= 0)
		return;

	$('.resp-tab-content').each(function(){
		var tab = this;
		var idAddress = parseInt($('#id_address_' + addressType,tab).val());
		buildAddressBlock(idAddress, addressType, $('#address_' + addressType,tab));

		// change update link
		var link = $('ul#address_' + addressType + ' li.address_update a',tab).attr('href');
		var expression = /id_address=\d+/;
		if (link)
		{
			link = link.replace(expression, 'id_address=' + idAddress);
			$('ul#address_' + addressType + ' li.address_update a',tab).attr('href', link);
		}
	});	
}

function updateAddresses()
{
	var idAddress_delivery = parseInt($('#id_address_delivery').val());
	var idAddress_invoice = $('#addressesAreEquals:checked').length === 1 ? idAddress_delivery : parseInt($('#id_address_invoice').val());

   	if(isNaN(idAddress_delivery) == false && isNaN(idAddress_invoice) == false)
	{
		$('.addresses .waitimage').show();
		$('[name="processAddress"]').prop('disabled', 'disabled');
		$.ajax({
			type: 'POST',
			headers: { "cache-control": "no-cache" },
			url: baseUri + '?rand=' + new Date().getTime(),
			async: true,
			cache: false,
			dataType : "html",
			data: {
				processAddress: true,
				step: 2,
				ajax: 'true',
				controller: 'order',
				'multi-shipping': $('#id_address_delivery:hidden').length,
				id_address_delivery: idAddress_delivery,
				id_address_invoice: idAddress_invoice,
				token: static_token
			},
			success: function(jsonData)
			{
				if (jsonData !== null && jsonData.hasError)
				{
					var errors = '';
					for(var error in jsonData.errors)
						//IE6 bug fix
						if(error !== 'indexOf')
							errors += $('<div />').html(jsonData.errors[error]).text() + "\n";
		            if (!!$.prototype.fancybox)
		                $.fancybox.open([
		                    {
		                        type: 'inline',
		                        autoScale: true,
		                        minHeight: 30,
		                        content: '<p class="fancybox-error">' + errors + '</p>'
		                    }
		                ], {
		                    padding: 0
		                });
		            else
		                alert(errors);
				}
				$('.addresses .waitimage').hide();
				$('[name="processAddress"]').prop('disabled', '');
			},
			error: function(XMLHttpRequest, textStatus, errorThrown) {
				$('.addresses .waitimage').hide();
				$('[name="processAddress"]').prop('disabled', '');
				if (textStatus !== 'abort')
				{
					error = "TECHNICAL ERROR: unable to save adresses \n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
		            if (!!$.prototype.fancybox)
		                $.fancybox.open([
		                    {
		                        type: 'inline',
		                        autoScale: true,
		                        minHeight: 30,
		                        content: '<p class="fancybox-error">' + error + '</p>'
		                    }
		                ], {
		                    padding: 0
		                });
		            else
		                alert(error);
				}
			}
		});
	}
}

function getAddressesTitles()
{
	if (typeof titleInvoice !== 'undefined' && typeof titleDelivery !== 'undefined')
		return {
			'invoice': titleInvoice,
			'delivery': titleDelivery
		};
	else
		return {
			'invoice': '',
			'delivery': ''
		};
}

function buildAddressBlock(id_address, address_type, dest_comp)
{
	if (isNaN(id_address))
		return;
	var adr_titles_vals = getAddressesTitles();
	var li_content = formatedAddressFieldsValuesList[id_address]['formated_fields_values'];
	var ordered_fields_name = ['title'];
	var reg = new RegExp("[ ]+", "g");
	ordered_fields_name = ordered_fields_name.concat(formatedAddressFieldsValuesList[id_address]['ordered_fields']);
	ordered_fields_name = ordered_fields_name.concat(['update']);
	dest_comp.html('');
	li_content['title'] = adr_titles_vals[address_type];
	if (typeof liUpdate !== 'undefined')
	{
		var items = liUpdate.split(reg);
		var regUrl = new RegExp('(https?://[^"]*)', 'gi');
		liUpdate = liUpdate.replace(regUrl, addressUrlAdd + parseInt(id_address));
		li_content['update'] = liUpdate;
	}
	appendAddressList(dest_comp, li_content, ordered_fields_name);
}

function appendAddressList(dest_comp, values, fields_name)
{
	for (var item in fields_name)
	{
		var name = fields_name[item].replace(/,/g, "");
		var value = getFieldValue(name, values);
		if (value != "")
		{
			var new_li = document.createElement('li');
			var reg = new RegExp("[ ]+", "g");
			var classes = name.split(reg);
			new_li.className = '';
			for (clas in classes)
				new_li.className += 'address_' + classes[clas].toLowerCase().replace(":", "_") + ' ';
			new_li.className = $.trim(new_li.className);
			new_li.innerHTML = value;
			dest_comp.append(new_li);
		}
	}
}

function getFieldValue(field_name, values)
{
	var reg = new RegExp("[ ]+", "g");
	var items = field_name.split(reg);
	var vals = new Array();
	for (var field_item in items)
	{
		items[field_item] = items[field_item].replace(/,/g, "");
		vals.push(values[items[field_item]]);
	}
	return vals.join(" ");
}
