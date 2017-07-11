<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="user_is_login.jsp" %>

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
		color: black;
		}
		.choice{
		color: #005590;
		font-size:18px;
		padding-left: 10px;
		}
		.prompt{
		font-size:13px;
		padding-left: 50px;
		color: #686868
		}
		</style>
  </head>
    <body>
			<div align="left" class="setinfo">
				<h2 align="left" style="color: black;">
					修改个人信息</h2>
				<fieldset>
				<legend class="title">请选择要修改的内容:</legend>
				<br />
				<a href="<%=basePath%>user/changeInfo!changeInfo.action" class="choice">修改个人基本信息: </a><br />
				 <label class="prompt">通过该选项你可以修改自己的昵称、性别、手机号、家庭地址和备注信息。</label><br /><br />
				 <a href="<%=basePath%>user/user_reset_password.jsp" class="choice"> 修改密码:</a><br />
				 <label class="prompt">你可以通过回答密码查询问题答案或者选择密码查询邮箱的方式修改密码。</label><br /><br />
				 <a href="<%=basePath%>user/changeInfo!changeQuestion.action" class="choice"> 修改密码查询问题:</a><br />
				 <label class="prompt">需要输入注册时的密码查询问题答案。</label><br /><br />
				 <a href="<%=basePath%>user/changeInfo!findPwdEmail.action" class="choice"> 修改密码查询邮箱:</a><br />
				 <label class="prompt">需要输入正确的登录密码。</label><br />
				<br />
				</fieldset>
			</div>
			<br /><br /><br />
  </body>
</html>
