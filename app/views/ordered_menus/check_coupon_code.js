if ("<%= @msg %>" == "Valid coupon code"){
 $("#coupon_validate_msg").html("");
 // $(".discount_span").text("<%= @discount_amount %>");
 $("#discount").text("<%= @discount_amount %>");
 $(".total_amount").text("<%= @paid_amount %>")
}
else{
 $("#coupon_validate_msg").html("<%= @msg %> ");
}
