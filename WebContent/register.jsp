<%-- 
    Document   : register
    Created on : 5 Jun 2020, 20:17:42
    Author     : danma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*" %>
<% 
    String errorLine = "";
    if(session.isNew()) {
        session.setAttribute("loggedin", "false");
        session.setAttribute("username", "");
        session.setAttribute("userID", 0);
        session.setAttribute("email", "");
        session.setAttribute("phonenum", 0);
    }
    String navbar = "<li class=\"nav-item\"><a class=\"nav-link\" href=\"login.jsp\">Sign In</a></li><li class=\"nav-item\"><button type=\"button\" class=\"btn btn-primary\" href=\"signup.jsp\">Sign Up</button></li>";
           
    if (session.getAttribute("loggedin") == "true") {
        navbar = "<div class=\"dropdown\"><button class=\"btn btn-secondary dropdown-toggle\" type=\button\" id=\"dropdownMenuButton\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">Dropdown button</button><div class=\"dropdown-menu\" aria-labelledby=\"dropdownMenuButton\"><img src=\"https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg\" class=\"img-thumbnail\"><a class=\"dropdown-item\" href=\"#\">View Account Details</a><a class=\"dropdown-item\" href=\"#\">Logout</a></div></div>";
    }
    try{
	    switch(request.getParameter("error")) {
	    	case "duplicateAccount": {
	    		errorLine = "An account with that email already exists";
	    		break;
	    	}
	    	case "passwordMatch": {
	    		errorLine = "Passwords do not match";
	    		break;
	    	}
	    	case "phonenum": {
	    		errorLine = "Your phonenumber does not match the format \"+44(Your Phone Num)\"";
	    		break;
	    	}
	    	case "email": {
	    		errorLine = "Your email is not @lsh.co.uk";
	    		break;
	    	}
	    	default: { errorLine = "There was a problem. Please try again later or contact the service administrator and give them this message:"+request.getParameter("error")+""; }
	    }
    } catch(Exception e) {
    	errorLine = "";
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

             <link href="CSSJS/css/bootstrap.min.css" rel="stylesheet">
		     <link href="CSSJS/css/bootstrap-datepicker.standalone.min.css" rel="stylesheet">
		     <link href="CSSJS/css/bootstrap-slider.css" rel="stylesheet">
		     <script src="CSSJS/js/bootstrap-slider.js"></script>
			 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
			 <script src="CSSJS/JQuery/jquery.min.js"></script>
		     <script src="CSSJS/js/bootstrap.bundle.min.js"></script>
		     <script src="CSSJS/js/bootstrap-datepicker.min.js"></script>

    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark static-top">
       <div class="container">
         <a class="navbar-brand" href="index.jsp">LSH Desk Booking System</a>
         <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
           <span class="navbar-toggler-icon"></span>
         </button>
         <div class="collapse navbar-collapse" id="navbarResponsive">
           <ul class="navbar-nav ml-auto">
             <li class="nav-item active">
               <a class="nav-link" href="index.jsp">Home
                 <span class="sr-only">(current)</span>
               </a>
             </li>
            <%= navbar %>
           </ul>
         </div>
       </div>
     </nav>
        <div class="container">
        <br>
        <strong>Register A New Account</strong>
        <p class="text-danger"><%= errorLine %></p>
        <hr/>
        <form action="registeraction.jsp">
            <div class="form-group">
              <label for="exampleInputEmai1">Email address</label>
              <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email e.g. JohnDoe@lsh.co.uk" name="email">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Password</label>
              <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password"  name="password">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Confirm Password</label>
              <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Confirm Password"  name="passwordconfirm">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">First Name</label>
              <input type="text" class="form-control" id="exampleInputPassword1" placeholder="First Name"  name="firstname">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Surname</label>
              <input type="text" class="form-control" id="exampleInputPassword1" placeholder="Surname"  name="surname">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Phone Number</label>
              <input type="number" class="form-control" id="exampleInputPassword1" placeholder="Phone Num"  name="phonenum">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
        
        </div>
        
        
    </body>
</html>
