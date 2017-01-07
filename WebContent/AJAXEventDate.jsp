<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.vishal.db.DBConnector"%>
<%@page import="com.vishal.java.model.ModelControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>




<%
if(request.getParameter("date") != null){
  String date = request.getParameter("date");
  Connection conn = DBConnector.getConnection("com.mysql.jdbc.Driver", "Clg_Project", "jdbc:mysql://localhost:3306/", "root", "root");
  String query = "select count(eventdate) from Events where eventdate = '" + date + "'";
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery(query);
  int i = 0;
  while(rs.next()){
    i = rs.getInt(1);
    System.out.println("ResultSets" + i);
  }
  if(i == 0){
    System.out.println("In IF");
%>
	<tr id="events">
		<td>Enter Date: </td>
		<td><input type="date" name="eventdate" onblur="getEvents(this)" value="<%=date%>"></td>
	</tr>
<%
  } else {
    System.out.println("In ELSE");
    %>
  	<tr id="events">
  		<td>Enter Date: </td>
  		<td><input type="date" name="eventdate" onblur="getEvents(this)" placeholder="yyyy/mm/dd"></td>
  		<td><label>Event Already Exists on this date</label></td>
  	</tr>
  <%
  }
  
}
%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

</body>
</html>