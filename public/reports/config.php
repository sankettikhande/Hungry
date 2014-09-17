<?php
$hostname = "localhost";
$username = "root";
$password = "";
$dbname = "holachef_production";
$mysqlconnection = new mysqli($hostname, $username, $password, $dbname);

/* check connection */
if ($mysqlconnection->connect_errno) {
    printf("Connect failed: %s\n", $mysqlconnection->connect_error);
    exit();
}
?>