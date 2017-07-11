<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>出错了！</title>
  </head>
  <body>
    <center>
    <a href="<%=basePath%>"> <img alt="500错误" src="images/500.jpg"></a>
    </center>
  </body>
</html>
