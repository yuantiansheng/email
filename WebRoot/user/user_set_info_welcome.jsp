<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link  href="<%=basePath %>css/linkman_welcome.css" type="text/css" rel="stylesheet"/>
	</head>
	<body>
			<div class="main bottom">
				<h2>
					修改个人信息
				</h2>
				<span class="font_color">“修改个人信息”包括修改自己的基本信息、修改密码、修改密码查询问题和修改密码查询邮箱。</span>
				<br />
				<br />
				<hr color="#99B1C4" />
				<div class="hb">
					<div class="fx">
						<b class="dE set_userInfo"></b>
						<p class="dR">
							<a id="_js4_link_1183_2809"
								href="<%=basePath %>user/changeInfo!changeInfo.action" >修改个人基本信息</a>
						</p>
						<p class="dS">
							通过该选项你可以修改自己的昵称、性别、手机号、家庭地址和备注信息
						</p>
					</div>
					<div class="fx">
						<b class="dE set_password"></b>
						<p class="dR">
							<a id="_js4_link_1183_2809"
								href="<%=basePath %>user/user_reset_password.jsp">修改密码</a>
						</p>
						<p class="dS">
							通过回答密码查询问题答案或者选择密码查询邮箱的方式修改密码
						</p>
					</div>
					<div class="fx">
						<b class="dE set_question"></b>
						<p class="dR">
							<a id="_js4_link_1183_2809"
								href="<%=basePath %>user/changeInfo!changeQuestion.action">修改密码查询问题</a>
						</p>
						<p class="dS">
							正确的回答安全问题，才可以重新设置安全问题和安全问题答案
						</p>
					</div>
					<div class="fx">
						<b class="dE set_email"></b>
						<p class="dR">
							<a id="_js4_link_1183_2809"
								href="<%=basePath %>user/changeInfo!findPwdEmail.action"">修改密码查询邮箱</a>
						</p>
						<p class="dS">
							输入登录时的密码就可以修改密码查询邮箱
						</p>
					</div>
				</div>
			</div> 
	<br /><br /><br />
	</body>
</html>

