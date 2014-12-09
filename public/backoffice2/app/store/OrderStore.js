Ext.define('HolaChef.store.OrderStore', {
    extend: 'Ext.data.Store',
    config: {
        model: 'HolaChef.model.OrderModel',
        proxy: {
            type: 'ajax',
            url: 'data/orders.json',
            reader: {
                type: 'json',            
            },            
            headers: {
                'Accept': 'application/json'
            }
        } 
    }
});