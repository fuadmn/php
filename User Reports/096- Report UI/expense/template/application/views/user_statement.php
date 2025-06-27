<?php

include 'header.php';
include 'sidebar.php';
?>



<div class="pcoded-main-container">
        <div class="pcoded-wrapper">
            <div class="pcoded-content">
                <div class="pcoded-inner-content">
                    <!-- [ breadcrumb ] start -->

                    <!-- [ breadcrumb ] end -->
                    <div class="main-body">
                        <div class="page-wrapper">
                           <div class="row">
                           <div class="col-xl-12">
                                    <div class="card">
                                        <div class="card-header">
                                            <h5>Basic Table</h5>
                                            <span class="d-block m-t-5">use class <code>table</code> inside table element</span>
                                        </div>
                                        <div class="card-block table-border-style">

                                        <div class="userForm">
                                          <div class="row">
                                             <div class="col-sm-4">
                                                <select name="type" id="type" name="type" class="form-control" >
                                                 <option value="0">All</option>
                                                 <option value="custme">Custme</option>
                                                </select>
                                             </div>

                                             <div class="col-sm-4">
                                                <input type="date" type" id="from" name="from" class="form-control">
                                             </div>
                                             <div class="col-sm-4">
                                                <input type="date" type" id="to" name="to" class="form-control">
                                             </div>

                                             <button id="addNew" class="btn btn-info m-3">Add New Transaction</button>
                                          </div>
                                        </div>

                                            <div class="table-responsive">
                                          
                                                <table class="table" id="expenseTable">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Amount</th>
                                                            <th>Type</th>
                                                            <th>Description</th>
                                                             
                                                            <th>Action</th>
                                                        </tr>
                                                    </thead>

                                                  <tbody>
                                                    

                                                  </tbody>

                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           </div>



                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>


<?php
include 'fooder.php'
?>

<script src="../js/user_statement.js"></script>