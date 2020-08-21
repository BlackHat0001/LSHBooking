<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*" %>
<%
	String email = (String)session.getAttribute("email");
	String name = "";
	long phonenum = 0;
	String pw = "";
	String pwconfirm = "";
	name = request.getParameter("name");
	if (!(request.getParameter("phonenum") == null || request.getParameter("phonenum") == "")) {
		phonenum = Long.parseLong(request.getParameter("phonenum"));
	}
	pw = request.getParameter("password");
	pwconfirm = request.getParameter("passwordConfirm");
	boolean updateName = true;
	boolean updatePhonenum = true;
	boolean updatePassword = true;
	try{
	if(name == null || name.equals("") || name.equals("null")) {
		updateName = false;
	} else {
		session.setAttribute("username", name);
	}
	if(phonenum == 0) {
		updatePhonenum = false;
	} else {
		session.setAttribute("phonenum", phonenum);
	}
	if(pw == null || pw.equals("") || pw.equals("null")) {
		updatePassword = false;
	} else {
		if(!(pw.equals(pwconfirm))) {
			response.sendRedirect("account.jsp?error=pwmatch");
		}
	}
	} catch (Exception e) {}
	com.server.DataBase.editUserAccount(email, pw, name, phonenum, updatePassword, updateName, updatePhonenum);
	response.sendRedirect("account.jsp?error=success");
	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Redirecting please wait</title>
</head>
<body>
<a>Sorry, This feature is still under construction</a>
</body>
</html>