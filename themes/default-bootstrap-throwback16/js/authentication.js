$(document).ready(function(){

	var isBusy = false; //first time, busy state is false

	$(document).on('submit', '#create-account_form', function(e){
		e.preventDefault();
		// console.log('create-account_form');
		submitFunction();
	});
	$('.is_customer_param').hide();


	
	$(document).on('submit', '#account-creation_formTMP', function(e){
			e.preventDefault();
			e.returnValue = false;

			var $form = $(this);			
				console.log('account-creation_form - Mailchimps');
				
				// Find out if a single newletter checkbox is checked or not
				if ($('#newsletter').is(":checked"))
				{
				  console.log('Checked');
				  var email = $('#email').val();
			        var customer_firstname = $('#customer_firstname').val();
			        var customer_lastname = $('#customer_lastname').val();
			        if(customer_firstname === '' || customer_lastname === '' || email === '') {
			            console.log('fields are required');
			        } else {
			        	    $.ajax({
					          type: "GET",
					          url: "https://ovh.us15.list-manage.com/subscribe/post-json?u=d56def1fdca3f61da060d5d2a&amp;id=2eca580371",
					          data: {
					          	"EMAIL": email,
					          	"FNAME": customer_firstname,
					          	"LNAME": customer_firstname
					          },
					          dataType    : 'jsonp',
					          jsonp       : 'c',
					          contentType: "application/json; charset=utf-8",
					          error       : function(err) { alert("Could not connect to the registration server."); },
					          success     : function(data) {
					          	console.log(data.msg); 
					         },
					         complete: function() { 
					         	console.log('Complete');
					            submitCustomFunction();
					         }
					      });
			        }
				} else {
					console.log('Not checked');
					isBusy = true;
					// e.returnValue = true;
					//$form.submit();
				}

			// return true;		  
	});
	
});

function submitCustomFunction()
{
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
				submitAccount: 1,
				ajax: true,
				token: token
			},
			success: function(jsonData)
			{
				console.log('submitCustomFunction OK');
				console.log(jsonData);
			},
			error: function(XMLHttpRequest, textStatus, errorThrown)
			{
				console.log('submitCustomFunction , not OK');
			}
		}
}


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
					$('#noSlide .simplified-header').hide();
					$('.page-heading:first').hide();
					
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