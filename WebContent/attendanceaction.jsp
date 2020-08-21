<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.io.*,java.util.*" %>
<%
	
	boolean allowAdvance = true;

	String tokentemp = "";
	tokentemp = request.getParameter("token");
	if(tokentemp == null || tokentemp.isEmpty()) {
		response.sendRedirect("index.jsp");
		allowAdvance = false;
	}
	int token = Integer.parseInt(tokentemp);
	
	boolean type = false;
	String typetemp = "";
	if (allowAdvance == true) {
	typetemp = request.getParameter("type");
	if(typetemp == null || typetemp.isEmpty()) {
		response.sendRedirect("index.jsp");
		allowAdvance = false;
	}
	
	type = Boolean.parseBoolean(typetemp);
	
	}
	
	if (allowAdvance == true) {
		
		if(type == true) {
			com.server.DataBase.updateBookingStatus(token, "Attended");
		} else {
			com.server.DataBase.updateBookingStatus(token, "Unattended");
		}
		
	}
	response.sendRedirect("index.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Redirect</title>
</head>
<body>

</body>
</html>