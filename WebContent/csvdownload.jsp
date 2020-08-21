<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, java.io.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%

	String type = request.getParameter("type");
	if(type.equals("all")) {
		String returnType = com.server.csv.downloadAll();
		out.print(returnType);
	} else if(type.equals("single")) {
		String IDtemp = request.getParameter("ID");
		int ID = Integer.parseInt(IDtemp);
		String returnType = com.server.csv.downloadOffice(ID);
		out.print(returnType);
	}

%>
</body>
</html>