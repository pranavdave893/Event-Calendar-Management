<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.Calendar.NewModel"%>
<%@page import="com.vishal.java.model.ModelControl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page errorPage="Logout.jsp" %>


<%
if(request.getParameter("method").equals("find")){
  List<HashMap<String, Object>> obj = (List<HashMap<String, Object>>)ModelControl.control(request);
  if(!obj.isEmpty()){
  //ModelControl.controlDispatch(request, response, "Calendar", ModelControl.control(request).toString());
  	NewModel.startSession(request, response, "UserID",obj);
  	System.out.println(obj.get(0).values().toString());
  	int ID = Integer.parseInt(obj.get(0).values().toString().trim().substring(1, 2));
  	System.out.println(ID);
  	NewModel.controlResDispatch(request, response, "Calendar.jsp");
  }
  else{
    NewModel.controlResDispatch(request, response, "Login.html");
  }
}
%>



<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html> -->