<?php
include '../connection.php';

$subjects = $_POST['subjects'];

$sqlQuary ="SELECT * FROM saleroom WHERE subjects = '$subjects'";
$resultQuery = $connection -> query($sqlQuary);

if($resultQuery -> num_rows > 0){
    echo json_encode(array("existSubjects" => true));
}else{
    echo json_encode(array("existSubjects" => false));
}