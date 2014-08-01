// grid-system
$("#hola-container, .hola-container").gridalicious({
    width: 150,
    gutter: 5,
    animate:true,
    animationOptions: {
        queue: true,
        speed: 100,
        duration: 300,
        effect: 'fadeInOnAppear',
        complete: onComplete,
    }
});
function onComplete()
{
}
//  each item inside modal script
$(document).ready(function(){
    $("#bill_amount").html($("#total_price").val()+"/-");
    var total = 0;
    var cnt = parseInt($("#order-count").html(),10);
    $('.item').live('click', function(){
        $(".modal-header").html("<button data-dismiss='modal' class='btn-close pull-right'>x</button>")
        $(".modal-footer").empty();
        $(".modal-body").html("<i class='modal-loading fa fa-spinner fa-spin'></i>" +
            "<p class='form-control looks-input hidden' id='order-count'>0</p>");
        $.ajax({
            'method': 'GET',
            'url': '/cooking_todays/get_item_details',
            'data': {'cooking_today_id': parseInt($(this).attr('id'))},
            'dataType': 'script'
        });
    });



    $('li.food-bill span.item-name').live('click',function(){
        $(".modal-header").html("<button data-dismiss='modal' class='btn-close pull-right'>x</button>")
        $(".modal-footer").empty();
        $(".modal-body").html("<i class='modal-loading fa fa-spinner fa-spin'></i>" +
            "<p class='form-control looks-input hidden' id='order-count'>0</p>");
        $.ajax({
            'method': 'GET',
            'url': '/cooking_todays/get_review_order_details',
            'data': {'cooking_today_id': parseInt($(this).attr('id')), 'cooking_today_qty':$(this).attr('data-quantity') },
            'dataType': 'script'
        });
    })

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
        }
    });

    $('#add-order-minus').unbind("click").live('click',function(e){
        e.preventDefault();
        $("#add-order-plus").removeAttr("disabled");
        $("#add-order-plus").removeClass("disabled");
        cnt = parseInt($("#order-count").html(),10)
        if(cnt >=  0){
            cnt = cnt - 1;
            $("#order-count").html(cnt);
        }
        if (cnt == 0){
            $("#add-order-minus").attr("disabled");
            $("#add-order-minus").addClass("disabled");
        }
    });

    $("#order-done").unbind("click").live('click',function(e){
        e.preventDefault();
        var selected_id = "#"+$("#selected_item").val()+" li.recipe-stock";
        var date = new Date();
        var dish_name = $("#"+$("#selected_item").val() +" ul li.recipe-title").html();
        var menu_qty = parseInt($("#order-count").html(),10);
        var menu_price = parseInt($(".modal-body li.recipe-price").html(),10);

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
                'data': {'item_id': parseInt($("#selected_item").val(),10) , 'qty': cnt, 'price': menu_price, 'date': date, 'dish_name': dish_name },
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


    });
    var selected_review_id = "";

    $(".review_order_list").live('click', function(){
        selected_review_id = $(this).attr('id');
    });

    $("#review-order-done").unbind("click").live('click',function(e){
        e.preventDefault();
        var selected_id = "#"+$("#selected_item").val()+" li.recipe-stock";
        var date = new Date();
        var menu_qty = parseInt($("#order-count").html(),10);
        var menu_price = parseInt($(".modal-body li.recipe-price span").html(),10);

        if(parseInt($("#order-count").html()) > 0){
            $.ajax({
                'method': 'GET',
                'url': '/orders/set_cart',
                'data': {'item_id': parseInt($("#selected_item").val(),10) , 'qty': $("#order-count").html(), 'price': menu_price, 'date': date, 'dish_name': $(".modal-body .recipe-name").html() },
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
            $("#"+selected_review_id).remove();
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
    $("#submit-order-button").click(function(){
        $("#submit_order").submit();
    })
    $("#submit_order input").focus(function(){
        $("#submit_order input").removeClass('active');
        $(this).addClass('active');
    })


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
        $("#submit_order").validationEngine('attach', {
            validationEventTrigger: "keyup",
            onFieldFailure: function(){
                $("#submit-order-button").addClass("text-grey")
            },
            onFieldSuccess: function(){
                if ($("#submit_order").validationEngine('validate')){
                    $("#submit-order-button").removeClass("text-grey")
                }
            }
        });
        if ($("#submit_order").validationEngine('validate')) {
            $("#submit-order-button").removeClass("text-grey")
        }
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

    if (window.location.href.indexOf("orders") > -1) {
        $(".btn-back").addClass("hidden");
        $('#footer').hide();
    }
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

    $('#star').raty({
        path:'/assets/',
        half:false,
        scoreName: 'food_item[ratings]',
        score: function() {
            return $(this).attr('data-score');
        },
        click: function(score, evt) {
            $.ajax({
                'url' : '/update_ratings',
                'type' : 'POST',
                'data' : {'food_item_id': parseInt($("#food_item_id").val()), 'food_item_ratings': parseInt($("input[name='food_item[ratings]']").val())},
                'dataType' : 'script'
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
        var paymentMode = $(this).attr('data-paymentMode');
        var orderId = $(this).attr('data-orderId');
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
    })

    $("#add_recipe_to_favorite").click(function(){
        var recipe_id = $(this).attr("data-recipe_id");
        $.ajax({
            'url': '/add_recipe_to_favorite?recipe_id='+recipe_id,
            'method': 'POST',
            'dataType':'script'
        })
    })
});
