<%@page import="com.vishal.db.DBConnector"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>

<%@ page import="com.Calendar.Month,java.io.*,java.sql.*,com.Calendar.*" %>
<%@ include file="CalendarCommon.jsp" %>
<%@ page errorPage="Logout.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Calendar</title>
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
</head>
<body>
<div style="float: right; "><a href="Logout.jsp">Logout</a></div>
<!-- <div style="float: right; ">&nbsp;|&nbsp;<a href="InsertEvent.jsp">Insert an Event Here</a></div> -->
<div style="float: right; "><form action="UpdateUser.jsp" method="post">
  <input type="hidden" name="table" value="User_Registration">
  <input type="hidden" name="method" value="find">
  <input type="hidden" name="fields" value="username">
  <input type="hidden" name="fields" value="password">
  <input type="hidden" name="fields" value="email">
  <input type="hidden" name="fields" value="cno">
  <input type="hidden" name="fields" value="address">
  <input type="hidden" name="fields" value="age">
  <input type="hidden" name="UserID" value="<%=ID%>">
  <input type="hidden" name="where" value="UserID">
  <input type="submit" value="Update Details Here" style="border: none; font-size: medium; font-family: serif;">
</form>&nbsp;</div>
<div style="float: right; "><form action="DisplayUserEvents.jsp" method="post">
  <input type="hidden" name="table" value="Events">
  <input type="hidden" name="method" value="find">
  <input type="hidden" name="fields" value="Event_Id">
  <input type="hidden" name="fields" value="eventname">
  <input type="hidden" name="fields" value="email">
  <input type="hidden" name="fields" value="eventdate">
  <input type="hidden" name="fields" value="eventType">
  <input type="hidden" name="fields" value="cno">
  <input type="hidden" name="fields" value="description">
  <input type="hidden" name="fields" value="nopeople">
  <input type="hidden" name="username" value="<%=ID%>">
  <input type="hidden" name="where" value="username">
  <input type="submit" value="View all events" style="border: none; font-size: medium; font-family: serif;">
</form></div>
<div style="float: right; ">
<a href="InsertEvent.jsp">Insert Event</a></div>



<div id="calendar_main_div">
<table border="1" cellspacing="0" cellpadding="4" id="calendar_table">
  <tr>
    <td width="100%" colspan="7" class="month_year_header">
      <%=monthName%>, <%=intYear%>
    </td>
  </tr>
  <tr class="week_header_row">
    <th width="14%" class="th_day_cell day">Sun</th>
    <th width="14%" class="th_day_cell day">Mon</th>
    <th width="14%" class="th_day_cell day">Tue</th>
    <th width="14%" class="th_day_cell day">Wed</th>
    <th width="14%" class="th_day_cell day">Thu</th>
    <th width="15%" class="th_day_cell day">Fri</th>
    <th width="15%" class="th_day_cell day">Sat</th>
  </tr>
<%
Connection conn = DBConnector.getConnection("com.mysql.jdbc.Driver", "Clg_Project", "jdbc:mysql://localhost:3306/", "root", "root");
ArrayList<String> listdate = new ArrayList<String>();
ArrayList<String> list = new ArrayList<String>();
if(conn == null)
	System.out.println("Connection Error");
else{
	String str = "select eventdate,eventType from Events";
	try{
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(str);
		int q = 0;
		while(rs.next()){
		  System.out.println("ResultSet : " + rs.getString(1) + " " + rs.getString(2));
			listdate.add(rs.getString(1));
			list.add(rs.getString(2));
		}
		conn.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
System.out.println("<><><>"+listdate.size());
String fun[] = new String[listdate.size()];
String[][] d = new String[listdate.size()][3];
for(int i = 0;i < listdate.size(); i++){
	d[i] = listdate.get(i).split("/");//2015-12-10
	fun[i] = list.get(i);
	for(int j = 0; j < 3; j++){
		System.out.print(d[i][j]+" ");
	}
	System.out.println();
}

{
  Month aMonth = Month.getMonth( Integer.parseInt(currentMonthString), Integer.parseInt(currentYearString) );
  //System.out.println(currentMonthString+"  >>  "+currentYearString);
  int [][] days = aMonth.getDays();
  for( int i=0; i<aMonth.getNumberOfWeeks(); i++ )
  {
    %><tr class="week_data_row"><%
    for( int j=0; j<7; j++ )
    {
    	Outside:
      if( days[i][j] == 0 )
      {
        %><td class="empty_day_cell">&nbsp;</td><%
      }
      else
      {
        // this is "today"
        if( currentDayInt == days[i][j] && currentMonthInt == aMonth.getMonth() && currentYearInt == aMonth.getYear() )
        {
          %><td class="today_cell"><%=days[i][j]%></td><%
        }
        else
        {
        	for(int q = 0; q < listdate.size(); q++){
        		//System.out.println(d[q][0]+" == "+aMonth.getYear()+"\n"+(Integer.parseInt(d[q][1])-1)+" == "+aMonth.getMonth()+"\n"+Integer.parseInt(d[q][2])+" == "+days[i][j]);
        			if(Integer.parseInt(d[q][0]) == aMonth.getYear() && 
        					(Integer.parseInt(d[q][1])-1) == aMonth.getMonth() && 
        							Integer.parseInt(d[q][2]) == days[i][j]){
	        				if(fun[q].equals("Birthday")){
	        			          %><td class="day_cell" style="color: blue;" title="<%=fun[q]%>"><b><%=days[i][j]%></b>
	        			          	</td><%
	        			        		  //System.out.println("Blue");
	        			        		  break Outside;
	        				} else if(fun[q].equals("Marriage")){
	        				       %><td class="day_cell" style="color: red;" title="<%=fun[q]%>"><b><%=days[i][j]%></b>
									</td><%
	        				    		   //System.out.println("red");
	        				    		   break Outside;
	        				} else if(fun[q].equals("Family Functions")){
	        				       %><td class="day_cell" style="color: green;" title="<%=fun[q]%>"><b><%=days[i][j]%></b>
									</td><%
	        				    		   //System.out.println("green");
	        				    		   break Outside;
	        				} else if(fun[q].equals("Business Functions")){
	        				       %><td class="day_cell" style="color: brown;" title="<%=fun[q]%>"><b><%=days[i][j]%></b>
									</td><%
	        				    		   //System.out.println("Brown");
	        				    		   break Outside;
	        				} else {
          						  %><td class="day_cell"><%=days[i][j]%></td><%
          								//System.out.println("none");
          								break Outside;
	        			    }
        			}
        			if(q == listdate.size()-1){
        				%><td class="day_cell"><%=days[i][j]%></td><%
        			}
        	}
        }
      } // end outer if
    } // end for
    %>
    </tr>
  <%}
}
%>
</table>

<%-- end of "calendar_div" --%>
</div>

<!-- navigation links -->
<%-- sorry, i don't know how to get this look without a table --%>
<table id="calendar_nav_table" border="0">
  <tr>
    <td id="prev_link">
      <form method="post">
        <input type="submit" name="PREV" value=" << " style="font-size: medium; font-family: serif;">
        <input type="hidden" name="month" value="<%=prevMonth%>">
        <input type="hidden" name="year" value="<%=prevYear%>">
      </form>
    </td>
    <td id="link_to_month_view">
      <form action="CalendarMonthPrintView.jsp" method="post">
        <input type="submit" value="  Full-Screen Print View  " class="submit_button" style="font-size: medium; font-family: serif;">
        <input type="hidden" name="month" value="<%=intMonth%>">
        <input type="hidden" name="year"  value="<%=intYear%>">
      </form>
    </td>
    <td id="next_link">
      <form method="post">
        <input type="submit" name="NEXT" value=" >> " style="font-size: medium; font-family: serif;">
        <input type="hidden" name="month" value="<%=nextMonth%>">
        <input type="hidden" name="year" value="<%=nextYear%>">
      </form>
    </td>
  </tr>
</table>
</body>
</html>