<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" integrity="sha512-v2CJ7UaYy4JwqLDIrZUI/4hqeoQieOmAZNXBeQyjo21dadnwR+8ZaIJVT8EE2iyI61OV8e6M8PP2/4hpQINQ/g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</head>
<body>
    
     <div style="text-align: center;" id="loginDiv">
	    <form action="" id="myLoginForm">
	    <h4>Login</h4>
	    <input type="text"   id="email1" name="email1" placeholder="Email" ><br><br>
	    <input type="password"   id="password1" name="password1" placeholder="password" ><br><br>
	    
	    <button type="button" style="text-align: center;" class="" onclick="userLogin();">Login</button><br><br>
	    
	    <div><a id="Clickreg" style="color: blue;">Click here to register!</a></div>
	    </form>
    </div>
   
    <div style="display: none; text-align: center;" id="regDiv">
	    <form action="" id="myRegForm">
	    <h4>User Registration</h4>
	    <input type="hidden" id="id" name="id" placeholder="" >
	    <input type="text"   id="fname" name="fname" placeholder="First Name " ><br><br>
	    <input type="text"   id="lname" name="lname" placeholder="Last Name " ><br><br>
	    <input type="text"   id="email" name="email" placeholder="Email" ><br><br>
	    <input type="password"   id="password" name="password" placeholder="password" ><br><br>
	    
	    <button type="submit" style="text-align: center;" class="anchor" onclick="saveUserData();">Submit</button>
	    </form>
    </div>
    
    
    <script type="text/javascript">
    
    $(document).ready(function() {
    	
    	$("#Clickreg").click(function(){
    		$("#regDiv").show();
    		$("#loginDiv").hide();
    	});
    	
    });

    
    function saveUserData() {
        let form = document.getElementById("myRegForm");

        form.addEventListener('submit', function (e) {
            e.preventDefault();

            let formData = new FormData(e.target);
            let formObj = Object.fromEntries(formData);

            console.log("formObj: ", formObj);

             $.ajax({
                 url: "${pageContext.request.contextPath}/customer/saveUser",
                 method: "POST",
                 data: JSON.stringify(formObj),
                 dataType: "json",
                 contentType: "application/json",
                 success: function(response) {
                     console.log("Server response: ", response);
                     Swal.fire({
						  title:'Registered',
						  icon: 'success',
						  html: 'User Registered SuccessFully for Id: '+response,
						  confirmButtonText: 'OK',
						  cancelButtonColor: '#d33',
						  //showCancelButton: true,
						  allowEnterKey: true,
						  allowEscapeKey : true,
						});
                     $("#loginDiv").show();
                     $("#regDiv").hide();
             		
                     
                 },
                 error: function(error) {
                     console.error("Error: ", error);
                 }
             });
        });
    }
    
    function userLogin() {
        let postParameter = {
            email: $("#email1").val(),
            password: $("#password1").val(),
        };

        $.ajax({
            url: "${pageContext.request.contextPath}/customer/login",
            method: "POST",
            data: JSON.stringify(postParameter),
            dataType: "json",
            contentType: "application/json",
            success: function(response) {
                console.log("22 " + response.status);
                if (response.status === "Login successful!") {
                    Swal.fire({
                        title: 'Login',
                        icon: 'success',
                        text: response.status,
                        confirmButtonText: 'OK',
                        allowEnterKey: true,
                        allowEscapeKey: true,
                    }).then(() => {
                        window.location.href = "${pageContext.request.contextPath}/customer/getMainPage";
                    });
                } else {
                	 Swal.fire({
                         title: 'Error',
                         icon: 'error',
                         text: response.status,
                         confirmButtonText: 'OK',
                         allowEnterKey: true,
                         allowEscapeKey: true,
                     });
                }
            },

            error: function(error) {
                console.error("Error: ", error);
                return;
            }
        });
    }


    </script>
    
</body>
</html>
