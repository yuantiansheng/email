<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="user_is_login.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>欢迎免费注册LJG邮箱</title>
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
						"user.answer" : {
							required : true,
							rangelength : [ 3, 40 ]
						},
						"user.authCode" : {
							required : true
						}
					},
					messages : { //自定义验证消息   
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
			<div id="main" align="left">
				<h2 align="left">
					修改密码查询问题
				</h2>
				<div class="top">
					<input type="button" class="button" title="修改个人基本信息" value="修改个人基本信息" onclick="reset('<%=basePath %>','1')"/>
					<input type="button" class="button" title="修改密码" value="修改密码"  onclick="reset('<%=basePath %>','2')"/>
					<input type="button" class="button" title="修改密码查询邮箱" value="修改密码查询邮箱"  onclick="reset('<%=basePath %>','4')"/>&nbsp;
					<a href="javascript:window.history.back()">&lt;&lt;返回</a>
				</div>
				<form id="register" name="register"
					action="<%=basePath%>user/changeInfo!checkAnswer.action"
					method="post" class="register">
					<table class="wwFormTable" border="0">

						<tr>
							<td class="tdLabel">
								<label for="register_user_question" class="label">
									密码查询问题&nbsp;:
								</label>
							</td>
							<td>
								<label class="label"><s:property value="user.question"/></label>
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.question"/></td>
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
						<tr ><td></td><td colspan="2">&nbsp;</td></tr>
						<tr>
							<td>
							</td>
							<td colspan="1">
								<div align="right">
									<input type="submit" id="register_0" value="下一步" style="width: 80px"/>
								</div>
							</td><td><a href="javascript:window.history.back()">&nbsp;返回</a></td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<br/>
		<br/>
		<br/>
	</body>
</html>

