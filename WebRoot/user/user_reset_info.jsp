<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="cn.edu.pdsu.bean.Gender" %>
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
	//用户信息有效性校验
	$().ready(
			function() {
				//自定义用户名校验规则
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
						"user.phoneNum" : {
							digits : true,
							rangelength : [ 11, 13 ]
						}
					},
					messages : { //自定义验证消息   
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
			<div id="main" align="left">
				<h2 align="left">
					修改个人基本信息
				</h2>
				<div class="top">
					<input type="button" class="button" title="修改密码" value="修改密码"  onclick="reset('<%=basePath %>','2')"/>
					<input type="button" class="button" title="修改密码查询问题" value="修改密码查询问题"  onclick="reset('<%=basePath %>','3')"/>
					<input type="button" class="button" title="修改密码查询邮箱" value="修改密码查询邮箱"  onclick="reset('<%=basePath %>','4')"/>&nbsp;
					<a href="javascript:window.history.back()">&lt;&lt;返回</a>
				</div>
				<form id="register" name="register"
					action="<%=basePath%>user/changeInfo!updateInfo.action"
					method="post" class="register">
					<table id="markinfo" border="0" class="wwFormTable">
						<tr>
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

						<tr>
							<td class="tdLabel">
								<label for="register_user_gender" class="label">
									性别&nbsp;:
								</label>
							</td>
							<td> <s:set var="gender" value="user.gender" scope="page"></s:set>
								<% if(pageContext.getAttribute("gender")!=null&&pageContext.getAttribute("gender").equals(Gender.MAN)){%>
								<input type="radio" name="user.gender"
									id="register_user_genderMAN" value="MAN" style="width:10px;" checked/>
								<%}else {%>
								<input type="radio" name="user.gender"
									id="register_user_genderMAN" value="MAN" style="width:10px;"/>
								<%} %>
								<label for="register_user_genderMAN" class="label">
									男   
								</label>
								<% if(pageContext.getAttribute("gender")!=null&&pageContext.getAttribute("gender").equals(Gender.WOMAN)){%>
								<input type="radio" name="user.gender"
									id="register_user_genderWOMAN" value="WOMAN" style="width:10px;" checked/>
								<%}else {%>	
								<input type="radio" name="user.gender"
									id="register_user_genderWOMAN" value="WOMAN" style="width:10px;" />
								<%} %>
								<label for="register_user_genderWOMAN" class="label">
									女
								</label>
							</td>
							<td class="errorMsg"></td>
						</tr>


						<tr>
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
						<tr>
							<td></td>
							<td colspan="2">
								<label class="message">
									11位手机号码，可以加上国家代码但不能超过13位
								</label>
							</td>
						</tr>
						<tr>
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

						<tr>
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
						<tr>
							<td >
							</td>
							<td colspan="1">
								<div align="right">
									<input type="submit" id="register_0" value="确&nbsp;定" style="width: 80px"/>
								</div>
							</td>
							<td><a href="javascript:window.history.back()">&nbsp;返回</a>
								</td>
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
