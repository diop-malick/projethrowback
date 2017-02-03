    var app = {};

    app.Row = Backbone.Model.extend({
      defaults:{
        rowID: '',
        rowHeight: 100,
        columns: 1,
        rowData: {
          bg_color: '#ffffff',
          bg_img: '',
          margin: 50,
          padding:0
        },
        column1: {
          columnContent: 'Example 1',
          columnOptions:{
          bg_color: 'transparent',
          margin: 50,
          padding:0,
          width: 0,
        }
        },
        column2: {
          columnContent: 'Example 2',
          columnOptions:{
          bg_color: 'transparent',
          margin: 50,
          padding:0,
          width: 0,
        }
        },
        column3: {
          columnContent: 'Example 3',
          columnOptions:{
          bg_color: 'transparent',
          margin: 50,
          padding:0,
          width: 0,
        }
        },
        column4: {
          columnContent: 'Example 4',
          columnOptions:{
          bg_color: 'transparent',
          margin: 50,
          padding:0,
          width: 0,
        }
        },
        column5: {
          columnContent: 'Example 5',
          columnOptions:{
          bg_color: 'transparent',
          margin: 50,
          padding:0,
          width: 0,
        }
        },
        column6: {
          columnContent: 'Example 6',
          columnOptions:{
          bg_color: 'transparent',
          margin: 50,
          padding:0,
          width: 0,
        }
        },
        column7: {
          columnContent: 'Example 7',
          columnOptions:{
          bg_color: 'transparent',
          margin: 50,
          padding:0,
          width: 0,
        }
        },
        column8: {
          columnContent: 'Example 8',
          columnOptions:{
          bg_color: 'transparent',
          margin: 50,
          padding:0,
          width: 0,
        }
        },

        
      }
    });

    app.PageBuilder = Backbone.Collection.extend({
      model:app.Row,
      localStorage: new Store('Row')
    });

    app.rowList = new app.PageBuilder();

    app.RowView = Backbone.View.extend({
    tagName: 'section',
    className: 'row',
    events: {
      'click button#rowDelete': 'deleteRow',
      'click button#rowEdit': 'EditRow',
      'click button#editRowSave': 'updateRow',
      'dblclick div.column': 'EditColumn',
      'click button#editColumnSave': 'updateColumn'
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
      _.bindAll(this, 'render','deleteRow','updateRow','EditRow','EditColumn','updateColumn'); // every function that uses 'this' as the current object should be in here
      this.model.on('updateRow', this.render, this);
      this.model.on('deleteRow',this.remove, this);
    },
    render: function(){
      rowColumns = this.model.get('columns');
      rowHeight = this.model.get('rowHeight');
      var rowData = this.model.get('rowData');
      var row_bg_img = rowData['bg_img'];
      var row_bg_color = rowData['bg_color'];
      var row_margin = rowData['margin'];
      var row_padding = rowData['padding'];

      $(this.el).attr('style','height:'+rowHeight+'px; background:'+row_bg_color+'; margin:'+row_margin+'px; padding:'+row_padding+'px;');

      if (row_bg_img) {
        $(this.el).css('background','url("'+row_bg_img+'")');
      }
      
      switch (rowColumns) {
        case '1':
          colWidth = '99%';
          break;
        case '2':
          colWidth = '49%';
          break;
        case '3':
          colWidth = '32.5%';
          break;
        case '4':
          colWidth = '24%';
          break;
        case '5':
          colWidth = '19%';
          break;
        case '6':
          colWidth = '16%';
          break;
        case '7':
          colWidth = '13.5%';
          break;
        case '8':
          colWidth = '11.5%';
          break;
        case '9':
          colWidth = '10.5%';
          break;
        case '10':
          colWidth = '5%';
          break;  
        default:
          colWidth = '99%';
          break;
      }

      for(var i = 1; i <= rowColumns; i++){
        var this_column = 'column'+i;
        var thisColumnModelData = this.model.get(this_column);
        var this_column_content = thisColumnModelData['columnContent'];
        var this_column_options = thisColumnModelData['columnOptions'];
        var this_column_bg_color = this_column_options['bg_color'];
        var this_column_margin = this_column_options['margin'];
        var this_column_bg_padding = this_column_options['padding'];
        $(this.el).append('<div class="column" id='+ this_column + ' data-col_id='+this_column+' style="width:' + colWidth +'; background:'+this_column_bg_color+';"> '+ this_column_content +'</div>');

      //  $('#'+this_column).attr('style','width:' + colWidth +'; background:'+this_column_bg_color+';');
      }

      // Row and column buttons
      $(this.el).append('<button id="rowDelete" class="row-btn btn-red" >Delete Row</button> <button id="rowEdit" class="row-btn">Edit Row</button>');
      $('.row').mouseenter(function(){
        $('.row-btn').css('display','block');
      });
      $('.row').mouseleave(function(){
       // $('.row-btn').css('display','none');
      });
      // Save the current model
      this.model.save();
      return this;
    },
    deleteRow: function(){ // Removes model from collection and save the collection.
      this.model.destroy();
      $(this.el).remove();
      this.model.save();
    },
    EditRow: function(){

      var row_height = this.model.get('rowHeight');
      var row_no_columns = this.model.get('columns');
      var rowData = this.model.get('rowData');
      var row_bg_img = rowData['bg_img'];
      var row_bg_color = rowData['bg_color'];
      var row_margin = rowData['margin'];
      var row_padding = rowData['padding'];

      $(this.el).append('<div class="lpp_modal edit_row"> <div class="lpp_modal_wrapper"> <div class="edit_options_left"> <h1 class="banner-h1">Row Options</h1> <label>Row Height :</label> <input type="text" name="row_height" id="row_height" placeholder="Set row height" class="edit_fields" value='+row_height+'> <br> <br> <label>Number of Columns :</label> <input type="number" name="number_of_columns" id="number_of_columns" placeholder="Number of columns in row" min="1" max="8" class="edit_fields" value='+row_no_columns+'> <br> <br> <label>Background Image :</label> <input type="text" name="rowBgImg" class="rowBgImg" value='+row_bg_img+'> <br> <br> <label>Background Color :</label> <input type="color" name="rowBgColor" class="rowBgColor" value='+row_bg_color+'> <br> <br> <label>Row Margin :</label> <input type="number" name="rowMargin" class="rowMargin" value='+row_margin+'> <br> <br> <label>Row Padding :</label> <input type="number" name="rowPadding" class="rowPadding" value='+row_padding+'> </div> <div class="edit_form"> <p><button id="edit_form_close" class="btn-red">Close</button></p> <p><button id="editRowSave">Save</button></p> </div> </div></div>');


      $('.edit_row').css('display','block');
      $('#edit_form_close').click(function(){
        $('.edit_row').remove();
      });
    },
    updateRow: function(){
      var rowheight = $('#row_height').val().trim();
      var numberComlumns = $('#number_of_columns').val().trim();
      var rowBgImg = $('.rowBgImg').val().trim();
      var rowBgColor = $('.rowBgColor').val().trim();
      var rowMargin = $('.rowMargin').val().trim();
      var rowPadding = $('.rowPadding').val().trim();

      if (rowheight) {
        this.model.set({
          rowHeight: rowheight,
          columns: numberComlumns,
          rowData: {
            bg_color: rowBgColor,
            bg_img: rowBgImg,
            margin: rowMargin,
            padding:rowPadding
          }
        });
      }
      
      this.model.save();
      $(this.el).html('');
      this.render();
    },
    EditColumn: function(ev){
      var this_column = $(ev.target).attr('data-col_id');
      var thisColumnData = this.model.get(this_column);
      var this_column_content = thisColumnData['columnContent'];
      var this_column_options = thisColumnData['columnOptions'];
      var this_column_bg_color = this_column_options['bg_color'];
      var this_column_margin = this_column_options['margin'];
      var this_column_bg_padding = this_column_options['padding'];
      
      $(this.el).append('<div class="lpp_modal edit_column"><div class="lpp_modal_wrapper"><div class="edit_options_left"><h1 class="banner-h1">Column Options</h1><label>Background Color :</label><input type="color" name="columnBgColor" class="columnBgColor" value='+this_column_bg_color+'><br><br><label>Column Margin :</label><input type="number" name="columnMargin" class="columnMargin" value='+this_column_margin+'><br><br><label>Column Padding :</label><input type="number" name="columnPadding" class="columnPadding" value='+this_column_bg_padding+'></div><div class="edit_form"><textarea class="columnContent" id='+this_column+' data-col_id='+this_column+'>'+ this_column_content +'</textarea><p><button id="edit_form_close" class="btn-red">Close</button></p><p><button id="editColumnSave" data-col_id='+this_column+' >Save</button></p></div></div></div>');

      $('.edit_column').css('display','block');
      $('#edit_form_close').click(function(){
        $('.edit_column').remove();
      });

    },
    updateColumn: function(ev){

      var columnToUpdate = $(ev.target).attr('data-col_id');
      var columnData      = $('.columnContent').val();
      var columnBgColor   = $('.columnBgColor').val().trim();
      var columnMargin    = $('.columnMargin').val().trim();
      var columnPadding   = $('.columnPadding').val().trim();

      if (columnData) {
        this.model.set({
          [columnToUpdate] : {
            columnContent: columnData,
            columnOptions:{
            bg_color: columnBgColor,
            margin: columnMargin,
            padding:columnPadding,
            width: 10,
            }
          }
        });
      } 
      

      this.model.save();
      $(this.el).html('');
      this.render();

    }

    });

var row = new app.Row();
var savedModels = app.rowList.fetch();

var PgCollectionView = new Backbone.CollectionView( {
    el : $( "ul#container" ),     // must be a 'ul' (i.e. unordered list) or 'table' element
    modelView : app.RowView,           // a View class to be used for rendering each model in the collection
    collection : app.rowList,
    sortable: true,
    selectable: true,
    emptyListCaption: 'Please add some rows.'
} );

//app.rowList.add(savedModels);
PgCollectionView.render();
PgCollectionView.setSelectedModel( app.rowList.first() );

    Backbone.history.start();
   // app.appView = new app.AppView();


$( ".newRow" ).click( function() {

 var row_height = 100;
 var row_no_columns = 1;
 var row_bg_img = "Image URL";
 var row_bg_color = '#ffffff';
 var row_margin = 0;
 var row_padding = 0;

  $('body').append('<div class="lpp_modal new_row_div"> <div class="lpp_modal_wrapper"> <div class="edit_options_left"> <h1 class="banner-h1">Row Options</h1> <label>Row Height :</label> <input type="text" name="row_height" id="row_height" placeholder="Set row height" class="edit_fields" value='+row_height+'> <br> <br> <label>Number of Columns :</label> <input type="number" name="number_of_columns" id="number_of_columns" placeholder="Number of columns in row" min="1" max="8" class="edit_fields" value='+row_no_columns+'> <br> <br> <label>Background Image :</label> <input type="text" name="rowBgImg" class="rowBgImg" value='+row_bg_img+'> <br> <br> <label>Background Color :</label> <input type="color" name="rowBgColor" class="rowBgColor" value='+row_bg_color+'> <br> <br> <label>Row Margin :</label> <input type="number" name="rowMargin" class="rowMargin" value='+row_margin+'> <br> <br> <label>Row Padding :</label> <input type="number" name="rowPadding" class="rowPadding" value='+row_padding+'> </div> <div class="edit_form"> <p><button id="newRowClose" class="btn-red">Close</button></p> <p><button id="newRowSave">Save</button></p> </div> </div></div>');

$('.new_row_div').css('display','block');


$('#newRowSave').click(function(){
  var rowheight = $('#row_height').val().trim();
  var numberComlumns = $('#number_of_columns').val().trim();
  var rowBgImg = $('.rowBgImg').val().trim();
  var rowBgColor = $('.rowBgColor').val().trim();
  var rowMargin = $('.rowMargin').val().trim();
  var rowPadding = $('.rowPadding').val().trim();


  if (rowheight && numberComlumns) {
    PgCollectionView.collection.add( {
      rowHeight: rowheight,
      columns: numberComlumns,
      rowData: {
        bg_color: rowBgColor,
        bg_img: rowBgImg,
        margin: rowMargin,
        padding:rowPadding
      }
    });
    $('.new_row_div').remove();
  }else{
    alert('Both fields are required!');
  }
});


$('#newRowClose').click(function(){
    $('.new_row_div').remove();
});
} );