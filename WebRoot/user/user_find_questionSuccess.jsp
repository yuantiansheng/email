<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>密码修改成功</title>
		<script type="text/javascript"
			src="<%=basePath%>js/jquery-1.6.2.min.js"></script>
		<script type="text/javascript">
    var i = 5;
    $().ready(function (){
    	timer();
    });
    function timer(){
    	window.setTimeout("timer()", 1000); 
        i--;
        if(i>0){
        	$("#second").text(i);
		} else {
			 window.location.href="<%=basePath%>";
			 i = 5;
		}
	}
</script>
		<style type="text/css">
#second {
	color: red;
	font-size: 20px;
	padding-left: 5px;
	padding-right: 5px;
}
#message {
	color: #437ca0;
}
a:link,a:visited {
	color: red;
	text-decoration: none
}
a:hover {
	text-decoration: underline;
}
a {
	font-size: 20px
}
</style>
	</head>
	<body>
		<center>
			<h2>
				你的密码已修改成功!
			</h2>
			<label id="message">非常感谢你使用LJG邮箱,本页面将在</label><label id="second">5</label><label id="message">秒后跳转到邮箱登录页面。</label>
			<br />
			<label id="message">如果不能自动跳转，请点击</label><a href="" id="a">登录 </a>
		</center>
	</body>
</html>
