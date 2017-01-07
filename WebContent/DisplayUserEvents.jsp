<%@page import="com.Calendar.NewModel"%>
<%@page import="com.vishal.java.model.ModelControl"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Events</title>
</head>
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
<body>
<table border="1">
	<tr>
		<th>EMail</th>
		<th>Event Name</th>
		<th>Event Date</th>
		<th>Event Type</th>
		<th>No of People</th>
		<th>Contact No</th>
		<th>Description</th>
		<th>Update Events</th>
		<th>Delete Events</th>
	</tr>
<%
List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)ModelControl.control(request);
System.out.println(list.toString() +"  "+list.size());
int i = 0;
while(i < list.size()){
	HashMap<String, Object> obj = list.get(i);
	System.out.println(obj.toString());
	i++;
	session.setAttribute("EventID", obj.get("Event_Id"));
%>
	<tr>
		<td><%= obj.get("email") %></td>
		<td><%= obj.get("eventname") %></td>
		<td><%= obj.get("eventdate") %></td>
		<td><%= obj.get("eventType") %></td>
		<td><%= obj.get("nopeople") %></td>
		<td><%= obj.get("cno") %></td>
		<td><%= obj.get("description") %></td>
		<%System.out.println(obj.get("Event_Id")); %>
		<td>
			<form action="Updateevent.jsp" method="post">
			  <input type="hidden" name="table" value="Events">
			  <input type="hidden" name="method" value="find">
			  <input type="hidden" name="fields" value="username">
			  <input type="hidden" name="fields" value="email">
			  <input type="hidden" name="fields" value="eventname">
			  <input type="hidden" name="fields" value="eventdate">
			  <input type="hidden" name="fields" value="eventType">
			  <input type="hidden" name="fields" value="nopeople">
			  <input type="hidden" name="fields" value="cno">
			  <input type="hidden" name="fields" value="description">
			  <input type="hidden" name="Event_Id" value="<%=obj.get("Event_Id")%>">
			  <input type="hidden" name="where" value="Event_Id">
			  <input type="submit" value="Update Event" style="border: none; font-size: medium; font-family: serif;">
			</form>
		</td>
		<td>
			<form action="Activity.jsp" method="post">
			  <input type="hidden" name="table" value="Events">
			  <input type="hidden" name="method" value="delete">
			  <!-- <input type="hidden" name="fields" value="username">
			  <input type="hidden" name="fields" value="email">
			  <input type="hidden" name="fields" value="eventname">
			  <input type="hidden" name="fields" value="eventdate">
			  <input type="hidden" name="fields" value="eventType">
			  <input type="hidden" name="fields" value="nopeople">
			  <input type="hidden" name="fields" value="cno">
			  <input type="hidden" name="fields" value="description"> -->
			  <input type="hidden" name="Event_Id" value="<%=obj.get("Event_Id")%>">
			  <input type="hidden" name="where" value="Event_Id">
			  <input type="submit" value="Delete Event" style="border: none; font-size: medium; font-family: serif;">
			</form>
		</td>
	</tr>
<%
}
%>
</table>
</body>
</html>