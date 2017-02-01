$('#left_column').hide();
$('#center_column').removeClass('col-sm-9').addClass('col-sm-12');

$( ".toggle_menu" ).click(function(e) {
	 e.preventDefault();
	 if ($( "#toggleMenu" ).hasClass("maxi")){

	 		//console.log($("#left_column").html());
	 	
		 	$('#left_column').show();
		 	$('#left_column').css("margin-top", "-40%");

			$('#center_column').removeClass('col-sm-12').addClass('col-sm-9');
			$('#center_column').css("float", "right");

		 	$('#homepage-slider').removeClass('col-xs-12').addClass('col-xs-9');
		 	$('#homepage-slider').css("width", "75%");
		 	$('#homepage-slider').css("float", "right");

		 	$('#toggleMenu').removeClass('maxi').addClass('mini');
	 }
	 else if ($( "#toggleMenu" ).hasClass("mini")){

		 	$('#left_column').hide();
		 	$('#left_column').css("margin-top", "40%");

			$('#center_column').removeClass('col-sm-9').addClass('col-sm-12');
			$('#center_column').css("float", "left");

		    $('#homepage-slider').removeClass('col-xs-9').addClass('col-xs-12');
		 	$('#homepage-slider').css("width", "100%");
		 	$('#homepage-slider').css("float", "left");

		 	$('#toggleMenu').removeClass('mini').addClass('maxi');
	 }
});