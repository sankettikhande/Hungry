Ext.define('HolaChef.view.ManageRunner', {
    extend: 'Ext.Container',
    xtype: 'ManageRunner',

    requires: [
        'Ext.Label',
        'Ext.Container',
        'Ext.Button'
    ],

    config:
        {
            items: [{
                xtype: 'container',
                id: 'ManageRunnerHtmlID',
                html: ''
            }]

        }
});