<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../user_is_login.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link  href="<%=basePath %>css/linkman_welcome.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="<%=basePath %>js/jquery-1.6.2.min.js"></script> 
<script type="text/javascript">
/*选择框全选*/
function sel_all_mail(){
	var check = $("#select_all").attr("checked");
		if(check=='checked')
			sel_all();
		else 
			sel_no_all();
}
/*点击全选时选中全部邮件*/
function sel_all(){
	$(":checkbox").attr("checked", true);
}
/*全部不选*/
function sel_no_all(){
	$(":checkbox").attr("checked", false);
}

/*发送请求*/
function send(type) {
		var obj = $("#lk_m_t input:checked");
		var size = obj.size();
		if (size > 0) {
			var strId = "";
			obj.each(function(i) {
				strId += $(this).attr("value") + ",";
			});
			strId = strId.substr(0, strId.length - 1);
			if(type=='del')
				window.location.href="<%=basePath %>user/linkman!delLinkman.action?linkmanIds="+strId+"&group.id=0";
			if(type=='move'){
				var value = $("#move option:selected").attr("value");
				if(value != -1)
					window.location.href="<%=basePath %>user/linkman!moveLinkman.action?linkmanIds="+strId+"&group.id="+value;
			}
		} else {
			alert("请选择联系人！");
			$("#move option:first-child").attr("selected", true);
		}
}
</script>
  </head>
  <body>
  <div class="main">
  <div class="top">
  <input type="button" title="新建联系人" value="新建联系人" onclick="javascript:window.location.href='<%=basePath%>user/linkman!addLinkmanSkip.action'"/>
  <input type="button" title="删除联系人" value="删除联系人" onclick="send('del')"/>
  <s:select list="user.group" listKey="id" listValue="name" headerKey="-1" headerValue="移动到分组" onchange="send('move')" id="move"></s:select>
  <a href="javascript:window.history.back()">&lt;&lt;返回</a>
 </div>
  <div class="boottom">
<table class="lk_m_t" id="title">
<tr class="title fc tr">
	<td class="ckb"><input title="选择/不选" type="checkbox" value="5" name="select_all" onclick="sel_all_mail()" id="select_all"/></td>
	<td class="name">姓名</td>
	<td class="emailAdd">邮件地址</td>
	<td class="phoneNum">电话号码</td>
</tr>
</table>
<table class="lk_m_t" id="lk_m_t">
<s:iterator value="user.group" status="sta">
	<s:iterator value="linkmans" status="status">
		<tr class="tr odd">
			<td class="ckb"><input title="选择/不选" type="checkbox" value="${id}" name="select_all" /></td>
			<td class="name" title="${name}" onclick="javascript:window.location.href='<%=basePath %>user/linkman!findLinkman.action?linkman.id=${id}'">${name}</td>
			<td class="emailAdd" title="${emailAdd}" onclick="javascript:window.location.href='<%=basePath %>user/linkman!findLinkman.action?linkman.id=${id}'">${emailAdd}</td>
			<td class="phoneNum" title="${phoneNum}" onclick="javascript:window.location.href='<%=basePath %>user/linkman!findLinkman.action?linkman.id=${id}'">${phoneNum}&nbsp;</td>
		</tr>
	</s:iterator>
</s:iterator>
</table>
  </div>
  </div>
  <br />
  <br />
  </body>
</html>
