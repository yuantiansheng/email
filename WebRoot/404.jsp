<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>错误了！</title>
  </head>
  
  <body>
    <center>
    <a href="<%=basePath%>"><img alt="网页找不到！" src="images/404.jpg"></a>
    </center>
  </body>
</html>
