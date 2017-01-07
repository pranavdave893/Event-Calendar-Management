<%@page import="java.util.Enumeration"%>
<%@page import="com.vishal.java.model.ModelControl"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update User Details</title>
</head>
<body>
<%
Enumeration<String> enumr = session.getAttributeNames();
String ID = null;
if(enumr.hasMoreElements()){
	if(!session.getAttribute("UserID").equals(null) || session.getAttribute("UserID") != null){
	  ID = session.getAttribute("UserID").toString();
	  System.out.println("UserID = "+ID);
	}
} else {
  response.sendRedirect("../EventCalendarPrj/");
}
%>

<%

  List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)ModelControl.control(request);
//System.out.println("Object : "+list.toString());
%>
<div style="float: right;"><a href="Logout.jsp">Logout </a></div>
<form action="Activity.jsp" method="post">
<input type="hidden" name="table" value="User_Registration">
<input type="hidden" name="method" value="update">
<table>
<%
	HashMap<String, Object> obj = list.get(0);
	System.out.println(obj.toString());
%>
	<tr>
		<td>Enter Username: </td>
		<td><input type="text" name="username" value="<%= obj.get("username") %>"></td>
	</tr>
	<tr>
		<td>Enter Password: </td>
		<td><input type="text" name="password" value="<%= obj.get("password") %>"></td>
	</tr>
	<tr>
		<td>Mail ID: </td>
		<td><input type="text" name="email" value="<%= obj.get("email") %>"></td>
	</tr>
	<tr>
		<td>Contact No: </td>
		<td><input type="number" name="cno" value="<%= obj.get("cno") %>"></td>
	</tr>
	<tr>
		<td>Address: </td>
		<td><input type="text" name="address" value="<%= obj.get("address") %>"></td>
	</tr>
	<tr>
		<td>Age: </td>
		<td><input type="number" name="age" value="<%= obj.get("age") %>"></td>
	</tr>
	<tr>
		<input type="hidden" name="UserID" value="<%=ID%>">
  		<input type="hidden" name="where" value="UserID">
		<td><input type="reset" value="Reset"></td>
		<td><input type="submit" value="Update"></td>
	</tr>
</table>
</form>
</body>
</html>