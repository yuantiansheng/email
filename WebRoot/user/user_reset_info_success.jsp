<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link type="text/css" rel="stylesheet" href="<%=basePath%>css/login.css" />
    <link type="text/css" rel="stylesheet" href="<%=basePath%>css/resetUserInfo.css" />
    <script type="text/javascript" src="<%=basePath%>js/user_reset_Info.js"></script>
  </head>
  <body>
  <div id="main" align="left">
  <h2 style="margin-top: 15px;">
	信息提示
  </h2>
		<div class="top">
			<input type="button" class="button" title="修改个人基本信息" value="修改个人基本信息" onclick="reset('<%=basePath %>','1')"/>
			<input type="button" class="button" title="修改密码" value="修改密码"  onclick="reset('<%=basePath %>','2')"/>
			<input type="button" class="button" title="修改密码查询问题" value="修改密码查询问题"  onclick="reset('<%=basePath %>','3')"/>
			<input type="button" class="button" title="修改密码查询邮箱" value="修改密码查询邮箱"  onclick="reset('<%=basePath %>','4')"/>&nbsp;
			<a href="javascript:window.history.back()">&lt;&lt;返回</a>
		</div>
  <h2 class="gray" align="center""><img alt="信息提示" src="<%=basePath%>/images/icon-info.gif">${message}</h2>
  </div>
  <br/>
  <br/>
  <br/>
  </body>
</html>
