<?php
session_start();
if($_SESSION['login'] != 1)
	header("Location: login.php"); 

if($_POST)
{
include_once('config.php');
$datefrom = $_POST['datefrom'];
$dateto = $_POST['dateto'];
$orderstatus = $_POST['orderstatus'];
$paymentstatus = $_POST['paymentstatus'];

$result = $mysqlconnection->query("SELECT * FROM orders WHERE order_status = '".$orderstatus."' AND payment_status = '".$paymentstatus."' AND date BETWEEN '".$datefrom."' AND '".$dateto."'");

$xlshead=pack("s*", 0x809, 0x8, 0x0, 0x10, 0x0, 0x0);
 $xlsfoot=pack("s*", 0x0A, 0x00);
 function xlsCell($row,$col,$val) {
  $len=strlen($val);
  return pack("s*",0x204,8+$len,$row,$col,0x0,$len).$val;
 }

 $data=xlsCell(0,0,"Name") . xlsCell(0,1,"email") . xlsCell(0,2,"Address"). xlsCell(0,3,"Total");
 $rowNumber=0;
 while ($row = $result->fetch_array()) {
  $rowNumber=$rowNumber+1;
  //$name=$row['firstName']." ".$row['lastName'];
  $name=$row['name'];
  $email=$row['email'];
  $cusAdd=$row['addressStreet1']." ".$row['addressStreet2']." ".$row['addressCity']." ".$row['addressZip'];
  $total=$row['total'];
  $data.=xlsCell($rowNumber,0,$name) . xlsCell($rowNumber,1,$email) . xlsCell($rowNumber,2,$cusAdd) . xlsCell($rowNumber,3,$total);
 }
 $filename="Report.xls";
 header("Content-Type: application/force-download");
 header("Content-Type: application/octet-stream");
 header("Content-Type: application/download");;
 header("Content-Disposition: attachment;filename=$filename"); 
 header("Content-Transfer-Encoding: binary ");
 echo $xlshead . $data . $xlsfoot;
}
?>