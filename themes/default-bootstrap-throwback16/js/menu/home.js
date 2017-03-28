$(document).ready(function() {

  if (window.matchMedia("(max-width: 768px)").matches) {
      $('.menu_vertical').removeClass('hidden').addClass('show');

        $(window).scroll(function (event) {
          var scroll_mob = $(window).scrollTop();
          if(scroll_mob>0){
              $('header .nav').removeClass('show').addClass('hidden');
              $(".logo-throwback").attr("src",url_logo_simple);
              $(".logo-throwback").css("margin-top", "20px");
        }
        else{

              $('header .nav').removeClass('hidden').addClass('show');
              $(".logo-throwback").attr("src",url_logo_simple);
              fullPage();

        }
      });

  } else {

        $('#left_column').hide();
        $('#center_column').removeClass('col-sm-9').addClass('col-sm-12');

        scrollAction();
    }

});
