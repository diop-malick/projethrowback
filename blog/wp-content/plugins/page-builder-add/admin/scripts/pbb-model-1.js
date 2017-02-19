( function( $ ) {
    app.Row = Backbone.Model.extend({
      defaults:{
        rowID: 'ulpb_Row'+Math.floor((Math.random() * 200000) + 100),
        rowHeight: 100,
        columns: 1,
        columnsDivRule:'none',
        rowData: {
          bg_color: '#ffffff',
          bg_img: ' ',
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
          customJS: ' ',
        },
        column1: {
          colWidgets: 0,
          columnOptions:{
          bg_color: 'transparent',
          margin: {
            columnMarginTop: 0,
            columnMarginBottom: 0,
            columnMarginLeft: 0,
            columnMarginRight: 0,
          },
          padding:{
            columnPaddingTop: 0,
            columnPaddingBottom: 0,
            columnPaddingLeft: 0,
            columnPaddingRight: 0,
          },
          width: '',
          }
        },
        column2: {
          colWidgets: 0,
          columnOptions:{
          bg_color: 'transparent',
          margin: {
            columnMarginTop: 0,
            columnMarginBottom: 0,
            columnMarginLeft: 0,
            columnMarginRight: 0,
          },
          padding:{
            columnPaddingTop: 0,
            columnPaddingBottom: 0,
            columnPaddingLeft: 0,
            columnPaddingRight: 0,
          },
          width: '',
          }
        },
        column3: {
          colWidgets: 0,
          columnOptions:{
          bg_color: 'transparent',
          margin: {
            columnMarginTop: 0,
            columnMarginBottom: 0,
            columnMarginLeft: 0,
            columnMarginRight: 0,
          },
          padding:{
            columnPaddingTop: 0,
            columnPaddingBottom: 0,
            columnPaddingLeft: 0,
            columnPaddingRight: 0,
          },
          width: '',
          }
        },
        column4: {
          colWidgets: 0,
          columnOptions:{
          bg_color: 'transparent',
          margin: {
            columnMarginTop: 0,
            columnMarginBottom: 0,
            columnMarginLeft: 0,
            columnMarginRight: 0,
          },
          padding:{
            columnPaddingTop: 0,
            columnPaddingBottom: 0,
            columnPaddingLeft: 0,
            columnPaddingRight: 0,
          },
          width: '',
          }
        },
        column5: {
          colWidgets: 0,
          columnOptions:{
          bg_color: 'transparent',
          margin: {
            columnMarginTop: 0,
            columnMarginBottom: 0,
            columnMarginLeft: 0,
            columnMarginRight: 0,
          },
          padding:{
            columnPaddingTop: 0,
            columnPaddingBottom: 0,
            columnPaddingLeft: 0,
            columnPaddingRight: 0,
          },
          width: '',
          }
        },
        column6: {
          colWidgets: 0,
          columnOptions:{
          bg_color: 'transparent',
          margin: {
            columnMarginTop: 0,
            columnMarginBottom: 0,
            columnMarginLeft: 0,
            columnMarginRight: 0,
          },
          padding:{
            columnPaddingTop: 0,
            columnPaddingBottom: 0,
            columnPaddingLeft: 0,
            columnPaddingRight: 0,
          },
          width: '',
          }
        },
        column7: {
          colWidgets: 0,
          columnOptions:{
          bg_color: 'transparent',
          margin: {
            columnMarginTop: 0,
            columnMarginBottom: 0,
            columnMarginLeft: 0,
            columnMarginRight: 0,
          },
          padding:{
            columnPaddingTop: 0,
            columnPaddingBottom: 0,
            columnPaddingLeft: 0,
            columnPaddingRight: 0,
          },
          width: '',
          }
        },
        column8: {
          colWidgets: 0,
          columnOptions:{
          bg_color: 'transparent',
          margin: {
            columnMarginTop: 0,
            columnMarginBottom: 0,
            columnMarginLeft: 0,
            columnMarginRight: 0,
          },
          padding:{
            columnPaddingTop: 0,
            columnPaddingBottom: 0,
            columnPaddingLeft: 0,
            columnPaddingRight: 0,
          },
          width: '',
          }
        }
      },
      url: "/"
    });

}( jQuery ) );