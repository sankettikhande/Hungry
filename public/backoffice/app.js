/*
 * File: app.js
 *
 * This file was generated by Sencha Architect version 3.0.2.
 * http://www.sencha.com/products/architect/
 *
 * This file requires use of the Sencha Touch 2.3.x library, under independent license.
 * License of Sencha Architect does not include license for Sencha Touch 2.3.x. For more
 * details see http://www.sencha.com/license or contact license@sencha.com.
 *
 * This file will be auto-generated each and everytime you save your project.
 *
 * Do NOT hand edit this file.
 */

// @require @packageOverrides
Ext.Loader.setConfig({

});

Ext.application({

    dataUrl: 'http://qa.holachef.com/api/',
    name: 'HolaChef',
    OrdersArry: [],
    PageSize: 5,
    PageCounter: 1,
    Orderid: '',
    ViewOrderid: '',
    MenuOrder: false,
    MenuOrderStatus: '',
    RunnerArry: [],
    RunnerId: '',
    models: [
    'OrderModel'

    ],

    views: [
        'MainView',
        'MainPage',
        'OrderView',
        'ManageRunner'

    ],

    controllers: [
        'Main'
    ],

    stores: [
    'OrderStore'

    ],

    launch: function () {

        Ext.fly('appLoadingIndicator').destroy();
        Ext.Viewport.setMasked({ xtype: 'loadmask', message: 'Hang On..', style: 'z-index:500' }, false);
        this.ShowHideLoader(false);
        Ext.create('HolaChef.view.MainView', { fullscreen: true });

    },
    ShowHideLoader: function (flag, msg) {
        if (arguments.length == 1)
            msg = "Hang On..";

        Ext.Viewport.setMasked({ message: msg });
        Ext.Viewport.setMasked(flag);
    }
});
