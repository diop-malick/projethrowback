$(document).ready(function(){

	// COLAPSE TABS
	$('.collapse').on('shown.bs.collapse', function(){
		$(this).parent().find(".resp-arrow").addClass("resp-arrow-active");
		if(this.id=="collapse0"){
			$('button.buttonpayment').removeClass('hidden');
		}
		else if(this.id=="collapse1"){
			$('button.buttonpayment').addClass('hidden');
		}
		// $('input[type=radio]', this).first().click();
		}).on('hidden.bs.collapse', function(){
		$('.resp-arrow').removeClass("resp-arrow-active");
			if(this.id=="collapse0"){
				$('button.buttonpayment').addClass('hidden');
			}
	});

});