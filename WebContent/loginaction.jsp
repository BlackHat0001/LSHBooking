<%-- 
    Document   : loginaction
    Created on : 5 Jun 2020, 15:37:01
    Author     : danma
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,com.server.*" %>
<% 
	boolean allowAdvance = true;
    String email = request.getParameter("email"); 
    String password = request.getParameter("password"); 
    String returnType = "";
    
    try {
        returnType = login.loginPerform(email, password);
    } catch (Exception e) {
        returnType = e.toString();
    }
    if(returnType.equals("invalidEmail")) {
    	response.sendRedirect("login.jsp?login=invalid");
    	allowAdvance = false;
    }
    if(returnType.equals("tempUser")) {
    	response.sendRedirect("login.jsp?login=tempUserException");
    	allowAdvance = false;
    }
    if(allowAdvance == true) {
    User tempUser = com.server.DataBase.queryUserAccount(email);
    String username = tempUser.getName();
    int userID = tempUser.getUserId();
    long phonenum = tempUser.getPhonenum();
    if(returnType.equals("correctDetails")) {
        session.setAttribute("loggedin", "true");
        session.setAttribute("username", username);
        session.setAttribute("userID", userID);
        session.setAttribute("email", email);
        session.setAttribute("phonenum", phonenum);
        session.setAttribute("admin", "false");
        response.sendRedirect("index.jsp");
    } else if (returnType.equals("adminAccount")){
    	session.setAttribute("loggedin", "true");
        session.setAttribute("username", username);
        session.setAttribute("userID", userID);
        session.setAttribute("email", email);
        session.setAttribute("phonenum", phonenum);
        session.setAttribute("admin", "true");
        response.sendRedirect("index.jsp");
    } else {
        response.sendRedirect("login.jsp?login=invalid");
    }
    }
    

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
        <h1>Redirecting please wait</h1>
    </body>
</html>
