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

    $row = $result->fetch_assoc();

    if($row['Message'] == 'Deny'){
          $data  = array("status" => false, "data" => "Insuficient Balance 😊😊😎");
    }elseif($row['Message'] == 'Registered'){
         $data  = array("status" => true, "data" => "Registered Successfully");
    }

   }else{
      $data  = array("status" => false, "data" => $conn->error);
   }


   echo json_encode($data);

}

function update_expense($conn){

   extract($_POST);

   $data = array();


   //buliding the query and call the stored procedures
   $query = "CALL register_expense_sp('$id','$amount','$type','$description','USR001')";

   //Ececution

   $result = $conn->query($query);

   //check if there ia an error or not
   if($result){

    $row = $result->fetch_assoc();


    if($row['Message'] == 'Updated'){
      $data  = array("status" => true, "data" => "Updated Successfully");
    }

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



function  get_expense_info($conn){

   extract($_POST);
   $data = array();
   $array_data = array();
   $query = "SELECT * FROM `expense` where id = '$id'";
   $result = $conn->query($query);

   if($result){

      $row  = $result->fetch_assoc();


      $data = array("status" => true, "data" => $row);

   }else{
     
        $data = array("status" => false, "data" => $conn->error);
   }

   echo json_encode($data);

}

function  delete_expense_info($conn){

   extract($_POST);
   $data = array();
   $array_data = array();
   $query = "DELETE  FROM `expense` where id = '$id'";
   $result = $conn->query($query);

   if($result){

      $data = array("status" => true, "data" => "deleted SuccessFully 😘");

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