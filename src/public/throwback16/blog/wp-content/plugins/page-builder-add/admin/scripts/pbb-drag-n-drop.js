( function( $ ) {

$(function(){
   $('.wdt-draggable').draggable({revert: true,cursor: "move"});  
});

$('.add-widgets').click(function(){

  app.widgetList.add({
        widgetType:'wigt-WYSIWYG',
        widgetMtop:'0',
        widgetMleft:'0',
        widgetMbottom:'0',
        widgetMright:'0',
        widgetWYSIWYG: {    
          widgetContent: 'Some Text'
        },
        widgetMenu:{
          menuName: 'Select',
          menuStyle: 'None'
        },
        widgetImg:{
          imgUrl: '/',
          imgSize: 'original',
          imgAlignment: 'default'
        },
        widgetForm:{
          formName: 'Select'
        },
        widgetSlider:{
          sliderName: 'Select'
        },
        widgetButton:{
          btnText: 'Click Me',
          btnLink: '#',
          btnTextColor: '#fff',
          btnFontSize: '14px',
          btnBgColor: '#333',
          btnWidth: '40',
          btnHeight: '20',
          btnHoverBgColor: '#222',
          btnBlankAttr: '_blank',
          btnBorderColor: '',
          btnBorderWidth: '',
          btnBorderRadius: '10',
          btnButtonAlignment: 'Select',
        },
  });



  $('.wdt-droppable').droppable({
    drop: function(event,ui){
      var type = ui.draggable.data('type');
      var curr_droppable = $(this).attr('data-widgetid');
      $('input[data-widgetType-id="'+curr_droppable+'"]').val(type);
      switch(type){
        case 'wigt-WYSIWYG': var texta = "HTML Editor"; break;
        case 'wigt-img': var texta = "Image Widget"; break;
        case 'wigt-menu': var texta = "Menu Widget"; break;
        case 'wigt-slider': var texta = "Slider Extension"; break;
        case 'wigt-smuzform': var texta = "Form Extension"; break;
        case 'wigt-btn-gen': var texta = "Button Generator Extension"; break;
        default : var texta = 'No widget or extension'; break;
      }


      $('.widget-area-'+curr_droppable).html(texta+ ' is selected <br> To edit click the green button below. <br> To change widget just drop any other widget here.');

      $('.editWidget-'+curr_droppable).trigger('click');

    }
   });

});


}( jQuery ) );