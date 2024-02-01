<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer List</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style type="text/css">

table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}

table.center {
  margin-left: auto; 
  margin-right: auto;
}

</style>
</head>
<body>
	<div style="text-align: center;">
	    <h4>List Of Customer</h4>
	    <button type="button" id="addCust" style="background-color: aqua;">Add Customer</button>
	    <select id="col_name" >
		    <option value="">Search By</option>
		    <option value="fname">First Name</option>
		    <option value="lname">Last name</option>
		    <option value="street">Street</option>
		    <option value="address">Address</option>
		    <option value="city">City</option>
		    <option value="state">State</option>
		    <option value="email">Email</option>
		    <option value="phone">Phone</option>
	    </select>
	    <input type="text" name="search_by" id="search_by" disabled="disabled"><br><br>
	    <table border="" id="customerTable"  class="center">
	        <thead style="background-color: blue; color: white;">
	            <tr>
	                <th>ID</th>
	                <th>First Name</th>
	                <th>Last Name</th>
	                <th>Street</th>
	                <th>Address</th>
	                <th>City</th>
	                <th>State</th>
	                <th>Email</th>
	                <th>Phone</th>
	                <th>Action</th>
	                
	            </tr>
	        </thead>
	        <tbody>
	           
	        </tbody>
	    </table>
	</div>

    <div style="display: none; text-align: center;" id="formDiv">
	    <form action="" id="myForm">
		    <h4>Customer Details</h4>
		    <input type="hidden" id="id" name="id" placeholder="" >
		    <input type="text"   id="fname" name="fname" placeholder="First Name " >
		    <input type="text"   id="lname" name="lname" placeholder="Last Name " ><br><br>
		    <input type="text"   id="street" name="street" placeholder="Street" >
		    <input type="text"   id="address" name="address" placeholder="Address" ><br><br>
		    <input type="text"   id="city" name="city" placeholder="City" >
		    <input type="text"   id="state" name="state" placeholder="State" ><br><br>
		    <input type="text"   id="email" name="email" placeholder="Email" >
		    <input type="text"   id="phone" name="phone" placeholder="Phone" ><br><br>
		    
		    <button type="submit" style="text-align: center;" class="anchor" onclick="saveCustomerData();">Submit</button>
		     <button type="button" style="text-align: center;" class="anchor" onclick="closeForm();">Close</button>
	    </form>
    </div>
    
    
    <script type="text/javascript">
    
    $(document).ready(function() {
    	setFetchCustomerData();
    	
    	$("#addCust").click(function(){
    		$("#formDiv").show();
    	});
    	
    	$("#col_name").change(function(){
    		
    		if($("#col_name").val()!=""){
    			$("#search_by").prop('disabled',false);
    			$("#search_by").focus();
    		}else{
    			$("#search_by").prop('disabled',true);
    		}
    		
    	});
    	
    	$("#search_by").blur(function(){
    		var propertyName = $("#col_name").val();
    		var propertyValue = $("#search_by").val();
    		searchByProperty(propertyName,propertyValue);
    	})
    	
    });
 	
    function setFetchCustomerData() {
        $.ajax({
            url: "${pageContext.request.contextPath}/customer/getAllCustomer",
            method: "GET",
            dataType: "json",
            contentType: "application/json",
            success: function (customerList) {
                let tbodyData = '';

                customerList.forEach(function (customer) {
                    tbodyData += '<tr>' +
                        '<td class="text-center" style="text-align: center;">' + (customer.id == null ? "" : customer.id) + '</td>' +
                        '<td class="" style="">' + (customer.fname == null ? "" : customer.fname) + '</td>' +
                        '<td class="" style="">' + (customer.lname == null ? "" : customer.lname) + '</td>' +
                        '<td class="" style="">' + (customer.street == null ? "" : customer.street) + '</td>' +
                        '<td class="" style="">' + (customer.address == null ? "" : customer.address) + '</td>' +
                        '<td class="" style="">' + (customer.city == null ? "" : customer.city) + '</td>' +
                        '<td class="" style="">' + (customer.state == null ? "" : customer.state) + '</td>' +
                        '<td class="" style="">' + (customer.email == null ? "" : customer.email) + '</td>' +
                        '<td class="" style="">' + (customer.phone == null ? "" : customer.phone) + '</td>' +
                        '<td width="100px" style="text-align: center;">'+
						  '&nbsp;&nbsp;<a href="javascript:;"style="color:#23239b" id="tableEntry"  onclick="updateCustomerData(\''+customer.id +'\')" class="" title="Edit">'+
			                '<i class="fa fa-pencil-square edit_btn" style="font-size: 22px;"></i>'+
			              '</a>&nbsp;'+
			              '<a href="javascript:;"style="color:#d72525" onclick="deleteCustomer(\''+customer.id+'\')" class="" title="Delete">'+
			                '<i class="fa fa-trash dlt_btn" style="font-size: 22px;"></i>'+
			              '</a>'+
                        '</tr>';
                });

                $('#customerTable tbody').empty().html(tbodyData);
            },
            error: function () {
                console.log("Failed to load customer list.");
            }
        });
    }
    
    function saveCustomerData() {
        let form = document.getElementById("myForm");

        form.addEventListener('submit', function (e) {
            e.preventDefault();

            let formData = new FormData(e.target);
            let formObj = Object.fromEntries(formData);

            console.log("formObj: ", formObj);

             $.ajax({
                 url: "${pageContext.request.contextPath}/customer/saveCustomer",
                 method: "POST",
                 data: JSON.stringify(formObj),
                 dataType: "json",
                 contentType: "application/json",
                 success: function(response) {
                     console.log("Server response: ", response);
                     Swal.fire({
						  title:'Saved!',
						  icon:'success',
						  html: 'Data Saved SuccessFully for Id: '+response,
						  confirmButtonText: 'OK',
						  cancelButtonColor: '#d33',
						  allowEnterKey: true,
						  allowEscapeKey : true,
						});
                     resetCustomerData();
                     setFetchCustomerData();
                     
                 },
                 error: function(error) {
                     console.error("Error: ", error);
                 }
             });
        });
    }
    
    
    function updateCustomerData(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/customer/getbyId/"+id,
            method: "GET",
            dataType: "json",
            contentType: "application/json",
            success: function (customerList) {
            	
            	$("#formDiv").show();
            	
				console.log("customerList "+JSON.stringify(customerList));
				console.log("First Name: " + customerList.fname);
				console.log("Last Name: " + customerList.lname);
				
				$("#id").val(customerList.id);
				$("#fname").val(customerList.fname);
				$("#lname").val(customerList.lname);
				$("#street").val(customerList.street);
				$("#address").val(customerList.address);
				$("#city").val(customerList.city);
				$("#state").val(customerList.state);
				$("#email").val(customerList.email);
				$("#phone").val(customerList.phone);
               
            },
            error: function () {
                console.log("Failed to load customer list.");
            }
        });
    }
    
    
    function deleteCustomer(id){
    	Swal.fire({
			title : "Alert",
			html : "Do you want to delete data?",
			icon : 'info',
			confirmButtonText : 'YES',
			cancelButtonColor : '#d33',
			showCancelButton: true,
			allowEnterKey : true,
			allowEscapeKey : true,
			didClose : function() {
				
			}
		}).then((result) => {
		  if (result.isConfirmed) {
			 
			  deleteCustomerData(id);
		  }else  {
			
		  }
		});	
	
    }
    
    function deleteCustomerData(id) {
        $.ajax({
            url: "${pageContext.request.contextPath}/customer/deleteById/"+id,
            type: "DELETE",
            dataType: "json",
            contentType: "application/json",
            success: function (customerId) {
            	
            	 console.log("Server response delete: ", customerId);
            	 Swal.fire({
					  title:'Success',
					  icon :'success',
					  html: 'Customer Deleted SuccessFully for Id: '+customerId,
					  confirmButtonText: 'OK',
					  cancelButtonColor: '#d33',
					  allowEnterKey: true,
					  allowEscapeKey : true,
					});
            	 setFetchCustomerData();
            },
            error: function () {
                console.log("Failed to load customer list.");
            }
        });
    }
    
    function closeForm(){
    	resetCustomerData();
    	$("#formDiv").hide();
    }

    
    function searchByProperty(propertyName,propertyValue) {
    	
        $.ajax({
            url: "${pageContext.request.contextPath}/customer/search",
            data: { column: propertyName, value: propertyValue },
            method: "GET",
            dataType: "json",
            contentType: "application/json",
            success: function (response) {
            	 let tbodyData = '';
            	console.log("response "+response)
                response.forEach(function (customer) {
                    tbodyData += '<tr>' +
                        '<td class="text-center" style="text-align: center;">' + (customer.id == null ? "" : customer.id) + '</td>' +
                        '<td class="" style="">' + (customer.fname == null ? "" : customer.fname) + '</td>' +
                        '<td class="" style="">' + (customer.lname == null ? "" : customer.lname) + '</td>' +
                        '<td class="" style="">' + (customer.street == null ? "" : customer.street) + '</td>' +
                        '<td class="" style="">' + (customer.address == null ? "" : customer.address) + '</td>' +
                        '<td class="" style="">' + (customer.city == null ? "" : customer.city) + '</td>' +
                        '<td class="" style="">' + (customer.state == null ? "" : customer.state) + '</td>' +
                        '<td class="" style="">' + (customer.email == null ? "" : customer.email) + '</td>' +
                        '<td class="" style="">' + (customer.phone == null ? "" : customer.phone) + '</td>' +
                        '<td width="100px" style="text-align: center;">'+
						  '&nbsp;&nbsp;<a href="javascript:;"style="color:#23239b" id="tableEntry"  onclick="updateCustomerData(\''+customer.id +'\')" class="" title="Edit">'+
			                '<i class="fa fa-pencil-square edit_btn" style="font-size: 22px;"></i>'+
			              '</a>&nbsp;'+
			              '<a href="javascript:;"style="color:#d72525" onclick="deleteCustomer(\''+customer.id+'\')" class="" title="Delete">'+
			                '<i class="fa fa-trash dlt_btn" style="font-size: 22px;"></i>'+
			              '</a>'+
                        '</tr>';
                });

                $('#customerTable tbody').empty().html(tbodyData);
            },
            error: function () {
                console.log("Failed to load customer list.");
            }
        });
    }

    
    function resetCustomerData() {
    	$("#id").val("");
		$("#fname").val("");
		$("#lname").val("");
		$("#street").val("");
		$("#address").val("");
		$("#city").val("");
		$("#state").val("");
		$("#email").val("");
		$("#phone").val("");
    }
    
    </script>
    
</body>
</html>
