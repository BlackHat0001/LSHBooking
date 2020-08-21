<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*, com.server.*" %>
<%

	session.setAttribute("loggedin", "false");
	session.setAttribute("username", "");
	session.setAttribute("userID", 0);
	session.setAttribute("email", "");
	session.setAttribute("phonenum", 0);
	response.sendRedirect("index.jsp");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>