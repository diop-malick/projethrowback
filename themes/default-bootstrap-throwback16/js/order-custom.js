$(document).ready(function(){

	// COLAPSE TABS
	$('.collapse').on('shown.bs.collapse', function(){
		$(this).parent().find(".resp-arrow").addClass("resp-arrow-active");		
		// $('input[type=radio]', this).first().click();
		}).on('hidden.bs.collapse', function(){
		$('.resp-arrow').removeClass("resp-arrow-active");
	});

});