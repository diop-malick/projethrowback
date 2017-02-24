$(document).ready(function()
{
console.log('slider new product');
	if ($('#bxslider li').length && !!$.prototype.bxSlider)
		$('#bxslider').bxSlider({
			minSlides: 2,
			maxSlides: 4,
			slideWidth: 285,
			slideMargin: 16,
			moveSlides:4,
			controls:false,
			infiniteLoop:false,
			hideControlOnEnd: true
		});

	if (!$('#bxslider li').length)
		$('.accessories-block').parent().remove();

});