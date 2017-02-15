$(document).ready(function() {
	if ($('#bxslider1 li').length && !!$.prototype.bxSlider)
		$('#bxslider1').bxSlider({
			minSlides: 2,
			maxSlides: 4,
			slideWidth: 271,
			slideMargin: 16,
			// pager: false,
			// nextText: '',
			// prevText: '',
			moveSlides:4,
			controls:false,
			infiniteLoop:false,
			hideControlOnEnd: true
		});

	if (!$('#bxslider1 li').length)
		$('#productscategory_list').parent().remove();
});