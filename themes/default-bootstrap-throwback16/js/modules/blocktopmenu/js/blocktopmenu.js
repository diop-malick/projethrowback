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

var responsiveflagMenu = false;
var categoryMenu = $('ul.sf-menu');
var mCategoryGrover = $('.sf-contener .cat-title');

$(document).ready(function(){
	categoryMenu = $('ul.sf-menu');
	mCategoryGrover = $('.sf-contener .cat-title');
	responsiveMenu();
	$(window).resize(responsiveMenu);
/*
	// Desactiver les liens catégories cms dans le menu horizontal
	var catCmsDir = "index.php?id_cms_category";
	var dir = baseDir + catCmsDir;
	var els = document.querySelectorAll("a[href^='"+dir+"']");
	for (var i = 0, l = els.length; i < l; i++) {
  		var el = els[i];

  		el.style.pointerEvents = "none";
	}
*/
 	/*
	 var node = document.querySelector('a[title="Services"]')
	console.log(node);
	node.onclick = function(){node.href ="http://sn-ecommerce.fr"};
		console.log(node); */
/*	$(node).on('click', function(){
	window.location.href = "http://localhost/throwback16/index.php?id_cms=7&controller=cms&id_lang=1" ;
	 console.log(window.location.href);
  }); */
});

// check resolution
function responsiveMenu()
{
    if ($(window).width() <= 767 && responsiveflagMenu == false) {
        menuChange('enable');
        responsiveflagMenu = true;
    } else if ($(window).width() >= 768) {
        menuChange('disable');
        responsiveflagMenu = false;
    }
}

// init Super Fish Menu for 767px+ resolution
function desktopInit()
{
	mCategoryGrover.off();
	mCategoryGrover.removeClass('active');
	$('#header #block_top_menu .sf-menu > li > ul').removeClass('menu-mobile').parent().find('.menu-mobile-grover').remove();
	$('#header #block_top_menu .sf-menu').removeAttr('style');
	categoryMenu.superfish('init');
	//add class for width define
	$('#header #block_top_menu .sf-menu > li > ul').addClass('submenu-container clearfix');
	 // loop through each sublist under each top list item
    $('#header #block_top_menu .sf-menu > li > ul').each(function(){
        i = 0;
        //add classes for clearing
        $(this).each(function(){
            if ($(this).attr('class') != "category-thumbnail"){
                i++;
                if(i % 2 == 1)
                    $(this).addClass('first-in-line-xs');
                else if (i % 5 == 1)
                    $(this).addClass('first-in-line-lg');
            }
        });
    });
}

function mobileInit()
{

	categoryMenu.superfish('destroy');
	$('.sf-menu').removeAttr('style');

	mCategoryGrover.on('click', function(e){
		$(this).toggleClass('active').parent().find('ul.menu-content').stop().slideToggle('medium');
		return false;
	});

	$('.sf-menu > li > ul').addClass('menu-mobile clearfix').parent().prepend('<span class="menu-mobile-grover"></span>');

	$(".sf-menu .menu-mobile-grover").on('click', function(e){
		var catSubUl = $(this).next().next('.menu-mobile');
		if (catSubUl.is(':hidden'))
		{
			catSubUl.slideDown();
			$(this).addClass('active');
		}
		else
		{
			catSubUl.slideUp();
			$(this).removeClass('active');
		}
		return false;
	});


	$('#block_top_menu > ul:first > li > a').on('click', function(e){
		var parentOffset = $(this).prev().offset();
	   	var relX = parentOffset.left - e.pageX;
		if ($(this).parent('li').find('ul').length && relX >= 0 && relX <= 20)
		{
			e.preventDefault();
			var mobCatSubUl = $(this).next('.menu-mobile');
			var mobMenuGrover = $(this).prev();
			if (mobCatSubUl.is(':hidden'))
			{
				mobCatSubUl.slideDown();
				mobMenuGrover.addClass('active');
			}
			else
			{
				mobCatSubUl.slideUp();
				mobMenuGrover.removeClass('active');
			}
		}
	});

}


function menuLateral()
{
	$('#left_column #block_top_menu .cat-title').addClass('active');
	$('#left_column #block_top_menu ul.sf-menu').superfish('destroy');
	$('#left_column #block_top_menu .sf-menu').removeAttr('style');

	$('#left_column #block_top_menu .cat-title').hide();

	mCategoryGrover.on('click', function(e){
		$(this).toggleClass('active').parent().find('#left_column #block_top_menu ul.menu-content').stop().slideToggle('medium');
		return false;
	});

	$('#left_column #block_top_menu .sf-menu > li > ul').addClass('menu-mobile clearfix').parent().prepend('<span class="menu-mobile-grover"></span>');

	$('#left_column #block_top_menu .menu-mobile').hide();

	$("#left_column #block_top_menu .sf-menu .menu-mobile-grover").on('click', function(e){
		var catSubUl = $(this).next().next('.menu-mobile');
		if (catSubUl.is(':hidden'))
		{
			catSubUl.slideDown();
			$(this).addClass('active');
		}
		else
		{
			catSubUl.slideUp();
			$(this).removeClass('active');
		}
		return false;
	});


	$('#left_column #block_top_menu > ul:first > li > a').on('click', function(e){
		var parentOffset = $(this).prev().offset();
	   	var relX = parentOffset.left - e.pageX;
		if ($(this).parent('li').find('ul').length && relX >= 0 && relX <= 20)
		{
			e.preventDefault();
			var mobCatSubUl = $(this).next('.menu-mobile');
			var mobMenuGrover = $(this).prev();
			if (mobCatSubUl.is(':hidden'))
			{
				mobCatSubUl.slideDown();
				mobMenuGrover.addClass('active');
			}
			else
			{
				mobCatSubUl.slideUp();
				mobMenuGrover.removeClass('active');
			}
		}
	});

}

// change the menu display at different resolutions
function menuChange(status)
{
	//status == 'enable' ? mobileInit(): desktopInit();

	if(status == 'enable'){
		mobileInit();
		menuLateral();
	}
		
	else{
		desktopInit();
		menuLateral();
		
	}
}
