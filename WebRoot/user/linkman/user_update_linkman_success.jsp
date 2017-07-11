<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<link  href="<%=basePath %>css/linkman_welcome.css" type="text/css" rel="stylesheet"/>
		<base href="<%=basePath%>">
		<style type="text/css">
a:link, a:visited {
color: #437CA0;
text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
</style>
	</head>
	<body>
	<div class="main">
		<div class="top">
			<input type="button" class="add_button" title="新建联系人分组" value="新建联系人分组" onclick="javascript:window.location.href='<%=basePath%>user/linkman/user_add_group.jsp'"/>
			<input type="button" class="add_button" title="新建联系人" value="新建联系人" onclick="javascript:window.location.href='<%=basePath%>user/linkman!addLinkmanSkip.action'"/>
			<a href="javascript:window.history.back()">&lt;&lt;返回</a>
		</div>
			<h2  align="center" class="gray">
				<img alt="信息提示" src="<%=basePath %>images/icon-info.gif">
				更新联系人信息成功!
			</h2>
	</div>
			<br />
		   
	</body>
</html>