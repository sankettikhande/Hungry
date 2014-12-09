Ext.define('HolaChef.view.Runnerinfo', {
    extend: 'Ext.Container',
    xtype: 'Runnerinfo',

    requires: [
        'Ext.Label',
        'Ext.Container',
        'Ext.Button'
    ],

    config: {
        items: [{
            xtype: 'container',
            id: 'RunnerInfoHeader',
            layout: { type: 'hbox', width: '100%' },
            items: [{
                xtype: 'container',
                html: 'Runner Orders',
                style: 'margin-top: 0.60em;font-size:25px;padding-bottom: 50px;'
            }]
        },
        {
            xtype: 'container',
            id: 'RunnerInfoDetail',
            layout: { type: 'hbox', width: '100%', height: '100%' },
            items: [
                {
                    xtype: 'container',
                    layout: { type: 'vbox', width: '100%' },
                    items: [
                    {
                        xtype: 'button',
                        text: 'Runner info',
                        id: 'btnRunnerinfo'
                    },
                    {
                        xtype: 'label',
                        id: 'lblRunnerinfo',
                        hidden: true,
                        html: 'Runner info'
                    },
                    {
                        xtype: 'label',
                        html: 'Orders',
                        id: 'lblorders',
                        hidden: true,
                        style: 'margin-top:5px;'
                    },
					{
					    xtype: 'button',
					    text: 'Orders',
					    id: 'btnorders',
					    style: 'margin-top:5px;'
					}]
                },
                {
                    xtype: 'container',
                    id: 'RunnerinfoHtmlID',
                    width: '90%',
                    html: 'asdasdas',
                    style: 'padding-left:5px;'
                },
                {
                    xtype: 'container',
                    id: 'RunnerOrderDetail',
                    scrollable: true,
                    width: '90%',
                    height: '600px',
                    html: 'asdasdas',
                    style: 'padding-left:5px;'
                }
            ]
        }]
    }
});