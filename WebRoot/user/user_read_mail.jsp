<%@page import="javax.swing.filechooser.FileNameExtensionFilter"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_is_login.jsp" %>
<%! String fileName[] =null; %>
<s:set var="ft" value="folderType" scope="page"></s:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>收取邮件</title>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.6.2.min.js"></script> 
<script type="text/javascript" src="<%=basePath %>js/user_receive_mail.js"></script>
<script type="text/javascript">
$(function(){
	setInfo("<%=basePath%>","${ft}","${page}");
});
</script>
<style type="text/css">
body, input, select, button, textarea {font-family: verdana;}
body {color: #000000;font-size: 12px;line-height: 166.6%;margin: 0;padding: 0;}
.main{margin:10px;}
h2{border: 0 none;margin: 0;padding: 0; font-size: 14px;padding-left:10px; padding-top:10px;}
.infotable{ margin-top:10px;}
.mailinfo{ background-color:#DDF2E0; border-bottom:1px solid #99B1C4;}
table tr td{ padding-bottom:5px; text-align:right;padding-left:10px; }
table .mailmessage{text-align:left;color: #7D7D7D;}
.mail_content{ height:auto;width:auto ; overflow:hidden}
.att_mail{padding:3px 10px; background-color:#DDF2E0;font-size: 14px; }
.attachment{border:1px solid #99B1C4;}
.reply{border-top:1px solid #99B1C4;margin-top:10px; background-color:#DDF2E0; padding-bottom:1px;}
.reply_mail{border:1px solid #99B1C4;height: 58px; width:504px;background-color:#FFFFFF; margin:10px   10px;}
.replay_textarea{ float:left; background: none repeat scroll 0 50% transparent;font-size: 12px;color: #7D7D7D;
    border: 0 none;
    height: 56px;
    outline: 0 none;
    overflow: auto;
    padding: 2px;
    resize: none;
    width: 420px;}
.replay_button{height: 56px;width: 80px;}
.top {
    background: none repeat scroll 0 0 #A5E6E9;
    height: 30px;
    padding-left: 10px;
    padding-top: 5px;
}
.ta_focus{color: black;}
</style>
</head>
<body>
<div class="main">
	<!--工具条开始-->
	<div class="top">
	<input type="button"  onclick="replyMail('${mailBean.messageUID}')" value="转 发" title="转发该邮件" />
	<c:if test="${ft != 4}">
	<input class="btn del_btn"  type="button"value="删 除" onclick="dMail('${mailBean.messageUID}')" />
	 </c:if>
	<input class="btn"  type="button" value="彻底删除" onclick="dMailForver('${mailBean.messageUID}')" />
    <select class="sel" onchange="mMail('${mailBean.messageUID}')" id="move" >
  		<option value="none" selected="selected">移动到...</option>
  		<c:if test="${ft != 2}"><option value="moveDraft">&nbsp;&nbsp;草稿箱</option></c:if>
		<c:if test="${ft != 3}"><option value="moveSended">&nbsp;&nbsp;已发送</option></c:if>
        <c:if test="${ft != 4}"><option value="moveDelete">&nbsp;&nbsp;已删除</option></c:if>
        <c:if test="${ft != 1}"><option value="moveInbox">&nbsp;&nbsp;收件箱</option></c:if>
        <c:if test="${ft != 5}"><option value="moveSpam">&nbsp;&nbsp;垃圾邮件</option></c:if>
	</select>
	<a href="javascript:window.history.back()">&lt;&lt;返回</a>
	</div>
    <!--工具条结束-->
    
    <!--邮件信息开始-->
    <div class="mailinfo">
    <h2>${mailBean.subject}</h2>
    <table  border="0" cellpadding="0" cellspacing="0" class="infotable">
    <tr>
    	<td><span class="info">发件人:</span></td>
    	<s:set var="from" value="mailBean.from" scope="page"></s:set>
    	<s:set  var="to" value="mailBean.to" scope="page"/>
        <s:set  var="cc" value="mailBean.cc" scope="page"/>
    	<%
    	String from =(String) pageContext.getAttribute("from"); 
    	from = from.replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll(",",";&nbsp;&nbsp;");// 发件人
    	String to = (String)pageContext.getAttribute("to"); 
        to = to.replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll(",",";&nbsp;&nbsp;");//收件人
        String cc = (String)pageContext.getAttribute("cc"); 
        if(cc != null && !"".equals(cc))
            cc = cc.replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll(",",";&nbsp;&nbsp;");//抄送人
    	%>
        <td class="mailmessage"><%=from %></td>
    </tr>
    <tr>
    	<td><span class="info">时&nbsp;&nbsp;&nbsp;间:</span></td>
        <td class="mailmessage"><s:date name="mailBean.date" format="yyyy年MM月dd日 HH:mm ss EE" /></td>
    </tr>
    <tr>
    	<td><span class="info">收件人:</span></td>
        <td class="mailmessage"><%=to %></td>
    </tr>
    <c:if test="${mailBean.cc != null}">
    <tr>
    	<td><span class="info">抄送人:</span></td>
        <td class="mailmessage"><%=cc %></td>
    </tr>
    </c:if>
    <s:set var="file" value="mailBean.file" scope="page"></s:set>
    <c:if test="${file != null}">
    <tr>
    	<td><span class="info">附&nbsp;&nbsp;&nbsp;件:</span></td>
        <td class="mailmessage"><%fileName = ((String)pageContext.getAttribute("file")).split(","); %><%=fileName.length %>个</td>
    </tr>
    </c:if>
    </table>
    </div>
    <!--邮件信息结束-->
    <!--正文信息开始-->
    <div class="content">
	<jsp:include page="/readMail.html"/>
    </div>
    <!--正文信息结束-->
    
    <c:if test="${file != null}">
    <!--附件列表开始-->
    <div class="attachment">
    <div class="att_mail"><strong>附件(<%=fileName.length %>个)</strong></div>
    <div class="att_table">
    	 <table  border="0" cellpadding="0" cellspacing="0">
    	 <%for(int i = 0;i<fileName.length;i++) {%>
         <tr><td style="text-align: left;"><%=fileName[i]%></td><td  style="text-align: left;"><span style="color: #7D7D7D;"></span></td><td  style="text-align: left;">
         <a href='<%=basePath %>user/receive!attachmentDownload.action?fileName=<%=fileName[i] %>&folderType=${ft}&uid=${mailBean.messageUID}'>下载</a>
         </td></tr>
         <%} %>
    	</table>
    </div>
    </div>
    <!--附件列表结束-->
    </c:if>
    
    <!--快速回复开始-->
    <div class="reply">
    <h2>快速回复</h2>
    <div class="reply_mail" >
    	<textarea class="replay_textarea" id="reply_q" onfocus="textareaFocus('<%=from %>')" onblur="textareaOnblur('<%=from %>')" >快速回复给 :<%=from %></textarea>
        <button class="replay_button" onclick="quecklyReply('<%=from %>')" >发送</button>
    </div>
    </div>
    <!--快速回复结束-->

<!--工具条开始-->
	<div class="top">
	<input type="button"  onclick="replyMail('${mailBean.messageUID}')" value="转 发" title="转发该邮件" />
	<c:if test="${ft != 4}">
	<input class="btn del_btn"  type="button"value="删 除" onclick="dMail('${mailBean.messageUID}')" />
	 </c:if>
	<input class="btn"  type="button" value="彻底删除" onclick="dMailForver('${mailBean.messageUID}')" />
    <select class="sel" onchange="mMail('${mailBean.messageUID}')" id="move" >
  		<option value="none" selected="selected">移动到...</option>
  		<c:if test="${ft != 2}"><option value="moveDraft">&nbsp;&nbsp;草稿箱</option></c:if>
		<c:if test="${ft != 3}"><option value="moveSended">&nbsp;&nbsp;已发送</option></c:if>
        <c:if test="${ft != 4}"><option value="moveDelete">&nbsp;&nbsp;已删除</option></c:if>
        <c:if test="${ft != 1}"><option value="moveInbox">&nbsp;&nbsp;收件箱</option></c:if>
        <c:if test="${ft != 5}"><option value="moveSpam">&nbsp;&nbsp;垃圾邮件</option></c:if>
	</select>
	<a href="javascript:window.history.back()">&lt;&lt;返回</a>
	</div>
    <!--工具条结束-->
</div>
<br/>
</body>
</html>
