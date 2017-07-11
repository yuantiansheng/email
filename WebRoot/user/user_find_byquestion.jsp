<%@ page language="java" import="java.util.*,cn.edu.pdsu.bean.User" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
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
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>米林邮箱通行证-找回密码</title>
		<link type="text/css" rel="stylesheet"
			href="<%=basePath%>css/login.css" />
			<script type="text/javascript"
			src="<%=basePath%>js/jquery-1.6.2.min.js">
	
</script>
		<script type="text/javascript"
			src="<%=basePath%>js/jquery.validate.min.js">
			</script>
<script type="text/javascript">
	function changeImg() {
		$("#authCode").attr(
				"src",
				"<%=basePath%>test/authCode.action?d="
						+ new Date().valueOf());
	}
	$(function() {
		$("#mark").click(function() {
			$("#markinfo").toggle('blind');
		});
	});

	//用户信息有效性校验
	$().ready(
			function() {
				$("#register").validate({
					submitHandler : function(form) { //表单提交句柄,为一回调函数，带一个参数：form   
						form.submit(); // 提交表单   
					},
					errorPlacement : function(error, element) { //验证消息放置的地方   
						element.parent("td").next("td").empty(); //清空原本内容
						error.appendTo(element.parent("td").next("td"));
					},
					highlight : function(element, errorClass) { //针对验证的表单设置高亮   
						$(element).addClass(errorClass);
					},
					success : function(label) {
						label.addClass("valid").text("Ok!");
					},
					rules : { //定义验证规则,其中属性名为表单的name属性   
						"user.password" : {
							required : true,
							rangelength : [ 3, 20 ]
						},
						"user.password2" : {
							required : true,
							equalTo : "#register_user_password"
						},
						"user.answer" : {
							required : true,
							rangelength : [ 3, 40 ]
						},
						"user.authCode" : {
							required : true
						}
					},
					messages : { //自定义验证消息   
						"user.password" : {
							required : "新密码是必需的！",
							rangelength : $.format("新密码要在{0}-{1}个字符之间！")
						},
						"user.password2" : {
							required : "确认新密码是必需的！",
							equalTo : "确认新密码要与新密码输入的一致！"
						},
						"user.answer" : {
							required : "密码查询答案是必需的！",
							rangelength : $.format("密码查询答案要在{0}-{1}个字符之间！")
						},
						"user.authCode" : {
							required : "验证码是必需的！"
						}
					}
				});
			});
</script>

	</head>
	<body>
		<div id="color">
			<div align="center">
				<!--标题部分-->
				<iframe width=1003 height=130 marginwidth=0 marginheight=0
					frameborder=0 scrolling=no src="<%=basePath%>top.html"></iframe>
			</div>
			<div id="main" align="left">
				<h2 align="left">
					找回密码
				</h2>
				<center>
					<label class="gray">
						共 3 步 当前第 3 步
					</label>
				</center>
				<hr />
				<br />
				<br />
				<form id="register" name="register"
					action="<%=basePath%>user/register!findByQuestion.action"
					method="post" class="register">
					<table class="wwFormTable" border="0">
						
						<tr>
							<td class="tdLabel">
								<label for="register_user_question" class="label">
									密码查询问题&nbsp;:
								</label>
							</td>
							<td>
								<label class="label"><s:property  value="user.question"/></label>
							</td>
							<td class="errorMsg"></td>
						</tr>
						
						<tr>
							<td class="tdLabel">
								<label for="register_user_answer" class="label">
									<span class="required">*</span>密码查询答案&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="user.answer" value="<s:property value='user.answer'/>"
									id="register_user_answer" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.answer"/></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<label class="message">
									请输入你注册时的密码查询问题答案
								</label>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="register_user_password" class="label">
									<span class="required">*</span>新密码&nbsp;:
								</label>
							</td>
							<td>
								<input type="password" name="user.password"
									id="register_user_password" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.password"/></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<label class="message">
									3~20位字符（字母、数字、符号），区分大小写
								</label>
							</td>
						</tr>

						<tr>
							<td class="tdLabel">
								<label for="register_user_password2" class="label">
									<span class="required">*</span>确认新密码&nbsp;:
								</label>
							</td>
							<td>
								<input type="password" name="user.password2"
									id="register_user_password2" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.password2"/></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<label class="message">
									请再次输入新密码
								</label>
							</td>
						</tr>

						

						
						
						<tr>
							<td class="tdLabel">
								<label for="register_user_authCode" class="label">
									验证码&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="user.authCode" value=""
									id="register_user_authCode" class="authcode"/>
									<img src="<%=basePath%>test/authCode.action"
									alt="验证码" id="authCode" onclick="changeImg()">
									<a href="javascript:changeImg()">看不清？换一张</a>
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.authCode"/></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<label class="message">
									请输入图片中的字符，不区分大小写
								</label>
							</td>
						</tr>
						<tr ><td></td><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td>
								
							</td>
							<td colspan="1">
								<div align="right">
									<input type="submit" id="register_0" value="确&nbsp;定" style="width: 80px"/>
								</div>
								<td style="padding-left: 20px">
									如果你已经想起密码，请
									<a href="<%=basePath%>" target="_self">登录</a>
								</td>
							</td>
						</tr>
					</table>
				</form>
				<div>
					<iframe style="margin-top: 5px" width=770 height=154 marginwidth=0
						marginheight=0 frameborder=0 scrolling=no
						src="<%=basePath%>bottom.html"></iframe>
				</div>
			</div>
		</div>


	</body>
</html>
