<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="user_is_login.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link type="text/css" rel="stylesheet" href="<%=basePath%>css/login.css" />
		<link type="text/css" rel="stylesheet" href="<%=basePath%>css/resetUserInfo.css" />
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/user_reset_Info.js"></script>
<script type="text/javascript">
	function changeImg() {
		$("#authCode").attr(
				"src",
				"<%=basePath%>test/authCode.action?d="
						+ new Date().valueOf());
	}

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
						"user.phoneNum" : {//原密码
							required : true,
							rangelength : [ 3, 20 ]
						},
						"user.password" : {//新密码
							required : true,
							rangelength : [ 3, 20 ]
						},
						"user.password2" : {//确认新密码
							required : true,
							equalTo : "#register_user_password"
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
						"user.phoneNum" : {
							required : "原密码是必需的！",
							rangelength : $.format("原密码要在{0}-{1}个字符之间！")
						}
					}
				});
			});
</script>

	</head>

	<body>
		<div id="color">
			<div id="main" align="left">
				<h2>
					修改密码
				</h2>
				<div class="top">
					<input type="button" class="button" title="修改个人基本信息" value="修改个人基本信息" onclick="reset('<%=basePath %>','1')"/>
					<input type="button" class="button" title="修改密码查询问题" value="修改密码查询问题"  onclick="reset('<%=basePath %>','3')"/>
					<input type="button" class="button" title="修改密码查询邮箱" value="修改密码查询邮箱"  onclick="reset('<%=basePath %>','4')"/>&nbsp;
					<a href="javascript:window.history.back()">&lt;&lt;返回</a>
				</div>
				<form id="register" name="register"
					action="<%=basePath%>user/changeInfo!changePassword.action"
					method="post" class="register">
					<table class="wwFormTable" border="0">
					<tr class="textLeft">
							<td class="tdLabel">
								<label for="register_user_phoneNum" class="label">
									<span class="required">*</span>原密码&nbsp;:
								</label>
							</td>
							<td>
								<input type="password" name="user.phoneNum" value="<s:property value='user.phoneNum'/>"
									id="register_user_phoneNum" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.phoneNum"/></td>
						</tr>
						<tr class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									请输入你登录时的密码
								</label>
							</td>
						</tr>
						<tr class="textLeft">
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
						<tr class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									3~20位字符（字母、数字、符号），区分大小写
								</label>
							</td>
						</tr>

						<tr class="textLeft">
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
						<tr class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									请再次输入新密码
								</label>
							</td>
						</tr>
						<tr ><td></td><td colspan="2">&nbsp;</td></tr>
						<tr class="textLeft">
							<td>
							</td>
							<td colspan="1">
								<div align="right">
									<input type="submit" id="register_0" value="确&nbsp;定" style="width: 80px"/>
								</div>
							</td>
							<td><a href="javascript:window.history.back()">&nbsp;返回</a></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<br/>
		<br/>
		<br/>
		<br/>
	</body>
</html>

