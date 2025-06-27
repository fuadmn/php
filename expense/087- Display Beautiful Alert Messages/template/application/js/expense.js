$("#addNew").on("click", function(){
   $("#expenseModal").modal("show");
});


$("#expenseForm").on("submit", function(event){

   event.preventDefault();

   let amount = $("#amount").val();
   let type = $("#type").val();
   let description = $("#description").val();


   let sendingData = {
      "amount": amount,
       "type": type,
       "description": description,
       "action": "register_expense",
   }
   $.ajax({
      method: "POST",
      dataType: "JSON",
      url: "../api/expense.php",
      data : sendingData,
      success: function(data){

         let status = data.status;
         let response = data.data;

        if(status){
         displayMessage("success",response);
        }else{
       displayMessage("error",response);
        }
      },
      error: function(data){

      }
   })

})

function displayMessage(type, message){

   let success = document.querySelector(".alert-success ");
   let error = document.querySelector(".alert-danger");

   if(type == "success"){
       error.classList = "alert alert-danger d-none";
       success.classList = "alert alert-success";
       success.innerHTML = message;

       setTimeout(function()  {
         $("#expenseModal").modal('hide');
         success.classList = "alert alert-success d-none";
         $("#expenseForm")[0].reset();
       }, 3000);
   }else{
    error.classList = "alert alert-danger ";
    error.innerHTML = message;
   }
}