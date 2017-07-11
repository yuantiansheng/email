<%@ page language="java" import="java.util.*,cn.edu.pdsu.bean.User" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User)session.getAttribute("userFindPassword"); 
if(user==null)
	 response.sendRedirect(basePath+"user/user_find_password1.jsp");
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
		padding-left: 10px;
		}
		.prompt{
		font-size:13px;
		padding-left: 50px;
		color: #ff6600
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
					<label class="gray" >共 3 步  当前第 2 步</label>
					</center>
				<hr/>
				<fieldset>
				<legend class="title">您可以选择通过以下方式找回密码:</legend>
				<a href="<%=basePath%>user/register!findPassword2.action?type=1" class="choice">密码提示问题: </a><br />
				 <label class="prompt">如果您曾经设置过密码提示问题和答案，只需回答对密码提示问题，即可设置新密码。</label><br /><br />
				 <a href="<%=basePath%>user/register!findPassword2.action?type=2" class="choice"> 密码查询邮箱:</a><br />
				 <label class="prompt">如果您已经使用过备用邮箱进行验证，可以使用此方式。</label><br /><label class="prompt">使用该方式将会向您的密码查询邮箱中发送一封包含新密码的邮件，同时您的密码也将会被重置为该新密码。</label><br />
				<br />
				<br />
				<div align="right">
				<label>如果你已经想起密码，请 </label><a href="<%=basePath%>" target="_self"> 登录</a>
				</div>
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
