Ext.define('HolaChef.view.MainView', {
    extend: 'Ext.NavigationView',    
    xtype: 'MainView',

    requires: [        
        'Ext.Panel',
        'Ext.navigation.Bar'
    ],

    config: {

        id: 'mainView',        
        width: '100%',
        height: '100%',
        autoDestroy: false,
        // cls: 'bg-stripe',
        items: [
            {                   
                xtype:'HomeMenu',
            }
        ],        
        navigationBar: {
            centered: false,
            docked: 'top',
            itemId: 'navBar',
            items:[
//                      {
//                        id: 'btnrefesh',
//                        align: 'right',
//                        name: 'nav_btn',
//                        iconCls: 'refresh',
//                        ui: 'plain',
//                        action: 'refresh',
//                        style: 'margin-right:20px;'
//                    },                 
                ]
            }                
        },
        initialize: function () {

            console.log('Panel initialize');            
            Ext.Viewport.on('orientationchange', 'handleOrientationChange', this);
            this.callParent(arguments); 
        },
     
        handleOrientationChange: function(viewport,orientation,width,height){
            
        }
});