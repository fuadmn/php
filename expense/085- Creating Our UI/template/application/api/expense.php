<?php

header("Content-type: application/json");

include '../config/conn.php';

// $action = $_POST['action'];

function register_expense($conn){

   extract($_POST);

   $data = array();


   //buliding the query and call the stored procedures
   $query = "CALL register_expense_sp('','$amount','$type','$description','USR001')";

   //Ececution

   $result = $conn->query($query);

   //check if there ia an error or not
   if($result){
    $data  = array("status" => true, "data" => "Registered Successfully");
   }else{
      $data  = array("status" => false, "data" => $conn->error);
   }


   echo json_encode($data);

}



if(isset($_POST['action'])){
   $action = $_POST['action'];
   $action($conn);
}else{
   echo json_encode(array("status" => false, "data" => "Action Required..."));

}