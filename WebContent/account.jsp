<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*" %>
<%

	if(session.isNew()) {
	    session.setAttribute("loggedin", "false");
	    session.setAttribute("username", "");
	    session.setAttribute("userID", 0);
	    session.setAttribute("email", "");
	    session.setAttribute("phonenum", 0);
	    response.sendRedirect("index.jsp");
	}
	String topDisplay = "Hello " + (String)session.getAttribute("username");
	if(session.getAttribute("loggedin").equals("false")) {
		topDisplay = "You are not signed in";
	}
	String username = (String)session.getAttribute("username");
	int userID = (int)session.getAttribute("userID");
	String email = (String)session.getAttribute("email");
	long phonenum = (long)session.getAttribute("phonenum"); 
	String navbar = "<li class=\"nav-item\"><a class=\"nav-link\" href=\"login.jsp?login=attempt\">Login</a></li><br><li class=\"nav-item\"><a class=\"btn btn-primary\" href=\"register.jsp\" role=\"button\">Register</a></li>";
	
	if (session.getAttribute("loggedin") == "true") {
	    navbar = "<div class=\"btn-group\">\n<button type=\"button\" class=\"btn btn-danger dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">" + session.getAttribute("username") + "</button>\n<div class=\"dropdown-menu\">\n<a class=\"dropdown-item\"><img src=\"https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/512x512/plain/user.png\" class=\"img-thumbnail\"></a>\n<a class=\"dropdown-item\" href=\"accountbookings.jsp\">View Bookings</a>\n<a class=\"dropdown-item\" href=\"account.jsp\">View Account Details</a>\n<a class=\"dropdown-item\" href=\"logoutaction.jsp\">Logout</a>\n</div>\n</div>";
	}
	String errorLine = "";
	try {
	if(request.getParameter("error").equals("pwmatch")) {
		errorLine = "Your passwords dont match";
	}
	} catch (Exception e) {}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
	   <script>
	   $(document).ready(function(){
	  	 	$("#editDetails").click(function(){
	  	 		$("#htm").html("<br><form action=\"editAccDetails.jsp\"><div class=\"form-group\"><label for=\"phonenum1\">Name</label><input type=\"text\" class=\"form-control\" id=\"Name1\" placeholder=\"Enter Name\" name=\"name\"></div><div class=\"form-group\"><label for=\"phonenum1\">Phone Number</label><input type=\"text\" class=\"form-control\" id=\"phonenum1\" placeholder=\"Enter Phone Number\" name=\"phonenum\"></div><button type=\"submit\" class=\"btn btn-primary\">Submit</button></form>");
	  	 	});
	  	 	$("#passwordReset").click(function(){
	  	 		$("#htm").html("<br><form action=\"editAccDetails.jsp\"><div class=\"form-group\"><label for=\"password\">Password</label><input type=\"password\" class=\"form-control\" id=\"password\" placeholder=\"Password\" name=\"password\"></div><div class=\"form-group\"><label for=\"passwordConfirm\">Confirm Password</label><input type=\"password\" class=\"form-control\" id=\"passwordConfirm\" placeholder=\"Confirm Password\" name=\"passwordConfirm\"></div><button type=\"submit\" class=\"btn btn-primary\">Submit</button></form>");
	  	 	});
	   });
	   </script>
<title>Account Details</title>
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
    	<div class="col-lg-3"></div>
    	<div class="col-lg-6">
    		<br>
    		<p class="h1 text-danger text-center"><%= topDisplay %></p>
    		<br>
    		<p class="h3">Your Account Details</p>
    		<p class="text-danger"><%= errorLine %></p>
    		<hr/>
    		<br>
    		<ul class="list-group">
    			<li class="list-group-item">Email: <%= email %></li>
    			<li class="list-group-item">Name: <%= username %></li>
    			<li class="list-group-item">Phone Number: <%= phonenum %></li>
   			</ul>
   			<br>
   			<button type="button" class="btn btn-primary" id="editDetails">Edit Account Details</button>
   			<button type="button" class="btn btn-primary" id="passwordReset">Password Reset</button>
   			<br>
   			<div id="htm"></div>
   			
    	</div>
    	<div class="col-lg-3"></div>
     </div>
</body>
</html>