var responsiveflagMenu = false;
var categoryMenu = $('ul.sf-menu');
var mCategoryGrover = $('.sf-contener .cat-title');

$(document).ready(function() {
    categoryMenu = $('ul.sf-menu');
    mCategoryGrover = $('.sf-contener .cat-title');
    responsiveMenu();

    if ($(window).width() <= 767) // executerseulemt sur mobile
        $(window).resize(responsiveMenu);

});

// check resolution
function responsiveMenu() {
    if ($(window).width() <= 767 && responsiveflagMenu == false) {
        menuChange('enable');
        responsiveflagMenu = true;
    } else if ($(window).width() >= 768) {
        menuChange('disable');
        responsiveflagMenu = false;
    }
}

// init Super Fish Menu for 767px+ resolution
function desktopInit() {
    mCategoryGrover.off();
    mCategoryGrover.removeClass('active');
    $('#header #block_top_menu .sf-menu > li > ul').removeClass('menu-mobile').parent().find('.menu-mobile-grover').remove();
    $('#header #block_top_menu .sf-menu').removeAttr('style');
    categoryMenu.superfish('init');
    //add class for width define
    $('#header #block_top_menu .sf-menu > li > ul').addClass('submenu-container clearfix');
    // loop through each sublist under each top list item
    $('#header #block_top_menu .sf-menu > li > ul').each(function() {
        i = 0;
        //add classes for clearing
        $(this).each(function() {
            if ($(this).attr('class') != "category-thumbnail") {
                i++;
                if (i % 2 == 1)
                    $(this).addClass('first-in-line-xs');
                else if (i % 5 == 1)
                    $(this).addClass('first-in-line-lg');
            }
        });
    });
}

function mobileInit() {

    categoryMenu.superfish('destroy');
    $('.sf-menu').removeAttr('style');

    mCategoryGrover.on('click', function(e) {
        $(this).toggleClass('active').parent().find('ul.menu-content').stop().slideToggle('medium');
        return false;
    });

    $('.sf-menu > li > ul').addClass('menu-mobile clearfix').parent().prepend('<span class="menu-mobile-grover"></span>');

    $(".sf-menu .menu-mobile-grover").on('click', function(e) {
        var catSubUl = $(this).next().next('.menu-mobile');
        if (catSubUl.is(':hidden')) {
            catSubUl.slideDown();
            $(this).addClass('active');
        } else {
            catSubUl.slideUp();
            $(this).removeClass('active');
        }
        return false;
    });


    $('#block_top_menu > ul:first > li > a').on('click', function(e) {
        var parentOffset = $(this).prev().offset();
        var relX = parentOffset.left - e.pageX;
        if ($(this).parent('li').find('ul').length && relX >= 0 && relX <= 20) {
            e.preventDefault();
            var mobCatSubUl = $(this).next('.menu-mobile');
            var mobMenuGrover = $(this).prev();
            if (mobCatSubUl.is(':hidden')) {
                mobCatSubUl.slideDown();
                mobMenuGrover.addClass('active');
            } else {
                mobCatSubUl.slideUp();
                mobMenuGrover.removeClass('active');
            }
        }
    });

}


function menuLateral() {
    $('#left_column #block_top_menu .cat-title').addClass('active');
    $('#left_column #block_top_menu ul.sf-menu').superfish('destroy');
    $('#left_column #block_top_menu .sf-menu').removeAttr('style');

    $('#left_column #block_top_menu .cat-title').hide();

    mCategoryGrover.on('click', function(e) {
        $(this).toggleClass('active').parent().find('#left_column #block_top_menu ul.menu-content').stop().slideToggle('medium');
        return false;
    });

    $('#left_column #block_top_menu .sf-menu > li > ul').addClass('menu-mobile clearfix').parent().prepend('<span class="menu-mobile-grover"></span>');

    $('#left_column #block_top_menu .menu-mobile').hide();

    $("#left_column #block_top_menu .sf-menu .menu-mobile-grover").on('click', function(e) {
        var catSubUl = $(this).next().next('.menu-mobile');
        if (catSubUl.is(':hidden')) {
            catSubUl.slideDown();
            $(this).addClass('active');
        } else {
            catSubUl.slideUp();
            $(this).removeClass('active');
        }
        return false;
    });


    $('#left_column #block_top_menu > ul:first > li > a').on('click', function(e) {
        var parentOffset = $(this).prev().offset();
        var relX = parentOffset.left - e.pageX;
        if ($(this).parent('li').find('ul').length && relX >= 0 && relX <= 20) {
            e.preventDefault();
            var mobCatSubUl = $(this).next('.menu-mobile');
            var mobMenuGrover = $(this).prev();
            if (mobCatSubUl.is(':hidden')) {
                mobCatSubUl.slideDown();
                mobMenuGrover.addClass('active');
            } else {
                mobCatSubUl.slideUp();
                mobMenuGrover.removeClass('active');
            }
        }
    });

}

function menuChange(status) {
    if (status == 'enable') {
        mobileInit();
        menuLateral();
    } else {
        desktopInit();
        menuLateral();

    }
}
