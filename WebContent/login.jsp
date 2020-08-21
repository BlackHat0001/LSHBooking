<%-- 
    Document   : login
    Created on : 5 Jun 2020, 14:34:04
    Author     : danma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*" %>
<% 
    String errorLine = "";
    if(session.isNew()) {
        session.setAttribute("loggedin", "false");
    }
    String navbar = "<li class=\"nav-item\"><a class=\"nav-link\" href=\"login.jsp\">Login</a></li><li class=\"nav-item\"><a class=\"btn btn-primary\" href=\"register.jsp\" role=\"button\">Register</a></li>";
           
    if (session.getAttribute("loggedin") == "true") {
        navbar = "<div class=\"dropdown\"><button class=\"btn btn-secondary dropdown-toggle\" type=\button\" id=\"dropdownMenuButton\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">Dropdown button</button><div class=\"dropdown-menu\" aria-labelledby=\"dropdownMenuButton\"><img src=\"https://png.pngtree.com/png-vector/20190827/ourlarge/pngtree-avatar-png-image_1700114.jpg\" class=\"img-thumbnail\"><a class=\"dropdown-item\" href=\"#\">View Account Details</a><a class=\"dropdown-item\" href=\"#\">Logout</a></div></div>";
    }
    String returntype = "attempt";
    try{
    	returntype = request.getParameter("login");
    	if(returntype == null) {
    		returntype = "attempt";
    	}
    } catch (Exception e) {
    	
    }
    if(returntype.equals("invalid")) {
        errorLine = "Incorrect Email or Password";
        String errorproblem = request.getParameter("debug");
    }
    if(returntype.equals("tempUserException")) {
        errorLine = "You can not log into this account! The email cannot contain \"tempuser:\"";
        String errorproblem = request.getParameter("debug");
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
        <strong>Login to Your Account</strong>
        <hr/>
		<p class="text-center text-danger"><a><%= errorLine %></a></p>
        <form action="loginaction.jsp">
            <div class="form-group">
              <label for="exampleInputEmai1">Email address</label>
              <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" name="email">
              <small id="emailHelp" class="form-text text-muted">We'll never share your details with anyone.</small>
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Password</label>
              <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password"  name="password">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
        
        </div>
        
    </body>
</html>
