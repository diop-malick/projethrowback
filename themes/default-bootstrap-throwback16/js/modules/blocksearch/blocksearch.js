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
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*/

var instantSearchQueries = [];

$(document).ready(function()
{
	if (typeof blocksearch_type == 'undefined')
		return;
					// CLEARABLE INPUT
			function tog(v){
	   		return v?'addClass':'removeClass';
	   }


	   $(document).on('input', '.search_query.form-control', function() {
	       $(this)[tog(this.value)]('x');
	   }).on('mousemove', '.x', function(e) {
	       $(this)[tog(this.offsetWidth-18 < e.clientX-this.getBoundingClientRect().left)]('onX');
	   }).on('click', '.onX', function(){
	       $(this).removeClass('x onX').val('').change();



				 var search_id = $(this).closest("form").attr('id');
				 var active_input = $(this).closest("input").attr('id');
				 $("#"+active_input+"").blur();
				 if ($(this).val() == '') {

						 $("#"+search_id+" :submit").prop('disabled', true);

				 } else {
					 $("#"+search_id+" :submit").prop('disabled', false);


				 }
	   });


			var $input = $("#search_query_" + blocksearch_type);


	var width_ac_results = 	$input.parent('form').outerWidth();
	if (typeof ajaxsearch != 'undefined' && ajaxsearch) {
		$input.autocomplete(
			search_url,
			{
				minChars: 3,
				max: 10,
				width: (width_ac_results > 0 ? width_ac_results : 500),
				selectFirst: false,
				scroll: false,
				dataType: "json",
				formatItem: function(data, i, max, value, term) {
					return value;
				},
				parse: function(data) {
					var mytab = [];
					for (var i = 0; i < data.length; i++)
						mytab[mytab.length] = { data: data[i], value: data[i].cname + ' > ' + data[i].pname };
					return mytab;
				},
				extraParams: {
					ajaxSearch: 1,
					id_lang: id_lang
				}
			}
		)
		.result(function(event, data, formatted) {
			$input.val(data.pname);
			document.location.href = data.product_link;
		});
	}

	if (typeof instantsearch != 'undefined' && instantsearch) {
		$input.on('keyup', function(){
			if($(this).val().length > 4)
			{
				stopInstantSearchQueries();
				instantSearchQuery = $.ajax({
					url: search_url + '?rand=' + new Date().getTime(),
					data: {
						instantSearch: 1,
						id_lang: id_lang,
						q: $(this).val()
					},
					dataType: 'html',
					type: 'POST',
					headers: { "cache-control": "no-cache" },
					async: true,
					cache: false,
					success: function(data){
						if ($input.val().length > 0) {
							tryToCloseInstantSearch();
							$('#center_column').attr('id', 'old_center_column');
							$('#old_center_column').after('<div id="center_column" class="' + $('#old_center_column').attr('class') + '">' + data + '</div>').hide();
							// Button override
							ajaxCart.overrideButtonsInThePage();
							$("#instant_search_results a.close").on('click', function() {
								$input.val('');
								return tryToCloseInstantSearch();
							});
							return false;
						}
						else
							tryToCloseInstantSearch();
					}
				});
				instantSearchQueries.push(instantSearchQuery);
			}
			else
				tryToCloseInstantSearch();
		});
	}
	$("#search_query_top").val('');
	// disable search button if empty search term
		var input_top = $("#search_query_top");
			input_top.keyup(function () {
				if ($(this).val() == '') {

						$("#searchbox :submit").prop('disabled', true);

				} else {
					$("#searchbox :submit").prop('disabled', false);

				}
		}).keyup();
		var input_block = $("#search_query_block");
			input_block.keyup(function () {
				if ($(this).val() == '') {

						$("#searchbox2 :submit").prop('disabled', true);

				} else {
					$("#searchbox2 :submit").prop('disabled', false);

				}
		}).keyup();
/*

		$('#search_query_top').on({
			focus: function () {

					$("#test").addClass('focused').removeClass('blured');
			},
			blur: function () {
					$("#test").removeClass('focused').addClass( 'blured' );
					if ($("#test").is( ':focus')) {

			 		}else{

	 						 }

			}
	}); */
	/* Mobile device */

	$('#search_query_top').on({

	focus: function () {
	//$('span').css('cssText', 'color: red !important');

	//console.log($('#header_logo'));
	if (window.matchMedia("(max-width: 420px)").matches) {
	/* La largeur maximum de l'affichage est 420 px inclus */
	/*$('#header_logo').css('cssText', 'margin-left: 25px !important');*/
	$('#menu_and_serach').removeClass('col-xs-4').addClass('col-xs-6');
	$('#header_logo').removeClass('col-xs-4').addClass('col-xs-3');
	$('#user_info').removeClass('col-xs-4').addClass('col-xs-3');
	$('.ac_results').css('cssText', 'width: 100px !important');

		} else {
	/* L'affichage est supèrieur à 420px de large */
		}

		}
	});

	$('#search_query_top').on({

	blur: function () {

	//console.log($('#header_logo'));
	if (window.matchMedia("(max-width: 420px)").matches) {
	/* La largeur maximum de l'affichage est 420 px inclus */
	$('#menu_and_serach').removeClass('col-xs-6').addClass('col-xs-4');
	$('#header_logo').removeClass('col-xs-3').addClass('col-xs-4');
	$('#user_info').removeClass('col-xs-3').addClass('col-xs-4');
	//$("#header_logo").css('marging-left', '45px');
		} else {
	/* L'affichage est supèrieur à 420px de large */
		}

		}
	});

});


function tryToCloseInstantSearch()
{
	var $oldCenterColumn = $('#old_center_column');
	if ($oldCenterColumn.length > 0)
	{
		$('#center_column').remove();
		$oldCenterColumn.attr('id', 'center_column').show();
		return false;
	}
}

function stopInstantSearchQueries()
{
	for(var i=0; i<instantSearchQueries.length; i++)
		instantSearchQueries[i].abort();
	instantSearchQueries = [];
}
