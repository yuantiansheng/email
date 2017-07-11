<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<base href="<%=basePath%>"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>米林邮箱通行证-找回密码</title>
		<link type="text/css" rel="stylesheet" href="<%=basePath%>css/login.css" />
		<style type="text/css">
		.title{
		font-size: 20px;
		}
		.choice{
		color: #ff6600;
		font-size:18px;
		}
		.prompt{
		font-size:18px;
		}
		.left{
		padding-left: 50px;
		}
		</style>
  </head>
    <body>
  <div id="color">
			<div align="center">
				<!--标题部分-->
				<iframe width=1003 height=130 marginwidth=0 marginheight=0
					frameborder=0 scrolling=no
					src="<%=basePath%>top.html"></iframe>
			</div>
			<div id="main" align="left">
				<h2 align="left">
					找回密码</h2>
					<center>
					<label class="gray" >共 3 步  当前第 3 步</label>
					</center>
				<hr/>
				<fieldset>
				<legend class="title">密码重置邮件已发送</legend>
				<br />
				 <label class="prompt left gray">我们已将新的密码发送到</label>
				 <label class="choice"><s:property  value="user.pwdEmail"/></label>
				 <label class="prompt gray">邮箱，请注意查收。</label><br />
			     <br />
				 <label class="prompt left gray">现在您可以使用新的密码</label>
				 <a href="<%=basePath%>" target="_self" style="color: #ff6600;font-size:19px;">登录</a>
				<label class="prompt gray"> 邮箱了！</label><br />
				<br />
				<br />
				</fieldset>
				<div>
					<iframe style="margin-top: 5px" width=770 height=154 marginwidth=0
						marginheight=0 frameborder=0 scrolling=no
						src="<%=basePath%>bottom.html"></iframe>
				</div>
			</div>
		</div>


  </body>
</html>
