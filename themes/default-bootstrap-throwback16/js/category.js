
$(document).ready(function(){
	
	resizeCatimg();

	/* from menu/category.js */
	$('#left_column').show();
	$('#center_column').removeClass('col-sm-12').addClass('col-sm-9');
	$('.menu_vertical').removeClass('hidden').addClass('show');
	$('#categories_block_left').show().css("position", "fixed").css("top", "140px").css("z-index", "5003").css("width", "18%");

	scrollAction();

});

$(window).resize(function(){
	resizeCatimg();
});

$(document).on('click', '.lnk_more', function(e){
	e.preventDefault();
	$('#category_description_short').hide(); 
	$('#category_description_full').show(); 
	$(this).hide();
});

function resizeCatimg()
{
	var div = $('.content_scene_cat div:first');

	if (div.css('background-image') == 'none')
		return;

	var image = new Image;

	$(image).load(function(){
	    var width  = image.width;
	    var height = image.height;
		var ratio = parseFloat(height / width);
		var calc = Math.round(ratio * parseInt(div.outerWidth(false)));

		div.css('min-height', calc);
	});
	if (div.length)
		image.src = div.css('background-image').replace(/url\("?|"?\)$/ig, '');
}