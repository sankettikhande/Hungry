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
    $("#bill_amount a").html($("#total_price").val()+"/-");
    var total = 0;
    var cnt = parseInt($("#order-count").html(),10);
    $('.item').live('click', function(){
        $.ajax({
            'method': 'GET',
            'url': '/cooking_todays/get_item_details',
            'data': {'cooking_today_id': parseInt($(this).attr('id'))},
            'dataType': 'script'
        });
    });

    $('li.food-bill span.item-name').live('click',function(){
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
        var date = new Date();
        var menu_qty = parseInt($("#order-count").html(),10);
        var menu_price = parseInt($(".modal-body li.recipe-price span").html(),10);
        $.ajax({
            'method': 'GET',
            'url': '/orders/set_cart',
            'data': {'item_id': parseInt($("#selected_item").val(),10) , 'qty': $("#order-count").html(), 'price': menu_price, 'date': date, 'dish_name': $(".modal-body .recipe-name").html() },
            'dataType': 'script'
        });
        $("#"+selected_review_id+" span.item-name").html($(".modal-body .recipe-name").html() )
        $("#"+selected_review_id+" span.item-qty").html($("#order-count").html() )
        $("#"+selected_review_id+" span.item-cost").html(parseInt($("#order-count").html(),10)*menu_price )



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

})

// random splash on refresh
$(document).ready(function(){

//   random splash on refresh
    var splash = parseInt(Math.random()*$('.random-imgs .bg-img').length);
    splash +=1;
    $('.bg-img').removeClass('active');
    $('.random-imgs .bg-img:nth-child('+splash+')').addClass('active');


    //  Datepicker

    $('#datetimepicker5').datetimepicker({
        pickTime: false
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
        scoreName: 'dish[ratings]',
        score: function() {
            return $(this).attr('data-score');
        },
        click: function(score, evt) {
            $.ajax({
                'url' : '/update_ratings',
                'type' : 'POST',
                'data' : {'dish_id': parseInt($("#dish_id").val()), 'dish_ratings': parseInt($("input[name='dish[ratings]']").val())},
                'dataType' : 'script'
            })
        }
    });
});
