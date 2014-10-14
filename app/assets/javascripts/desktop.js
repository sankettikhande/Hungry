var phoneRX = /^((\+[1-9]{1,4}[ \-]*)|(\([0-9]{2,3}\)[ \-]*)|([0-9]{2,4})[ \-]*)*?[0-9]{3,4}?[ \-]*[0-9]{3,4}?$/;
var emailRX = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
var customUrl = "";

if(window.location.host == "www.holachef.com" || window.location.host == "holachef.com")
	customUrl = "http://reports.holachef.com/holachef.php";
else
	customUrl = "http://reports.holachef.com/qa/holachef.php";

function validatefield(id,filterEX) {
    var a = document.getElementById(id).value;
    var filter = filterEX;
    if (filter.test(a)) {
        return true;
    }
    else {
        return false;
    }
}
$( document ).ready(function() {

	var j = $(window).height();
	$("#hungry").css("height", j);
	$("#hungry").css("width", j*0.5658);
	$("#hungry").css("background-size", j*0.5658+"px "+j+"px");


	$("#chk,.image-order").css("width", $("#hungry").width()-(j*0.641*19/286));
	$("#chk,.image-order").css("height", 413*j/509);

	$("#chk,.image-order").css("left", (12*j/509)+"px");
	$("#chk,.image-order").css("top", (50*j/509)+"px");

	$(".image-order").click(function() {
		$(this).hide();
	});

	$('body').on({

	'mouseenter':function(){
	$('.overlayMouse').stop().fadeOut();
	},'mouseleave':function(){
	$('.overlayMouse').stop().fadeIn();
	}
	});

	$( "#cform-submit-con" ).click(function() {
	var name = $("#cust_name");
	var phone = $("#cust_phno");
	var email = $("#cust_email");
	var isChef = $("#cust_chef");
	var msg = $("#cust_msg");
	var error_msg = "";
	if($.trim(name.val()) == "")
		error_msg = "Please enter your name.";
	else if($.trim(phone.val())=="")
		error_msg = "Please enter your phone number.";
	else if(!validatefield('cust_phno',phoneRX))
		error_msg = "Please enter valid phone number.";
	else if($.trim(email.val())=="")
		error_msg = "Please enter your email address.";
	else if(!validatefield('cust_email',emailRX))
		error_msg = "Please enter valid email address.";
	else if($.trim(msg.val())=="")
		error_msg = "Please enter your message.";
	else {

			 $.ajax({
                      url: customUrl,
                      type : "post",
                      data: {
                                name: name.val(),
                                phone: phone.val(),
                                email: email.val(),
                                msg: msg.val(),
                                isChef: isChef.is(':checked'),
                                action: 'contact'
                            },
                      success: function(data) {
                        if($.trim(data) == "1") {
                        	alert("Thank you for contacting us.");
                       		$('#contact-modal').modal('hide');

                       	}
                        else
                        	alert("Something went wrong.");
                      }
                    }); 
	}	
	if(error_msg)
		alert(error_msg);
	return false;
	});
	$( "#cform-submit" ).click(function() {
	var name = $("#party_name");
	var phone = $("#party_phone");
	var email = $("#party_email");
	var msg = $("#party_msg");
	var error_msg = "";
	if($.trim(name.val()) == "")
		error_msg = "Please enter your name.";
	else if($.trim(phone.val())=="")
		error_msg = "Please enter your phone number.";
	else if(!validatefield('party_phone',phoneRX))
		error_msg = "Please enter valid phone number.";
	else if($.trim(email.val())=="")
		error_msg = "Please enter your email address.";
	else if(!validatefield('party_email',emailRX))
		error_msg = "Please enter valid email address.";
	else if($.trim(msg.val())=="")
		error_msg = "Please enter your special instructions.";
	else {
			
			$.ajax({
                      url: customUrl,
                      type : "post",
                      data: {
                                name: name.val(),
                                phone: phone.val(),
                                email: email.val(),
                                msg: msg.val(),
                                action: 'party'
                            },
                      success: function(data) {
                        	if($.trim(data) == "1")
                        	{
                        	alert("Party order submitted successfully.");
                        	$('#party-modal').modal('hide');
                        	}	
                        else
                        	alert("Something went wrong.");
                      }
                    }); 	
	}	
	if(error_msg)
		alert(error_msg);
	return false;
	});
});
