<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="cn.edu.pdsu.bean.Gender" %>
<%@ include file="../user_is_login.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="<%=basePath%>css/ui-lightness/jquery-ui-1.8.14.custom.css" />
<link type="text/css" rel="stylesheet" href="<%=basePath%>css/login.css" />
			<style type="text/css">
body {
	color: #000000;
	margin: 0px;
	padding: 0px;
}
.tdLabel {
    width: 120px;
}
#register input {
    width: 200px;
}
.errorMsg {
    width: 200px;
}
.top {
	height: 30px;
	background: #A5E6E9;
	padding-left: 10px;
    padding-top: 5px;
}
</style>
<script type="text/javascript" src="<%=basePath%>js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.validate.min.js"></script>
<script type="text/javascript"  src="<%=basePath%>js/jquery.ui.core.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.ui.widget.min.js"></script>
<script type="text/javascript"  src="<%=basePath%>js/jquery.ui.datepicker-zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>js/jquery.ui.datepicker.min.js"></script>
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
						"linkman.name" : {
							required : true
						},
						"linkman.emailAdd" : {
							required : true,
							email : true
						},
						"linkman.phoneNum" : {
							digits : true,
							rangelength : [ 11, 13 ]
						}
					},
					messages : { //自定义验证消息   
						"linkman.name" : {
							required : "用户名是必需的！"
						},
						"linkman.emailAdd" : {
							required : "密码查询邮箱是必需的！",
							email : "邮件地址格式不正确!"
						},
						"linkman.phoneNum" : {
							digits : "手机号必须是数字！",
							rangelength : $.format("手机号要在{0}-{1}位之间！")
						}
					}
				});
			});
	$(function() {
		$( "#register_linkman_birthday" ).datepicker({
			changeMonth: true,
			changeYear: true,
			yearRange: '1910:2011'
		});
	});
</script>

	</head>

	<body>
		<div id="color">
		<div style="margin-left: 10px">
			<div class="top">
				<a href="javascript:window.history.back()">&lt;&lt;返回</a>
			</div>
			<div>
				<h3>
				更新联系人
				</h3>
				<form id="register" name="register"
					action="<%=basePath%>user/linkman!upLinkman.action"
					method="post" class="register" target="content">
					<table class="wwFormTable" border="0" style="width: 520px">
					<s:hidden name="linkman.id" value="%{linkman.id}"></s:hidden>
					<tr>
							<td class="tdLabel">
								<label for="register_linkman_name" class="label">
									<span class="required">*</span>姓名&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="linkman.name" value="<s:property  value='linkman.name'/>"
									id="register_linkman_name" />
							</td>
							<td class="errorMsg"><s:fielderror fieldName="linkman.name"></s:fielderror></td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="register_linkman_gender" class="label">
									性别&nbsp;:
								</label>
							</td>
							<td> <s:set var="gender" value="linkman.gender" scope="page"></s:set>
							<% if(pageContext.getAttribute("gender")!=null&&pageContext.getAttribute("gender").equals(Gender.MAN)){%>
								<input type="radio" name="linkman.gender"
									id="register_linkman_genderMAN" value="MAN" style="width:10px;" checked="checked" />
							<%}else {%>
								<input type="radio" name="linkman.gender"
									id="register_linkman_genderMAN" value="MAN" style="width:10px;" />
							<%} %>
								<label for="register_linkman_genderMAN" class="label">
									男
								</label>
							<% if(pageContext.getAttribute("gender")!=null&&pageContext.getAttribute("gender").equals(Gender.WOMAN)){%>
								<input type="radio" name="linkman.gender"
									id="register_linkman_genderWOMAN" value="WOMAN" style="width:10px;" checked="checked"/>
							<%}else {%>	
								<input type="radio" name="linkman.gender"
									id="register_linkman_genderWOMAN" value="WOMAN" style="width:10px;"/>
							<%} %>
								<label for="register_linkman_genderWOMAN" class="label">
									女
								</label>
							</td>
							<td class="errorMsg"></td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="register_linkman_birthday" class="label">
									生日&nbsp;:
								</label>
							</td>
							<td>
							
								<input type="text" name="linkman.birthday" value='<s:date name="linkman.birthday" format="yyyy-MM-dd"/>'
									id="register_linkman_birthday" style="width: 150px;" readonly="readonly"/>
							</td>
							<td class="errorMsg"></td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="register_linkman_emailAdd" class="label">
									<span class="required">*</span>邮件地址&nbsp;:
								</label>
							</td>
							<td> 
								<input type="text" name="linkman.emailAdd" value="<s:property  value='linkman.emailAdd'/>"
									id="register_linkman_emailAdd" />
							</td>
							<td class="errorMsg"></td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="register_linkman_group" class="label" >
									所属分组&nbsp;:
								</label>
							</td>
							<td> 
								<label  class="label"><s:property  value='linkman.group.name' /></label>
							</td>
							<td class="errorMsg"></td>
						</tr>
						
						<tr>
							<td class="tdLabel">
								<label for="register_linkman_group" class="label" >
									更新分组&nbsp;:
								</label>
							</td>
							<td> 
							 <s:select id="register_linkman_group" list="user.group" name="group.id" listValue="name" listKey="id" cssStyle="width: 200px;height: 25px;font: 14px verdana, sans-serif;">
							 </s:select>
							</td>
							<td class="errorMsg"></td>
						</tr>
						
						<tr>
							<td class="tdLabel">
								<label for="register_linkman_phoneNum" class="label">
									手机号&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="linkman.phoneNum" value="<s:property  value='linkman.phoneNum'/>"
									id="register_linkman_phoneNum" />
							</td>
							<td class="errorMsg"></td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="register_linkman_address" class="label">
									家庭住址&nbsp;:
								</label>
							</td>
							<td>
								<input type="text" name="linkman.address" value="<s:property  value='linkman.address'/>" id="register_linkman_address" />
							</td>
							<td class="errorMsg"></td>
						</tr>

						<tr>
							<td class="tdLabel">
								<label for="register_linkman_mark" class="label">
									备注&nbsp;:
								</label>
							</td>
							<td colspan="2">
								<textarea name="linkman.mark" cols="30" rows="5" 
									id="register_linkman_mark"><s:property  value="linkman.mark"/> </textarea>
							</td>
						</tr>
						<tr>
							<td>
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
		</div>
		<br />
		<br />
		<br />
	</body>
</html>

