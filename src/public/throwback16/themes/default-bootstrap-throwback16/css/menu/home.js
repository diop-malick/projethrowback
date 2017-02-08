$('#left_column').hide();
$('#center_column').removeClass('col-sm-9').addClass('col-sm-12');
$(window).scroll(function (event) {
    var scroll = $(window).scrollTop();
    if(scroll>0){
        $('#block_top_menu').removeClass('show').addClass('hidden');
        $('.menu_vertical').removeClass('hidden').addClass('show');
        $('#search_block_top').removeClass('col-sm-4').addClass('col-sm-3');
        $('.nav').removeClass('show').addClass('hidden');
    }
    else{
        $('#block_top_menu').removeClass('hidden').addClass('show');
        $('.menu_vertical').removeClass('show').addClass('hidden');
        $('#search_block_top').removeClass('col-sm-3').addClass('col-sm-4');
        $('.nav').removeClass('hidden').addClass('show');

        fullPage();
    }
});