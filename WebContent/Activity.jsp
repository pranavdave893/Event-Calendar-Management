<%@page import="com.Calendar.NewModel"%>
<%@page import="com.vishal.model.ModelLibrary"%>
<%@page import="com.vishal.java.model.ModelControl"%>
<%@page import="com.vishal.java.model.Model"%>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> --%>

<%
if(request.getParameter("method").equals("add") || request.getParameter("method").equals("update") || request.getParameter("method").equals("delete")){
  ModelControl.control(request, response, "Calendar", "Logout");
}
if(request.getParameter("method").equals("find")){
  Object obj = ModelControl.control(request);
  //ModelControl.controlDispatch(request, response, "Calendar", ModelControl.control(request).toString());
  NewModel.controlResDispatch(request, response, "Calendar");
}
%>


<!-- 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html> -->