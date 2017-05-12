$(document).ready(function(){

	var isBusy = false; //first time, busy state is false

	$(document).on('submit', '#create-account_form', function(e){
		e.preventDefault();
		// console.log('create-account_form');
		submitFunction();
		$('.alert-danger').empty().hide();
		$('#identification .authentication').empty().append("Création de compte");
	});
	$('.is_customer_param').hide();

	 if (window.matchMedia('(min-width: 992px)').matches) {
		if(typeof isFromBasket !== 'undefined' && isFromBasket)
			$('#login_form ,  #create-account_form').css("height", "370px").css("padding", "20px 100px");
    }
	
});

function submitFunction()
{
	$('#create_account_error').html('').hide();
	$.ajax({
		type: 'POST',
		url: baseUri + '?rand=' + new Date().getTime(),
		async: true,
		cache: false,
		dataType : "json",
		headers: { "cache-control": "no-cache" },
		data:
		{
			controller: 'authentication',
			SubmitCreate: 1,
			ajax: true,
			email_create: $('#email_create').val(),
			back: $('input[name=back]').val(),
			token: token
		},
		success: function(jsonData)
		{
			if (jsonData.hasError)
			{
				var errors = '';
				for(error in jsonData.errors)
					//IE6 bug fix
					if(error != 'indexOf')
						errors += '<li>' + jsonData.errors[error] + '</li>';
				$('#create_account_error').html('<ol>' + errors + '</ol>').show();
			}
			else
			{
				// adding a div to display a transition
				$('#center_column').html('<div id="noSlide">' + $('#center_column').html() + '</div>');
				$('#noSlide').fadeOut('slow', function()
				{

					$('#noSlide').html(jsonData.page);
					// thorwback - custom - hide header and step-order showing twice
					$('#noSlide .simplified-header').hide();
					$('#noSlide .page-heading:first').hide();
					$('#noSlide #order_step').hide();					
					
					$(this).fadeIn('slow', function()
					{
						if (typeof bindUniform !=='undefined')
							bindUniform();
						if (typeof bindStateInputAndUpdate !=='undefined')
							bindStateInputAndUpdate();
						document.location = '#account-creation';
					});
				});
			}
		},
		error: function(XMLHttpRequest, textStatus, errorThrown)
		{
			error = "TECHNICAL ERROR: unable to load form.\n\nDetails:\nError thrown: " + XMLHttpRequest + "\n" + 'Text status: ' + textStatus;
			if (!!$.prototype.fancybox)
			{
				$.fancybox.open([
				{
					type: 'inline',
					autoScale: true,
					minHeight: 30,
					content: "<p class='fancybox-error'>" + error + '</p>'
				}],
				{
					padding: 0
				});
			}
			else
				alert(error);
		}
	});
}