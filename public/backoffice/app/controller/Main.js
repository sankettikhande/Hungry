Ext.define('HolaChef.controller.Main', {
    extend: 'Ext.app.Controller',

    config: {
        refs: {
            
            MainView: '#mainView',
            
            DefectPageHtmlRef: '#DefectPageHtmlID',
            btnrunnercnfrm: 'button[action=runnercnfrm]',
            btnreasonsubmmit: 'button[action=reasonsubmit]',
            btndamagerefund: 'button[action=DamageRefund]',
            btndamagereorder: 'button[action=Damagereorder]',
            btnrefreshRef: 'button[action=actrefresh]',
            btnSearchRef: 'button[action=actSearch]',
            btnFilterRef: 'button[action=actFilter]',
            Refreturnreason: '#txtreturnreason',
            RefAllRunnerList: '#AllRunnerList',
            Refbtndate: '#btnbydate',
            refbtnclosedate: '#btndateback',
            refbtnsubmitdate: '#btndatesubmit',
            refbtnstatus: 'button[action=filterstatus]',
            refbtnstatusclose: '#btnstatusclose',
            refbtnstatusgo: '#btnstatusgo',
            NewBtnRef: 'button[action=NewBtnAct]',
            OldBtnRef: 'button[action=OldBtnAct]',
            ManageRunnerHtmlRef: '#ManageRunnerHtmlID',
            RunnerinfoHtmlRef: '#RunnerinfoHtmlID',
            RefbtnRunnerinfo: '#btnRunnerinfo',
            Refbtnorders: '#btnorders',
            RefRunnerOrderDetail: '#RunnerOrderDetail',
            
            
        },

        control: {
            btnrunnercnfrm: { tap: 'onbtnrunnercnfrm' },
            btnreasonsubmmit: { tap: 'onbtnreasonsubmit' },
            btndamagereorder: { tap: 'onbtnbtndamagereorder' },
            btnrefreshRef: { tap: 'onbtrefreshclick' },
            btnSearchRef: { tap: 'onsearchclick' },
            btnFilterRef: { tap: 'GetFilters' },
            btndamagerefund: { tap: 'onbtndamagerefund' },
            Refbtndate: { tap: 'onbydate' },
            refbtnclosedate: { tap: 'onclosebydate' },
            refbtnsubmitdate: { tap: 'ondatesubmit' },
            refbtnstatus: { tap: 'onbtnstatus' },
            refbtnstatusclose: { tap: 'onbtnstausclose' },
            refbtnstatusgo: {tap:'onbtnstatusgo'},
            NewBtnRef: { tap: 'NewBtnHandler' },
            OldBtnRef: { tap: 'OldBtnHandler' },
            RefbtnRunnerinfo: {tap: 'onRefbtnRunnerinfo'},
            Refbtnorders: { tap: 'onrefbtnordersclick' },
            MainView: {pop: 'onNavigationPop', push: 'onNavigationPush',},
            Refbtnrefresh: {tap: 'onrefreshclick'},
        }
    },
    init: function () {
        this.Orderid = '';
    },
 

//    Runner start
OldBtnHandler: function () {
    
        if (!this.managerunner)
            this.managerunner = Ext.create('HolaChef.view.ManageRunner');
        this.getMainView().push(this.managerunner);
        this.ManageRunnerGridData();
    },
    onMainViewload: function () {
        if (!this.managerunner)
            this.managerunner = Ext.create('HolaChef.view.ManageRunner');
        this.getMainView().push(this.managerunner);
        this.ManageRunnerGridData();
    },
    ManageRunnerGridData: function () {
  
        HolaChef.app.ShowHideLoader(true);
        var ref = this;        
        Ext.data.JsonP.request({
            url: HolaChef.app.dataUrl + 'runners.json',
            params: {
                method: 'orders',
                format: 'json',
                callback: 'callback'
            },
            success: function (records) {
             
                HolaChef.app.RunnerArry = records
                var str = '';                
                str += '<div>Manage Runner</div><div>&nbsp;</div><div class="table-responsive" id="grid"><table class="table table-bordered" id=""><thead>';
                str += '<tr class="headerrow"><th>Name</th><th>Order delivered</th><th>cash collected</th><th>orders to Deliver</th><th>Average Delivery Time</th></tr>';
                for (var i = 0; i < records.length; i++) {
                    if (i % 2 == 0)
                        str += '<tr class="datarow2">';
                    else
                        str += '<tr class="datarow1">';
                    str += '<td><a href="#" onclick="RunnerDetail(\'' + records[i]["id"] + '\');">' + records[i]["name"] + '</a></td><td>' + records[i]["orders_delivered"] + '</td><td>' + records[i]["cash_collected"] + '</td><td>'+records[i]["orders_pending"]+'</td><td>' + records[i]["average_delivery_time"] + '</td></tr>';
                }
                str += '</table></div>';


                str += '</tbody></table></div>';
                ref.getManageRunnerHtmlRef().setHtml("");
                ref.getManageRunnerHtmlRef().setHtml(str);
                HolaChef.app.ShowHideLoader(false);
            },
            failure: function (response) {
                HolaChef.app.ShowHideLoader(false);
                Ext.Msg.alert('Alert', 'Please check internet connectivity !');
            }
        });

    },
    RunnerinfoGridData: function (id)
    {
        if (this.runnerinfo)
            this.runnerinfo = null;
        if (!this.runnerinfo)
            this.runnerinfo = Ext.create('HolaChef.view.Runnerinfo');            
        this.getMainView().push(this.runnerinfo);
        this.setRunnerinfo(id);
    },
    onRefbtnRunnerinfo: function () {
        HolaChef.app.ShowHideLoader(true);
        this.setRunnerinfo(HolaChef.app.RunnerId);
    },
    setRunnerinfo: function (id) {
    
        var runnerary = HolaChef.app.RunnerArry;
        Ext.getCmp("lblRunnerinfo").setHidden(false);
        this.getRefbtnRunnerinfo().setHidden(true);

        Ext.getCmp("lblorders").setHidden(true);
        this.getRefbtnorders().setHidden(false);

        this.getRunnerinfoHtmlRef().setHidden(false);
        this.getRunnerinfoHtmlRef().setHtml("");
        var str = '';
        for (var i = 0; i < runnerary.length; i++) {
            if (runnerary[i]["id"] == id) {
                str += '<table style="border:1px solid black;" cellspacing="0" cellpadding="0" width="100%"><tr><td style="paading:10px;">';
                str += '<table cellspacing="0" cellpadding="0" width="100%"><tr><td>Runner Name</td><td>' + runnerary[i]["name"] + '</td><td>Avg delivry Time</td><td>' + runnerary[i]["average_delivery_time"] + '</td></tr><tr><td>Phone</td><td>' + runnerary[i]["phone"] + '</td><td>Damages</td><td>' + runnerary[i]["damages"] + '</td></tr><tr><td>Address</td><td>' + runnerary[i]["address"] + '</td><td>Returns</td><td>' + runnerary[i]["returns"] + '</td></tr><tr><td>Amount Pending</td><td>Rs.' + runnerary[i]["amount_pending"] + '</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>Orders Pending</td><td>' + runnerary[i]["orders_pending"] + '</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>Account Status</td><td></td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td colspan="4"><br/><br/><br/></td></tr><tr><td colspan="4"><a href="#">Change Password</a></td></tr><tr><td colspan="4"><br/><br/><br/></td></tr></table>';
                str += '</td></tr></table>';
            }
        }
        this.getRunnerinfoHtmlRef().setHtml(str);
        this.getRefRunnerOrderDetail().setHidden(true);
        HolaChef.app.ShowHideLoader(false);
    },
    onrefbtnordersclick: function () {
        
        var ref = this;

        this.getRefbtnRunnerinfo().setHidden(false);
        Ext.getCmp("lblRunnerinfo").setHidden(true);

        Ext.getCmp("lblorders").setHidden(false);
        this.getRefbtnorders().setHidden(true);        
        

        HolaChef.app.ShowHideLoader(true);
        Ext.data.JsonP.request({
            url: HolaChef.app.dataUrl + 'runners/' + HolaChef.app.RunnerId + '/orders.json',
            params: {
                method: 'orders',
                format: 'json',
                callback: 'callback'
            },
            success: function (records) {
                
                ref.getRefRunnerOrderDetail().setHtml("");
                var str = '';
                str += '<div class="table-responsive" id="grid"><table class="table table-bordered" id=""><thead><tr class="headerrow"><th>Order No</th><th>Amount</th><th>Payment Mode</th><th>Order Status</th><th>Card Number</th><th>Delivered In</th><th>Action</th></tr></thead><tbody>';
                for (var i = 0; i < records.length; i++) {
                    if (i % 2 == 0)
                        str += '<tr class="datarow2">';
                    else
                        str += '<tr class="datarow1">';
                    str += '<td><a href="#">' + records[i]["id"] + '</a></td><td>' + records[i]["bill_amount"] + '</td><td>' + records[i]["payment_mode"] + '</td><td>' + records[i]["order_status"] + '</td><td>5</td><td></td><td>';
                    str += '<select><option value="select">select</option><option value="collection">Collect Amount</option></select>';
                    str += '</td></tr>';
                }
                str += '</table></div>';


                str += '</tbody></table></div>';

                ref.getRunnerinfoHtmlRef().setHidden(true);
                ref.getRefRunnerOrderDetail().setHtml(str);
                ref.getRefRunnerOrderDetail().setHidden(false);

                HolaChef.app.ShowHideLoader(false);
                
            },
            failure: function (response) {
                HolaChef.app.ShowHideLoader(false);
                Ext.Msg.alert('Alert', 'Please check internet connectivity !');
            }
        });
    },
    onNavigationPop: function () {
        this.getRefbtnrefresh().show();
    },
    onNavigationPush: function ()
    {
        if (this.runnerinfo)
            this.getRefbtnrefresh().hide();
    },
//    onrefreshclick: function ()
//    {
//        this.onMainViewload();
//    },
//Runner End

    NewBtnHandler: function () {
      OpenOrderDetails();
        if (!this.OrderView)
            this.OrderView = Ext.create('HolaChef.view.OrderView');        
        this.getMainView().push(this.OrderView);
        var task = setInterval(function () {
                   OpenOrderDetails();

                }, 60000);
                var ls = Ext.getStore("LocalStore");
                var item = ls.getAt(0);
                item.set('task', task);
                ls.sync();
    },
    onbtnstatusgo: function () {
     
        var ddlstatusval = Ext.getCmp("AllStatusList").getValue();
        var Dataarry = HolaChef.app.OrdersArry;
        var finaldata_Ary = new Array();

        if (ddlstatusval == "All") {

            this.setOrderList(Dataarry);
            this.onbtnstausclose();
            Ext.getCmp('Filtersdetailpanel').hide();
        }
        else {
            var flag = true;
            for (var i = 0; i < Dataarry.length; i++) {                
                if (Dataarry[i]["order_status"].search(ddlstatusval) != -1) {
                    flag = false;
                    finaldata_Ary.push(Dataarry[i]);
                }
            }
            if (flag)
                Ext.Msg.alert("Info", "No Record found...!");
            else {
                this.setOrderList(finaldata_Ary);
                this.onbtnstausclose();
                Ext.getCmp('Filtersdetailpanel').hide();
            }
        }
    },
    onbtnstausclose: function () {
        var obj = Ext.getCmp("StatusPanel");
        var btnsatusobj = Ext.getCmp("btnfilStatus");
        var ddlstatusval = Ext.getCmp("AllStatusList").setValue("All");
        obj.setHidden(true);
        btnsatusobj.setHidden(false);
        Ext.getCmp("btnbydate").setHidden(false);
    },
    onbtnstatus: function () {        
        var obj = Ext.getCmp("StatusPanel");
        var btnsatusobj = Ext.getCmp("btnfilStatus");
        obj.setHidden(false);
        btnsatusobj.setHidden(true);
        Ext.getCmp("btnbydate").setHidden(true);
    },
    ondatesubmit: function () {
        var ref = this;
        var startdate_obj = Ext.getCmp("Dtstartdate").getPicker()._value;
        var enddate_obj = Ext.getCmp("Dtenddate").getPicker()._value;

        var startdate = startdate_obj.year + "-" + startdate_obj.month + "-" + startdate_obj.day;
        var enddate = enddate_obj.year + "-" + enddate_obj.month + "-" + enddate_obj.day;        

        $.ajax({
            type: "GET",
            url: HolaChef.app.dataUrl + 'orders.json?from_date=' + startdate + '&to_date='+ enddate,
            
            contentType: 'application/json; charset=utf-8',
            dataType: "jsonp",
            success: function (response) {//On Successfull service call       
                
                ref.setOrderList(response);
                ref.onclosebydate();
                ref.onbtnstausclose();
                Ext.getCmp('Filtersdetailpanel').hide();
               // Ext.getCmp('Filtersdetailpanel').hide();
            },
            failure: function (response) {
                alert(response);
            }
        });
    },
    onbydate: function () {
        var obj = Ext.getCmp("Bydatepanel");
        var btndateobj = Ext.getCmp("btnbydate");
        obj.setHidden(false);
        btndateobj.setHidden(true);
        Ext.getCmp("btnfilStatus").setHidden(true);
    },
    onclosebydate: function () {
        var obj = Ext.getCmp("Bydatepanel");
        var btndateobj = Ext.getCmp("btnbydate");
        var startdate =  Ext.getCmp("Dtstartdate");
        var enddate = Ext.getCmp("Dtenddate");
        startdate.setValue("");
        enddate.setValue("");
        obj.setHidden(true);

        btndateobj.setHidden(false);
        Ext.getCmp("btnfilStatus").setHidden(false);
    },
    GetFilters: function () {
       
        var ref = this;
        if (!this.Filters) {
            this.Filters = Ext.Viewport.add({
                xtype: 'panel',
                id: 'Filtersdetailpanel',
                modal: true,
                hideOnMaskTap: false,
                hidden: true,
                showAnimation: {
                    type: 'popIn',
                    duration: 250,
                    easing: 'ease-out'
                },
                hideAnimation: {
                    type: 'popOut',
                    duration: 250,
                    easing: 'ease-out',
                    listeners: {
                        animationend: function (evt, obj) {

                        }
                    }
                },
                centered: true,
                width: '80%',
                height: '60%',
                scrollable: true,
                items: [
                        {

                            items: [
                                {
                                    xtype: 'button',
                                    text: 'Close',
                                    docked: 'right',
                                    listeners: {
                                        tap: function () {
                                            ref.onclosebydate();
                                            ref.onbtnstausclose();                                            
                                            Ext.getCmp('Filtersdetailpanel').hide();
                                            
                                        }
                                    }
                                }]
                        },
                            {
                                xtype: 'container',
                                id: 'Filtersdetailcontainer',
                                title: '',
                                layout: {
                                    type: 'vbox',
                                    align: 'center'
                                },
                                items: [
					{
					    xtype: 'label',
					    html: 'Search By :',
					    style: 'margin-top: 0.60em;'
					},
                    { xtype: 'spacer', style: 'padding:10px;' },
					{
					    xtype: 'button',
					    text: 'Date',					    					    
					    id: 'btnbydate'					    
					},
                    {
                        layout: { width:'100%',type: 'vbox' },
                        id: 'Bydatepanel',
                        hidden: true,
                        style: 'margin-top: 0.60em;',
                        items: [
                                {
                                    xtype: 'spacer',
                                    style: 'margin: 0.20em;padding-left:5px;'
                                },                                
                                {
                                    xtype: 'datepickerfield',
                                    label: 'Start date',
                                    name: 'strdate',
                                    id:'Dtstartdate',
                                    picker: {
                                        yearFrom: 2010, // Note: can have helper function
                                        yearTo: parseInt(getMaxYear())
                                    }

                                },
                                {
                                    xtype: 'datepickerfield',
                                    label: 'End date',
                                    name: 'enddate',
                                    id: 'Dtenddate',
                                    picker: {
                                        yearFrom: 2010, // Note: can have helper function
                                        yearTo: parseInt(getMaxYear())
                                    }

                                },
                                {
                                    xtype: 'button',
                                    text: 'Submit',                                    
                                    height: '1.6em',
                                    width: '120px',
                                    style: 'margin:10px;margin-top:15px;',
                                    id: 'btndatesubmit'
                                },
                                {
                                    xtype: 'button',
                                    text: 'Close',                                    
                                    height: '1.6em',
                                    width: '120px',
                                    style: 'margin:10px;margin-top:15px;',
                                    id: 'btndateback'
                                },
                        ]

                    },
                    {xtype:'spacer',style:'padding:10px;'},
                    {
                        xtype: 'button',
                        text: 'Status',					    
                        cls: 'locationbtn locationbtngap',
                        id: 'btnfilStatus',
                        action:'filterstatus'
                    },
                    {
                        layout: { type: 'hbox',width:'100%' },
                        id: 'StatusPanel',
                        hidden: true,
                        style: 'margin-top: 0.60em;',
                        items: [
                            {
                                xtype: 'spacer',
                                style: 'margin: 0.20em;'
                            },                            
                            {
                                xtype: 'selectfield',
                                id: "AllStatusList",
                                style: 'border:1px solid #000;margin-top:5px;margin-bottom:5px;',
                                options: [
                                    { value: 'All', text: 'All' },
                                    {value: 'Created', text: 'Created'},
                                    { value: 'Confirmed', text: 'Confimed' },
                                    {value:'Canceled',text:'Canceled'},
                                    {value: 'Dispatched', text: 'Dispatched'},
                                    {value: 'Delivered', text: 'Delivered'},
                                    { value: 'Damaged', text: 'Damaged' },
                                    { value: 'Reordered', text: 'Reordered' },
                                    { value: 'Returned', text: 'Returned' },

                                ]

                            },
                            {
                                xtype: 'button',
                                text: 'Submit',                                
                                height: '1.6em',
                                width: '120px',
                                style: 'margin:10px;margin-top:15px;',
                                id: 'btnstatusgo'
                            },
                            {
                                xtype: 'button',
                                text: 'Close',                                
                                height: '1.6em',
                                width: '120px',
                                style: 'margin:10px;margin-top:15px;',
                                id: 'btnstatusclose'
                            },
                        ]
                    }
					
                                ]
                            }

                ]

            });
        }
        this.Filters.show();
    },
    onsearchclick: function () {
        
        var txtobj = Ext.getCmp("txtsearch");
        if (txtobj.getValue() != "") {
            var searchval = txtobj.getValue();
            var Dataarry = HolaChef.app.OrdersArry;
            var finaldata_Ary = new Array();
            var flag = true;
            for (var i = 0; i < Dataarry.length; i++) {
                var id = String(Dataarry[i]["id"]);
                if (id.indexOf(searchval) != -1) {
                    flag = false;
                    finaldata_Ary.push(Dataarry[i]);
                }
                if (Dataarry[i]["customer_name"].search(searchval) != -1) {
                    flag = false;
                    finaldata_Ary.push(Dataarry[i]);
                }
            }
            if (flag)
                Ext.Msg.alert("Info", "No Record found...!");
            else {
                this.setOrderList(finaldata_Ary);
            }
        }
        else
            Ext.Msg.alert("Info", "Please Enter Value...!");
    },
    onbtrefreshclick: function () {
   
        HolaChef.app.getController("Main").GetDefectGridData();
    },
    onbtndamagerefund: function () {
        var ref = this
        var id = HolaChef.app.Orderid;
        if (HolaChef.app.MenuOrder)
        {
            var obj = Ext.getCmp("DamageOrder");            
            obj.hide();
            obj = null;
            var menuid = fetchmenuid();
            UpdateMenueItemStatus(HolaChef.app.Orderid, 'Refunded', menuid);
        }
        else {
            $.ajax({
                type: "GET",
                url: HolaChef.app.dataUrl + 'orders/' + id + '/update_status.json?status=Refunded',
                contentType: 'application/json; charset=utf-8',
                dataType: "jsonp",
                success: function (response) {//On Successfull service call                
                    var obj = Ext.getCmp("DamageOrder");
                    var id = HolaChef.app.Orderid;
                    obj.hide();
                    obj = null;
                    obj = Ext.getCmp("OredrDetailspanel");
                    obj.hide();
                    ref.GetDefectGridData();
                },
                failure: function (response) {
                    alert(response);
                }
            });
        }
    },
    onbtnbtndamagereorder: function () {
       
        var id = HolaChef.app.Orderid;
        var ref = this;
        if (HolaChef.app.MenuOrder) {
            var obj = Ext.getCmp("DamageOrder");            
            obj.hide();
            obj = null;
            //var menuid = fetchmenuid();
            //UpdateMenueItemStatus(HolaChef.app.Orderid, 'Reordered', menuid);
        }
        else {
            $.ajax({
                type: "GET",
                url: HolaChef.app.dataUrl + 'orders/' + id + '/reorder.json?status=Reordered',
                contentType: 'application/json; charset=utf-8',
                dataType: "jsonp",
                success: function (response) {//On Successfull service call                
                    var obj = Ext.getCmp("DamageOrder");
                    var id = HolaChef.app.Orderid;
                    obj.hide();
                    obj = null;
                    obj = Ext.getCmp("OredrDetailspanel");
                    obj.hide();
                    ref.GetDefectGridData();
                },
                failure: function (response) {
                    alert(response);
                }
            });
        }
    },
    onbtnrunnercnfrm: function () {

        var obj = Ext.getCmp("RunnerDetails")
        var id = HolaChef.app.Orderid;
        obj.hide();
        var ddlrunner = document.getElementById("AllRunnerList").value;
        if (ddlrunner != "Select") {
            //OrderdetailPopup(HolaChef.app.Orderid, 'dispatch', HolaChef.app.ViewOrderid);
            //return;
            $.ajax({
             
                type: "GET",
                url: HolaChef.app.dataUrl + 'orders/' + id + '/assign_runner.json?runner_id=' + ddlrunner,
                contentType: 'application/json; charset=utf-8',
                dataType: "jsonp",
                success: function (response) {//On Successfull service call 
                     
                    var obj = response;
                    $.ajax({
                        type: "GET",
                        url: HolaChef.app.dataUrl + 'orders/' + id + '/update_status.json?status=Dispatched',
                        contentType: 'application/json; charset=utf-8',
                        dataType: "jsonp",
                        success: function (response) {//On Successfull service call                
                            
                            OrderdetailPopup(HolaChef.app.Orderid, 'Dispatched');
                        },
                        failure: function (response) {
                            alert(response);
                        }
                    });
                },
                failure: function (response) {
                    alert(response);
                }
            });
        }
        else
            Ext.Msg.alert("Info", "Please Select Runner");
    },
    onbtnreasonsubmit: function () {
        var obj = Ext.getCmp("ReturneOrder")
        var id = HolaChef.app.Orderid;
        obj.hide();        
        var txtobj = this.getRefreturnreason();            
        $.ajax({
            type: "GET",
            url: HolaChef.app.dataUrl + 'orders/' + id + '/update_status.json?status=Returned&reason=' + txtobj.getValue(),
            contentType: 'application/json; charset=utf-8',
            dataType: "jsonp",
            success: function (response) {//On Successfull service call                
                OrderdetailPopup(HolaChef.app.Orderid, 'Returned');
            },
            failure: function (response) {
                alert(response);
            }
        });
    },
    GetDefectGridData: function () {

        var ref = this;
        //this.getDefectPageHtmlRef().setHtml("");                 
        Ext.data.JsonP.request({
            url: HolaChef.app.dataUrl + 'orders.json',
            params: {
                method: 'orders',
                format: 'json',
                callback: 'callback'
            },
            success: function (response) {
                
                HolaChef.app.OrdersArry = response;                
                ref.setOrderList(response);
            },
            failure: function (response) {
                Ext.Msg.alert('Alert', 'Please check internet connectivity !');
            }
        });
        
    },
    setOrderList: function (records) {
    
        HolaChef.app.ShowHideLoader(true);
        var ref = this;
        var str = '';
        str += '<div class="table-responsive" id="grid"><table class="table table-bordered" id=""><thead><tr class="headerrow"><th>Order No</th><th>Name</th><th>Mobile</th><th>Payment</th><th>Progress</th><th>Meal Type</th><th>Order Time</th></tr></thead><tbody>';
        for (var i = 0; i < records.length; i++) {
            var date= records[i]["confirmed_at"];
            var dispat= records[i]["dispatched_at"];
            
            var timeNow = new Date(date);
            var DiffMins = (new Date()-timeNow)/(1000*60);
            var id = records[i]["id"];
            if (DiffMins > 5 && dispat == null)
                 str += '<tr class="datarow5">';
            else if(i % 2 == 0)
                 str += '<tr class="datarow2">';
            else
                str += '<tr class="datarow1">';

            var j = i + 1;

            var innhtml = '<a href="#" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');"> View</a>';
            var status = records[i]["order_status"];
            if (records[i]["order_progress"] == "Created" && records[i]["order_status"] == "Created")
                innhtml = '';
            else if (status == "Confirmed") {
                if (records[i]["original_order_id"])
                    innhtml = '<a href="#" onclick="ondispatch(\'' + String(id) + '\');">Dispatch</a> , <a href="#" onclick="OrderdetailPopup(\'' + String(id) + '\',\'ReNewOrder\');"> View</a>';
                else
                    innhtml = '<a href="#" onclick="ondispatch(\'' + String(id) + '\');">Dispatch</a> , <a href="#" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');"> View</a>';
            }
            else if (status == "Dispatched")
                innhtml = '<a href="#" onclick="ondeliverd(\'' + String(id) + '\');">Delivered</a> , <a href="#" onclick="OrderdetailPopup(\'' + String(id) + '\',\'' + status + '\');"> View</a>';
            else if (status == "Canceled" || status == "Delivered" || status == "Returned" || status == "Reordered")
                innhtml = '<a href="#" onclick="OrderdetailPopup(\'' + String(id) + '\',\'' + status + '\');"> View</a>';
            
            str += '<td><a href="#" style="text-decoration:none;color:black;" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');">' + String(id) + '</a></td><td><a href="#" style="text-decoration:none;color:black;" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');"> ' + records[i]["customer_name"] + '</a></td><td><a href="#" style="text-decoration:none;color:black;" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');"> ' + records[i]["customer_contact_number"] + '</a></td><td><a href="#" style="text-decoration:none;color:black;" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');">' + records[i]["payment_mode"] + '</a></td><td> <a href="#" style="text-decoration:none;color:black;" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');">' + records[i]["order_progress"] + '</a></td>';
            str += '<td><a href="#" style="text-decoration:none;color:black;" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');">' + (records[i]["order_items"][0] == undefined ? "" : records[i]["order_items"][0]["meal_type"]) + '</a></td><td><a href="#" style="text-decoration:none;color:black;" onclick="OrderdetailPopup(\'' + String(id) + '\',\'orderno\');">' + records[i]["confirmed_at"] + '</td></a>';
            str += '</tr>';
        }

        str += '</tbody></table></div>';
        ref.getDefectPageHtmlRef().setHtml(str);
        HolaChef.app.ShowHideLoader(false);
    },
    GetOrderDetail: function () {
        
        var ref = this;        
        if (!this.OredrDetails) {
            this.OredrDetails = Ext.Viewport.add({
                xtype: 'panel',
                id: 'OredrDetailspanel',
                modal: true,
                hideOnMaskTap: false,
                hidden: true,
                showAnimation: {
                    type: 'popIn',
                    duration: 250,
                    easing: 'ease-out'
                },
                hideAnimation: {
                    type: 'popOut',
                    duration: 250,
                    easing: 'ease-out',
                    listeners: {
                        animationend: function (evt, obj) {

                        }
                    }
                },
                centered: true,
                width: '80%',
                height: '85%',
                scrollable: true,
                items: [
                        {

                            items: [
                                {
                                    xtype: 'button',
                                    text: 'Close',
                                    docked: 'right',
                                    listeners: {
                                        tap: function () {
                                            HolaChef.app.OrdersArry = null;
                                            HolaChef.app.Orderid = '';
                                            HolaChef.app.MenuOrder = false;
                                            HolaChef.app.MenuOrderStatus = '';
                                            ref.GetDefectGridData();
                                            Ext.getCmp('OredrDetailspanel').setHtml("");
                                            Ext.getCmp('OredrDetailspanel').hide();                                            
                                        }
                                    }
                                }]
                        },
                            {
                                xtype: 'container',
                                id: 'OrderViewpanel',
                                html: ''
                            }

                        ]

            });
        }
        this.OredrDetails.show();
    }
});
function OrderdetailPopup(id, from) {

    HolaChef.app.getController("Main").GetOrderDetail();      
    viewordetail(id, from);
}
function viewordetail(id,from)
{
    HolaChef.app.ShowHideLoader(true);
    var html = '';
    Ext.data.JsonP.request({
        url: HolaChef.app.dataUrl + 'orders/'+id+'.json',
        params: {
            method: 'orders',
            format: 'json',
            callback: 'callback'
        },
        success: function (records) {
          
            html += '<div style="padding:20px"><table cellpadding="0" cellspacing="0" width="100%"><tr><td><div style="float: left; width: 70%">Order No :<span id="orderno">' + String(records["id"]) + '</span></div>';
            if (from == "Dispatched")
                html += '<div style="float: left; width: 30%"><button onclick="ondeliverd(\'' + String(records["id"]) + '\')">Delivered</button><button onclick="onreturnd(\'' + String(records["id"]) + '\')">Returned</button><button onclick="ondamage(\'' + String(records["id"]) + '\');">Damage</button><button onclick="oncancelbtn(\'' + String(records["id"]) + '\')">Cancel</button></div>';
            else if (from == "Delivered")
                html += '<div style="float: left; width: 30%"><button onclick="ondamage(\'' + String(records["id"]) + '\');">Damage</button></div>';
            else if (from == "Returned" || from == "Canceled" || from == "Reordered")
                html += '';
            else
                html += '<div style="float: left; width: 30%"><button onclick="ondispatch(\'' + String(records["id"]) + '\',\'' + HolaChef.app.ViewOrderid + '\');">Dispatched</button><button onclick="ondamage(\'' + String(records["id"]) + '\');">Damage</button><button onclick="oncancelbtn(\'' + String(records["id"]) + '\')">Cancel</button></div>';
            
            html+='</td></tr><tr><td><table cellpadding="0" cellspacing="0" width="100%"><tr><td style="border:1px solid black;padding:5px;width:50%"><table cellpadding="0" cellspacing="0"><tr><td>' + records["customer_name"] + '</td></tr><tr><td>' + records["customer_contact_number"] + '</td></tr>';
            var address = records["address"];
            var add1 = address.address_line_1 == null ? "" : address.address_line_1;
            var add2 = address.address_line_2 == null ? "" : address.address_line_2;
            var add_city = address.address_city == null ? "" : address.address_city;
            var pin = address.pincode == null ? "" : address.pincode;
            var land = address.landmark == "" ? "" : address.landmark;

            html += '<tr><td>' + add1 + '</td></tr>';
            html += '<tr><td>' + add2 + '</td></tr>';
            html += '<tr><td>' + add_city + '</td></tr>';
            html += '<tr><td>' + pin + '</td></tr>';
            html += '<tr><td>' + land + '</td></tr>';

            html += '</table></div></td><td style="border:1px solid black;padding:5px;width:50%"><table cellpadding="0" cellspacing="0"><tr><td >Order progress : </td><td style="width:60%"> ' + records["order_progress"] + '</td></tr><tr><td>Payment : </td><td>' + records["payment_mode"] + '</td></tr><tr><td>Delivery Time : </td><td>' + records["deliverySlot"] + '</td></tr>';

            if (from == "Dispatched") {
                var runner = records["runner"];
                html += '<tr><td>Delivery Boy :</td><td>' + runner.name + ' </td><td style="padding-left:10px;"><img src="resources/images/editico.png" alt="edit" style="width:20%;height:20%" onclick="ondispatch(\'' + String(records["id"]) + '\',\'' + HolaChef.app.ViewOrderid + '\');"/></td></tr>';
            }
            else if (from == "Returned")
                html += '<tr><td>Returned</td><td></td></tr>';

            else if (from == "Reordered")
                html += '<tr><td>New Order Created : </td><td><a href="#" onclick="showneworder(\'' + records["reorder_id"] + '\',\'' + records["id"] + '\')">' + records["reorder_id"] + '</a></td></tr>';
            else if (from == "ReNewOrder")
                html += '<tr><td>Parent Order Number : </td><td><a href="#" onclick="OrderdetailPopup(\'' + records["original_order_id"] + '\',\'Reordered\');">' + records["original_order_id"] + '</a></td></tr>';


            html += '</table></td></tr></table></td></tr><tr><td><div style="float: right; width: 30%"><select id="ddlaction"><option value="0">Select Action</option><option value="Canceled">Canceled</option><option value="Damaged">Damaged</option>';
            //<option value="Ordered">Ordered</option><option value="Returned">Returned</option>
            html += '</select><button onclick="onbtnaction(\'' + String(records["id"]) + '\');">Submit</button></div></td></tr><tr><td><div class="table-responsive" id="grid"><table class="table table-bordered" id=""><thead><tr class="headerrow"><th>Select</th><th>Item ID</th><th>Name</th><th>Box No</th><th>Qty</th><th>Unit Price</th><th>Row Total</th><th>Status</th></tr></thead><tbody>';
            
            var orders = records["order_items"];
            for (var i = 0; i < orders.length; i++)
            {
                
                html += '<tr class="datarow2"><td><input type="checkbox" value="' + orders[i].menu_item_id + '" id="orderchkbox_' + String(i) + '" /></td><td>1</td><td>' + orders[i].dish_name + '</td><td>1</td><td>' + orders[i].quantity + '</td><td>' + orders[i].rate + '</td><td>' + orders[i].menu_item_total + '</td><td>' + orders[i].order_status + '</td></tr>';
                
            }

        
            html += '</tbody></table></td></tr><tr><td><table cellpadding="0" cellspacing="0" width="100%"><tr><td rowspan="3" style="width:40%;"><textarea rows="10" cols="36" style= "width:100%;border: 1px solid black">Order History and Comments</textarea></td><td style="padding-left:25%;vertical-align:text-top;">Total Amount : ' + records["bill_amount"] + '</td></tr><tr><td style="padding-left:25%;vertical-align:text-top;">Coupon Id : ' + records["couponID"] + '</td></tr><tr><td style="padding-left:25%;vertical-align:text-top;">Payable Amount : ' + records["payment_value"] + '</td></tr></table></td></tr></table></div>';
            var obj = Ext.getCmp('OrderViewpanel');            
            obj.setHtml(html);
            HolaChef.app.ShowHideLoader(false);
        },
        failure: function (response) {
            Ext.Msg.alert('Alert', 'Please check internet connectivity !');
        }
    });
}
function ondispatch(id) {

    HolaChef.app.Orderid = id;    
    var ref = this;
    HolaChef.app.ShowHideLoader(true);


    if (this.RunnerDetails) {
        this.RunnerDetails = null;
        //Ext.Viewport.remove(Ext.Viewport.getAt(3), true)
    }

    if (!this.RunnerDetails)
    {
        this.RunnerDetails = Ext.Viewport.add({
            xtype: 'panel',
            id: 'RunnerDetails',
            modal: true,
            hideOnMaskTap: true,
            hidden: true,
            showAnimation: {
                type: 'popIn',
                duration: 250,
                easing: 'ease-out',
                listeners:
                    {
                        animationend: function (evt, obj)
                        {
                            $.ajax({
                                type: "GET",

                                url: HolaChef.app.dataUrl + 'runners.json',
                                contentType: 'application/json; charset=utf-8',
                                dataType: "jsonp",
                                success: function (response) {//On Successfull service call
                                    var obj = document.getElementById("ddlpanel");
                                    obj.innerHTML = "";
                                    var html = '<select id="AllRunnerList" style="border:1px solid #000;margin-top:5px;margin-bottom:5px;">';
                                    html += '<option value ="Select">Select</option>';
                                    for (var k = 0; k < response.length; k++) {                                        
                                        html += '<option value ="' + response[k]["id"] + '">' + response[k]["name"] + '</option>';
                                    }
                                    html += '</select>'                                    
                                    obj.innerHTML = html;

                                    HolaChef.app.ShowHideLoader(false);
                                },
                                failure: function (response) {
                                    alert(response);
                                }
                            });                            
                        }
                }
            },
            hideAnimation: {
                type: 'popOut',
                duration: 250,
                easing: 'ease-out',
                listeners: {
                    animationend: function (evt, obj) {
                        ref.RunnerDetails = null;
                    }
                }
            },            
            centered: true,
            width: '50%',
            height: '60%',
            scrollable: true,
            items: [
                        {

                            items: [
                                {
                                    xtype: 'button',
                                    text: 'Close',
                                    docked: 'right',
                                    listeners: {
                                        tap: function () {                                            
                                            Ext.getCmp('RunnerDetails').hide();
                                        }
                                    }
                                }]
                        },
                            {
                                xtype: 'container',
                                id: 'dispatchpanel',
                                items: [{
                                    layout: {
                                        type: 'hbox',
                                        align: 'center'
                                    },

                                    items: [
					                    {
					                        xtype: 'label',
					                        html: 'Select Delivery Boy :',
					                        style: 'margin-top: 0.60em;'
					                    },
                                        {
                                            xtype: 'label',
                                            id : 'ddlpanel',
                                            html: 'asdasdasdasd'
                                            
                                        }]
                                },
                                {

                                    xtype: 'button',
                                    text: 'Confirm',
                                    height: '1.6em',
                                    width: '120px',
                                    style: 'margin:10px;margin-top:15px;float:right',
                                    id: 'btncnfrm',
                                    action: 'runnercnfrm'
                                }

                                ]

                            }

            ]

        });
        this.RunnerDetails.show();
    }
}
function ondeliverd(id, viewid)
{
    HolaChef.app.Orderid = id;    
    $.ajax({
        type: "GET",
        url: HolaChef.app.dataUrl + 'orders/' + id + '/update_status.json?status=Delivered',
        contentType: 'application/json; charset=utf-8',
        dataType: "jsonp",
        success: function (response) {//On Successfull service call            
            HolaChef.app.getController("Main").GetDefectGridData();
            OrderdetailPopup(HolaChef.app.Orderid, 'Delivered');
        },
        failure: function (response) {
            alert(response);
        }
    });
}
function ondamage(id) {
    HolaChef.app.Orderid = id;
    var ref = this;
    if (this.DamageOrder)
        this.DamageOrder = null;
    if (!this.DamageOrder) {
        var ref = this;
        this.DamageOrder = Ext.Viewport.add({
            xtype: 'panel',
            id: 'DamageOrder',
            modal: true,
            hideOnMaskTap: false,
            hidden: true,
            showAnimation: {
                type: 'popIn',
                duration: 250,
                easing: 'ease-out'
            },
            hideAnimation: {
                type: 'popOut',
                duration: 250,
                easing: 'ease-out',
                listeners: {
                    animationend: function (evt, obj) {

                    }
                }
            },
            centered: true,
            width: '40%',
            height: '25%',
            scrollable: true,
            items: [
                        {

                            items: [
                                {
                                    xtype: 'button',
                                    text: 'Close',
                                    docked: 'right',
                                    listeners: {
                                        tap: function () {
                                            Ext.getCmp('DamageOrder').hide();
                                        }
                                    }
                                }]
                        },
                            {
                                xtype: 'container',
                                id: 'dispatchpanel',
                                items: [{
                                    layout: {
                                        type: 'hbox',
                                        align: 'center'
                                    },

                                    items: [

                                     {

                                         xtype: 'button',
                                         text: 'Reorder',
                                         height: '1.6em',
                                         width: '120px',
                                         style: 'margin:10px;margin-top:15px;',
                                         id: 'btnreorder',
                                         action: 'Damagereorder'
                                     },
                                         {

                                             xtype: 'button',
                                             text: 'Refund',
                                             height: '1.6em',
                                             width: '120px',
                                             style: 'margin:10px;margin-top:15px;',
                                             id: 'btnrefund',
                                             action: 'DamageRefund'
                                         }
                                    ]

                                }]
                            }

            ]

        });
    }

    this.DamageOrder.show();
}
function onreturnd(id) {
    HolaChef.app.Orderid = id;
    var ref = this;
    if (this.ReturneOrder)
        this.ReturneOrder = null;
    if (!this.ReturneOrder) {
        this.ReturneOrder = Ext.Viewport.add({
            xtype: 'panel',
            id: 'ReturneOrder',
            modal: true,
            hideOnMaskTap: false,
            hidden: true,
            showAnimation: {
                type: 'popIn',
                duration: 250,
                easing: 'ease-out'
            },
            hideAnimation: {
                type: 'popOut',
                duration: 250,
                easing: 'ease-out',
                listeners: {
                    animationend: function (evt, obj) {

                    }
                }
            },
            centered: true,
            width: '50%',
            height: '50%',
            scrollable: true,
            items: [
                        {

                            items: [
                                {
                                    xtype: 'button',
                                    text: 'Close',
                                    docked: 'right',
                                    listeners: {
                                        tap: function () {
                                            Ext.getCmp('ReturneOrder').hide();
                                        }
                                    }
                                }]
                        },
                            {
                                xtype: 'container',
                                id: 'dispatchpanel',
                                items: [{
                                    layout: {
                                        type: 'vbox',
                                        align: 'center'
                                    },

                                    items: [
					                    {
					                        xtype: 'label',
					                        html: 'Return Reason :',
					                        style: 'margin-top: 0.60em;'
					                    },
					                    {
					                        xtype: 'textareafield',
                                            id:'txtreturnreason',
					                        resize: 'none',
					                        height: '6.5em'
					                    }]
                                },
                                {

                                    xtype: 'button',
                                    text: 'Submit',
                                    height: '1.6em',
                                    width: '120px',
                                    style: 'margin:10px;margin-top:15px;float:right',
                                    id: 'btnsubmit',
                                    action: 'reasonsubmit'
                                }

                                ]

                            }

            ]

        });
    }

    this.ReturneOrder.show();
}
function oncancelbtn(id) {
   
    HolaChef.app.Orderid = id;    
    $.ajax({
        type: "GET",
        url: HolaChef.app.dataUrl + 'orders/' + id + '/update_status.json?status=Canceled',
        contentType: 'application/json; charset=utf-8',
        dataType: "jsonp",
        success: function (response) {//On Successfull service call
          
            var obj = Ext.getCmp("OredrDetailspanel");
            obj.hide();
            HolaChef.app.getController("Main").GetDefectGridData();
        },
        failure: function (response) {
            alert(response);
        }
    });
}
function onbtnaction(id)
{
    var ddlobj = document.getElementById("ddlaction");
    HolaChef.app.MenuOrder = true;
    var val = ddlobj.value;
    if (val == "0")
        Ext.Msg.alert("", "Please Choose action");
    else {
        MenuOrderStatus = val;
        var menuid = fetchmenuid();
        if (menuid != 0) {
            if (val == "Canceled")
                UpdateMenueItemStatus(id, val, menuid)
            else
                ondamage(id);
        }
        else
            Ext.Msg.alert("Info", "Please Choose Any Item");
    }
}
function fetchmenuid()
{

    var obj = document.getElementsByTagName("input");
    var chkedvalue = 0;
    for (var i = 0; i < obj.length; i++)
    {
        if (obj[i].id.search("orderchkbox_") != -1)
        {
            var chkboj = obj[i];
            if (chkboj.checked) {
                chkedvalue = chkboj.value;
                break;
            }
        }
    }
    return chkedvalue;
}
function UpdateMenueItemStatus(id, val, menuid) {
    $.ajax({
        type: "GET",
        url: HolaChef.app.dataUrl + 'orders/' + id + '/update_menu_item_status.json?status=' + val + '&order_menu_id=' + menuid,
        contentType: 'application/json; charset=utf-8',
        dataType: "jsonp",
        success: function (response) {//On Successfull service call
           
            var obj = Ext.getCmp("OredrDetailspanel");
            obj.hide();
            HolaChef.app.getController("Main").GetDefectGridData();
        },
        failure: function (response) {
            alert(response);
        }
    });
}
function showneworder(id, oldid) {
    OrderdetailPopup(id, "ReNewOrder");
}
function getMaxYear() {
    return new Date().getFullYear();
}
function RunnerDetail(id) {

    HolaChef.app.ShowHideLoader(true);
    HolaChef.app.RunnerId = id;
    HolaChef.app.getController("Main").RunnerinfoGridData(id);
}
function OpenOrderDetails()
{

HolaChef.app.getController("Main").GetDefectGridData();
}