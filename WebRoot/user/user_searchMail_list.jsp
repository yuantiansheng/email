<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="user_is_login.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>收取电子邮件</title>
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
       		<div class="menu">
       		<c:if test="${ft != 4}">
            <input type="button"value="删 除" onclick="searchDeleteMail('${content}')" />
            </c:if>
            <input  type="button" value="彻底删除" onclick="searchDeleteMailForver('${content}')" />
			<select class="sel" onchange="searchMark('${content}')" id="mark">
				<option value="none" selected>标记为...</option>
				<option value="markRead">&nbsp;&nbsp;已读邮件</option>
				<option value="markUnread">&nbsp;&nbsp;未读邮件</option>
			</select>
  
			<select class="sel" onchange="searchMove('${content}')" id="move" >
  				<option value="none" selected>移动到...</option>
  				<c:if test="${ft != 2}"><option value="moveDraft">&nbsp;&nbsp;草稿箱</option></c:if>
				<c:if test="${ft != 3}"><option value="moveSended">&nbsp;&nbsp;已发送</option></c:if>
                <c:if test="${ft != 4}"><option value="moveDelete">&nbsp;&nbsp;已删除</option></c:if>
                <c:if test="${ft != 1}"><option value="moveInbox">&nbsp;&nbsp;收件箱</option></c:if>
                 <c:if test="${ft != 5}"><option value="moveSpam">&nbsp;&nbsp;垃圾邮件</option></c:if>
			</select>
            </div>
             <div class="page">
             <!-- -------------------------分页开始------------------------------------------>
       		<span class="txt">
       			<c:if test="${(type != 'seeUnread') &&(type != 'seeRead')}">
       			<span class="unable"><a href="<%=basePath%>user/search.action?folderType=${ft}&searchMailFB.content=${content}&page=1" >首页</a></span>&nbsp;
       			<c:forEach var="wp" begin="${pageView.pageindex.startIndex}" end="${pageView.pageindex.endIndex}">
       			<c:if test="${pageView.currentpage == wp}"><b>${wp}</b></c:if>
       			<c:if test="${pageView.currentpage != wp}">
       			<span class="unable"><a href="<%=basePath%>user/search.action?folderType=${ft}&searchMailFB.content=${content}&page=${wp}" >${wp}</a></span>&nbsp;</c:if>
       			</c:forEach>
       			<span class="unable"><a href="<%=basePath%>user/search.action?folderType=${ft}&searchMailFB.content=${content}&page=${pageView.totalpage}" >末页</a></span>
       			</c:if>
       		</span>
       		<!-- -------------------------分页结束-------------------------------------------->
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
    			<td class="ibx_th_from" title="${mail.from}" onclick="readMail('${mail.messageUID}')"><a href="javascript:void(0)" ><%=from %></a></td>
    			<td class="ibx_th_subject" title="${mail.subject}" onclick="readMail('${mail.messageUID}')"><a href="javascript:void(0)"><%=subject %></a></td>
    			
    			<td class="ibx_th_icoinfo"><c:if  test="${mail.file!=null}"><b class="attachment" title="${mail.file}" ></b></c:if></td>
    			<td class="ibx_th_date" title='<s:date name="#mail.date" format="yyyy年MM月dd日 HH:mm ss EE" />' onclick="readMail('${mail.messageUID}')"><b class="font_14"><s:date name="#mail.date" format="M月d日" /></b></td>
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

