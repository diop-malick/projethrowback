/*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @version  Release: $Revision$
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

$(document).ready(function(){

	if (typeof(homeslider_speed) == 'undefined')
		homeslider_speed = 500;
	if (typeof(homeslider_pause) == 'undefined')
		homeslider_pause = 3000;
	if (typeof(homeslider_loop) == 'undefined')
		homeslider_loop = true;
	if (typeof(homeslider_width) == 'undefined')
		homeslider_width = 779;


	$('.homeslider-description').click(function () {
		window.location.href = $(this).prev('a').prop('href');
	});

	if ($('#htmlcontent_top').length > 0)
		$('#homepage-slider').addClass('col-xs-8');
	else
		$('#homepage-slider').addClass('col-xs-12');

	if (!!$.prototype.bxSlider)
		slider = $('#homeslider').bxSlider({

			useCSS: false,
			maxSlides: 1,
			slideWidth: homeslider_width,
			infiniteLoop: homeslider_loop,
			hideControlOnEnd: true,
			pager: true,
			autoControls : false,
			autoHover: true,
			auto: homeslider_loop,
			speed: parseInt(homeslider_speed),
			pause: homeslider_pause,
			controls: false,
			// auto: true,

			// Executes immediately after each slide transition
			onSlideAfter: function(currentSlide){
				$(".homeslider-description").show('slow', function() {
					
				});
				if(slider.getCurrentSlide() == 1){
					$(".homeslider-description h2").addClass("animated rotateInDownLeft");
					$(".homeslider-description p").addClass("animated rotateInDownRight");
				} 
				else if (slider.getCurrentSlide() == 2) {
					$(".homeslider-description h2").addClass("animated bounceInLeft");
					$(".homeslider-description p").addClass("animated bounceInLeft");
				} else if (slider.getCurrentSlide() == 3) {
					$(".homeslider-description h2").addClass("animated lightSpeedIn");
					$(".homeslider-description p").addClass("animated bounceInDown");
				}

				

        
        },
        // Executes immediately before each slide transition.
        onSlideBefore: function(){
        	 $(".homeslider-description").fadeOut();
        if(slider.getCurrentSlide() == 1){
					$(".homeslider-description h2").removeClass("animated").removeClass("rotateInDownLeft");
					$(".homeslider-description p").removeClass("animated").removeClass("rotateInDownRight");
				} 
				else if (slider.getCurrentSlide() == 1) {
					$(".homeslider-description h2").removeClass("animated").removeClass("bounceInLeft");
					$(".homeslider-description p").removeClass("animated").removeClass("bounceInLeft");
				}
				else if (slider.getCurrentSlide() == 3) {
					$(".homeslider-description h2").removeClass("animated").removeClass("lightSpeedIn");
					$(".homeslider-description p").removeClass("animated").removeClass("flip");
				}
        }

		});
});