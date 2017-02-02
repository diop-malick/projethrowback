$('#left_column').hide();
$('#center_column').removeClass('col-sm-9').addClass('col-sm-12');

function fullPage() {
	$('#left_column').hide().css("position", "static");
	$('#center_column').removeClass('col-sm-9').addClass('col-sm-12').css("float", "left");
	$('#homepage-slider').removeClass('col-xs-9').addClass('col-xs-12').css("width", "100%").css("float", "left");
	$('#toggleMenu').removeClass('mini').addClass('maxi');
}

function minimizePage() {
	$('#left_column').show().css("position", "fixed").css("top", "160px").css("z-index", "5003").css("width", "20%");;
	$('#center_column').removeClass('col-sm-12').addClass('col-sm-9').css("float", "right");
	$('#homepage-slider').removeClass('col-xs-12').addClass('col-xs-9').css("width", "75%").css("float", "right");
	$('#toggleMenu').removeClass('maxi').addClass('mini');
}

$( ".toggle_menu" ).click(function(e) {
	 e.preventDefault();
	 if ($( "#toggleMenu" ).hasClass("maxi")){
	 		minimizePage();
	 }
	 else if ($( "#toggleMenu" ).hasClass("mini")){
			fullPage();
	 }
});

$(window).scroll(function (event) {
    var scroll = $(window).scrollTop();
    if(scroll>0){
    	$('#block_top_menu').removeClass('show').addClass('hidden');
    	$('.menu_vertical').removeClass('hidden').addClass('show');
    	$('#search_block_top').removeClass('col-sm-4').addClass('col-sm-3');
    	$('.nav').removeClass('show').addClass('hidden');
    }
    else{
    	$('#block_top_menu').removeClass('hidden').addClass('show');
    	$('.menu_vertical').removeClass('show').addClass('hidden');
    	$('#search_block_top').removeClass('col-sm-3').addClass('col-sm-4');
    	$('.nav').removeClass('hidden').addClass('show');

    	fullPage();
    }
});