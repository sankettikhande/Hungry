Ext.define('HolaChef.store.LocalStore', {
  extend: 'Ext.data.Store',
  config: {

    model: 'HolaChef.model.LocalStore',
    autoLoad: true,
    proxy: {
      type: 'localstorage',
      //id: 'localstore',  
    }
  }
});