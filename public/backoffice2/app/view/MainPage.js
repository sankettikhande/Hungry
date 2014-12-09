Ext.define('HolaChef.view.MainPage', {
    extend: 'Ext.Container',
    xtype: 'HomeMenu',

    requires: [
        'Ext.Label',
        'Ext.Container',
        'Ext.Button'
    ],

    config: {

        title: 'Hola',
        id: 'mainPage',
        cls: 'bg-stripe',

        layout: {
            type: 'vbox',
            align: 'center'
        },
        items: [
            {
                html: '&nbsp',
                height: 50
            },
            {
                xtype: 'button',
                text: 'Order',
                action: 'NewBtnAct',
                cls: 'btntext btns'
            },
            {
                html: '&nbsp',
                height: 20
            },
            {
                xtype: 'button',
                text: 'Runner',
                action: 'OldBtnAct',
                cls: 'btntext btns'
            }
        ]
    }

});