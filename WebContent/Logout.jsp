<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Logout Page</title>
</head>
<body>
<%
Enumeration<String> enumr = session.getAttributeNames();
System.out.print("Session Attributes : ");
String e = null;
while(enumr.hasMoreElements()){
  e = enumr.nextElement();
  System.out.print(e + " ");
  session.removeAttribute(e);
  //response.sendRedirect("Login.html");
}
System.out.println();
session.invalidate();

%>
<div><h4>You are logged out...</h4></div>
<div><a href="../EventCalendarPrj/">Click Here</a> to Login Again</div>
</body>
</html>