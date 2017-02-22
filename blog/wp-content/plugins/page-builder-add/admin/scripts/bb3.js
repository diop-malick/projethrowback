( function( $ ) {

  $('.btnText').change(function(){
    $('#btn-prev').text($('.btnText').val());
  });
  $('.btnHeight').change(function(){
    var btnHeight = $('.btnHeight').val();
    var btnWidth = $('.btnWidth').val();
    $('#btn-prev').css('padding',btnHeight+'px '+btnWidth+'px '+btnHeight+'px '+btnWidth+'px');
  });
  $('.btnWidth').change(function(){
    var btnHeight = $('.btnHeight').val();
    var btnWidth = $('.btnWidth').val();
    $('#btn-prev').css('padding',btnHeight+'px '+btnWidth+'px '+btnHeight+'px '+btnWidth+'px');
  });
  $('.btnColor').change(function(){
    $('#btn-prev').css('color',$('.btnColor').val());
  });
  $('.btnFontSize').change(function(){
    $('#btn-prev').css('font-size',$('.btnFontSize').val()+'px');
  });
  $('.btnBgColor').change(function(){
    $('#btn-prev').css('background-color',$('.btnBgColor').val());
  });
  $('.btnHoverBgColor').change(function(){
       // $('#btn-prev').mouseOver().css('background-color',$('.btnColor').val());
  });
  $('.btnBorderWidth').change(function(){
    $('#btn-prev').css('border',$('.btnBorderWidth').val() +'px solid '+ $('.btnBorderColor').val());
  });
  $('.btnBorderColor').change(function(){
    $('#btn-prev').css('border-color',$('.btnBorderColor').val());
  });
  $('.btnBorderRadius').change(function(){
    $('#btn-prev').css('border-radius',$('.btnBorderRadius').val()+'px');
  });
  $('.btnButtonAlignment').change(function(){
    $('#btn-prev').parent().css('text-align',$('.btnButtonAlignment').val()+'px');
  });



$('.closeWidgetPopup').click(function(ev){
  var that = $(ev.target).attr('data-CurrWidget');
  $('div[data-saveCurrWidget="'+that+'"]').click();
});


$('.pageBgImage').change(function(){
    var pageBgImage = $('.pageBgImage').val();
    $('#container').attr('style','background-image: url("'+pageBgImage+'"); background-size:cover;');
  });

$('.card-img').mouseover(function(ev) {
  //console.log($(ev.target).children());
  var tempprevbtn = $(ev.target).attr('class').split(' ')[1];
  console.log(tempprevbtn);
  $('#'+tempprevbtn).width($(ev.target).width());
  $('#'+tempprevbtn).height($(ev.target).height());
  var tempPhieght = $(ev.target).height();
  $('.tempPrev p').css('margin-top',tempPhieght/2);
  $('#'+tempprevbtn).slideDown(100);
});
$('.card').mouseleave(function(ev){
  $('.tempPrev').slideUp('100');
});

$('.tempPrev').click(function(ev) {
  var ths_tempprev = $(ev.target).attr('id');
  $('.pb_preview_container').attr('style','display:block;overflow:auto;');
  var imgURL = $('img.'+ths_tempprev).attr('src');
  $('.pb_temp_prev').append('<img src='+$('img.'+ths_tempprev).attr('src')+' class="pb_temp_prev_img" >');
});

$('.pb_preview_container').click(function(){
  $('.pb_preview_container').attr('style','display:none;');
  $('.pb_temp_prev').html(' ');
});

}( jQuery ) );