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
         var cnt = parseInt($("#order-count").html(),10);
         $('.item').live('click', function(){
             $("#selected_item").val($(this).attr('id'));
             var img_src = "#"+parseInt($("#selected_item").val(),10)+" .chef-profile-pic";
             var user_name = "#"+parseInt($("#selected_item").val(),10)+" .chef-name";
             var chef_id = "#"+parseInt($("#selected_item").val(),10)+" .chef-id";
             var href =  "/chef-profile/"+ $(chef_id).val();
             $("#recipe-modal a#chef_info").attr('href', href);
             $("#recipe-modal .profile-pic img").attr("src", $(img_src).val());
             $("#recipe-modal .user-name").html("<h3>"+ $(user_name).val() +"<span class='user-level'>Hola Star</span></h3>")
             //$('.modal-body').html($(this).html());
             $("#order-count").html(cnt)
             $.ajax({
                 'method': 'GET',
                 'url': '/cooking_todays/get_item_details',
                 'data': {'cooking_today_id': parseInt($(this).attr('id'))},
                 'dataType': 'script'
             })

         });

        $('li.food-bill span.item-name').live('click',function(){
            $.ajax({
                'method': 'GET',
                'url': '/cooking_todays/get_menu_details',
                'data': {'cooking_today_id': parseInt($(this).attr('id')), 'cooking_today_qty':$(this).attr('data-quantity') },
                'dataType': 'script'
            })


        })

//      Increment order count
         $('#add-order-plus').unbind("click").live('click', function(e){
             e.preventDefault();
             $("#add-order-minus").removeClass("disabled");
             $("#add-order-minus").removeAttr("disabled")
             var selected_item = $("#selected_item").val()
             var max_qty = $("#"+selected_item+" .menu_max_qty").val();
             if (cnt < parseInt(max_qty,10)){
                 cnt = cnt + 1;
                 $("#order-count").html(cnt);
             }
             if (cnt == max_qty){
                 $("#add-order-plus").attr("disabled");
                 $("#add-order-plus").addClass("disabled");
             }


         })

//      Decrement Order Count
         $('#add-order-minus').unbind("click").live('click',function(e){
             $("#add-order-plus").removeAttr("disabled");
             $("#add-order-plus").removeClass("disabled");
             e.preventDefault();
             cnt = $("#order-count").html()
             cnt = parseInt(cnt,10);
             if(cnt >=  0){
                 cnt = cnt - 1;
                 $("#order-count").html(cnt);
             }
             if (cnt == 0){
                 $("#add-order-minus").attr("disabled");
                 $("#add-order-minus").addClass("disabled");
             }

         })



//      On PopUp Close
         $("#order-done").unbind("click").live('click',function(e){
             $("#order-count").val("0");
             e.preventDefault();
             var selected_item = $("#selected_item").val()
             var selected_id = "#"+selected_item+" li.recipe-stock";
             $(selected_id).addClass('text-orange')
             cnt = parseInt($("#order-count").html(),10);
             var date = new Date();
             var dish_name = $("#"+selected_item +" ul li.recipe-title").html();

//          Printing Cart message
             if(cnt >= 0){
                 $(selected_id).html(cnt +" in cart")
                 $("#"+selected_item+" li div.append-cart").append("<div class='add-cart'></div>")
                 $(selected_id).addClass('text-orange');
             }

//          Calculation of Total Price
             var total = 0;
             $("#"+selected_item+" .menu_qty").val(cnt)
             var menu_price = parseInt($("#"+selected_item+" .menu_price").val(), 10);
             total = parseInt($("#total_price").val(),10) + (menu_price * cnt);

             $("#total_price").val(total);
             $("#bill_amount a").html(total+"/-");

             $.ajax({
                 'method': 'GET',
                 'url': '/orders/set_cart',
                 'data': {'item_id': parseInt(selected_item) , 'qty': cnt, 'price': menu_price, 'date': date, 'dish_name': dish_name },
                 'dataType': 'script'
             })


         })

     });

// random splash on refresh
 $(document).ready(function(){
    var splash = parseInt(Math.random()*$('.random-imgs .bg-img').length);
    splash +=1;
    $('.bg-img').removeClass('active');
    $('.random-imgs .bg-img:nth-child('+splash+')').addClass('active');
 });

