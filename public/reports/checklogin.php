<?php
session_start();
$username = strip_tags($_POST['email']);
$password = strip_tags($_POST['loginpass']);
if($username == "holachef" && $password == "h01ach3f" )
{
	$_SESSION['login']=1;
	header("Location: index.php");
}
else
{
	header("Location: login.php?error=Invalid username or password");
}
?>