Ext.define('HolaChef.model.OrderModel', {
    extend: 'Ext.data.Model',
    config: {
        fields: ['customer_name', 'customer_contact_number', 'order_status', 'address']
    }
});