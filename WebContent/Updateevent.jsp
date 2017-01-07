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
<title>Update Event</title>
</head>
<script>

function getEvents(str)
{
	if (window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	} else {
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	alert(str.value);

	xmlhttp.open("POST","AJAXEventDate.jsp?date=" +str.value,true);
	xmlhttp.send();
	xmlhttp.onreadystatechange = function() {
		//alert("current state "+xmlhttp.readyState);
		if (xmlhttp.readyState == 4) {
			//alert(xmlhttp.responseText.trim());
			document.getElementById("events").innerHTML = xmlhttp.responseText;
		}
	}
}

</script>
<body>
<%
Enumeration<String> enumr = session.getAttributeNames();
String ID = null, EventID = null;
if(enumr.hasMoreElements()){
	if(!session.getAttribute("UserID").equals(null) || session.getAttribute("UserID") != null){
	  ID = session.getAttribute("UserID").toString();
	  EventID = session.getAttribute("EventID").toString();
	  System.out.println("UserID = " + ID + " EventID = " + EventID);
	}
} else {
  response.sendRedirect("../Project/");
}
%>
<%

  List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)ModelControl.control(request);
//System.out.println("Object : "+list.toString());
%>
<div style="float: right;"><a href="Logout.jsp">Logout </a></div>
<form action="Activity.jsp" method="post">
<input type="hidden" name="table" value="Events">
<input type="hidden" name="method" value="update">
<table>
<%
	HashMap<String, Object> obj = list.get(0);
	System.out.println(obj.toString());
%>

		<input type="hidden" name="username" value="<%= obj.get("username") %>">
	
	<tr>
		<td>Mail ID: </td>
		<td><input type="text" name="email" value="<%= obj.get("email") %>"></td>
	</tr>
	<tr>
		<td>Event Name</td>
		<td><input type="text" name="eventname" value="<%= obj.get("eventname") %>"></td>
	</tr>
	<tr id="events">
		<td>Event Date</td>
		<td><input type="date" name="eventdate" value="<%= obj.get("eventdate") %>" onblur="getEvents(this)"></td>
	</tr>
	<tr>
		<td>eventType</td>
		<td><select name="eventType">
			<option value="<%= obj.get("eventType") %>"><%= obj.get("eventType") %></option>
		<%if(obj.get("eventType").equals("Marriage")){ %>
			<option value="Birthday">Birthday</option>
			<option value="Family Functions">Family Functions</option>
			<option value="Business Functions">Business Functions</option>
		<%}else if(obj.get("eventType").equals("Birthday")){ %>
			<option value="Marriage">Marriage</option>
			<option value="Family Functions">Family Functions</option>
			<option value="Business Functions">Business Functions</option>
		<%}else if(obj.get("eventType").equals("Family Functions")){ %>
			<option value="Marriage">Marriage</option>
			<option value="Birthday">Birthday</option>
			<option value="Business Functions">Business Functions</option>
		<%}else if(obj.get("eventType").equals("Business Functions")){ %>
			<option value="Marriage">Marriage</option>
			<option value="Birthday">Birthday</option>
			<option value="Family Functions">Family Functions</option>
		<%} else {%>
			<option value="Marriage">Marriage</option>
			<option value="Birthday">Birthday</option>
			<option value="Family Functions">Family Functions</option>
			<option value="Business Functions">Business Functions</option>
		<%} %>
			</select></td>
		
	</tr>
	<tr>
		<td>Number of People</td>
		<td><input type="number" name="nopeople" value="<%= obj.get("nopeople") %>"></td>
	<tr>
	<tr>
		<td>Contact Number</td>
		<td><input type="text" name="cno" value="<%= obj.get("cno") %>"></td>
	<tr>
	<tr>
		<td>Description</td>
		<td><input type="text" name="description" value="<%= obj.get("description") %>"></td>
	<tr>
		<td>
		<input type="hidden" name="Event_Id" value="<%=EventID%>">
  		<input type="hidden" name="where" value="Event_Id"></td>
		<td><input type="submit" value="Update"></td>
	</tr>
</table>


</body>
</html>