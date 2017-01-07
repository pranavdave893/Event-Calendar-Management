<%@page import="com.vishal.db.DBConnector"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>

<%@ page import="com.Calendar.Month,java.io.*,java.sql.*,com.Calendar.*"%>
<%@ include file="CalendarCommon.jsp" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Calendar Month Print View</title>
<%
Enumeration<String> enumr = session.getAttributeNames();
if(enumr.hasMoreElements()){
	if(!session.getAttribute("UserID").equals(null) || session.getAttribute("UserID") != null){
	  String ID = session.getAttribute("UserID").toString();
	  System.out.println("UserID = "+ID);
	}
} else {
  response.sendRedirect("../EventCalendarPrj/");
}
%>
</head>
<body>

<div id="calendar_print_view_main_div">
<table border="1" cellspacing="0" cellpadding=4 width="100%" height="600" id="calendar_table">
  <tr>
    <td colspan="7" class="month_year_header" align="center">
     <h3><b><%=monthName%>, <%=intYear%></b></h3>
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
  {%>
    <tr>
    <%
    for( int j=0; j<7; j++ )
    {
    	Outside:
      if( days[i][j] == 0 )
      {%>
        <td class="empty_day_cell">&nbsp;</td>
      <%}
      else
      {
      for(int q = 0; q < listdate.size(); q++){
        		//System.out.println(d[q][0]+" == "+aMonth.getYear()+"\n"+(Integer.parseInt(d[q][1])-1)+" == "+aMonth.getMonth()+"\n"+Integer.parseInt(d[q][2])+" == "+days[i][j]);
        			if(Integer.parseInt(d[q][0]) == aMonth.getYear() && 
        					(Integer.parseInt(d[q][1])-1) == aMonth.getMonth() && 
        							Integer.parseInt(d[q][2]) == days[i][j]){
	        				if(fun[q].equals("Birthday")){
	        			          %><td class="day_cell" style="color: blue;" title="<%=fun[q]%>">
	        			          		<b><%=days[i][j]%></b>
	        			          	</td><%
	        			        		  //System.out.println("Blue");
	        			        		  break Outside;
	        				} else if(fun[q].equals("Marriage")){
	        				       %><td class="day_cell" style="color: red;" title="<%=fun[q]%>">
	        				       		<b><%=days[i][j]%></b>
	        				       	</td><%
	        				    		   //System.out.println("red");
	        				    		   break Outside;
	        				} else if(fun[q].equals("Family Functions")){
	        				       %><td class="day_cell" style="color: green;" title="<%=fun[q]%>">
	        				       		<b><%=days[i][j]%></b>
	        				       	</td><%
	        				    		   //System.out.println("green");
	        				    		   break Outside;
	        				} else if(fun[q].equals("Business Functions")){
	        				       %><td class="day_cell" style="color: brown;" title="<%=fun[q]%>">
	        				       		<b><%=days[i][j]%></b>
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
    } // end for %>
    </tr>
  <%}
}
%>
</table>
</div>


</body>
</html>