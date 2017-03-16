$(document).ready(function(){

	// COLAPSE TABS
	$('.collapse').on('shown.bs.collapse', function(){
		$(this).parent().find(".resp-arrow").addClass("resp-arrow-active");		
		if(this.id=="collapse0"){
			$('button.standard-checkout').removeClass('hidden');
		}
		else if(this.id=="collapse1"){
			$('button.standard-checkout').addClass('hidden');
		}
		// $('input[type=radio]', this).first().click();
		}).on('hidden.bs.collapse', function(){
		$('.resp-arrow').removeClass("resp-arrow-active");
			if(this.id=="collapse0"){
				$('button.standard-checkout').addClass('hidden');
			}
	});

});