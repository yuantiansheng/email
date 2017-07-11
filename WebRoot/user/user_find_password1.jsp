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
	//用户信息有效性校验
	$().ready(
			function() {
				//自定义用户名校验规则
				$.validator.addMethod("username", function(value, element) {
					return this.optional(element)
							|| /^[a-zA-Z0-9._-]{3,25}$/.test(value);
				}, "只能包含字母、数字、下划线、中划线或点号(.)");
				
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
						"user.username" : {
							required : true,
							rangelength : [ 3, 20 ],
							username : true
						},
						"user.authCode" : {
							required : true
						}
					},
					messages : { //自定义验证消息   
						"user.username" : {
							required : "用户名是必需的！",
							rangelength : $.format("用户名要在{0}-{1}个字符之间！")
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
					frameborder=0 scrolling=no
					src="<%=basePath%>top.html"></iframe>
			</div>
			<div id="main" align="center">
				<h2 align="left">
					找回密码</h2>
					<label class="gray">共 3 步， 当前第 1 步</label>
				<hr/>
				<br/>
				<br/>
				<br/>
				<form id="register" name="register"
					action="<%=basePath%>user/register!findPassword1.action"
					method="post" class="register">
					<table class="wwFormTable" border="0">
						<tr class="textLeft">
							<td class="tdLabel">
								<label for="register_user_username" class="label">
									<span class="required">*</span>邮箱名称&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="user.username" value="<s:property value='user.username'/>"
									id="register_user_username" class="username" />
								<label class="ljg">@abc.com</label>
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.username"/> </td>
						</tr>
						<tr class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									3~20位之间，请用字母、数字、下划线、中划线或点号"."
								</label>
							</td>
						</tr>
						
						<tr class="textLeft">
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
						<tr class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									请输入图片中的字符，不区分大小写
								</label>
							</td>
						</tr>
						<tr ><td></td><td colspan="2">&nbsp;</td></tr>
						<tr class="textLeft">
							<td>
							</td>
							<td colspan="1">
								<div align="right">
									<input type="submit" id="register_0" value="下一步" style="width: 80px"/>
								</div>
								<td style="padding-left: 20px">
									已想起密码，请
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
