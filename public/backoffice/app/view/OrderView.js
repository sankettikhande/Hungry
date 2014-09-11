Ext.define('HolaChef.view.OrderView', {
    extend: 'Ext.Container',
    xtype: 'OrderView',

    requires: [
        'Ext.Label',
        'Ext.Container',
        'Ext.Button'
    ],
    config: {
       
    
        width: '100%',
        height: '100%',
        xtype: 'container',
        scrollable: true,
        items: [
            {
                xtype: 'spacer',
                style: 'padding-top:20px;'
            },
            {
                layout: {
                    width:'100%',
                    type: 'hbox',
                    align: 'center'
                },

                items: [
                 {
                     xtype: 'container',
                     html: 'Search By :&nbsp;&nbsp;&nbsp;',
                     style: 'margin-top: 0.60em;'
                 },                 
                 {
                     xtype: 'textfield',
                     id: 'txtsearch',
                     placeHolder: 'Search',
                     width: '30%',                     
                 },
                {
                    xtype: 'button',
                    text: 'Search',                    
                    height: '1.6em',
                    width: '10%',
                    action:'actSearch',
                    style: 'margin:10px;margin-top:15px;',
                    id: 'btnsearch'

                },
                {
                    xtype: 'button',
                    text: 'Filter',
                    height: '1.6em',
                    width: '10%',
                    action:'actFilter',
                    style: 'margin:10px;margin-top:15px;',
                    id: 'btnFilter'

                },
                 {   xtype: 'spacer' },
                 {
                     xtype: 'button',
                     id: 'btnrefesh',
                     text: 'Refresh',
                     action: 'actrefresh',
                     width: '20%',
                     style: 'float:right'
                 }]            
            },
                {
                    xtype: 'spacer',
                    style:'padding-top:50px;'
                },
               {
                   width: '100%',
                   xtype: 'list',                  
                   id: 'DefectPageHtmlID',
                   action: 'SubmittedChecksheets',
                   emptyText: '<div>No records found</div>',
                   html: ''
               }
        ]
    }
//    ,
//    show: function () {
//        HolaChef.app.getController("Main").GetDefectGridData();
//    }

});