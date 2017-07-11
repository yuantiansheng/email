<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>欢迎登录LJG邮箱</title>
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>css/login.css" />
		<script type="text/javascript"
			src="<%=basePath%>js/jquery-1.6.2.min.js">
	
</script>
		<script type="text/javascript"
			src="<%=basePath%>js/jquery.validate.min.js">
	
</script>
		<script type="text/javascript">
	$(function() {
		$("li").focusin(function() {
			$(this).find("input").addClass("on-focus");
			$("#errDiv").empty();
		});
		$("li").focusout(function() {
			$(this).find("input").removeClass("on-focus");
		});
	});
</script>
		<!--数据有效性校验-->
		<script type="text/javascript">
	$().ready(function() {
		$("#loginForm").validate({
			submitHandler : function(form) { //表单提交句柄,为一回调函数，带一个参数：form     
				form.submit(); //  提交表单   
			},
			errorPlacement : function(error, element) { //验证消息放置的地方
				error.appendTo(element.parent("li").next("li"));
			},

			rules : { //定义验证规则,其中属性名为表单的name属性   
				username : {
					required : true
				},
				password : {
					required : true
				}
			},
			messages : { //自定义验证消息   
				username : {
					required : "用户名是必需的！"
				},
				password : {
					required : "密码是必需的！"
				}
			}
		});
	});
</script>
		<style type="text/css">
ul,ol,li,span,form {
	margin: 0;
	padding: 0;
	border: 0;
	z-index: inherit
}
#content {
	height: 300px;
	margin-top: 10px
}

#content .left {
	width: 339px;
	float: left;
}

#content .left ol {
	clear: both;
	color: #a6a9ad;
}

#content .left li {
	line-height: 30px;
	text-indent: 10px;
}

#content .left ol span {
	font-size: 14px;
	font-weight: bold;
	color: #6699ba;
	margin-right: 8px;
}

#content .right {
	width: 421px;
	height: 310px;
	background: url(<%=basePath%>images/bg-login.jpg)
		no-repeat;
	float: left
}

.right ul {
	color: #4c4c4c;
	margin: 15px 0 0 35px;
	font-size: 14px;
}

.right ul li {
	margin-bottom: 2px;
}

#content .right .now {
	margin: 2px 0 0 190px;
}

#content .right .wrong {
	color: #FF0000;
	margin: 0 0 5px 47px;
	font-size: 12px;
}

.wid {
	width: 183px;
	margin-right: 8px;
}
 /*输入框宽度*/
.pw {
	font-size: 12px;
}  
/*忘记密码*/
a.pw:link,a.pw:visited {
	color: #437ca0;
	text-decoration: underline
}

a.pw:hover {
	text-decoration: none;
}

.mar {
	margin: 5px 0 0 50px
}
#errDiv{
width: 300px;
height: 25px
}
#errDiv  .error{
margin: 0 0 5px 85px;
list-style: none;
color: #FF0000;
font-size: 12px;
}
#title{
   margin: 5px 0 0 2px;
   font-size: 25px;
   width: 300px;
}
</style>
	</head>
	<body>
		<div>
			<div align="center">
				<!--标题部分-->
				<iframe width=1003 height=130 marginwidth=0 marginheight=0
					frameborder=0 scrolling=no
					src="<%=basePath%>top.html"></iframe>
			</div>
			<div id="main">
				<!-- 正文部分-->
				<div id="content">
					<!--左边 -->
					<div class="left">
						<img src="<%=basePath%>images/email-login.png"
							style="margin-top: 5px" />
						<ol>
							<li>
								<span>闪电般的速度</span>页面响应迅速
							</li>
							<li>
								<span>安全稳定的服务</span>国内一流服务品质
							</li>
							<li>
								<span>50M超大附件</span>目前国内最高的附件大小
							</li>
						</ol>
					</div>
					<!--右边-->
					<div class="right" id="login_box">
						<div id="title">
							登录邮箱</div>
							   <div id="errDiv">
								<s:fielderror  fieldName="username" cssClass="error">&nbsp;</s:fielderror>
								</div>
						
						
						<form id="loginForm"
							action="<%=basePath%>user/login.action"
							method="post">
							<ul>
								<li>
									邮 箱：
									<input type="text" class="wid" id="username" name="username" value="<s:property value='username'/>"/>
									<samp class="ljg">
										@abc.com
									</samp>
								</li>
								<li class="wrong" id="nameError">
									&nbsp;
								</li>
								<li>
									密 码：
									<input type="password" class="wid" id="password"
										name="password" />
									<a href="<%=basePath%>user/user_find_password1.jsp" target="_self" class="pw">忘记密码</a>
								</li>
								<li class="wrong" id="passwordError">
									&nbsp;
								</li>
								<li class="font12 mar">
									<input name="userCookie" id="rpwd" type="checkbox" value="true"/>
									<label for="rpwd" title="为了您的信息安全，请不要在网吧或公用电脑上使用此功能！">
										两周内自动登录
									</label>
									<label title="SSL是加密通讯协议，可有效防止黑客盗取您的用户名、密码，保证邮箱安全。" style="color: #999">(SSL安全登录)</label>
								</li>
								<li class="mar">
									<input id="login_img" type="image"
										src="<%=basePath%>images/u-login.png"
										border="0" />
								</li>
								<li class="now">
									还没有邮箱？
									<a href="<%=basePath%>user/register.jsp"
										target="_self">现在注册</a>
								</li>
							</ul>
						</form>
					</div>
				</div>
				<div>
					<iframe style="margin-top: 5px" width=770 height=154 marginwidth=0
						marginheight=0 frameborder=0 scrolling=no
						src="<%=basePath%>bottom.html"></iframe>
				</div>
			</div>
		</div>
	</body>
</html>


