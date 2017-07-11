<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../user_is_login.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link  href="<%=basePath %>css/linkman_main.css" type="text/css" rel="stylesheet"/>
<script src="<%=basePath %>js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" >
//设置左边工具条高度
var h =0;
$(function($) {
	h= $("#divleft").height();
	$("#input").focusout(function() {
		var value = $("#input").attr("value");
		if (value == "") {
			$("#input").attr("value", "请输入联系人...");
			$("#input").removeClass("input_focse");
		}
	});
	$("#list li").click(function() {
		$("#list li").removeClass("list_focse");
		$(this).addClass("list_focse");
	});
});
function SetLeftHeight(){
	var height= $("#divcontent").height();
	if(height>h){
		$("#divleft").height(height);
	}else{
		$("#divleft").height(h);
	}
}
//iframe自动适应网页的高度
function SetWinHeight(obj)
{
	var win=obj;
	if (document.getElementById)
	{
		if (win && !window.opera)
		{
			if (win.contentDocument && win.contentDocument.body.offsetHeight){ 
   				win.height = win.contentDocument.body.offsetHeight; 
			}
   			else if(win.Document && win.Document.body.scrollHeight){
  				win.height = win.Document.body.scrollHeight;
			}
		}
		
	}
	
	SetLeftHeight();
}
function clearValue(){
	var value = $("#input").attr("value");
	if (value == "请输入联系人...") {
		$("#input").attr("value", "");
		$("#input").addClass("input_focse");
	}
}
//页面跳转
function skip(path){
	 parent.document.getElementById("rightcontent").src=path;
}
</script>
</head>
<body>
<!--主div-->
<div class="main">
	<!--顶部-->
    <div class="top">
    	<h2>通讯录</h2>
    </div>
    <!--底部-->
    <div class="bottom">
    <!--左边-->
    <div class="left l" id="divleft">
    	<div class="tootle">
        <form class="one" action="<%=basePath %>user/linkman!searchLinkman.action" method="post" target="linkman_content">
         <input type="text" name="name" class="l input" value="请输入联系人..." title="请输入要查找的联系人" id="input" onfocus="clearValue()"/>
         <input type="submit" value="" class="sch_btn" title="根据联系人姓名或邮件地址搜索联系人"/>
         </form>
        </div>
        <div class="list" id="list">
    	<ul><%int sum=0; %>
    	    <s:iterator value="user.group" var="u">
        	<li><a href="<%=basePath %>user/linkman!linkmanList.action?group.id=${u.id}" class="a" target="linkman_content">${u.name}(<s:property value="#u.linkmans.size"/>)</a></li>
           	<s:set value="#u.linkmans.size" var="size"></s:set>
			<%sum +=(Integer)(pageContext.getAttribute("size"));  %>
           </s:iterator>
        	<li><a href="<%=basePath %>user/linkman!linkmanList.action" class="a" target="linkman_content">所有(<%=sum %>)</a></li>
            <li id="group"><a href="<%=basePath %>user/linkman/user_add_group.jsp" title="新建联系人分组" target="linkman_content" >新建联系组</a></li>
        </ul>
        </div>
    </div>
    <!--右边-->
    <div class="right" id="divcontent">
  	 <iframe width="100%" align="middle"  id="divrightcontent" name="linkman_content" onload="SetWinHeight(this)" frameborder="0" scrolling="no" src="<%=basePath %>user/linkman/${operationPath}"></iframe>
    </div>
    </div>
</div>
</body>
</html>

