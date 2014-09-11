Ext.define('HolaChef.model.LocalStore', {
    extend: 'Ext.data.Model',

    config: {
        fields: [
            { name: 'task', type: 'string' }
        ],
        identifier: 'uuid',
        proxy: {
            type: 'localstorage',
            id: 'localStore'
        }
    }

});