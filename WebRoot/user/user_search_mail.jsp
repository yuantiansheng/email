<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="user_is_login.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript" src="<%=basePath %>js/jquery-1.6.2.min.js"></script> 
    <title>高级搜索</title>
 <style type="text/css">
 body {
    color: #000000;
    font-family: verdana,arial,helvetica,sans-serif;
    font-size: 12px;
    margin: 0;
    padding: 0;
}
.main{
	width:97%;
	height:auto;
	overflow:hidden;
	margin-top:10px;margin-left:20px;margin-bottom:10px;margin-right:25px;
}
.title{display: inline;margin-right: 6px;}
.g_color{color: #7D7D7D}
.t_left{width: 100px; text-align: right;padding-right: 10px;}
.t_input{width: 150px;}
table tr td{font-family: verdana,arial,helvetica,sans-serif;font-size: 12px; padding-bottom: 10px;}
</style>
<script type="text/javascript">
function checkValue(){
	var value = $("#t_time").val();
	var num = parseInt(value);
	if(value == null || value =="" ){
		alert("请输入时间范围！");
	}else if(isNaN(num)){
		alert("时间范围应为数字类型的数据！");
	}else{
		$("#searchMail").submit();
	}
}
</script>
  </head>
  <body>
  <div class="main">
  <h3 class="title">高级搜索</h3>
  <span class="g_color">(快速、准确、轻松地找到所要查找的内容)</span>
  <hr color="#99B1C4">
  <form action="<%=basePath %>user/search!highSearch.action" method="post" target="content" id="searchMail">
  <table border="0" cellpadding="0" cellspacing="0" id="tb_main">
  <tr><td><br/></td></tr>
  <!-- 邮件开始 -->
  <tr>
  	<td class="t_left">搜索关键字:</td>
  	<td><input type="text" name="searchMailFB.keyword" value="" class="t_input"/><span class="g_color">(可选填)</span></td>
  </tr>
   <tr>
  	<td class="t_left">搜索范围:</td>
  	<td>
  		<select name="searchMailFB.folderType" class="t_input">
  		<option value="-1" selected="selected">所有文件夹</option>
  		<option value="1">收件箱</option>
  		<option value="2">草稿箱</option>
  		<option value="3">已发送</option>
  		<option value="4">已删除</option>
  		<option value="5">垃圾邮件</option>
  		</select>
  	</td>
  </tr>
   <tr>
  	<td></td>
  	<td><input type="checkbox" name="searchMailFB.inSubject" value="true">在邮件的主题里搜索 </td>
  </tr>
   <tr>
  	<td></td>
  	<td><input type="checkbox" name="searchMailFB.inFromOrTo" value="true">在“收件人”和“发件人”中搜索 </td>
  </tr>
   <tr>
  	<td class="t_left">时间范围:</td>
  	<td><input type="text" name="searchMailFB.time" value="" class="t_input" id="t_time"/>
  		<select name="searchMailFB.timeType">
  			<option value="1" selected="selected">天</option>
  			<option value="2">周</option>
  			<option value="3">月</option>
  			<option value="4">年</option>
  		</select> 内
  	</td>
  </tr>
  <!-- 邮件结束 -->
  </table>
  <hr color="#99B1C4" style="margin-bottom: 15px;">
  <input type="button"" value="确  定" style="margin-left: 100px;" onclick="checkValue()"/> 
  <input type="button" value="取  消" style="margin-left: 35px;" onclick="javascript:window.history.back()"/> 
  </form>
  </div>
  <br />
  <br />
  </body>
</html>
