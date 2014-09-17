<?php
session_start();
if($_SESSION['login'] != 1)
	header("Location: login.php"); 
?>
<html>
  <head>
  <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">

  <script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
	</script>
    <title>Holachef</title>
  </head>
  <body>
  <div class="container">
  	  <div class="row">
  <div class="col-xs-12">
  <a class="pull-right" href="logout.php">Logout</a>
  </div>
  </div>
 <div class="row">
    <div class="col-xs-12 text-center">
    <h2>Holachef Report</h2>
    </div>
    <div class="col-lg-6 col-lg-offset-3">
  <form class="form-horizontal" id="getvalueform" role="form" method="post" action="getdata.php">
  <div class="form-group">
    <label for="orderstatus">Order Status</label>
    <select class="form-control" name="orderstatus" id="orderstatus" required>
      <option value="">Select</option>
      <option value="Created">Created</option>
      <option value="Confirmed">Confirmed</option>
      <option value="Dispatched">Dispatched</option>
      <option value="Damaged">Damaged</option>
      <option value="Delivered">Delivered</option>
      <option value="Canceled">Canceled</option>
      <option value="Returned">Returned</option>
      <option value="Reordered">Reordered</option>
    </select>
  </div>
  <div class="form-group">
    <label for="payment_status">Payment Status</label>
    <select class="form-control" name="paymentstatus" id="payment_status" required>
      <option value="" >Select</option>
      <option value="Waiting for Payment">Waiting for Payment</option>
      <option value="Payment Gateway Failed">Payment Gateway Failed</option>
      <option value="Paid">Paid</option>
      <option value="On Delivery">On Delivery</option>
      <option value="User Canceled">User Canceled</option>
    </select>
  </div>
  <div class="form-group">
    <label for="datefrom">Date From</label>
    <input id="datefrom" name="datefrom" type="text" class="date-picker form-control" required />
  </div>
  <div class="form-group">
    <label for="dateto">Date To</label>
    <input id="dateto" type="text" name="dateto" class="date-picker form-control" required />
  </div>
  <div class="form-group">
    <input type="submit" id="seeresults" class="btn btn-default" value="Get Report" />
  </div>
</form>
</div>

 </div>
  </div>
 <script>
$(function() {
    $( ".date-picker" ).datepicker({ maxDate: "+0D" , dateFormat: "yy-mm-dd"});
    $("form").validationEngine();
	});
</script>
</body>
</html>