
function fullPage() {
	if (window.matchMedia("(max-width: 768px)").matches) {$(".block_content").css("display", "none");
	$('#left_column').hide().css("position", "static");
	/*$('#center_column').removeClass('col-xs-3').addClass('col-xs-12').css("float", "left");
	$('#homepage-slider').removeClass('col-xs-9').addClass('col-xs-12').css("width", "100%").css("float", "left");*/

}else{
	$('#left_column').hide().css("position", "static");
	$('#center_column').removeClass('col-sm-9').addClass('col-sm-12').css("float", "left");
	$('#homepage-slider').removeClass('col-xs-9').addClass('col-xs-12').css("width", "100%").css("float", "left");
	$('#toggleMenu').removeClass('mini').addClass('maxi');

    $('.breadcrumb').css("margin-left", "0");
	}
	$('#toggleMenu').removeClass('mini').addClass('maxi');
}

function minimizePage() {

	if (window.matchMedia("(max-width: 768px)").matches) {$(".block_content").css("display", "block");
	$('#left_column').show().css("position", "fixed").css("top", "96px").css("z-index", "9999").css("width", "90%").css("background-color", "#fff").css("height", "100%");
	/*$('#center_column').removeClass('col-xs-12').addClass('col-xs-3').css("float", "right");
	$('#homepage-slider').removeClass('col-xs-12').addClass('col-xs-9').css("width", "75%").css("float", "right");*/
	}


	 else{
	$('#left_column').show().css("position", "fixed").css("top", "160px").css("z-index", "5003").css("width", "20%");
	$('#center_column').removeClass('col-sm-12').addClass('col-sm-9').css("float", "right");
	$('#homepage-slider').removeClass('col-xs-12').addClass('col-xs-9').css("width", "75%").css("float", "right");


    $('.breadcrumb').css("margin-left", "25.5%");
	}
	$('#toggleMenu').removeClass('maxi').addClass('mini');
}
$(document).ready(function() {
    $( ".toggle_menu" ).click(function(e) {

         e.preventDefault();
         if ($( "#toggleMenu" ).hasClass("maxi")){
                minimizePage();
         }
         else if ($( "#toggleMenu" ).hasClass("mini")){
                fullPage();
         }
    });

    $('.product_list li').hover(function () {
        $( this).addClass('hovered');
    }, function () {
        $( this).removeClass('hovered');
    });
});
