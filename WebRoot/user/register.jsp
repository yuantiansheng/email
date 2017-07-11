<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>欢迎免费注册LJG邮箱</title>
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
		$("#detail").toggle(
			function(){
				$(".markinfo").show();
				$("#detail").text("隐藏详细信息...");
			},
			function(){
				$(".markinfo").hide();
				$("#detail").text("显示详细信息...");
			}
		);
	});

	//用户信息有效性校验
	$().ready(
			function() {
				//自定义用户名校验规则
				$.validator.addMethod("username", function(value, element) {
					return this.optional(element)
							|| /^[a-zA-Z0-9._-]{3,25}$/.test(value);
				}, "只能包含字母、数字、下划线、中划线或点号(.)");
				$.validator.addMethod("selectQuestion",
						function(value, element) {
							if (value == -1)
								return false;
							else
								return true;
						}, "请选择一个安全问题！");
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
							username : true,
							remote:"<%=basePath%>user/register!checkUser.action"

						},
						"user.password" : {
							required : true,
							rangelength : [ 3, 20 ]
						},
						"user.password2" : {
							required : true,
							equalTo : "#register_user_password"
						},
						"user.pwdEmail" : {
							required : true,
							email : true
						},
						"user.question" : {
							selectQuestion : true
						},
						"user.answer" : {
							required : true,
							rangelength : [ 3, 40 ]
						},
						"user.authCode" : {
							required : true
						},
						"user.phoneNum" : {
							digits : true,
							rangelength : [ 11, 13 ]
						}
					},
					messages : { //自定义验证消息   
						"user.username" : {
							required : "用户名是必需的！",
							rangelength : $.format("用户名要在{0}-{1}个字符之间！"),
							remote:"用户名已被占用！"
						},
						"user.password" : {
							required : "密码是必需的！",
							rangelength : $.format("密码要在{0}-{1}个字符之间！")
						},
						"user.password2" : {
							required : "确认密码是必需的！",
							equalTo : "确认密码要与密码输入的一致！"
						},
						"user.pwdEmail" : {
							required : "密码查询邮箱是必需的！",
							email : "邮件地址格式不正确!"
						},
						"user.answer" : {
							required : "密码查询答案是必需的！",
							rangelength : $.format("密码查询答案要在{0}-{1}个字符之间！")
						},
						"user.authCode" : {
							required : "验证码是必需的！"
						},
						"user.phoneNum" : {
							digits : "手机号必须是数字！",
							rangelength : $.format("手机号要在{0}-{1}位之间！")
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
				<h1>
					欢迎免费注册LJG邮箱
				</h1>
				<form id="register" name="register"
					action="<%=basePath%>user/register.action"
					method="post" class="register">
					<table class="wwFormTable" border="0" >
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
							<td class="errorMsg"><s:fielderror fieldName="user.username"/></td>
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
								<label for="register_user_password" class="label">
									<span class="required">*</span>登录密码&nbsp;:
								</label>
							</td>
							<td>
								<input type="password" name="user.password"
									id="register_user_password" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.password"/></td>
						</tr>
						<tr  class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									3~20位字符（字母、数字、符号），区分大小写
								</label>
							</td>
						</tr>

						<tr  class="textLeft">
							<td class="tdLabel">
								<label for="register_user_password2" class="label">
									<span class="required">*</span>确认密码&nbsp;:
								</label>
							</td>
							<td>
								<input type="password" name="user.password2"
									id="register_user_password2" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.password2"/></td>
						</tr>
						<tr  class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									请再次输入登录密码
								</label>
							</td>
						</tr>

						<tr class="textLeft">
							<td class="tdLabel">
								<label for="register_user_pwdEmail" class="label">
									<span class="required">*</span>密码查询邮箱&nbsp;:
								</label>
							</td>
							<td> 
								<input type="text" name="user.pwdEmail" value="<s:property value='user.pwdEmail'/>"
									id="register_user_pwdEmail" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.pwdEmail"/></td>
						</tr>
						<tr class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									邮箱地址格式如（zhangsan@163.com），该邮箱地址用于找回密码
								</label>
							</td>
						</tr>

						<tr  class="textLeft">
							<td class="tdLabel">
								<label for="register_user_question" class="label">
									<span class="required">*</span>密码查询问题&nbsp;:
								</label>
							</td>
							<td>
								<select name="user.question" id="register_user_question"
									style="font-size: 15px">
									<option value="-1">
										--请选择安全问题--
									</option>
									<option value="我的手机号码是什么？">
										我的手机号码是什么？
									</option>
									<option value="我手机号码的后6位？">
										我手机号码的后6位？
									</option>
									<option value="我母亲的生日？">
										我母亲的生日？
									</option>
									<option value="我父亲的生日？">
										我父亲的生日？
									</option>
									<option value="我母亲的名字？">
										我母亲的名字？
									</option>
									<option value="我父亲的名字？">
										我父亲的名字？
									</option>
									<option value="我最好朋友的生日？">
										我最好朋友的生日？
									</option>
									<option value="我最好朋友的名字？">
										我最好朋友的名字？
									</option>
									<option value="我儿时居住地的地址？">
										我儿时居住地的地址？
									</option>
									<option value="我小学校名全称？">
										我小学校名全称？
									</option>
									<option value="我初中学校名全称？">
										我初中学校名全称？
									</option>
									<option value="我高中学校名全称？">
										我高中学校名全称？
									</option>
									<option value="我大学学校名全称？">
										我大学学校名全称？
									</option>
									<option value="离我家最近的医院全称？">
										离我家最近的医院全称？
									</option>
									<option value="离我家最近的公园全称？">
										离我家最近的公园全称？
									</option>
									<option value="我的座右铭是？">
										我的座右铭是？
									</option>
									<option value="我最喜爱的电影？">
										我最喜爱的电影？
									</option>
									<option value="我最喜爱的歌曲？">
										我最喜爱的歌曲？
									</option>
									<option value="我最喜爱的食物？">
										我最喜爱的食物？
									</option>
									<option value="我最大的爱好？">
										我最大的爱好？
									</option>
									<option value="我最喜欢的小说？">
										我最喜欢的小说？
									</option>
								</select>
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.question"/></td>
						</tr>
						<tr class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									请选择密码查询问题
								</label>
							</td>
						</tr>
						<tr  class="textLeft">
							<td class="tdLabel">
								<label for="register_user_answer" class="label">
									<span class="required">*</span>密码查询答案&nbsp;:
								</label>
							</td>
							<td >
								<input type="text" name="user.answer" value="<s:property value='user.answer'/>"
									id="register_user_answer" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.answer"/></td>
						</tr>
						<tr  class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									3~40位之间，不允许含有特殊字符，用于找回密码请牢记
								</label>
							</td>
						</tr>
						<tr  class="textLeft">
							<td class="tdLabel">
								<label for="register_user_authCode" class="label">
									验证码&nbsp;:
								</label>
							</td>
							<td >
								<input type="text" name="user.authCode" value=""
									id="register_user_authCode" class="authcode"/>
									<label id="register_authCode"></label>
								<img src="<%=basePath%>test/authCode.action"
									alt="验证码" id="authCode" onclick="changeImg()">
									<a href="javascript:changeImg()">看不清？换一张</a>
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.authCode"/></td>
						</tr>
						<tr  class="textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									请输入图片中的字符，不区分大小写
								</label>
							</td>
						</tr>
						<tr class="markinfo textLeft" >
							<td class="tdLabel">
								<label for="register_user_alias" class="label">
									昵称&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="user.alias" value="<s:property value='user.alias'/>"
									id="register_user_alias" />
							</td>
							<td class="errorMsg"></td>
						</tr>

						<tr class="markinfo textLeft">
							<td class="tdLabel">
								<label for="register_user_gender" class="label">
									性别&nbsp;:
								</label>
							</td>
							<td>
								<input type="radio" name="user.gender"
									id="register_user_genderMAN" value="MAN" style="width:10px;" checked="checked"/>
								<label for="register_user_genderMAN" class="label">
									男
								</label>
								<input type="radio" name="user.gender"
									id="register_user_genderWOMAN" value="WOMAN" style="width:10px;"/>
								<label for="register_user_genderWOMAN" class="label">
									女
								</label>
							</td>
							<td class="errorMsg"></td>
						</tr>


						<tr class="markinfo textLeft">
							<td class="tdLabel">
								<label for="register_user_phoneNum" class="label">
									手机号&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="user.phoneNum" value="<s:property value='user.phoneNum'/>"
									id="register_user_phoneNum" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="user.phoneNum"/></td>
						</tr>
						<tr class="markinfo textLeft">
							<td></td>
							<td colspan="2">
								<label class="message">
									11位手机号码，可以加上国家代码但不能超过13位
								</label>
							</td>
						</tr>
						<tr class="markinfo textLeft"> 
							<td class="tdLabel">
								<label for="register_user_address" class="label">
									家庭住址&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="user.address" value="<s:property value='user.address'/>"
									id="register_user_address" />
							</td>
							<td class="errorMsg"></td>
						</tr>

						<tr class="markinfo textLeft">
							<td class="tdLabel">
								<label for="register_user_mark" class="label">
									备注&nbsp;:
								</label>
							</td>
							<td>
								<textarea name="user.mark" class="textarea"
									id="register_user_mark"><s:property value='user.mark'/></textarea>
							</td>
							<td class="errorMsg"></td>
						</tr>
						<tr ><td></td><td colspan="2">&nbsp;</td></tr>
						<tr class="textLeft">
							<td align="right">
								<a href="#"><span id="detail">显示详细信息...</span></a>
							</td>
							<td colspan="1" >
								<div align="right">
									<input type="submit" id="register_0" value="&#27880;&nbsp;&#20876;" style="width: 80px"/>
								</div>
								<td style="padding-left: 20px">
									已有邮箱账号，请
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

