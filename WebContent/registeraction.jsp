<%-- 
    Document   : registeraction
    Created on : 5 Jun 2020, 20:18:28
    Author     : danma
--%>

<%@page import="com.server.DataBase"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.Pattern, java.util.regex.Matcher" %>
<% 
	boolean allowAdvance = true;
    String email = request.getParameter("email"); 
    String password = request.getParameter("password"); 
    String passwordConfirm = request.getParameter("passwordconfirm");
    String firstname = request.getParameter("firstname");
    String surname = request.getParameter("surname");
    String phonenumtemp = request.getParameter("phonenum");
    System.out.println(password + "" + passwordConfirm);
    String name = firstname + " " + surname;
    String returnType = "";
    String error = "";
    Pattern regExPattern = Pattern.compile("^[\\w-\\._\\+%]+@(lsh.co.uk|lsh.com)");
    Matcher matcher = regExPattern.matcher(email);
    if(!(matcher.matches())) {
    	error = "email";
    	allowAdvance = false;
    }
    long phonenum = 0;
    if(!(password.equals(passwordConfirm))) {
    	error = "passwordMatch";
    	allowAdvance = false;
    }
    if(allowAdvance == true) {
   		try{
   			phonenum = Long.parseLong(phonenumtemp);
           returnType = com.server.login.createAccount(email, password, name, phonenum); 
        } catch (Exception e) {
        }
    }
    if(returnType.equals("accCreateComplete")) {
        session.setAttribute("loggedin", "true");
        session.setAttribute("username", name);
        session.setAttribute("userID", com.server.DataBase.queryUserAccount(email).getUserId());
        session.setAttribute("email", email);
        session.setAttribute("phonenum", phonenum);
        response.sendRedirect("index.jsp");
    } else {
    	if(error.equals("")) {
    		error = returnType;
    	}
        response.sendRedirect("register.jsp?error="+error);
    }
    

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
