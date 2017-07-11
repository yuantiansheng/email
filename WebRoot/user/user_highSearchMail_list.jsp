<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_is_login.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>高级搜索电子邮件</title>
<link href="<%=basePath %>css/receive.css" type="text/css" rel="stylesheet"/>
<s:set var="ft" value="folderType" scope="page"></s:set>
<s:set var="content" value="searchMailFB.content" scope="page"></s:set>
<script type="text/javascript" src="<%=basePath %>js/jquery-1.6.2.min.js"></script> 
<script type="text/javascript" src="<%=basePath %>js/user_receive_mail.js"></script>
<script type="text/javascript">
$(function(){
	setInfo("<%=basePath%>","${ft}","${pageView.currentpage}");
});
</script>
</head>
<body>
<!--主div-->
<div class="main">
       <!--标题-->
       <div class="title">
      		 <b class="inbox" >
      		 搜索结果
      		 </b>&nbsp;&nbsp;(共&nbsp;<b id="font_14">${pageView.totalrecord}</b>&nbsp;封)
       </div>
       <!--工具-->
       <div class="tool">
       <a href="javascript:window.history.back()">&lt;&lt;返回</a>
       </div>
       <!-- 工具结束 -->
       </div>
       <!--邮件列表-->
       <div class="message">
       <table class="table" id="content_table">
  			<tr>
   				 <th class="ibx_th_f"></th>
   					<th class="ibx_th_chkbx"><input id="select_all_mail" title="全选/不选　本页所有邮件" 
      type="checkbox" name="all" onclick="sel_all_mail()" /></th>
    				<th class="ibx_th_icoinfo"><b class="icoibx" title=邮件类型></b></th>
   					<th class="ibx_th_from">发件人</th>
    				<th class="ibx_th_subject">主题</th>
    				<th class="ibx_th_attach">附件</th>
    				<th class="ibx_th_date">日期</th>
             </tr>
       </table>
       <div class="message_list">
       <table class="table" id="content_list" action="list">
       <!-- -----------------------------------------------邮件列表开始------------------------------------------------------->
       <s:iterator value="pageView.records" var="mail" status="status" >
       			<s:if test="#status.odd">
  				<tr class="odd">
  				</s:if>
  				<s:else>
  				 <tr class="even">
  				</s:else>
    			<td class="ibx_th_f"></td>
  				<td class="ibx_th_chkbx">
  				<c:if test="${mail.read}">
  				<input title="选择/不选" type="checkbox" value="${mail.messageUID}" name="mailid" read="read" /></td>
   			    <td class="ibx_th_icoinfo"><b class="read_message" title="已读邮件" ></b></td>
                <!--未读邮件设置成unread_message，已读邮件设置成read_message-->
                </c:if>
              <c:if test="${!mail.read}">
              	<input title="选择/不选" type="checkbox" value="${mail.messageUID}" name="mailid" read="unread" /></td>
   			    <td class="ibx_th_icoinfo"><b class="unread_message" title="未读邮件" ></b></td>
                <!--未读邮件设置成unread_message，已读邮件设置成read_message-->
                </c:if>
                <s:set var="from" value="#mail.from" scope="page"></s:set>
                <s:set var="subject" value="#mail.subject" scope="page"></s:set>
                <%
    				String from =(String) pageContext.getAttribute("from"); 
    				from = from.replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll(",",";&nbsp;&nbsp;");// 发件人
    				String subject = (String)pageContext.getAttribute("subject");
    				if(subject != null && !"".equals(subject)){
    					subject = subject.replaceAll("<","&lt;").replaceAll(">","&gt;");
    				}
    			%>
    			<td class="ibx_th_from" title="${mail.from}" onclick="highSearchReadMail('${mail.folderType}','${mail.messageUID}')"><a href="javascript:void(0)" ><%=from %></a></td>
    			<td class="ibx_th_subject" title="${mail.subject}" onclick="highSearchReadMail('${mail.folderType}','${mail.messageUID}')"><a href="javascript:void(0)"><%=subject %></a></td>
    			
    			<td class="ibx_th_icoinfo"><c:if  test="${mail.file!=null}"><b class="attachment" title="${mail.file}" ></b></c:if></td>
    			<td class="ibx_th_date" title='<s:date name="#mail.date" format="yyyy年MM月dd日 HH:mm ss EE" />' onclick="highSearchReadMail('${mail.folderType}','${mail.messageUID}')"><b class="font_14"><s:date name="#mail.date" format="M月d日" /></b></td>
             </tr>
        </s:iterator>
          <!-------------------------------------------------邮件列表结束------------------------------------------------------->
    </table>
    <h4 id="oh4check" class="ibx_lst_bextra">
选择：
<a type="all" href="#" onclick="sel_all()">全部</a>
&nbsp;-&nbsp;
<a type="unread" href="#" onclick="sel_all_unread()">未读</a>
&nbsp;-&nbsp;
<a type="read" href="#" onclick="sel_all_read()">已读</a>
&nbsp;-&nbsp;
<a type="reverse" href="#" onclick="sel_reversal()">反选</a>
&nbsp;-&nbsp;
<a type="no" href="#" onclick="sel_no_all()">不选</a>
</h4>
       </div>
       </div>
</div>
<br/>
</body>
</html>

