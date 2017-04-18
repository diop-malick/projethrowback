$(document).ready(function() {
	//$('.breadcrumb').css("margin-left", "24.5%");
	$('#left_column').show();
	$('#center_column').removeClass('col-sm-12').addClass('col-sm-9');
	$('.menu_vertical').removeClass('hidden').addClass('show');
	$('#categories_block_left').show().css("position", "fixed").css("top", "140px").css("z-index", "5003").css("width", "18%");

	scrollAction();
});
