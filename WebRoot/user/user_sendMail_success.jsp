<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="user_is_login.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <script type="text/javascript">
    </script>
	<style type="text/css">
	html {border-bottom: 0px; border-left: 0px; height: 100%; border-top: 0px; border-right: 0px; }
	body,div{ padding:0px; margin:0px;font-size:12px; font-family: Verdana,Geneva,sans-serif;}
	h3 ul li,h3 ul{padding:0px; margin:0px;list-style: none;}
	h4{color:#005590;padding:0px; margin:0px; padding-top: 15px;}
	.errorMessage{color: #FF3333}
	.successMessage{color:green;}
	.main{width:97%;height:auto;overflow:hidden;margin-top:10px;margin-left:20px;margin-bottom:10px;margin-right:25px;}
	.linkman{color: #565656; width:100%;height: auto;}
	</style>
  </head>
  
  <body>
  	<div class="main">
      <s:set  var="success" value="mailInfoFB.sended" scope="page"/>
      <s:set  var="from" value="mailInfoFB.from" scope="page"/>
      <s:set  var="to" value="mailInfoFB.to" scope="page"/>
      <s:set  var="cc" value="mailInfoFB.cc" scope="page"/>
      <s:set  var="bcc" value="mailInfoFB.bcc" scope="page"/>
      <%
      boolean success = (Boolean)pageContext.getAttribute("success");//是否发送成功
      String from = (String)pageContext.getAttribute("from"); //消息信息
      String to = (String)pageContext.getAttribute("to"); 
      to = to.replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll(",",";&nbsp;&nbsp;");//收件人
      String cc = (String)pageContext.getAttribute("cc"); 
      if(cc != null && !"".equals(cc))
      cc = cc.replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll(",",";&nbsp;&nbsp;");//抄送人
      String bcc = (String)pageContext.getAttribute("bcc"); 
      if(bcc != null && !"".equals(bcc))
      bcc = bcc.replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll(",",";&nbsp;&nbsp;");//密送人
      %>
       <h3 <%if(success) {%>class="successMessage"<%}else{ %> class="errorMessage"<%} %>><%=from %></h3>
      <hr color="#99B1C4">
      <h4>收件人</h4>
      <hr color="#99B1C4">
      <p class="linkman" id="i_to"><%=to %></p>
      <%if(cc != null && !"".equals(cc)) {%>
      <h4>抄送人</h4>
      <hr color="#99B1C4">
      <p class="linkman" id="i_cc"><%=cc %></p>
     <%} %>
      
     <%if(bcc != null && !"".equals(bcc)){%>
      <h4>密送人</h4>
       <hr color="#99B1C4">
       <p class="linkman" id="i_bcc"><%=bcc %></p>
        <%} %>
      <div>
      
      <hr color="#99B1C4" style="margin-top: 20px;">
      <input type="button" value="返回收件箱" onclick="javascript:window.location.href='<%=basePath %>user/receive.action'"/> 
       <input type="button" value="继续写信" style="margin-left: 35px;" onclick="javascript:window.location.href='<%=basePath %>user/sendMail.action'"/> 
      &nbsp;&nbsp;<a href="javascript:window.history.back()">&lt;&lt;返回</a>
      </div>
      
     </div>
     <br/>
      <br/>
  </body>
</html>
