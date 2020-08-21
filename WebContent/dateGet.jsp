<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<body>
<% 
String officeName = request.getParameter("officeName");
String date = request.getParameter("date");
String returnType = com.server.loadData.timeSelection(officeName, date);
out.print(returnType);
%>

</body>
</html>