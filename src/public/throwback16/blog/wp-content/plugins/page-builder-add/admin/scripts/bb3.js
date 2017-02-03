( function( $ ) {
  app.RowView = Backbone.View.extend({
    tagName: 'section',
    className: 'row',
    template: _.template($('#item-template').html()),
    events: {
      'click #rowDelete': 'deleteRow',
      'click #rowEdit': 'EditRow',
      'click #editRowSave': 'updateRow',
      'click #WidthSave': 'updateWidth',
      'dblclick div.column': 'EditColumn',
      'click #editColumnSave': 'updateColumn'
    },
    attributes: function() {
        if(this.model) {
            return {
                RowID: this.model.get('rowID')
            }
        }
        return {}
    },
    initialize: function(){
      _.bindAll(this, 'render','deleteRow','updateRow','EditRow','EditColumn','updateColumn','updateWidth'); 
    },
    render: function(){
      this.$el.html(this.template(this.model.toJSON() )  );

      var rowID = this.model.get('rowID');
      var rowCID = this.model.cid;
      rowColumns = this.model.get('columns');
      rowHeight = this.model.get('rowHeight');
      var rowData = this.model.get('rowData');
      var row_bg_img = rowData['bg_img'];
      var row_bg_color = rowData['bg_color'];
      var row_margin = rowData['margin'];
      var row_padding = rowData['padding'];
      var custom_styling = rowData['customStyling'];
      var custom_JS = rowData['customJS'];

      $(this.el).attr('style','min-height:'+rowHeight+'px; background:'+row_bg_color+'; margin:'+row_margin+'px; padding:'+row_padding+'px;');

      $(this.el).append('<style>'+custom_styling+'</style>');

      if (row_bg_img) {
        $(this.el).css('background','url("'+row_bg_img+'")');
      }
    

      for(var i = 1; i <= rowColumns; i++){
        var this_column = 'column'+i;
        var thisColumnModelData = this.model.get(this_column);
        
        var this_column_options = thisColumnModelData['columnOptions'];
        var this_column_bg_color = this_column_options['bg_color'];
        var this_column_margin = this_column_options['margin'];
        var this_column_padding = this_column_options['padding'];
        var colWidth = this_column_options['width'];

        var columnMarginTop = this_column_margin['columnMarginTop'];
        var columnMarginRight = this_column_margin['columnMarginRight'];
        var columnMarginBottom = this_column_margin['columnMarginBottom'];
        var columnMarginLeft = this_column_margin['columnMarginLeft'];

        var this_column_margins = "'margin:"+columnMarginTop+"px "+columnMarginRight+"px "+columnMarginBottom+"px "+columnMarginLeft+"px;'";

        if (colWidth === "") {
          switch (rowColumns) {
          case '1':
            colWidth = '1268';
            break;
          case '2':
            colWidth = '633';
            break;
          case '3':
            colWidth = '421.5';
            break;
          case '4':
            colWidth = '314.5';
            break;
          case '5':
            colWidth = '242.4';
            break;
          case '6':
            colWidth = '204';
            break;
          case '7':
            colWidth = '172.2';
            break;
          case '8':
            colWidth = '146.7';
            break;
          case '9':
            colWidth = '133.9';
            break;
          case '10':
            colWidth = '63.8';
            break;  
          default:
            colWidth = '1276';
            break;
        }
      }

        $(this.el).append('<div class="column '+this_column+'" id='+rowID+'-'+this_column+' data-col_id='+this_column+' style="width:' + colWidth +'px;min-height:'+(rowHeight-25)+'px; background:'+this_column_bg_color+'; text-align:'+'contentAlign'+' "><div class="overlay" style="width:'+colWidth+'px;height:'+(rowHeight-25)+'px;" data-col_id='+this_column+' data-overlay_id='+this_column+'><img src="https://cdn4.iconfinder.com/data/icons/basic-ui-elements/700/09_pencil-512.png" style="margin-top:'+((rowHeight-100)/2)+'px; "  id="col-edit-icon" data-col_id='+this_column+' ><p style="color:white; font-size:18px; text-align:center;">  Double Click To Edit The Column</p></div></div>');

        var this_column_widgets = thisColumnModelData['colWidgets'];
        var this_column_widgets_array = _.values(this_column_widgets);

      for (var j = 0; j < this_column_widgets_array.length; j++) { 

        var this_column_widgets_array_C = this_column_widgets_array[j];
        var this_column_widgets_array_current = this_column_widgets_array_C;

        var this_column_type = this_column_widgets_array_current['widgetType'];
        var widgetStyling = this_column_widgets_array_current['widgetStyling'];
        var this_column_editor = this_column_widgets_array_current['widgetWYSIWYG'];
        var this_column_editor_content = this_column_editor['widgetContent'];
        var this_column_img_content = this_column_widgets_array_current['widgetImg'];
        var imgUrl  = this_column_img_content['imgUrl'];
        var imgSize = this_column_img_content['imgSize'];
        var imgAlignment = this_column_img_content['imgAlignment'];
        var this_column_img = "<img src="+imgUrl+" style='text-align:"+imgAlignment+";' align="+imgAlignment+" class='ftr-img-"+this_column+" img-"+imgSize+" '>";

        var this_column_menu_content = this_column_widgets_array_current['widgetMenu'];
        var menuName = this_column_menu_content['menuName'];
        var menuStyle = this_column_menu_content['menuStyle'];
        var this_column_menu  = "<img style='max-width:100%;' src='"+PageBuilderAdminImageFolderPath+menuStyle+".png' />";

        var this_widget_btn = this_column_widgets_array_current['widgetButton'];
        var btnText = this_widget_btn['btnText'];
        var btnLink = this_widget_btn['btnLink'];
        var btnBgColor = this_widget_btn['btnBgColor'];
        var btnTextColor = this_widget_btn['btnTextColor'];
        var btnFontSize = this_widget_btn['btnFontSize'];
        var btnHoverBgColor = this_widget_btn['btnHoverBgColor'];
        var btnWidth = this_widget_btn['btnWidth'];
        var btnHeight = this_widget_btn['btnHeight'];
        var btnBlankAttr = this_widget_btn['btnBlankAttr'];
        var btnBorderColor = this_widget_btn['btnBorderColor'];
        var btnBorderWidth = this_widget_btn['btnBorderWidth'];
        var btnBorderRadius = this_widget_btn['btnBorderRadius'];
        var btnButtonAlignment = this_widget_btn['btnButtonAlignment'];

        var widgetMtop = this_column_widgets_array_current['widgetMtop'];
        var widgetMleft = this_column_widgets_array_current['widgetMleft'];
        var widgetMbottom = this_column_widgets_array_current['widgetMbottom'];
        var widgetMright = this_column_widgets_array_current['widgetMright'];
        var widgetBgColor = this_column_widgets_array_current['widgetBgColor'];

        switch (this_column_type) {
          case 'wigt-WYSIWYG':
            this_column_content = this_column_editor_content;
            contentAlign = 'none';
            break;
          case 'wigt-img':
            this_column_content = this_column_img;
            contentAlign = imgAlignment;
            break;
          case 'wigt-menu':
            this_column_content = this_column_menu;
            contentAlign = 'none';
            break;
          case 'wigt-btn-gen':
            var this_widget_btn = "<br><div class='wdt-this_column_type' style='text-align:"+btnButtonAlignment+";'><a href='"+btnLink+"' style='text-decoration:none !important;' target='' > <button style='color:"+btnTextColor+" !important;font-size:"+btnFontSize+" !important; background: "+btnBgColor+" !important; background-color: "+btnBgColor+" !important; padding: "+btnHeight+"px "+btnWidth+"px !important; border: "+btnBorderWidth+"px solid "+btnBorderColor+" !important; border-radius: "+btnBorderRadius+"px !important;'>"+btnText+"</button></a></div><br>";
            this_column_content = this_widget_btn;
            break;
          default:
            this_column_content = this_column_editor_content;
            contentAlign = 'none';
            break;
        }

        var this_widget_margins = "'margin:"+widgetMtop+"px "+widgetMright+"px "+widgetMbottom+"px "+widgetMleft+"px; background:"+widgetBgColor+"; background-color:"+widgetBgColor+"; "+widgetStyling+"'";
        $('section[RowID="'+rowID+'"] '+'.'+this_column).append("<div class='widget-"+j+"' style="+this_widget_margins+">"+this_column_content+"</div>");

     }
      }


      $('.column').resizable({
        containment: '.row',
        maxHeight: rowHeight,
        maxWidth: 1268,
        start: function (event, ui) {
          this.widthOfNextEl = ui.originalSize.width + ui.element.next().innerWidth();
        },
        resize: function (event, ui) {
          ui.element.next().width(this.widthOfNextEl - ui.size.width);
          ui.element.children('.overlay').width(ui.size.width);
          ui.element.next().children('.overlay').width(ui.element.next().width());
        },
        stop: function(event, ui) {
          $(ui.element.siblings('#WidthSave')).trigger('click');
        }
      });

      $(this.el).append('<div style="display:none;"></div><div id="rowDelete" class="row-btn btn-red btn" ><span class="dashicons dashicons-trash"></span></div> <div id="rowEdit" class="row-btn btn"> <span class="dashicons dashicons-edit"></span></div></p> <div id="WidthSave" class="pb_hidden"></div>');

     

      $('li[data-model-cid="'+rowCID+'"]').mouseenter(function(){
        $('li[data-model-cid="'+rowCID+'"] .row-btn').css('display','block');
      });
      $('.row').mouseleave(function(){
       $('.row-btn').css('display','none');
      });

      return this;
    },
    deleteRow: function(){ 
      var cong = confirm('Do you want to delete this Row ?');
      if (cong == true) {
        this.model.destroy();
        $(this.el).remove();
      }
    },
    EditRow: function(){

      var row_height = this.model.get('rowHeight');
      var row_no_columns = this.model.get('columns');
      var rowData = this.model.get('rowData');
      var row_bg_img = rowData['bg_img'];
      var row_bg_color = rowData['bg_color'];

      var row_margin = rowData['margin'];
      var rowMarginTop = row_margin['rowMarginTop'];
      var rowMarginBottom = row_margin['rowMarginBottom'];
      var rowMarginLeft = row_margin['rowMarginLeft'];
      var rowMarginRight = row_margin['rowMarginRight'];

      var row_padding = rowData['padding'];
      var rowPaddingTop = row_padding['rowPaddingTop'];
      var rowPaddingBottom = row_padding['rowPaddingBottom'];
      var rowPaddingLeft = row_padding['rowPaddingLeft'];
      var rowPaddingRight = row_padding['rowPaddingRight'];

      var customStyling = rowData['customStyling'];
      var customJS = rowData['customJS'];

      $('#row_height').val(row_height);
      $('#number_of_columns').val(row_no_columns);
      $('.rowBgImg').val(row_bg_img);
      $('.rowBgColor').val(row_bg_color);
      $('.rowMarginTop').val(rowMarginTop);
      $('.rowMarginBottom').val(rowMarginBottom);
      $('.rowMarginLeft').val(rowMarginLeft);
      $('.rowMarginRight').val(rowMarginRight);
      $('.rowPaddingTop').val(rowPaddingTop);
      $('.rowPaddingBottom').val(rowPaddingBottom);
      $('.rowPaddingLeft').val(rowPaddingLeft);
      $('.rowPaddingRight').val(rowPaddingRight);
      $('.rowCustomStyling').val(customStyling);
      $('.rowCustomJS').val(customJS);

      $('.wp-color-result').css('background-color',row_bg_color);
      $('.wp-picker-container').css('margin-left','24%');

      $('.edit_options_right').append('<div class="column rules"></div>');

      $(this.el).append('<div id="ulpb_row_controls"> <p><div id="edit_form_close" class="btn-red btn">Close</div></p> <p><div id="editRowSave" class="btn">Save</div>  </div> </div></div>');


      $('.edit_row').css('display','block');
      $('#edit_form_close').click(function(){
        $('.edit_row').slideUp();
        $('#ulpb_row_controls').remove();
      });
    },
    updateRow: function(){

      var rowheight = $('#row_height').val();
      var numberComlumns = $('#number_of_columns').val();
      var rowBgImg = $('.rowBgImg').val();
      var rowBgColor = $('.rowBgColor').val();
      var rowMargin = $('.rowMargin').val();
      var customJS = $('.rowCustomJS').val();
      var customStyling = $('.rowCustomStyling').val();

      var rowMarginTop      =   $('.rowMarginTop').val();
      var rowMarginBottom   =   $('.rowMarginBottom').val();
      var rowMarginLeft     =   $('.rowMarginLeft').val();
      var rowMarginRight    =   $('.rowMarginRight').val();
      var rowPaddingTop     =   $('.rowPaddingTop').val();
      var rowPaddingBottom  =   $('.rowPaddingBottom').val();
      var rowPaddingLeft    =   $('.rowPaddingLeft').val();
      var rowPaddingRight   =   $('.rowPaddingRight').val();

      var rowMargin = {
        rowMarginTop: rowMarginTop,
        rowMarginBottom: rowMarginBottom,
        rowMarginLeft: rowMarginLeft,
        rowMarginRight: rowMarginRight,
      };

      var rowPadding = {
        rowPaddingTop: rowPaddingTop,
        rowPaddingBottom: rowPaddingBottom,
        rowPaddingLeft: rowPaddingLeft,
        rowPaddingRight: rowPaddingRight,
      };

      if (rowheight) {
        this.model.set({
          rowHeight: rowheight,
          columns: numberComlumns,
          rowData: {
            bg_color: rowBgColor,
            bg_img: rowBgImg,
            margin: rowMargin,
            padding:rowPadding,
            customStyling: customStyling,
            customJS: customJS,
          }
        });
      }
      
      $(this.el).html('');
      $('.edit_row').slideUp();
      $('#ulpb_row_controls').remove();
      this.render();
    },
    EditColumn: function(ev){
      
      var this_column = $(ev.target).attr('data-col_id');
      var rowID = this.model.get('rowID');
      var thisColumnData = this.model.get(this_column);
      var this_column_widgets = thisColumnData['colWidgets'];
      var this_column_content = thisColumnData['columnContent'];
      var this_column_type = thisColumnData['columnType'];
      var this_column_options = thisColumnData['columnOptions'];
      var this_column_bg_color = this_column_options['bg_color'];
      var this_column_width = this_column_options['width'];

      var this_column_margin = this_column_options['margin'];
      var columnMarginTop = this_column_margin['columnMarginTop'];
      var columnMarginBottom = this_column_margin['columnMarginBottom'];
      var columnMarginLeft = this_column_margin['columnMarginLeft'];
      var columnMarginRight = this_column_margin['columnMarginRight'];

      var this_column_padding = this_column_options['padding'];
      var columnPaddingTop = this_column_padding['columnPaddingTop'];
      var columnPaddingBottom = this_column_padding['columnPaddingBottom'];
      var columnPaddingLeft = this_column_padding['columnPaddingLeft'];
      var columnPaddingRight = this_column_padding['columnPaddingRight'];
      
      var colWidth = $('section[RowID="'+rowID+'"]'+' .'+this_column).width();

      $('#columnBgColor').val(this_column_bg_color);
      $('#columnMargin').val(this_column_margin);
      $('#columnPadding').val(this_column_padding);
      $('#columnWidth').val(colWidth);
      $('.widget-type-field').val(this_column_type);

      $('.columnMarginTop').val(columnMarginTop);
      $('.columnMarginBottom').val(columnMarginBottom);
      $('.columnMarginLeft').val(columnMarginLeft);
      $('.columnMarginRight').val(columnMarginRight);
      $('.columnPaddingTop').val(columnPaddingTop);
      $('.columnPaddingBottom').val(columnPaddingBottom);
      $('.columnPaddingLeft').val(columnPaddingLeft);
      $('.columnPaddingRight').val(columnPaddingRight);

      $('.wp-color-result').css('background-color',this_column_bg_color);
      $('.wp-picker-container').css('margin-left','24%');
      $(this.el).append('<br><p><div id="ulpb_column_controls"><div id="edit_form_close" class="btn-red btn">Close</div></p><p><div id="editColumnSave" style="margin-top: -13px;" class="btn" data-col_id='+this_column+' >Save</div></p><br></div>');

    app.widgetList.reset();
    if (this_column_widgets) {
      app.widgetList.add(this_column_widgets);

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
    }

      $('.edit_column').slideDown();
      $('#edit_form_close').click(function(){
        $('.edit_column').slideUp();
        $('#ulpb_column_controls').remove();
      });

    },
    updateColumn: function(ev){
      var columnToUpdate =  $(ev.target).attr('data-col_id');
      var columnBgColor     = $('.columnBgColor').val();
      var columnMargin      = $('.columnMargin').val();
      var columnPadding     = $('.columnPadding').val();
      var colWidth          = $('.columnWidth').val();

      var columnMarginTop = $('.columnMarginTop').val();
      var columnMarginBottom = $('.columnMarginBottom').val();
      var columnMarginLeft = $('.columnMarginLeft').val();
      var columnMarginRight = $('.columnMarginRight').val();
      var columnPaddingTop = $('.columnPaddingTop').val();
      var columnPaddingBottom = $('.columnPaddingBottom').val();
      var columnPaddingLeft = $('.columnPaddingLeft').val();
      var columnPaddingRight = $('.columnPaddingRight').val();


      var columnMargin = {
        columnMarginTop: columnMarginTop,
        columnMarginBottom: columnMarginBottom,
        columnMarginLeft: columnMarginLeft,
        columnMarginRight: columnMarginRight,
      };

      var columnPadding = {
        columnPaddingTop: columnPaddingTop,
        columnPaddingBottom: columnPaddingBottom,
        columnPaddingLeft: columnPaddingLeft,
        columnPaddingRight: columnPaddingRight,
      };
      
        var widgets = app.widgetList.toJSON();
        this.model.set({
          [columnToUpdate] : {
            colWidgets: widgets,
            columnOptions:{
            bg_color: columnBgColor,
            margin: columnMargin,
            padding:columnPadding,
            width: colWidth,
            }
          }
        });
      
      $(this.el).html('');
      $('.edit_column').slideUp();
      $('#ulpb_column_controls').remove();
      this.render();
    },
    updateWidth: function() {
      rowColumns = this.model.get('columns');
      for(var i = 1; i<= rowColumns; i++){
        var this_column = 'column'+i;
        var thisColumnModelData = this.model.get(this_column);
        var this_column_widgets = thisColumnModelData['colWidgets'];
        var this_column_options = thisColumnModelData['columnOptions'];
        var this_column_bg_color = this_column_options['bg_color'];
        var this_column_margin = this_column_options['margin'];
        var this_column_padding = this_column_options['padding'];
        var colWidth = this_column_options['width'];

        var rowID = this.model.get('rowID');
        var colWidth = $('section[RowID="'+rowID+'"]'+' .'+this_column).width();
        console.log(rowID);
       var widgets = this_column_widgets;
        this.model.set({
          [this_column] : {
            colWidgets: widgets,
            columnOptions:{
            bg_color: this_column_bg_color,
            margin: this_column_margin,
            padding:this_column_padding,
            width: colWidth,
            }
          }
        });
      }
    }

    });


app.WidgetView = Backbone.View.extend({
  tagName: 'div',
  className: 'wdt-droppable',
  template: _.template($('#widget-template').html()),
  attributes: function() {
        if(this.model) {
            return {
                'data-widgetID': this.model.cid
            }
        }
        return {}
    },
  events: {
    'click #widgetDelete': 'deleteWidget',
    'click #widgetEdit': 'EditWidget',
    'click #widgetSave': 'updateWidget',
  },
  initialize: function () {
    _.bindAll(this,'render','deleteWidget','EditWidget','updateWidget');
  },
  render: function () {
    this.$el.html(this.template(this.model.toJSON() )  );

    var widgetType = this.model.get('widgetType');
    var textb = "is selected <br> To edit click the green button below. <br> To change widget just drop any other widget here.";
    switch(widgetType){
        case 'wigt-WYSIWYG': var texta = "HTML Editor"; break;
        case 'wigt-img': var texta = "Image Widget"; break;
        case 'wigt-menu': var texta = "Menu Widget"; break;
        case 'wigt-slider': var texta = "Slider Extension"; break;
        case 'wigt-smuzform': var texta = "Form Extension"; break;
        case 'wigt-btn-gen': var texta = "Button Generator Extension"; break;
        case 'wigt-Sform': var texta = "Subscribe Form Extension"; break;
        case 'wigt-PostSlider': var texta = "Posts Slider Extension"; break;
        case 'wigt-TestimonialSlider': var texta = "Testimonial Slider Extension"; break;
        case 'wigt-SocialFeed': var texta = "Social Feed Extension"; break;
        default : var texta = 'Drag a widget or extension and drop it here to use it.'; var textb = " ";  break;
      }

    $(this.el).append('<h4 class="widget-area-'+this.model.cid+'">'+texta+' '+textb+'</h4><br><br><div class="btn btn-red remove-widgets" id="widgetDelete"><span class="dashicons dashicons-trash"></span></div><div id="widgetEdit" class="btn editWidget-'+this.model.cid+'"> <span class="dashicons dashicons-edit"></span></div><input type="text" name="widget-type" class="bp_hidden" style="display:none"  data-widgetType-id="'+this.model.cid+'" value="'+widgetType+'">');

    $(this.el).append('<div id="widgetSave" class="pb_hidden" data-saveCurrWidget="'+this.model.cid+'"></div>');
  },
  deleteWidget: function () {
    this.model.destroy();
    $(this.el).remove();
  },
  EditWidget: function () {
    $('.lpp_modal_2').slideDown('500');
    var this_widget_type = $('input[data-widgetType-id="'+this.model.cid+'"]').val();

    var widgetStyling = this.model.get('widgetStyling');
    var widgetMtop = this.model.get('widgetMtop');
    var widgetMbottom = this.model.get('widgetMbottom');
    var widgetMleft = this.model.get('widgetMleft');
    var widgetMright = this.model.get('widgetMright');
    var widgetBgColor = this.model.get('widgetBgColor');
    var this_widget_editor_content = this.model.get('widgetWYSIWYG');
    var editorContent = this_widget_editor_content['widgetContent'];
    var this_widget_img_content = this.model.get('widgetImg');
    var imgUrl  = this_widget_img_content['imgUrl'];
    var imgSize = this_widget_img_content['imgSize'];
    var imgAlignment = this_widget_img_content['imgAlignment'];

    var this_widget_menu_content = this.model.get('widgetMenu');
    var menuName = this_widget_menu_content['menuName'];
    var menuStyle = this_widget_menu_content['menuStyle'];
    var menuColor = this_widget_menu_content['menuColor'];

    var this_widget_form_content = this.model.get('widgetForm');
    var formName = this_widget_form_content['formName'];

    var this_widget_slider_content = this.model.get('widgetSlider');
    var sliderName = this_widget_slider_content['sliderName'];

    var this_widget_sForm_content = this.model.get('widgetSform');
    var sFormName = this_widget_sForm_content['sFormName'];

    var this_widget_postsSlider_content = this.model.get('widgetPostSlider');
    var postsSliderName = this_widget_postsSlider_content['postsSliderName'];

    var this_widget_testimonialSlider_content = this.model.get('widgetTestimonialSlider');
    var testimonialSliderName = this_widget_testimonialSlider_content['testimonialSliderName'];

    var this_widget_socialFeed_content = this.model.get('widgetSocialFeed');
    var socialFeedName = this_widget_socialFeed_content['socialFeedName'];

    var this_widget_btn = this.model.get('widgetButton');
    var btnText = this_widget_btn['btnText'];
    var btnLink = this_widget_btn['btnLink'];
    var btnBgColor = this_widget_btn['btnBgColor'];
    var btnTextColor = this_widget_btn['btnTextColor'];
    var btnFontSize = this_widget_btn['btnFontSize'];
    var btnHoverBgColor = this_widget_btn['btnHoverBgColor'];
    var btnWidth = this_widget_btn['btnWidth'];
    var btnHeight = this_widget_btn['btnHeight'];
    var btnBlankAttr = this_widget_btn['btnBlankAttr'];
    var btnBorderColor = this_widget_btn['btnBorderColor'];
    var btnBorderWidth = this_widget_btn['btnBorderWidth'];
    var btnBorderRadius = this_widget_btn['btnBorderRadius'];
    var btnButtonAlignment = this_widget_btn['btnButtonAlignment']

    $('.widgetStyling').val(widgetStyling);
    $('.widgetMtop').val(widgetMtop);
    $('.widgetMbottom').val(widgetMbottom);
    $('.widgetMleft').val(widgetMleft);
    $('.widgetMright').val(widgetMright); 
    $('.widgetBgColor').val(widgetBgColor); 
    $('.ftr-img').val(imgUrl);
    $('#ftr-img-size').val(imgSize);
    $('#ftr-img-alignment').val(imgAlignment);
    $('.ftr-img').val(imgUrl);
    $('#ftr-menu-select').val(menuName);
    $('input[value='+menuStyle+']').attr('checked','checked');
    $('#ftr-menu-color').val(menuColor);
    $('#select_smuz_form').val(formName);
    $('#select_smuz_slider').val(sliderName);
    $('#select_subscribe_form').val(sFormName);
    $('#select_posts_slider').val(postsSliderName);
    $('#select_testimonials_slider').val(testimonialSliderName);
    $('#select_socialFeed').val(socialFeedName);

    $('.btnText').val(btnText);
    $('.btnLink').val(btnLink);
    $('.btnHeight').val(btnHeight);
    $('.btnWidth').val(btnWidth);
    $('.btnColor').val(btnTextColor);
    $('.btnFontSize').val(btnFontSize);
    $('.btnBgColor').val(btnBgColor);
    $('.btnHoverBgColor').val(btnHoverBgColor);
    $('.btnBorderWidth').val(btnBorderWidth);
    $('.btnBorderColor').val(btnBorderColor);
    $('.btnBorderRadius').val(btnBorderRadius);
    $('.btnBlankAttr').val(btnBlankAttr);
    $('.btnButtonAlignment').val(btnButtonAlignment);

    $('#btn-prev').text(btnText);
    $('#btn-prev').attr('style','padding: '+btnHeight+'px '+btnWidth+'px; color:'+btnTextColor+'; background-color:'+btnBgColor+'; border :'+btnBorderWidth+'px solid'+btnBorderColor+'; border-radius:'+btnBorderRadius+'px; font-size:'+btnFontSize+'px;');


    $('.widgetBgColor').parent().parent().css('margin-left','0');
    $('.widgetBgColor').parent().prev().css('background-color',widgetBgColor);
    $('#ftr-menu-color').parent().parent().css('margin-left','10px');
    $('#ftr-menu-color').parent().prev().css('background-color',menuColor);
    $('#btnColor').parent().prev().css('background-color',btnTextColor);
    $('#btnBgColor').parent().prev().css('background-color',btnBgColor);
    $('#btnHoverBgColor').parent().prev().css('background-color',btnHoverBgColor);
    $('#btnBorderColor').parent().prev().css('background-color',btnBorderColor);

    var editorID = 'columnContent';
    if ($('#wp-'+editorID+'-wrap').hasClass("tmce-active"))
        tinyMCE.get(editorID).setContent(editorContent);
    else
      $('#'+editorID).val(editorContent);
      

    switch (this_widget_type) { 
        case 'wigt-WYSIWYG':
          $('.wdt-editor').slideDown(500);
          $('.wdt-img').css('display','none');
          $('.wdt-menu').css('display','none');
          $('.wdt-btn-gen').hide(100);
          $('.wdt-testimonialSlider').hide(100);
          $('.wdt-sForm').hide(100);
          $('.wdt-socialFeed').hide(100);
          $('.wdt-smuzform').css('display','none');
          break;
        case 'wigt-img':
          $('.wdt-img').slideDown(500);
          $('.wdt-editor').css('display','none');
          $('.wdt-menu').css('display','none');
          $('.wdt-btn-gen').hide(100);
          $('.wdt-testimonialSlider').hide(100);
          $('.wdt-sForm').hide(100);
          $('.wdt-socialFeed').hide(100);
          $('.wdt-smuzform').css('display','none');
          break;
        case 'wigt-menu':
          $('.wdt-menu').slideDown(500);
          $('.wdt-img').hide(100);
          $('.wdt-editor').css('display','none');
          $('.wdt-btn-gen').hide(100);
          $('.wdt-testimonialSlider').hide(100);
          $('.wdt-sForm').hide(100);
          $('.wdt-socialFeed').hide(100);
          $('.wdt-smuzform').css('display','none');
          break;
        case 'wigt-smuzform':
          $('.wdt-smuzform').slideDown(500);
          $('.wdt-menu').hide(100);
          $('.wdt-img').hide(100);
          $('.wdt-btn-gen').hide(100);
          $('.wdt-slider').hide(100);
          $('.wdt-testimonialSlider').hide(100);
          $('.wdt-sForm').hide(100);
          $('.wdt-socialFeed').hide(100);
          $('.wdt-editor').css('display','none');
          break;
        case 'wigt-slider':
          $('.wdt-slider').slideDown(500);
          $('.wdt-smuzform').hide(100);
          $('.wdt-menu').hide(100);
          $('.wdt-img').hide(100);
          $('.wdt-btn-gen').hide(100);
          $('.wdt-editor').css('display','none');
          break;
        case 'wigt-btn-gen':
          $('.wdt-btn-gen').slideDown(500);
          $('.wdt-slider').hide(100);
          $('.wdt-smuzform').hide(100);
          $('.wdt-menu').hide(100);
          $('.wdt-img').hide(100);
          $('.wdt-editor').css('display','none');
          break;
          case 'wigt-Sform':
          $('.wdt-sForm').slideDown(500);
          $('.wdt-testimonialSlider').hide(100);
          $('.wdt-postsSlider').hide(100);
          $('.wdt-socialFeed').hide(100);
          $('.wdt-btn-gen').hide(100);
          $('.wdt-slider').hide(100);
          $('.wdt-smuzform').hide(100);
          $('.wdt-menu').hide(100);
          $('.wdt-img').hide(100);
          $('.wdt-editor').css('display','none');
          break;
          case 'wigt-PostSlider':
          $('.wdt-postsSlider').slideDown(500);
          $('.wdt-testimonialSlider').hide(100);
          $('.wdt-sForm').hide(100);
          $('.wdt-socialFeed').hide(100);
          $('.wdt-btn-gen').hide(100);
          $('.wdt-slider').hide(100);
          $('.wdt-smuzform').hide(100);
          $('.wdt-menu').hide(100);
          $('.wdt-img').hide(100);
          $('.wdt-editor').css('display','none');
          break;
          case 'wigt-TestimonialSlider':
          $('.wdt-testimonialSlider').slideDown(500);
          $('.wdt-socialFeed').hide(100);
          $('.wdt-postsSlider').hide(100);
          $('.wdt-sForm').hide(100);
          $('.wdt-btn-gen').hide(100);
          $('.wdt-slider').hide(100);
          $('.wdt-smuzform').hide(100);
          $('.wdt-menu').hide(100);
          $('.wdt-img').hide(100);
          $('.wdt-editor').css('display','none');
          break;
          case 'wigt-SocialFeed':
          $('.wdt-socialFeed').slideDown(500);
          $('.wdt-testimonialSlider').hide(100);
          $('.wdt-postsSlider').hide(100);
          $('.wdt-sForm').hide(100);
          $('.wdt-btn-gen').hide(100);
          $('.wdt-slider').hide(100);
          $('.wdt-smuzform').hide(100);
          $('.wdt-menu').hide(100);
          $('.wdt-img').hide(100);
          $('.wdt-editor').css('display','none');
          break;
        default:
          $('.wdt-droppable').slideDown(100);
          $('.wdt-editor, .wdt-img, .wdt-menu, .wdt-smuzform').css('display','none');
          break;
      }

    var that = this.model.cid;
      $('.closeWidgetPopup').attr('data-CurrWidget',that);
    },
  updateWidget: function () {

    var widgetType = $('input[data-widgetType-id="'+this.model.cid+'"]').val();
    var widgetStyling     = $('.widgetStyling').val();
    var widgetMtop        = $('.widgetMtop').val();
    var widgetMbottom     = $('.widgetMbottom').val();
    var widgetMleft       = $('.widgetMleft').val();
    var widgetMright      = $('.widgetMright').val();
    var widgetBgColor      = $('.widgetBgColor').val();
    
    var widgetImgUrl      = $('.ftr-img').val();
    var widgetImgSize     = $('#ftr-img-size').val();
    var widgetImgAlignment= $('#ftr-img-alignment').val();
    var widgetMenuName    = $('#ftr-menu-select').val();
    var widgetMenuStyle   = $('input[name=ftr-menu-select-style]:checked').val();
    var widgetMenuColor   = $('#ftr-menu-color').val();
    var formName          = $('#select_smuz_form').val();
    var sliderName        = $('#select_smuz_slider').val();
    var sFormName         = $('#select_subscribe_form').val();
    var postsSliderName   = $('#select_posts_slider').val();
    var testimonialSliderName = $('#select_testimonials_slider').val();
    var socialFeedName    = $('#select_socialFeed').val();

    var btnText = $('.btnText').val();
    btnLink = $('.btnLink').val();
    btnHeight = $('.btnHeight').val();
    btnWidth = $('.btnWidth').val();
    btnColor = $('.btnColor').val();
    btnFontSize = $('.btnFontSize').val();
    btnBgColor = $('.btnBgColor').val();
    btnHoverBgColor = $('.btnHoverBgColor').val();
    btnBorderWidth = $('.btnBorderWidth').val();
    btnBorderColor = $('.btnBorderColor').val();
    btnBorderRadius = $('.btnBorderRadius').val();
    btnBlankAttr = $('.btnBlankAttr').val();
    btnButtonAlignment = $('.btnButtonAlignment').val();

    var editorID = 'columnContent';
    if($('#wp-'+editorID+'-wrap').hasClass("tmce-active")){
        var widgetEditorData = tinyMCE.get(editorID).getContent({format : 'raw'});
    }else{
        var widgetEditorData = $('#'+editorID).val();
    }

      this.model.set({
        widgetType:widgetType,
        widgetStyling:widgetStyling,
        widgetMtop:widgetMtop,
        widgetMleft:widgetMleft,
        widgetMbottom:widgetMbottom,
        widgetMright:widgetMright,
        widgetBgColor: widgetBgColor,
        widgetWYSIWYG: {  
          widgetContent:widgetEditorData
        },
        widgetMenu:{
          menuName: widgetMenuName,
          menuStyle: widgetMenuStyle,
          menuColor: widgetMenuColor
        },
        widgetImg:{
          imgUrl: widgetImgUrl,
          imgSize: widgetImgSize,
          imgAlignment: widgetImgAlignment
        },
        widgetForm:{
          formName: formName
        },
        widgetSlider:{
          sliderName: sliderName
        },
        widgetSform:{
          sFormName: sFormName
        },
        widgetPostSlider:{
          postsSliderName: postsSliderName
        },
        widgetTestimonialSlider:{
          testimonialSliderName: testimonialSliderName
        },
        widgetSocialFeed:{
          socialFeedName: socialFeedName
        },
        widgetButton:{
          btnText: btnText,
          btnLink: btnLink,
          btnTextColor: btnColor,
          btnFontSize: btnFontSize,
          btnBgColor: btnBgColor,
          btnWidth: btnWidth,
          btnHeight: btnHeight,
          btnHoverBgColor: btnHoverBgColor,
          btnBlankAttr: btnBlankAttr,
          btnBorderColor: btnBorderColor,
          btnBorderWidth: btnBorderWidth,
          btnBorderRadius: btnBorderRadius,
          btnButtonAlignment: btnButtonAlignment,
        },
      });

      $('.columnWidgetPopup').slideUp('200');
  }


});


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


$('#SavePage').click(function() {

  var setFrontPage = '';
  var loadWpHead = $('.loadWpHead').attr('checked');
  var loadWpFooter = $('.loadWpFooter').attr('checked');
  var pageSeoName = $('#title').val();
  var pageSeoDescription = $('.pageSeoDescription').val();
  var pageSeoKeywords = $('.pageSeoKeywords').val();
  var pageBgImage = $('.pageBgImage').val();
  var pageBgColor = $('.pageBgColor').val();
  var pagePaddingTop = $('.pagePaddingTop').val();
  var pagePaddingBottom = $('.pagePaddingBottom').val();
  var pagePaddingLeft = $('.pagePaddingLeft').val();
  var pagePaddingRight = $('.pagePaddingRight').val();

  if ($('.setFrontPage').is(':checked')) {
    setFrontPage = "true";
  } else{
    setFrontPage = "false"; 
  }

  if (loadWpHead == 'checked') {
    loadWpHead = "true";
  } else{
    loadWpHead = "false"; 
  }

  if (loadWpFooter == 'checked') {
    loadWpFooter = "true";
  } else{
    loadWpFooter = "false"; 
  }

  var pageOps = {
    setFrontPage: setFrontPage,
    loadWpHead:loadWpHead,
    loadWpFooter: loadWpFooter,
    pageBgImage: pageBgImage,
    pageBgColor: pageBgColor,
    pagePadding: {
      pagePaddingTop : pagePaddingTop,
      pagePaddingBottom : pagePaddingBottom,
      pagePaddingLeft : pagePaddingLeft,
      pagePaddingRight : pagePaddingRight,
    },
    pageSeoName: pageSeoName,
    pageSeoDescription: pageSeoDescription,
    pageSeoKeywords: pageSeoKeywords
  };

  $('#container').attr('style','background-image: url("'+pageBgImage+'"); background-size:cover;');

  var PageStatus = app.PageBuilderModel.get('pageStatus');
  app.PageBuilderModel.set( 'pageOptions', pageOps);
  app.PageBuilderModel.set('pageStatus','Published');
  app.PageBuilderModel.set( 'Rows', app.rowList.models );
  app.PageBuilderModel.save();
  $('.pb_loader_container').slideDown(200);
  setTimeout(function(){
    $('.pb_loader_container').slideUp(200);
    if (PageStatus == 'Unpublished') {
      window.location.href = admURL+'post.php?post='+P_ID+'&action=edit'; 
    }
  }, 2000);

});

$( ".newRow" ).click( function() {

 var row_height = 100;
 var row_no_columns = 1;
 var row_bg_img = "Image URL";
 var row_bg_color = '#ffffff';
 var row_margin = 0;
 var row_padding = 0;

$('.wp-picker-container').css('margin-left','24%');

  $('body').append('<div id="ulpb_row_controls"> <p><div id="newRowClose" class="btn-red btn">Close</div></p> <p><div id="newRowSave" class="btn">Save</div></p> </div> </div></div>');

$('.new_row_div').css('display','block');


$('#newRowSave').click(function(){
  var rowheight = $('#new_row_height').val();
  var numberComlumns = $('#new_row_number_of_columns').val();
  var rowBgImg = $('.new_rowBgImg').val();
  var rowBgColor = $('.new_rowBgColor').val();
  var rowMargin = $('.new_rowMargin').val();
  var rowPadding = $('.new_rowPadding').val();
  var customStyling = $('.new_rowCustomStyling').val();
  var customJS = $('.new_rowCustomJS').val();


  if (rowheight && numberComlumns) {
    app.rowList.add( {
      rowID: 'ulpb_Row'+Math.floor((Math.random() * 200000) + 100),
      rowHeight: rowheight,
      columns: numberComlumns,
      rowData: {
        bg_color: rowBgColor,
        bg_img: rowBgImg,
        margin: {
          rowMarginTop: 0,
          rowMarginBottom: 0,
          rowMarginLeft: 0,
          rowMarginRight: 0,
        },
        padding:{
          rowPaddingTop: 0,
          rowPaddingBottom: 0,
          rowPaddingLeft: 0,
          rowPaddingRight: 0,
        },
        customStyling: '/* Your Custom Styling */',
        customJS: '/* Your JS Styling */',
      }
    });
    $('.new_row_div').slideUp();
    $('#ulpb_row_controls').remove();
  }else{
    alert('Both fields are required!');
  }
});


$('#newRowClose').click(function(){
    $('.new_row_div').slideUp();
    $('#ulpb_row_controls').remove();
});

});

$('.closeWidgetPopup').click(function(ev){
  var that = $(ev.target).attr('data-CurrWidget');
  $('div[data-saveCurrWidget="'+that+'"]').click();
});
if (isPub == "publish") { 
  var btn_text = "Save Page"; 
} else {var btn_text = "Publish Page"; }
$('#side-sortables').append('<div id="savePageSide"><div id="SavePageOther" class="btn-green aligncenter large-btn">'+btn_text+'</div></div>');

$ftrList = $('#ftr-list').html();
$('#side-sortables').append('<div style="min-height:275px; background:#fff; margin-top:25px; border: 3px dashed #b4b9be;" >'+$ftrList+'</div>');

$sideOptions = $('#sideOptions').html();
$('#side-sortables').append('<div style="min-height:275px; background:#fff; margin-top:25px; border: 3px dashed #b4b9be;" >'+$sideOptions+'</div>');


$('#side-sortables').append('<br> <br><span style="font-size:15px"> Please send us your <a href="https://wordpress.org/support/plugin/page-builder-add" target="_blank">feedback</a></span>');

$('#SavePageOther').click(function(){
  $('#SavePage').trigger('click');
});


$('.pageBgImage').change(function(){
    var pageBgImage = $('.pageBgImage').val();
    $('#container').attr('style','background-image: url("'+pageBgImage+'"); background-size:cover;');
  });

$('.card-img').mouseover(function(ev) {
  //console.log($(ev.target).children());
  var tempprevbtn = $(ev.target).attr('class').split(' ')[1];
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


$('.switch').click(function(ev){
  var thisSwitch = $(ev.target).attr('class');
  var checkSwitch = $('.'+thisSwitch).attr('checked');
  if (checkSwitch == 'checked') {
    $('.'+thisSwitch).removeAttr('checked');
  } else{
    $('.'+thisSwitch).attr('checked','checked');
  }
});

}( jQuery ) );