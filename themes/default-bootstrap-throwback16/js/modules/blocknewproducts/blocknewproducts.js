$(document).ready(function()
{
	if ($('#bxslider li').length && !!$.prototype.bxSlider)
		$('#bxslider').bxSlider({
			minSlides: 2,
			maxSlides: 4,
			slideWidth: 290,
			slideMargin: 16,
			moveSlides:4,
			controls:false,
			infiniteLoop:false,
			hideControlOnEnd: true
		});

	if (!$('#bxslider li').length)
		$('.accessories-block').parent().remove();

});