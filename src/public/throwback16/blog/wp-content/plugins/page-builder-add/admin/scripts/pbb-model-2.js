( function( $ ) {
app.ULPBPage = Backbone.Model.extend({
      defaults:{
        pageID: P_ID,
        pageTitle:'',
        pageStatus:'Unpublished',
        pageBuilderVersion: PageBuilder_Version,
        pageOptions: {
          setFrontPage: 0,
          loadWpHead:0,
          loadWpFooter:0,
          pageBgImage: ' ',
          pageBgColor: 'transparent',
          pagePadding: '0',
          pageSeoName: '',
          pageSeoDescription: '',
          pageSeoKeywords: '',
        },
        rows:{}
      },
      url: URLL
});

app.ColWidget = Backbone.Model.extend({
      defaults:{
      	widgetType:' ',
        widgetStyling:' /* Your Custom Styling */',
        widgetMtop:'',
        widgetMleft:'',
        widgetMbottom:'',
        widgetMright:'',
        widgetBgColor: 'transparent',
        widgetWYSIWYG: {		
        	widgetContent: ' '
        },
        widgetMenu:{
        	menuName: 'Select',
          menuStyle: 'menu-style-1',
          menuColor: '#333'
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
        widgetSform:{
          sFormName: 'Select'
        },
        widgetPostSlider:{
          postsSliderName: 'Select'
        },
        widgetTestimonialSlider:{
          testimonialSliderName: 'Select'
        },
        widgetSocialFeed:{
          socialFeedName: 'Select'
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

      },
      url: '/'
});


app.RowCollection = Backbone.Collection.extend({
    model:app.Row
});

app.WidgetCollection = Backbone.Collection.extend({
    model:app.ColWidget
});


}( jQuery ) );