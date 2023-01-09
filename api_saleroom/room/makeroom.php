<?php
include '../connection.php';

$room_root_id = $_POST['room_root_id'];
$subjects = $_POST['subjects'];
$content = $_POST['content'];
$callnumber = $_POST['callnumber'];
$youtubeLink = $_POST['youtubeLink'];
$delyn = $_POST['delyn'];

$sqlQuary ="INSERT INTO saleroom SET room_root_id='$room_root_id',subjects='$subjects', 
content='$content',callnumber='$callnumber',youtubeLink='$youtubeLink',delyn='$delyn'";

$resultQuery = $connection -> query($sqlQuary);

if($resultQuery){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success" => false));
}
