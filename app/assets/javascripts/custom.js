//  each item inside modal script
$(document).ready(function(){
    if ($("#total_price").val() !== undefined){
      $("#bill_amount").html($("#total_price").val()+"/-");
    }
    var total = 0;
    var cnt = parseInt($("#order-count").html(),10);

    $('.time-slots span').click(function(){
      $(this).parent().find('.o-time').removeClass('selected');
      $(this).addClass('selected');
      $("#"+$(this).data('meal_type')).val($(this).html())
    });

    $('.recipe-block').on('click', function(){
        $(this).find('.dark-overlay').toggle()
    });
    $('.foodDesp').on('click', function(){
        $(this).closest('.square').find('.dark-overlay').toggle()
    });


      $("#talk-us-form,#new_chef_request,#new_party_order").validationEngine({promptPosition : "topLeft"});
      $("#new_hola_user_address").validationEngine({promptPosition : "bottomLeft"});

     $('li.food-bill span.item-name').live('click',function(){
        $(".modal-header").html("<button data-dismiss='modal' class='btn-close pull-right'>x</button>")
        $(".modal-footer").empty();
        $("#item-modal .modal-body").html("<i class='modal-loading fa fa-spinner fa-spin'></i>" +
            "<p class='form-control looks-input hidden' id='order-count'>0</p>");
        $.ajax({
            'method': 'GET',
            'url': '/cooking_todays/get_review_order_details',
            'data': {'cooking_today_id': parseInt($(this).attr('id')), 'cooking_today_qty':$(this).attr('data-quantity') },
            'dataType': 'script'
        });
    })
    $(".select_payment_method").click(function(){
        $(".payment_method_div").validationEngine('showPrompt', ' Please select a payment method', 'error');
        $(".undefinedformError").css('left','21px');
    })
    $("#radio-nbanking").click(function(){
       $(".netbanking").show();
       $(".cash_delivery").hide();
       $(".select_payment_method").hide();
       $(".undefinedformError").hide();
    });

    $("#radio-cod").click(function(){
       $(".cash_delivery").show();
       $(".netbanking").hide();
       $(".select_payment_method").hide();
       $(".undefinedformError").hide();
    });

    $('#add-order-plus').unbind("click").live('click', function(e) {
        e.preventDefault();
        $("#add-order-minus").removeClass("disabled");
        $("#add-order-minus").removeAttr("disabled");
        var max_qty = parseInt($("#item_max_qty").val(), 10);
        if (cnt < parseInt(max_qty,10)){
            cnt = parseInt($("#order-count").html(),10) + 1;
            $("#order-count").html(cnt);
        }
        if (cnt == max_qty){
            $("#add-order-plus").attr("disabled");
            $("#add-order-plus").addClass("disabled");
            alert("Max quantity reached")
        }
    });

    $("#login_form").find('#hola_session').submit(function(){
        if ($(this).validationEngine('validate')){
            $('#login_otp_sms_button').attr("disabled", true)
        }
    })

    $('.add-order-plus').unbind("click").live('click', function(e) {
        e.preventDefault();
        $(".add-order-minus").removeClass("disabled");
        $(".add-order-minus").removeAttr("disabled");
        var max_qty = parseInt($("#item_max_qty").val(), 10);
        if (cnt < parseInt(max_qty,10)){
            cnt = parseInt($("#order-count").html(),10) + 1;
            $("#order-count").html(cnt);
        }
        if (cnt == max_qty){
            $("#add-order-plus").attr("disabled");
            $("#add-order-plus").addClass("disabled");
        }
    });

    $('#add-order-minus').unbind("click").live('click',function(e){
        e.preventDefault();
        $("#add-order-plus").removeAttr("disabled");
        $("#add-order-plus").removeClass("disabled");
        cnt = parseInt($("#order-count").html(),10)
        if(cnt >=  2){
            cnt = cnt - 1;
            $("#order-count").html(cnt);
        }
        if (cnt == 2){
            $("#add-order-minus").attr("disabled");
            $("#add-order-minus").addClass("disabled");
        }
    });

    /************************************* ADD REMOVE ITEMS TO CART ********************************/

    $(".increase-order-item").on('click', function(){
        quantity_input = $(this).parent().prev().find("input");
        new_link = $($(this).parent().parent().parent().parent().find('.update-cart'));
        available_quantity = parseInt($(this).data("available-quantity"));
        quantity = parseInt(quantity_input.val()) + 1;
        $(this).parents('.square').addClass('added-2-cart');
        if(available_quantity >= quantity){            
            flash_msg_element = $(this).parents('.square').find(".prod-carted span");
            cart_quantity=parseInt($(".navbar-header div.pull-right").text(),10) +1;           
            $(new_link).data("quantity", quantity);
            update_cart($(this).parent().parent().parent().parent().find('.update-cart').data(), quantity_input, quantity, flash_msg_element);
            // quantity_input.val(quantity);
            // $(".navbar-header div.pull-right a").text(cart_quantity);            
        }else{
            alert("Max quantity reached");
        }

    })

    $(".decrease-order-item").on('click', function(){        
        quantity_input = $(this).parent().next().find("input")
        new_link = $($(this).parent().parent().parent().parent().find('.update-cart'))
        quantity = parseInt(quantity_input.val()) - 1
        $(this).parents('.square').addClass('added-2-cart');
        if(quantity >= 0){            
            flash_msg_element = $(this).parents('.square').find(".prod-carted span");
            cart_quantity=parseInt($(".navbar-header div.pull-right").text(),10) -1;            
            $(new_link).data("quantity", quantity)
            update_cart($(this).parent().parent().parent().parent().find('.update-cart').data(), quantity_input, quantity, flash_msg_element);
            // quantity_input.val(quantity);
            // $(".navbar-header div.pull-right a").text(cart_quantity);
        }

    })
    $(".layout-tabbed li").on("click",function(){
        $(this).addClass("active");
        if ($(this).attr("class") == ""){
            $("#Lunch").removeClass("active");
            meal_type= $(this).find("a").attr("href").replace("#",'');
            $("#"+meal_type).addClass("active");
        }
        else{
            meal_type= $(this).find("a").attr("href").replace("#",'');
            $("#"+meal_type).addClass("active");
            if (meal_type == "Lunch") {
                $("#Dinner").removeClass("active");
                $("#li_Dinner").removeClass("active");
            }
            else {
                $("#Lunch").removeClass("active");
                $("#li_Lunch").removeClass("active");
            }

        }
    })


    function update_cart(data_attribs, quantity_input, quantity, flash_msg_element){
        url = (parseInt(data_attribs.quantity) > 0) ? "/orders/set_cart" : "/orders/remove_from_cart"
        if (parseInt(data_attribs.quantity) > 0){
            $(this).parents("ul.square").find('.add-cart').removeClass('hidden')
        }else{
            $(this).parents("ul.square").find('.add-cart').addClass('hidden')
        }
        $.ajax({
                'method': 'GET',
                'url': url ,
                'data': {'item_id': data_attribs.item_id , 'qty': data_attribs.quantity, 'price': data_attribs.price, 'dish_name': data_attribs.dishName, 'category': data_attribs.category, 'meal_type': data_attribs.mealType },
                'dataType': 'script',
                'complete': function(){                    
                    quantity_input.val(quantity);
                    flash_msg_element.html(quantity);
                }
            })

    }
   /********************************************************************************************/


    $("#order-done").unbind("click").live('click',function(e){
        e.preventDefault();
        var selected_id = "#"+$("#selected_item").val()+" li.recipe-stock";
        var date = new Date();
        var dish_name = $("#"+$("#selected_item").val() +" ul li.recipe-title").html();
        var menu_qty = parseInt($("#order-count").html(),10);
        var cnt = parseInt($("#order-count").html(),10)
        var menu_price = parseInt($(".modal-body li.recipe-price").html(),10);
        var category = $("#menu_category_"+parseInt($("#selected_item").val(),10)).val();

        if(cnt == 0){
            $(selected_id).html(parseInt($("#order-count").html(),10) +" in cart");
            $.ajax({
                'method': 'GET',
                'url': '/orders/remove_from_cart',
                'data': {'item_id': parseInt($("#selected_item").val(),10) , 'qty': parseInt($("#order-count").html()), 'price': menu_price, 'total': parseInt($("#total_price").val(),0)},
                'dataType': 'script'
            })

        }
        //Printing Cart message
        if(parseInt($("#order-count").html()) > 0){
            $(selected_id).html(cnt +" in cart")
            $("#"+$("#selected_item").val()+" li div.append-cart").append("<div class='add-cart'></div>")
            $(selected_id).addClass('text-orange');
            //Calculation of Total Price

            $.ajax({
                'method': 'GET',
                'url': '/orders/set_cart',
                'data': {'item_id': parseInt($("#selected_item").val(),10) , 'qty': cnt, 'price': menu_price, 'date': date, 'dish_name': dish_name, 'category' :category },
                'dataType': 'script'
            })
        }
        else if(parseInt($("#order-count").html()) == 0){
            $(selected_id).html(parseInt($("#item_max_qty").val(), 10)+ " left")
            $("#"+$("#selected_item").val()+" .add-cart").remove();
            $(selected_id).removeClass('text-orange');
            $.ajax({
                'method': 'GET',
                'url': '/orders/remove_from_cart',
                'data': {'item_id': parseInt($("#selected_item").val(),10) , 'qty': parseInt($("#order-count").html()), 'price': menu_price, 'total': parseInt($("#total_price").val(),0)},
                'dataType': 'script'
            })
        }
        $('#footer').show();
    });
    var selected_review_id = "";

    $(".review_order_list").live('click', function(){
        selected_review_id = $(this).attr('id');
    });

    $("#review-order-done").unbind("click").live('click',function(e){
        e.preventDefault();
        if(parseInt($("#order-count").html()) < 0){
           alert("Quantity should be negative")
        }
        var selected_id = "#"+$("#selected_item").val()+" li.recipe-stock";
        var date = new Date();
        var menu_qty = parseInt($("#order-count").html(),10);
        var menu_price = parseInt($(".modal-body li.recipe-price span").html(),10);
        var discount = $(".discount_span").html(0);
        var category = $("#menu_category_"+parseInt($("#selected_item").val(),10)).val();
        var item_model= $('#item-modal').addClass("item-model-"+selected_review_id)
        var meal_type = $("li.item_"+selected_review_id).siblings('input[type="hidden"][id$="_slot"]').val();
        meal_type = meal_type.split("_")[0]
        if(parseInt($("#order-count").html()) > 0){
            $.ajax({
                'method': 'GET',
                'url': '/orders/set_cart',
                'data': {'item_id': parseInt($("#selected_item").val(),10) , 'qty': $("#order-count").html(), 'price': menu_price, 'date': date, 'dish_name': $(".modal-body .recipe-name").html(), 'category' : category, 'meal_type' : meal_type },
                'dataType': 'script'
            })
            $("#"+selected_review_id+" span.item-name").html($(".modal-body .recipe-name").html() )
            $("#"+selected_review_id+" span.item-qty").html($("#order-count").html() )
            $("#"+selected_review_id+" span.item-cost").html(parseInt($("#order-count").html(),10)*menu_price )
        }
        else if(parseInt($("#order-count").html()) == 0){
            $.ajax({
                'method': 'GET',
                'url': '/orders/remove_from_cart',
                'data': {'item_id': parseInt($("#selected_item").val(),10) , 'qty': parseInt($("#order-count").html()), 'price': menu_price, 'total': parseInt($("#total_price").val(),0)},
                'dataType': 'script'
            })

            $("#"+selected_review_id+" span.item-name").html($(".modal-body .recipe-name").html() )
            $("#"+selected_review_id+" span.item-qty").html($("#order-count").html() )
            $("#"+selected_review_id+" span.item-cost").html(parseInt($("#order-count").html(),10)*menu_price );
        }
        if($(".item-model-"+selected_review_id).hasClass('in')== true){
            $(this).ajaxStop(function () {
                item_model.modal('hide');
                $('#item-modal').removeClass("item-model-"+selected_review_id)
                if(parseInt($("#order-count").html()) == 0){
                    $("#"+selected_review_id).remove();
                }
            });
        }
    });

    $("span.item-remove a").live('click',function(){
        $.ajax({
            'method': 'GET',
            'url': '/cooking_todays/delete_item',
            'data': {'item_id': $(this).attr('data-item')},
            'dataType': 'script'
        });
    });

    $("span.item-edit").live('click',function(){
        $(this).closest('.review_order_list').find('span.item-name').click();
    });

    $("#submit-order-button").click(function(e){
        $("#submit_order").submit();
    })
    $("#submit_order input").focus(function(){
        $("#submit_order input").removeClass('active');
        $(this).addClass('active');
    })

    var path = window.location.pathname.split('/')[1]
    if (path == "order-confirm") {
        var host = window.location.origin
        timer = setTimeout(function() {
            window.location.href = host + "/mobile"}, 10000);
         $(document).click(function(){
            clearTimeout(timer)
            timer = setTimeout(function() {
                window.location.href = host + "/mobile"}, 30000);
        })
    }else if(path == "recipe"){
        if ($("#total_price").val() == "0"){
            $('#footer').hide();
        }
    }else if(path == "become-a-chef"){
            $('#footer').hide();
        }


//    Signature Dish Order
    var signature_cnt = 0;
    var signature_total = 0;
    var price = 0;
    $('#signature-add-order').unbind("click").live('click', function(e) {
        e.preventDefault();
        $("#signature-minus-order").removeClass("disabled");
        $("#signature-minus-order").removeAttr("disabled");
        price = parseInt($('#signature-cost').html(),10);
        var max_qty = 20;
        if (signature_cnt < max_qty){
            signature_cnt = parseInt($("#order-count").html(),10) + 1;
            signature_total = signature_cnt * price;
            $("#order-count").html(signature_cnt);
            $("#signature_qty").val(signature_cnt);
            $('#signature-total').html(signature_total);
        }
        if (signature_cnt == max_qty){
            $("#signature-add-order").attr("disabled");
            $("#signature-add-order").addClass("disabled");
        }
    });

    $('#signature-minus-order').unbind("click").live('click',function(e){
        e.preventDefault();
        $("#signature-add-order").removeAttr("disabled");
        $("#signature-add-order").removeClass("disabled");
        signature_cnt = parseInt($("#order-count").html(),10)
        price = parseInt($('#signature-cost').html(),10);
        if(signature_cnt >=  0){
            signature_cnt = signature_cnt - 1;
            signature_total = signature_cnt * price
            $("#order-count").html(signature_cnt);
            $("#signature_qty").val(signature_cnt);
            $('#signature-total').html(signature_total);
        }
        if (signature_cnt == 0){
            $("#signature-minus-order").attr("disabled");
            $("#signature-minus-order").addClass("disabled");
        }
    });


    $("#signature_form").validationEngine({
        'custom_error_messages': {
            '#datetimepicker5' : {
                'required': {
                    'message': "Date is required "
                }
            },
            '#datetimepicker-from' : {
                'required': {
                    'message': "From Time is required "
                }
            },
            '#datetimepicker-upto' : {
                'required': {
                    'message': "Upto Time is required "
                }
            }
        }
    });

    $('#friend_referal_submit').click(function(){
      $("#friend_referal_form").validationEngine();
    });

    $('#invoice-submit').click(function(){
      $("#invoice-form").validationEngine();
    });

    $('#signature-submit').click(function(){
        var valid = $("#signature_form").validationEngine('validate');
        if(valid == true){
            if(parseInt($('#signature_qty').val(),10) == 0) {
                $('#order-count').validationEngine('showPrompt', 'Please select at least 1 quantity', 'error')
            }
            else{
                $.ajax({
                    'url': '/create_signature_order',
                    'type': "POST",
                    'data' : $('#signature_form').serialize(),
                    'dataType': 'script'
                })
            }
        }
        else{
            $("#signature_form").validationEngine();
        }
    });

//        validation for cart select payment method
    $(document).ready(function(){
        $("#submit_order").validationEngine('attach', { maxErrorsPerField:1})
        $("#hola_session").validationEngine('attach', { maxErrorsPerField:1})
    })

    $('.signature-modal').on('hide.bs.modal', function (e) {
       $(".modal-header p").html("Delivery on:");
       $("#order-count").html("0");
       $('#datetimepicker-from, #datetimepicker-upto, #datetimepicker5').val(null)
       $("#signature_thanks").remove();
       $("#signature-minus-order").attr("disabled", "disabled");
       $("#signature-minus-order").addClass("disabled")
    });

//    Disable back button on Order Confirmation page
    var href_url = window.location.href;
    if (href_url.indexOf("orders") > -1 && href_url.indexOf("party_orders") == -1) {
        $('#footer').hide();
    }
    if (href_url.indexOf("order_histories") > -1){
        $('#footer').hide();
    }

//    refresh review order page on remove item
    $("#remove_last_dish, #remove_dish").on('hide.bs.modal',function(){
        location.reload();
    })
});

// random splash on refresh
$(document).ready(function(){

//   random splash on refresh
    var splash = parseInt(Math.random()*$('.random-imgs .bg-img').length);
    splash +=1;
    $('.bg-img').removeClass('active');
    $('.random-imgs .bg-img:nth-child('+splash+')').addClass('active');


    //  Datepicker
    var dateToday = new Date();
    $('#datetimepicker5').datetimepicker({
        format: "DD/MM/YYYY",
        pickTime: false,
        minDate: dateToday
    });


    $('#datetimepicker-from,#datetimepicker-upto').datetimepicker({
        pickDate: false
    });

    // Sidemenu for desktop fix
    $('.navbar-header .navbar-toggle').click(function(){
        $('#sidebar').fadeToggle();
    });
    // Sidemenu for desktop fix
    $('.navbar-header .navbar-brand').click(function(){
        $('#sidebar').fadeToggle();
    });

    $('#star').raty({
        path:'/assets/',
        half: false,
        scoreName: 'food_item[ratings]',
        score: function() {
            return $(this).attr('data-score');
        },
        click: function(score, evt) {
            $.ajax({
                'url' : '/update_ratings',
                'type' : 'POST',
                'data' : {'food_item_id': parseInt($("#food_item_id").val()), 'food_item_ratings': $("input[name='food_item[ratings]']").val()},
                'dataType' : 'script'
            })
        }
    });


    $('.star').raty({
        path:'/assets/',
        half: false,
        scoreName: 'food_item[ratings]',
        score: function() {
            return $(this).attr('data-score');
        },
        click: function(score, evt) {
            var id = $(this).data().id;
            var msg_id = $(this).next().attr('id')            
            $.ajax({
                'url' : '/update_ratings',
                'type' : 'POST',
                'data' : {'food_item_id': parseInt(id), 'food_item_ratings': $(this).data().score, 'order_id': $(this).data().order},
                'dataType' : 'script',
                'success' : function(){         
                    $('#'+ msg_id).css('display', 'block'); 
                    $('#'+ msg_id).delay(1000).fadeOut(300);
                   
                }
            })
        }
    });    

    if ($(".dish-image").length > 0){
        $(".recipe-image").removeClass('hidden')
        $(".recipe-name").addClass('hidden')
    }

    if ($(".recipe-img").length > 0){
        $("#recipe-page-img").removeClass('hidden')
        $("#recipe-page-txt").addClass('hidden')
    }

    $(".payment_mode").click(function(){
        var paymentMode = $(this).attr('data-paymentmode');
        var orderId = $(this).attr('data-orderid');
        $.ajax({
            'url' : '/submit_payment_form',
            'method': 'POST',
            'data': {'paymentMode': paymentMode, 'orderId':orderId},
            'dataType':'script'
        })
    });

    $("#cover-title").fitText(1.2, {
        minFontSize:'16px',
        maxFontSize:'24px'
    });

    $("#add_chef_to_favorite").click(function(){
        var chef_id = $(this).attr("data-cheff_id");
        $.ajax({
            'url': '/add_chef_to_favorite?chef_id='+chef_id,
            'method': 'POST',
            'dataType':'script'
        })
        return false;
    })

    $("#add_recipe_to_favorite").click(function(){
        var recipe_id = $(this).attr("data-recipe_id");
        $.ajax({
            'url': '/add_recipe_to_favorite?recipe_id='+recipe_id,
            'method': 'POST',
            'dataType':'script'
        })
        return false;
    })
});

$(document).ready(function(){
  $('.set_default').click(function(){
    var address_id = $(this).data("address-id");
    $.ajax({
      'url': '/hola_user_addresses/set_default',
      'type': "POST",
      'data' : {'address_id': address_id},
      'dataType': 'script'
    })
  });

  $('#orders_address_type').change(function(){
    $.ajax({
      'url': '/get_address_by_type',
      'type': "GET",
      'data' : {'address_type': $(this).val()},
      'dataType': 'script'
    })
  });
});

$('#submit_review').click(function(){
    $.ajax({
        'url' : '/post_review',
        'method': 'POST',
        'data': {'food_item_id': $('#review').data('food-item-id'), 'review' : $('#review').val(), 'order_id' : $('#review').data('order-id')},   
        'dataType' : 'script',
        'success' : function(){
            $('#reviewAlert').modal('hide');  
           
        }
    })
})
