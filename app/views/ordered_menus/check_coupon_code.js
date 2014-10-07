if ("<%= @msg %>" == "Valid coupon code"){
 $("#coupon_validate_msg").html("");
 $(".discount_ul").show();
 $(".discount_span").text("<%= @discount_amount %>");
 $(".total_amount").text("<%= @paid_amount %>")
}
else{
 $("#coupon_validate_msg").html("<%= @msg %> ");
 $(".discount_ul").hide();
}