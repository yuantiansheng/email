<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../user_is_login.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link type="text/css" rel="stylesheet" href="<%=basePath%>css/login.css" />
		<link  href="<%=basePath %>css/linkman_welcome.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript" src="<%=basePath%>js/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js">
</script>
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
						"group.name" : {
							required : true
						}
					},
					messages : { //自定义验证消息   
						"group.name" : {
							required : "请填写分组名称！"
						}
					}
				});
			});
</script>
	</head>
	<body>
		<div id="color">
			<div class="main" >
				<div class="top">
				<input type="button" class="add_button" title="新建联系人" value="新建联系人" onclick="javascript:window.location.href='<%=basePath%>user/linkman!addLinkmanSkip.action'"/>
				<a href="javascript:window.history.back()">&lt;&lt;返回</a>
				</div>
				<h3 align="left">
					添加联系人分组
				</h3>
				<form id="register" name="register"
					action="<%=basePath%>user/linkman!addGroup.action"
					method="post" class="register" target="content">
					<table class="wwFormTable" border="0" style="width:auto;">
						<tr>
							<td class="tdLabel" style="width:100px;">
								<label for="register_add_group" class="label">
									<span class="required">*</span>分组名称&nbsp;:
								</label>
							</td>
							<td style="width:150px;">
								<input type="text" name="group.name" value="" id="register_add_group" style="width:145px;"/>
							</td>
							<td class="errorMsg" style="width:150px;"><s:fielderror fieldName="group.name"/></td>
						</tr>
						<tr>
							<td></td>
							<td colspan="2">
								<label class="message">
									请输入新的联系人分组名称，可以是任意字符
								</label>
							</td>
						</tr>
						<tr>
							<td align="right">
							</td>
							<td colspan="1">
								<div align="right">
									<input type="submit" id="register_0" value="确&nbsp;定" style="width: 80px"/>
								</div>
								<td style="padding-left: 20px">
									<a href="javascript:window.history.back()">返回</a>
								</td>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
		<br/>
		<br/>
	</body>
</html>

