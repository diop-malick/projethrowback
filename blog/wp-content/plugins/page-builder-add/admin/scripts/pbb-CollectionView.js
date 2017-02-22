
( function( $ ) {
app.rowList = new app.RowCollection();
app.widgetList = new app.WidgetCollection();
app.PageBuilderModel = new app.ULPBPage();

var row = new app.Row();
var widget = new app.ColWidget();
//var savedPage = app.PageBuilderModel.fetch();
app.PageBuilderModel.fetch({
    success: function() { 
      var Rows = app.PageBuilderModel.get('Rows');
      var pageOptions = app.PageBuilderModel.get('pageOptions');
      var frontPage = pageOptions['frontPage'];
      var loadWpHead = pageOptions['loadWpHead'];
      var loadWpFooter = pageOptions['loadWpFooter'];
      var pageSeoName = pageOptions['pageSeoName'];
      var pageLink = pageOptions['pageLink'];
      var pageSeoDescription = pageOptions['pageSeoDescription'];
      var pageSeoKeywords = pageOptions['pageSeoKeywords'];

      var pageBgColor = pageOptions['pageBgColor'];
      var pageBgImage = pageOptions['pageBgImage'];
      var pagePadding = pageOptions['pagePadding'];
      var pagePaddingTop = pagePadding['pagePaddingTop'];
      var pagePaddingBottom = pagePadding['pagePaddingBottom'];
      var pagePaddingRight = pagePadding['pagePaddingRight'];
      var pagePaddingLeft = pagePadding['pagePaddingLeft'];
      
    $('#title').val(pageSeoName);
    $('#new-post-slug').val(pageLink);
    $('#title-prompt-text').html(' ');
    $('.pageSeoDescription').val(pageSeoDescription);
    $('.pageSeoKeywords').val(pageSeoKeywords);
    $('.pageBgImage').val(pageBgImage);
    $('.pageBgColor').val(pageBgColor);
    $('.pagePaddingTop').val(pagePaddingTop);
    $('.pagePaddingBottom').val(pagePaddingBottom);
    $('.pagePaddingLeft').val(pagePaddingLeft);
    $('.pagePaddingRight').val(pagePaddingRight);

    $('.pageBgColor').parent().prev().css('background-color',pageBgColor);
    $('#container').attr('style','background-image: url("'+pageBgImage+'"); background-size:cover; background-color:'+pageBgColor+';');
      _.each( Rows, function(Row, index ) {
        app.rowList.add(Row);
      });
    },
    error: function() {
        console.log('Failed to fetch!');
    }
});


var PgCollectionView = new Backbone.CollectionView( {
    el : $( "#container" ),
    modelView : app.RowView,
    collection : app.rowList,
    sortable: true,
    selectable: true,
    emptyListCaption: '<h3>Add some rows.</h3>'
} );

var widgetCollectionView = new Backbone.CollectionView( {
    el : $( "#widgets" ),
    modelView : app.WidgetView,
    collection : app.widgetList,
    sortable: false,
    selectable: false,
    emptyListCaption: 'Add some widgets.'
} );

PgCollectionView.render();
widgetCollectionView.render();
}( jQuery ) );