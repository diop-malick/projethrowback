
function fullPage() {
	if (window.matchMedia("only screen and (min-width: 480px) and  (max-width: 768px)").matches) {
			$(".block_content").css("display", "none");
			$('#left_column').hide().css("position", "static");
			/*$('#center_column').removeClass('col-xs-3').addClass('col-xs-12').css("float", "left");
			$('#homepage-slider').removeClass('col-xs-9').addClass('col-xs-12').css("width", "100%").css("float", "left");*/
	}else{
			$('#left_column').hide().css("position", "static");
			$('#center_column').removeClass('col-sm-9').addClass('col-sm-12').css("float", "left");
			$('#homepage-slider').removeClass('col-xs-9').addClass('col-xs-12').css("width", "100%").css("float", "left");
			$('.footer-container').css("width", "100%").css("float", "left");
			$('#toggleMenu').removeClass('mini').addClass('maxi');
			$('.breadcrumb').css("margin-left", "-0.7500em");
		 }
			$('#toggleMenu').removeClass('mini').addClass('maxi');
	}

function minimizePage() {

	if (window.matchMedia("only screen and (min-width: 480px) and (max-width: 768px)").matches) {
		$(".block_content").css("display", "block");
		$('#left_column').show().css("position", "fixed").css("top", "96px").css("z-index", "9999").css("width", "90%").css("background-color", "#fff").css("height", "100%");
		/*$('#center_column').removeClass('col-xs-12').addClass('col-xs-3').css("float", "right");
		$('#homepage-slider').removeClass('col-xs-12').addClass('col-xs-9').css("width", "75%").css("float", "right");*/
	}
	else{
			$('#left_column').show().css("position", "fixed").css("top", "80px").css("z-index", "5003").css("width", "20%");
			$('#center_column').removeClass('col-sm-12').addClass('col-sm-9').css("float", "right");
			$('#homepage-slider').removeClass('col-xs-12').addClass('col-xs-9').css("width", "75%").css("float", "right");
			$('.footer-container').css("width", "75%").css("float", "right");
			$('.breadcrumb').css("margin-left", "24.5%");
	}
	$('#toggleMenu').removeClass('maxi').addClass('mini');
}

function scrollAction(){
	$(window).scroll(function (event) {
        var scroll = $(window).scrollTop();

        // JavaScript API built in for detecting media mobile
        var isMobile = window.matchMedia("only screen and (max-width: 480px)");
	
        if(scroll>0 && !isMobile.matches ){
            // $('#block_top_menu').removeClass('show').addClass('hidden');
            $('.menu_vertical').removeClass('hidden').addClass('show');
            //$('#search_block_top').removeClass('col-sm-4').addClass('col-sm-3');
            $('header .nav').removeClass('show').addClass('hidden');
            $(".logo-throwback").attr("src",url_logo_simple);
            $("#header_logo").css("margin-top", "-20px");
        }
        else{
            // $('#block_top_menu').removeClass('hidden').addClass('show');
            $('.menu_vertical').removeClass('show').addClass('hidden');
            //$('#search_block_top').removeClass('col-sm-3').addClass('col-sm-4');
            $('header .nav').removeClass('hidden').addClass('show');
            $(".logo-throwback").attr("src",url_logo);
            $("#header_logo").css("margin-top", "-70px");
            fullPage();
        }
    });
}
$(document).ready(function() {
    $( ".toggle_menu" ).click(function(e) {
         e.preventDefault();
         $('#left_column #block_top_menu ul.sf-menu').show();
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

    // check mobile device
    var browser_device = (/android|webos|iphone|ipad|ipod|blackberry|iemobile|opera mini/i.test(navigator.userAgent.toLowerCase()));
    console.log(browser_device);
    console.log(navigator.userAgent);
    if( /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent) ) {
        // You are in mobile browser
        console.log('ok');
    }

});
