<%@ page language="java" import="java.util.*,cn.edu.pdsu.bean.Group,cn.edu.pdsu.bean.Linkman" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="fck" %>
<%@ include file="user_is_login.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link  href="<%=basePath %>css/linkman_main.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.6.2.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>js/swfobject.js" charset="UTF-8"></script> 
<script type="text/javascript" src="<%=basePath%>js/jquery.uploadify.v2.1.4.min.js" charset="GBK" charset="UTF-8"></script> 
<script language="javascript">
 $(function(){
	$(".group").click( function () {
		var obj = $(this).find("img");
		var img = obj.attr("src");
		if(img =="<%=basePath %>images/jia.gif"){
    		 obj.attr("src","<%=basePath %>images/jian.gif");
			 $(this).next("tr").css("display","block");
  		}
 		else{
   			 obj.attr("src","<%=basePath %>images/jia.gif");
			  $(this).next("tr").css("display","none");
  		}
	});
	$("#hidenLinkman").click( function () {
			$("#list_linkman").toggle("normal");
			$("#hidenLinkman").toggleClass("showLinkman");
			
	});
	$("#input").focusout(function() {if($("#input").attr("value")==''){resetinput();$("#searchl").css("height","0px");}});
	$("#sb").click( function () {$("#searchl").empty();resetinput();$("#searchl").css("height","0px");});
	changHeight();
});
 //关闭搜索结果列表
 function resetinput(){
	 var value = $("#input").attr("value");
		$("#input").attr("value", "请输入联系人...");
		$("#input").removeClass("input_focse");
		$("#sb").removeClass("cls_btn");
 }
function changHeight(){
	$("#list_linkman").height($("#sendmailInfo").height());
	$("#menulinkman").height($("#list_linkman").height()-70);
	if($("#searchl").height()!=0){
		$("#searchl").height($("#list_linkman").height()-70);
	}
	window.setTimeout("changHeight()", 300); 
}
function clearValue(){
	var value = $("#input").attr("value");
	if (value == "请输入联系人...") {
		$("#input").attr("value", "");
		$("#input").addClass("input_focse");
	}
}
function bb(){
	var show = $("#cc").css("display");
	if(show =='table-row'){
		if($("#i_cc").val() != ""){
			var del = window.confirm("你确定要删除 \"抄送人\" 吗？ ");
			if (del) {$("#i_cc").val("");focus="";}
			else return ;
		}
		$("#acc").text("添加抄送");
	}else{	
		$("#acc").text("删除抄送");
		focus = "i_cc";
	}
	$("#cc").toggle('normal');
}
function cbb(){
	var show = $("#bcc").css("display");
	if(show =='table-row'){
		if($("#i_bcc").val() != ""){
			var del = window.confirm("你确定要删除 \"密送人\" 吗？ ");
			if (del) {$("#i_bcc").val("");focus="";}
			else return ;
		}
		$("#abcc").text("添加抄送");
	}else{
		$("#abcc").text("删除抄送");
		focus = "i_bcc";	
	}
	$("#bcc").toggle('normal');
};
//搜索用户信息
function search() {
	var value = $("#input").attr("value");
	var s = $("#allLinkman").find("span");
	if (s.size() > 0 && value != "") {
		var v = "<ul>";
		s.each(function(i) {
			var str = $(this).attr("title");
			var m =str.match(value);
			if(m!=null){
				var index = str.indexOf(value);
				var str1 = str.substring(0,index).replace("<","&lt;").replace(">","&gt;");
				var str2 = m.toString().fontcolor("red");
				var str3 = str.substring(index+value.length,str.length).replace("<","&lt;").replace(">","&gt;");
				v += "<li><span class='splk' onclick='add(this)' title='"+str+"'>"+str1+str2+str3+"</span></li><hr>";
			}
		});
		v+="</ul>";
		$("#searchl").empty();
		$("#searchl").append(v);
		$("#searchl").height($("#list_linkman").height()-70);
		$("#sb").addClass("cls_btn");
	}
}
//自动添加收件人
var focus = "";//获取焦点的id
function inputfocus(){
	focus= document.activeElement.id;
}
//点击联系人添加到列表中
function add(value) {
	var obj = $(value).attr("title") + ";";
	if (focus == "i_cc") {//抄送
		var val = $("#i_cc").val();
		var is = val.match(obj);
		if (is == null) {
			$("#i_cc").val($("#i_cc").val() + obj);
		}
		$("#i_cc").focus();
		focus = "i_cc";
	} else if (focus == "i_bcc") {//密送
		var val = $("#i_bcc").val();
		var is = val.match(obj);
		if (is == null) {
			$("#i_bcc").val($("#i_bcc").val() + obj);
		}
		$("#i_bcc").focus();
		focus = "i_bcc";
	} else {//收件人
		var val = $("#i_rescive").val();
		var is = val.match(obj);
		if (is == null) {
			$("#i_rescive").val($("#i_rescive").val() + obj);
		}
		$("#i_rescive").focus();
	}
}
//上传附件
$(document).ready(function() {
	$("#uploadify").uploadify({
	    'uploader'       : '<%=basePath%>images/uploadify.swf',
	    'script'         : '<%=basePath%>user/fileUpload.action?userName=${user.name}',
	    'fileDataName'   : 'fileDate',
	    'folder'         : '/',
	    'queueID'        : 'fileQueue',
	    'queueSizeLimit' : 6,
	    'multi'          : true,
	    'auto'           : false,
	    'sizeLimit'      : 1024*1024*10, 
	    'simUploadLimit' : 2,
	    'buttonImg'      : '<%=basePath%>images/attach.png', 
	    'height'         : 20,
	    'width'          : 50,
	    'cancelImg'      : 'images/cancel.png',
	    'wmode'          : 'transparent' ,
	    //事件
	    onSelect :function(event,queueId,fileObj){
	    	$("#fujian").css("display","table-row"); 
	    	var bytes = Math.round(fileObj.size / 1024);
	    	$("#divComposeAttachContent ul").append(
	    	"<li id='"+queueId +"'>"+
			"<span class=\"ico_attState\"></span>"+
			"<span class=\"person\">"+fileObj.name+"</span><div class='progress' id='progress'>"+
			"<span class=\"g-pro\"><span class=\"g-pro-inner p_bar\" style=\"width:0%\"></span></span>"+
			"<span class=\"bc p_pa\">0%</span>"+
			"<span class=\"bc\">已上传<em class='p_c'>0K</em>，文件大小<em>"+bytes+"K</em></span></div>"+
			"<span class=\"bW\"><a href=\"javascript:$('#uploadify').uploadifyCancel('"+queueId+"')\">删除</a></span>"+
			"</li>"
	    	);
	    },
	    onClearQueue : function(event){
	    	$("#divComposeAttachContent ul").empty();
	    	$("#fujian").css("display","none");
	    },
	    onCancel :function(event,queueId,fileObj,data){
	    	$("#"+queueId).remove();
	    	if($("#fujian").find("li").size() == 0)
	    		$("#fujian").css("display","none");
	    },
	    onProgress : function(event,queueId,fileObj,data){
	    	var bytes = Math.round(data.bytesLoaded / 1024);
	    	$("#"+queueId).find(".p_bar").css("width",data.percentage+"%");
	    	$("#"+queueId).find(".p_pa").text(data.percentage+"%");
	    	$("#"+queueId).find(".p_c").text(bytes+"K");
	    	$("#"+queueId).find("a").attr("href","javascript:deleteAttach('"+queueId+"','"+fileObj.name+"')");//删除以上传的附件
	    	return false;
	    },
	    onComplete : function (event, queueId, fileObj, response, data){ 
	    	if(response == 1)
	    		$("#"+queueId).addClass("success");
	    	else 
	    		$("#"+queueId).addClass("error");
	    },
	    onError : function(event,queueId,fileObj,errorObj){
	    	$("#"+queueId).addClass("error");
	    	if(fileObj.size>1024*1024*10){
	    		alert("你上传的 \“"+fileObj.name+"\” 文件过大，请上传小于10M的附件。");
	    	}
	    }
	   });
	});
	//删除附件
	function deleteAttach(queueId,name){
		$("#"+queueId).remove();
		if($("#fujian").find("li").size() == 0)
    		$("#fujian").css("display","none");
		$.ajax({
			   type: "POST",
			   url: "<%=basePath%>user/fileUpload!deleteAtt.action",
			   data: "fileName="+name+"&userName=${user.name}"
		});
	}
	//保存到草稿箱
	function saveDraft(){
		showProgress("正在保存到草稿箱...");//显示保存进度
		var fckeditor = FCKeditorAPI.GetInstance('mailInfoFB.content');
	    var content = fckeditor.GetHTML().replace(/\&nbsp;/g," "); //正文内容 ,替换正文中的空格
	    var subject = $("#i_subject").val();//获取邮件主题
	    if(subject=="" || subject.length<=0){
	    	var  date = new Date();
	    	subject = date.getFullYear()+"年"+(date.getMonth()+1)+"月"+date.getDate()+"日 "+date.getHours()+":"+date.getMinutes()+" "+date.getSeconds();
	    }
	    var parm = "mailInfoFB.from="+$("#i_from").val()+"&mailInfoFB.to="+$("#i_rescive").val()+"&mailInfoFB.cc="+$("#i_cc").val()+"&mailInfoFB.bcc="+$("#i_bcc").val()
		   +"&mailInfoFB.subject="+subject+"&mailInfoFB.content="+content;
	    if($("#i_sended").attr("checked")=='checked'){parm+="&mailInfoFB.sended="+$("#i_sended").val();}
	    if($("#i_exigence").attr("checked")=='checked'){parm+="&mailInfoFB.exigence="+$("#i_exigence").val();}
	    if($("#i_text").attr("checked")=='checked'){parm+="&mailInfoFB.text="+$("#i_text").val();}
	    if($("#i_time").attr("checked")=='checked'){parm+="&mailInfoFB.time="+$("#i_time").val();}
		$.ajax({
			   type: "POST",
			   url: "<%=basePath%>user/sendMail!saveDraft.action",
			   data: parm,
			   dataType:"text",
			   success: function (data, textStatus) {
				   hiddenProgress();//隐藏进度条
				   if(data=='true'){$("#messageDiv" ,window.parent.document).removeClass("error").addClass("success"); $("#message" ,window.parent.document).empty().append("已将邮件保存到草稿箱！");}
				   else {$("#messageDiv" ,window.parent.document).removeClass("success").addClass("error"); $("#message" ,window.parent.document).empty().append("邮件保存到草稿箱失败！");}
			   }
		});
	}
	//发送邮件(检测收件人)
	var reg = /^((\w+([-_.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*;)|(".*"<\w+([-_.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*>;))*((\w+([-_.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*(;?))|(".*"<\w+([-_.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*>(;?)))$/;
	function checkTo(){
		var to =$.trim($("#i_rescive").val());
		var sub = $("#i_subject").val();
		var con = $("#i_content").val();
		var cc =$.trim($("#i_cc").val());
		var bcc =$.trim($("#i_bcc").val());
		if(to == "" || to.length==0){
			alert("请填写联系人！");return ;
		} 
		if(sub == "" || sub.length==0){
			alert("请填写邮件主题！");return ;
		} 
		if(to != "" && to.length>0){
			if(!reg.test(to)){
					alert("你输入的收件人地址不正确!");return ;
			}
		} 
		if(cc != "" && cc.length>0){
			if(!reg.test(cc)){
				alert("你输入的抄送人地址不正确!");return ;
			}
		} 
		if(bcc != "" && bcc.length>0){
			if(!reg.test(bcc)){
				alert("你输入的密送人地址不正确!");return ;
			}
		} 
			showProgress("正在发送邮件...");//显示保存进度
			$("#sendmail").submit();
		
	}
	function showProgress(value){
		$("#divProgress").css("display","block");
		$("#spanProgress").empty().append(value);
	}
	function hiddenProgress(){
		$("#divProgress").css("display","none");
		$("#spanProgress").empty();
	}
</script>
<style type="text/css">
.bottom{width:auto;}
.top {height: 30px;padding-left: 10px;padding-top: 5px;background: #A5E6E9;}
.list{background-color:#FFFFFF;width:180px;height:516px;border:2px solid #A5E6E9; float:right;position: relative; }
.title{ margin:0px;padding:0px;margin-left:15px;margin-top:5px;margin-bottom:10px;}
.menu{color:black;}
.childMenu{color:#565656;margin-left:45px;}
.menu:hover,.childMenu:hover{ cursor:pointer}
.sendMail{width:auto;overflow:hidden; border:2px solid  #A5E6E9;}
.send tr td{padding-bottom:5px; padding-top:5px; height:auto;}
.table{margin-top:10px;}
.label{ text-align:right;padding-right:5px; padding-left:15px; width:55px}
.s_input{width:100%;height:26px;font-size: 12px;font-family: Verdana,Geneva,sans-serif;}
.person{font-family: Verdana, Geneva, sans-serif;}
.send tr td a:link,a:visited{text-decoration:underline;color:#005590;}
.send tr td  a:hover {text-decoration:none; }
 input:focus ,textarea:focus{ background-color: #FFFFE1}
.content{width:auto; overflow:hidden; }
.bar{width:8px; height: 60px; float: right; padding-top: 250px;}
.hidenLinkman{background-image: url("<%=basePath %>images/f1.gif"); display: block; background-position: -1312px 0px; width:8px;height: 60px;}
.hidenLinkman:hover{background-position: -1280px 0px;}
.showLinkman{background-position: -1312px -95px;}
.showLinkman:hover{background-position: -1280px -95px;}
#searchl{position: absolute;padding: 0px;margin: 0px;background-color:  #DDF2E0; width:180px; overflow: auto;}
#searchl ul li,#searchl ul, .cn ul li ,.cn ul{padding: 0px;margin: 0px;list-style: none;}
.linkman{overflow: auto;height:446px;}
hr{color: #F0F0F0}
.cls_btn{background-image: url("<%=basePath %>images/f1.gif"); background-position: -575px -160px;}
.cls_btn:hover{background-position: -575px -128px;}
.splk:hover{text-decoration: underline;cursor: pointer;}
.cn{height: auto;}
.ico_attState{background-image: url("<%=basePath %>images/ico.gif");  background-position: -135px -8px; width:16px;height: 14px; display:inline-block;}
.bc{margin-right: 5px;vertical-align: middle;}
.br{color:#565656;}
.g-pro{width: 100px; display:inline-block;height:7px;border:1px solid #ccc;background:#fff;padding:1px;overflow:hidden;vertical-align: middle;}
.g-pro-inner{vertical-align: top;display:inline-block;height:7px;display:inline-block;background-color:#00CC33}
.addAttachment,.progress{display:inline-block;}
#uploadifyUploader{vertical-align: middle;}
#divComposeAttachContent ul li {display:block;padding: 0px;margin: 0px;list-style: none;}
#divComposeAttachContent span{margin-right: 5px;}
.error{ background-color: #FDE5DD ;border: 1px solid #FBCBBC ;}
.success{ background-color: #D6FADD ;border: 1px solid #DDF2E0;}
.divProgress{height: 18px; width: auto; position: absolute;margin: 0 auto; padding: 5px 10px;left: 100px; top: 0px;background-color: #E6A800; display: none;}
.proImag{background-image: url("<%=basePath %>images/loading.gif");display: inline-block; width: 16px;height: 16px;}
#spanProgress{vertical-align: middle;padding-left: 10px; color: white;}
</style>
</head>

<body>
<div class="main">
<div class="divProgress" id="divProgress"><span class="proImag"></span><span id="spanProgress"></span></div>
<!--顶部-->
<h2>写信</h2>
<div class="top">
<input type="button" title="发信" value="发&nbsp;信" onclick="checkTo()"/>
<input type="button" title="存草稿" value="存草稿" onclick="saveDraft()"/>
<input type="button" title="取消" value="取&nbsp;消" onclick="javascript:window.history.back();"/>
</div>
<!--底部-->
<div class="bottom">
<!--联系人div-->
<div id="list_linkman" class="list">
<h3 class="title">通讯录</h3>
<div class="tootle">
   <input type="text" name="name" class="l input" value="请输入联系人..." title="请输入要查找的联系人" id="input" onfocus="clearValue()" onkeyup="search()"/>
   <input type="button" class="sch_btn" title="根据联系人姓名或邮件地址搜索联系人"  id="sb"/>
</div>
<div id="searchl">
</div>
<div class="linkman" id="menulinkman">
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class="table">
<!--循环开始-->
<%int sum=0; %>
<s:iterator status="su" value="user.group" var="u">
<tr class="group">
	<td>
    <img src="<%=basePath %>images/jia.gif" border="0" alt="展开" id="img1" />
	<span class="menu" title="${u.name}">${u.name}(<s:property value="#u.linkmans.size"/>)</span>
	<s:set value="#u.linkmans.size" var="size"></s:set>
	<%sum +=(Integer)(pageContext.getAttribute("size"));  %>
	</td>
</tr>
<!-- 数状导航图显示子菜单 -->
<tr id="OpenRep1" style="display:none;" class="lk">                         
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
        	<!--联系人列表开始-->
        	<s:iterator value="#u.linkmans" status="slk" var="lk">
			<tr><td><span class="childMenu" title='"${lk.name}"&lt;${lk.emailAdd}&gt;' onclick="add(this)">${lk.name}</span></td></tr>
            <!--联系人列表结束-->
            </s:iterator>
		</table>
	</td>
</tr>
<!--循环结束-->
</s:iterator>
<tr class="group">
	<td>
    <img src="<%=basePath %>images/jia.gif" border="0" alt="展开" id="img1" />
	<span class="menu" title="所有">所有(<%=sum %>)</span>
	</td>
</tr>
<!-- 数状导航图显示子菜单 -->
<tr id="OpenRep1" style="display:none;" class="lk">                         
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" id="allLinkman">
        	<!--联系人列表开始-->
        	<s:iterator value="user.group" var="u">
        	<s:iterator value="#u.linkmans" status="slk" var="lk">
			<tr><td><span class="childMenu" title='"${lk.name}"&lt;${lk.emailAdd}&gt;' onclick="add(this)">${lk.name}</span></td></tr>
            <!--联系人列表结束-->
            </s:iterator>
            </s:iterator>
		</table>
	</td>
</tr>
</table>
</div>
</div>
<!--联系人div结束-->

<!--底部左边-->
<div class="sendMail" id="sendmailInfo">
<!-- 显示隐藏条 开始-->
<div class="bar">
<span class="hidenLinkman" id="hidenLinkman"></span>
</div>
<!-- 显示隐藏条 结束-->
<div class="content">
<form action="<%=basePath %>user/sendMail!sendEmail.action" method="post" id="sendmail">
<table class="send"  width="99%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td class="label">发件人:</td>
	<s:set var="alias" value="user.userInfo.alias"></s:set>
	<%String name = ""; %>
    <td><span class="person">
    	<s:if test='#alias!=null&&#alias!=""'>"${alias}"<%name="\""+pageContext.getAttribute("alias")+"\"&lt;"+user.getName()+"@abc.com&gt;";%></s:if>
    		<s:else>"${user.name}"<%name="\""+user.getName()+"\"&lt;"+user.getName()+"@abc.com&gt;";%></s:else>&lt;${user.name}@abc.com&gt;
    	</span>
    	<input type="hidden" name="mailInfoFB.from" value='<%=name %>' id="i_from"/>
    </td>
    <td align="right"><a href="javascript:bb()" id="acc">添加抄送</a>&nbsp;|&nbsp;<a href="javascript:cbb()" id="abcc">添加密送</a></td>
</tr>
<tr>
	<td class="label">收件人:</td>
    <td class="e_input" colspan="2"><textarea  title="多个收件人请以分号(;)分隔"  class="s_input" id="i_rescive" onfocus="inputfocus()"  name="mailInfoFB.to"><s:property value="mailInfoFB.to"/></textarea></td>
</tr>
<tr id="cc" style="display: none;">
	<td class="label">抄送:</td>
    <td class="e_input" colspan="2"><textarea  title="多个抄送人请以分号(;)分隔"  class="s_input" id="i_cc" onfocus="inputfocus()"  name="mailInfoFB.cc"></textarea></td>
</tr>
<tr id="bcc" style="display: none;">
	<td class="label">密送:</td>
    <td class="e_input" colspan="2"><textarea   title="多个密送人请以分号(;)分隔"  class="s_input" id="i_bcc" onfocus="inputfocus()"  name="mailInfoFB.bcc"></textarea></td>
</tr>
<tr id="subject">
	<td class="label">主题:</td>
    <td class="e_input" colspan="2"><input type="text" title="邮件主题"  class="s_input" id="i_subject" name="mailInfoFB.subject" value='<s:property value="mailInfoFB.subject"/>'/></td>
</tr>
<tr id="addfujian">
	<td class="label"></td>
    <td class="e_input" colspan="2">
    <div class="addAttachment">
    	<input type="file" name="fileDate" id="uploadify" title="添加小于20M的文件作为附件" /> 
		<a href="javascript:$('#uploadify').uploadifyUpload()">开始上传</a>
		<a href="javascript:$('#uploadify').uploadifyClearQueue()">取消上传</a>
	</div>
	</td>
</tr>
<tr id="fujian" style="display: none;">
	<td class="label"></td>
    <td class="e_input" colspan="2" style="background-color: #F0F0F0;">
    <div class="attach">
    <div id="divComposeAttachContent" class="cn">
		<ul>
			<!-- 上传附件列表 -->
		</ul>
	</div>
</div>
    </td>
</tr>
<tr id="content">
	<td class="label">内容:</td>
	<s:set var="content" value="mailInfoFB.content" scope="page"/>
    <td class="e_input" colspan="2"><fck:editor instanceName="mailInfoFB.content" height="300px" basePath="/fckeditor"  value='<%=(String)pageContext.getAttribute("content")%>'/></td>
</tr>
<tr>
	<td class="label"></td>
    <td class="e_input" colspan="2"><input type="checkbox"  name="mailInfoFB.sended" value="true" id="i_sended"/>保存到"已发送"&nbsp;&nbsp;
    <input type="checkbox"  name="mailInfoFB.exigence" value="true" id="i_exigence"/>紧急&nbsp;&nbsp;
    <input type="checkbox"  name="mailInfoFB.text" value="true" id="i_text"/>纯文本&nbsp;&nbsp;
    <input type="checkbox"  name="mailInfoFB.time" value="true" id="i_time"/>定时发送&nbsp;&nbsp;
    </td>
</tr>
</table>
</form>
</div>
</div>
<!-- 底部左边结束  -->
</div>
<div class="top">
<input type="button" title="发信" value="发&nbsp;信" onclick="checkTo()"/>
<input type="button" title="存草稿" value="存草稿" onclick="saveDraft()"/>
<input type="button" title="取消" value="取&nbsp;消" onclick="javascript:window.history.back();"/>
</div>
</div>
<br/>
</body>
</html>
