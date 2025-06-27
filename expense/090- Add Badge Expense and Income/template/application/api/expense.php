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


function get_user_transaction($conn){

   $data = array();
   $array_data = array();
   $query = "SELECT `id`, `amount`, `type`, `description`FROM `expense` WHERE 1";
   $result = $conn->query($query);

   if($result){

      while($row  = $result->fetch_assoc()){
        $array_data [] = $row;
      }

      $data = array("status" => true, "data" => $array_data);

   }else{
     
        $data = array("status" => false, "data" => $conn->error);
   }

   echo json_encode($data);

}

if(isset($_POST['action'])){
   $action = $_POST['action'];
   $action($conn);
}else{
   echo json_encode(array("status" => false, "data" => "Action Required..."));

}