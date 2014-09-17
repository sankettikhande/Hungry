<?php
session_start();
if($_SESSION['login'] == 1)
  header("Location: index.php"); 
?>
<html>
  <head>
  <script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
  <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
  <script src="https://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>
  <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <title>Holachef</title>
  </head>
  <body>
 <div class="row">
 <?php if($_GET['error']): ?>
  <div class="col-xs-12 text-center">
  <div class="alert alert-danger"><?php echo $_GET['error']; $_GET['error']=""; ?></div>
  </div>
 <?php endif; ?>
    <div class="col-xs-12 text-center">
    <h2>Holachef Report Login</h2>
    </div>
    <div class="col-lg-6 col-lg-offset-3">
<form class="col-md-12" method="post" action="checklogin.php">
    <div class="form-group">
        <input type="text" name="email" class="form-control input-lg" placeholder="Username" required>
    </div>
    <div class="form-group">
        <input type="password" name="loginpass" class="form-control input-lg" placeholder="Password" required>
    </div>
    <div class="form-group">
        <button class="btn btn-primary btn-lg btn-block">Sign In</button>
    </div>
</form>
</div>
</div>
</body>
</html>