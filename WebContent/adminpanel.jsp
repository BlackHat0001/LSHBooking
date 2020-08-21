<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*, com.server.*" %>
<% 
	boolean allowAdvance = true;
    if(session.isNew()) {
        session.setAttribute("loggedin", "false");
        session.setAttribute("username", "");
        session.setAttribute("userID", 0);
        session.setAttribute("email", "");
        session.setAttribute("phonenum", 0);
        session.setAttribute("admin", "false");
    }
	if(!(session.getAttribute("loggedin") == "true")) {
		session.setAttribute("admin", "false");
	}
	String navbar = "<li class=\"nav-item\"><a class=\"nav-link\" href=\"login.jsp?login=attempt\">Login</a></li><br><li class=\"nav-item\"><a class=\"btn btn-primary\" href=\"register.jsp\" role=\"button\">Register</a></li>";
	
	if (session.getAttribute("loggedin") == "true") {
	    navbar = "<div class=\"btn-group\">\n<button type=\"button\" class=\"btn btn-danger dropdown-toggle\" data-toggle=\"dropdown\" aria-haspopup=\"true\" aria-expanded=\"false\">" + session.getAttribute("username") + "</button>\n<div class=\"dropdown-menu\">\n<a class=\"dropdown-item\"><img src=\"https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/512x512/plain/user.png\" class=\"img-thumbnail\"></a>\n<a class=\"dropdown-item\" href=\"accountbookings.jsp\">View Bookings</a>\n<a class=\"dropdown-item\" href=\"account.jsp\">View Account Details</a>\n<a class=\"dropdown-item\" href=\"logoutaction.jsp\">Logout</a>\n</div>\n</div>";
	}
	if(session.getAttribute("admin") == "false") {
		response.sendRedirect("index.jsp");
		allowAdvance = false;
	}
	ArrayList<com.server.Booking> bookings = com.server.DataBase.queryAllBookingOffice();
	String officeName = "";
	int officeID = 0;
	int officeSeats = 0;
	int officeOpen = 0;
	int officeClose = 0;
	int officeSlots = 0;
	String officeRequest = "";
	ArrayList<User> users = new ArrayList();
	com.server.Office office = new Office(0, "", 0, 0, 0, 0);
	users = com.server.DataBase.queryAllUserAccount();
	System.out.println(users.size());
	String csvdata = "";
	if(allowAdvance == true) {
		try{
		officeRequest = request.getParameter("office");
		} catch (Exception e) {}
		if(officeRequest == null) {
			officeRequest = "UK House";
		}
		office = com.server.DataBase.queryOfficeSingleName(officeRequest);
		officeName = office.getOfficeName();
		officeSeats = office.getSeatsAvailable();
		officeOpen = office.getOfficeOpens();
		officeClose = office.getOfficeCloses();
		officeSlots = office.getMaxSlotsPerDay();
		officeID = office.getOfficeID();
	}

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
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.21/css/dataTables.bootstrap4.min.css"/>
     <script type="text/javascript" language="javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
	<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" language="javascript" src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
     <script src="CSSJS/js/bootstrap-slider.js"></script>
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	 <script src="CSSJS/JQuery/jquery.min.js"></script>
     <script src="CSSJS/js/bootstrap.bundle.min.js"></script>
     <script src="CSSJS/js/bootstrap-datepicker.min.js"></script>
     <script>
     $(document).ready(function(){
    	 $("body").on("click", "button", function() {
           		var bookingIDtemp = $(this).val();
           		var actiontemp = $(this).text();
           		$(this).fadeIn(500, function(){$(this).append(' <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>')});
       		$.post("admindata.jsp",	  
   			  {
   			    bookingID: bookingIDtemp, 
   	     		action: actiontemp, 
    			  },
    			  function(data){
   				  if(actiontemp == "Approve" || actiontemp == "Deny") {
    				$("tr[data-id=" + bookingIDtemp + "]").fadeOut(1000, function() { $(this).remove(); });
    			  } else {
    				  $("tr[data-other-id=" + bookingIDtemp + "]").fadeOut(1000, function() { $(this).remove(); }); 
    			  }
    			  });
       	});
      	$('#btn1').click(function(){
			var html = $("#btn1data").html();
			$("#table").html(html);
      	});
      	$('#btn2').click(function(){
			var html = $("#btn2data").html();
			$("#table").html(html);
      	});
     });
     
     </script>
     <script type="text/javascript" class="init">
     </script>
<title>Admin Panel</title>

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
     <div class="row">
     <div class="col-2"></div>
     <div class="col-4">
     	<br>
     	<br>
     	<div class="card" style="width: 32rem;">
     		<div class="card-body">
     			<h5 class="display-4 card-title">Office Name</h5>
     			<h3 class="card-subtitle mb-2 text-muted"><%= officeName %></h3>
   			</div>
		</div>
		
     </div>
     <div class="col-4">
     	<br>
     	<br>
     	<div class="card" style="width: 26rem;">
     		<div class="card-body">
     			<h5 class="display-4 card-title">Office Capacity</h5>
     			<h3 class="card-subtitle mb-2 text-muted"><%= officeSeats %></h3>
   			</div>
		</div>
     </div>
     <div class="col-2"></div>
     </div>
     <div class="row">
     	<div class="col-3"></div>
     	<div class="col-6">
     	<br>
     	<h1 class="display-3">Welcome Admin</h1>
     	<hr/>
     	<br>
     	<div class="row">
     		<div class="col-4">
     		<input class="btn btn-primary" id="btn1" type="button" value="View New Bookings">
     		</div>
     		<div class="col-4">
     		<input class="btn btn-primary" id="btn2" type="button" value="View All Bookings">
     		</div>
     		<div class="col-4">
     		<a type="button" class="btn btn-primary" id="csv" type="button" download="<%= officeName %>.csv" href="data:application/csv;charset=utf-8,<%= csvdata = com.server.csv.downloadOffice(officeID) %>">Export Excel File</a>
     		</div>
     	</div>
     	</div>
     	<div id="table">
     	</div>
     	<div class="col-3"></div>
     </div>
     <div class="d-none" id="btn1data">
     <table class="table" id="btn1table">
	<br>
   	<hr/>
     <thead>
	    <tr>
	      <th scope="col">#</th>
	      <th scope="col">Name</th>
	      <th scope="col">Email</th>
	      <th scope="col">Phone Number</th>
	      <th scope="col">Date</th>
	      <th scope="col">Time</th>
	      <th scope="col">No. Seats</th>
	    </tr>
 		</thead>
 		<tbody>
     <%
     if(allowAdvance == true) {
     StringBuilder str = new StringBuilder();
     ArrayList<com.server.Booking> userBookings = new ArrayList();
     System.out.println(bookings.size());
     for(int i=0; i<bookings.size(); i++) {
    	 if(bookings.get(i).getOfficeid() == office.getOfficeID() && bookings.get(i).getStatus().equals("waiting")) {
    		 userBookings.add(bookings.get(i));
    	 }
     }
     
     for(int i=0; i<userBookings.size(); i++){
    	 int userIndex = 0;
    	 for(int j=0; j<users.size(); j++) {
    		 if(users.get(j).getUserId() == userBookings.get(i).getUserID()) {
    			 userIndex = j;
    			 break;
    		 }
    	 }
    	 str.append("<tr data-id=\""+userBookings.get(i).getBookingID()+"\">");
    	 str.append("<th scope=\"row\">"+(i+1)+"</th>");
    	 str.append("<td>"+users.get(userIndex).getName()+"</td>");
    	 String email = users.get(userIndex).getEmail();
    	 if(email.contains("tempuser:")) {
    		 email = email.replace("tempuser:", "");
    	 }
    	 str.append("<td>"+email+"</td>");
    	 str.append("<td>0"+users.get(userIndex).getPhonenum()+"</td>");
    	 str.append("<td>"+userBookings.get(i).getDate()+"</td>");
    	 double timecalc = office.getOfficeOpens();
    		double officeOpenTime = Math.abs(12 - office.getOfficeOpens()) + Math.abs(0 - office.getOfficeCloses());
    		officeOpenTime = Math.abs(officeOpenTime);
    		double officeSlotLength = officeOpenTime / office.getMaxSlotsPerDay();
    		officeSlotLength = officeSlotLength * (userBookings.get(i).getTimeslot() - 1);
    		timecalc = timecalc + officeSlotLength;
    		
    	    double mintemp = timecalc % 1;
    		int hour = (int)(timecalc - mintemp);
    		int min = (int)(mintemp * 60);
    		
    		officeSlotLength = officeOpenTime / office.getMaxSlotsPerDay();
    		timecalc = office.getOfficeOpens();
    		officeSlotLength = officeSlotLength * (userBookings.get(i).getTimeslot());
    		timecalc = timecalc + officeSlotLength;
    		
    	    double mintempend = timecalc % 1;
    		int hourend = (int)(timecalc - mintempend);
    		int minend = (int)(mintempend * 60);
    		
    		String additional1 = "";
    		String additional2 = "";
    		if(min == 0) {
    			additional1 = "0";
    		}
    		if (minend == 0) {
    			additional2 = "0";
    		}
    	 str.append("<td>"+hour+":"+min+""+additional1+" - "+hourend+":"+minend+""+additional2+"</td>");
    	 str.append("<td>"+userBookings.get(i).getNumberdesks()+"</td>");
    	 str.append("<td><button type=\"button\" value=\""+userBookings.get(i).getBookingID()+"\" class=\"btn btn-success\" href=\"\" role=\"button\">Approve</button></td><td><button type=\"button\" value=\""+userBookings.get(i).getBookingID()+"\" class=\"btn btn-danger\" href=\"\" role=\"button\">Deny</button></td>");
    	 str.append("</tr>");
    	 System.out.println("a");
     }
    	out.println(str.toString());
     } else {
    	 out.println("<tr><th scope=\"1\"></th><td>No Data To Display</td></tr>");
     }
     %>
     <tr>
     <td>No more data</td>
     </tr>
     </tbody>
     </table>
     </div>
     <div class="d-none" id="btn2data">
     <table class="table" id="btn2table">
	<br>
   	<hr/>
     <thead>
	    <tr>
	      <th scope="col">#</th>
	      <th scope="col">Name</th>
	      <th scope="col">Email</th>
	      <th scope="col">Phone Number</th>
	      <th scope="col">Date</th>
	      <th scope="col">Time</th>
	      <th scope="col">No. Seats</th>
	      <th scope="col">Status</th>
	    </tr>
 		</thead>
 		<tbody>
     <%
     if(allowAdvance == true) {
     StringBuilder str = new StringBuilder();
     ArrayList<com.server.Booking> userBookings = new ArrayList();
     System.out.println(bookings.size());
     for(int i=0; i<bookings.size(); i++) {
    	 if(bookings.get(i).getOfficeid() == office.getOfficeID()) {
    		 userBookings.add(bookings.get(i));
    	 }
     }
     
     for(int i=0; i<userBookings.size(); i++){
    	 int userIndex = 0;
    	 for(int j=0; j<users.size(); j++) {
    		 if(users.get(j).getUserId() == userBookings.get(i).getUserID()) {
    			 userIndex = j;
    			 break;
    		 }
    	 }
    	 str.append("<tr data-other-id=\""+userBookings.get(i).getBookingID()+"\">");
    	 str.append("<th scope=\"row\">"+(i+1)+"</th>");
    	 str.append("<td>"+users.get(userIndex).getName()+"</td>");
    	 String email = users.get(userIndex).getEmail();
    	 if(email.contains("tempuser:")) {
    		 email = email.replace("tempuser:", "");
    	 }
    	 str.append("<td>"+email+"</td>");
    	 str.append("<td>0"+users.get(userIndex).getPhonenum()+"</td>");
    	 str.append("<td>"+userBookings.get(i).getDate()+"</td>");
    	 double timecalc = office.getOfficeOpens();
    		double officeOpenTime = Math.abs(12 - office.getOfficeOpens()) + Math.abs(0 - office.getOfficeCloses());
    		officeOpenTime = Math.abs(officeOpenTime);
    		double officeSlotLength = officeOpenTime / office.getMaxSlotsPerDay();
    		officeSlotLength = officeSlotLength * (userBookings.get(i).getTimeslot() - 1);
    		timecalc = timecalc + officeSlotLength;
    		
    	    double mintemp = timecalc % 1;
    		int hour = (int)(timecalc - mintemp);
    		int min = (int)(mintemp * 60);
    		
    		officeSlotLength = officeOpenTime / office.getMaxSlotsPerDay();
    		timecalc = office.getOfficeOpens();
    		officeSlotLength = officeSlotLength * (userBookings.get(i).getTimeslot());
    		timecalc = timecalc + officeSlotLength;
    		
    	    double mintempend = timecalc % 1;
    		int hourend = (int)(timecalc - mintempend);
    		int minend = (int)(mintempend * 60);
    		
    		String additional1 = "";
    		String additional2 = "";
    		if(min == 0) {
    			additional1 = "0";
    		}
    		if (minend == 0) {
    			additional2 = "0";
    		}
    	 str.append("<td>"+hour+":"+min+""+additional1+" - "+hourend+":"+minend+""+additional2+"</td>");
    	 str.append("<td>"+userBookings.get(i).getNumberdesks()+"</td>");
    	 String color = "success";
    	 if(bookings.get(i).getStatus().equals("waiting")) {
    		 color = "danger";
    	 }
    	 String bookingstatus = userBookings.get(i).getStatus();
  		if(bookingstatus.equals("Unattended")) {
  			bookingstatus = "Didn't Attend";
  			color = "warning";
  		}
    	 str.append("<td><p class=\"text-"+color+"\">"+bookingstatus+"</p></td>");
    	 str.append("<td><button type=\"button\" value=\""+userBookings.get(i).getBookingID()+"\" class=\"btn btn-danger\" href=\"\" data-toggle=\"modal\" data-target=\"#exampleModal\" role=\"button\">Delete</button></td>");
    	 str.append("</tr>");
    	 System.out.println("a");
     }
    	out.println(str.toString());
     } else {
    	 out.println("<tr><th scope=\"1\"></th><td>No Data To Display</td></tr>");
     }
     %>
     </tbody>
     </table>
     </div>
     </div>
    
</body>
</html>