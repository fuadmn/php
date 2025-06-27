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
         alert(response)
        }else{
         alert(response)
        }
      },
      error: function(data){

      }
   })

})