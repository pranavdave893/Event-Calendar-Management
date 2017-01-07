<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<form action="Activity.jsp" method="post">
<input type="hidden" name="table" value="Events">
<input type="hidden" name="method" value="add">
<input type="hidden" name="username" value="<%=ID%>">
<table>
	<tr>
		<td>Mail ID: </td>
		<td><input type="text" name="email"></td>
	</tr>
	<tr>
		<td>Enter Event Name: </td>
		<td><input type="text" name="eventname"></td>
	</tr>
	<tr id="events">
		<td>Enter Date: </td>
		<td><input type="date" name="eventdate" onblur="getEvents(this)" placeholder="yyyy/mm/dd"></td>
	</tr>
	<tr>
		<td>Event Type: </td>
		<td><select name="eventType">
			<option>Select Event Type</option>
			<option value="Marriage">Marriage</option>
			<option value="Birthday">Birthday</option>
			<option value="Family Functions">Family Functions</option>
			<option value="Business Functions">Business Functions</option>
			</select></td>
	</tr>
	<tr>
		<td>Number of Peoples: </td>
		<td><input type="number" name="nopeople"></td>
	</tr>
	<tr>
		<td>Contact Number: </td>
		<td><input type="text" name="cno"></td>
	</tr>
	<tr>
		<td>Description: </td>
		<td><input type="text" name="description"></td>
	</tr>
	<tr>
		<td><input type="reset" value="Reset"></td>
		<td><input type="submit" value="Add Event"></td>
	</tr>
</table>
</form>

</body>
</html>