<%@ page language="java" import="java.util.*,cn.edu.pdsu.action.user.UserLoginAction,cn.edu.pdsu.bean.User" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User)session.getAttribute(UserLoginAction.USER_SESSION);
if(user==null)
	 response.sendRedirect(basePath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link type="text/css" rel="stylesheet" href="<%=basePath %>css/main.css"/>
<title>邮箱</title>
<script src="<%=basePath %>js/jquery-1.6.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>js/ResetWinHeight.js"></script>
</head>
<body>
<!--主div-->
<div class="main">
	<div id="messageDiv" class="message" align="center" >
		<span id="message"></span>
	</div>
   <!--上边-->
   <div class="top">
   		<img src="<%=basePath %>images/logo_main.png"  alt="logo" class="logo"/>
        <div class="top_titile">
       		 <div class="name">
             	<ul>
                	<li>
                    	 <span>&lt;<s:property value="user.name"/>@abc.com&gt;</span>
                    </li><li>[</li>
                    <li>
                    	 <span><a href="<%=basePath %>user/welcome.jsp" target="content">首页</a></span>
                    </li><li>|</li>
                    <li>
                    	 <span><a href="<%=basePath %>user/welcome.jsp" target="content">换肤</a></span>
                    </li><li>]</li>
                </ul>
       			
        	 </div>
              <div class="name float_right">
             	<ul>
                    <li>
                    	 <span><a href="<%=basePath %>user/welcome.jsp" target="content">帮助</a></span>
                    </li><li>|</li>
                    <li>
                    	 <span><s:a action="login!userLogout" namespace="/user">退出</s:a></span>
                    </li>
                </ul>
       			
        	 </div>
          </div>
         
        <div class="menu">
        		<!--标题-->
        		<div class="title float_left" id="title">
                 
                </div>
                <!--搜索框-->
                <div class="float_right">
                	<form name="search" action="<%=basePath %>user/search.action" method="get" id="searchMail" target="content">
						<span >
                        <a class="sch_hbtn float_right" title="高级搜索" href="<%=basePath %>user/user_search_mail.jsp" target="content"></a>
                        <input class="sch_btn float_right" title="立即搜索" type="button"  value="" onclick="checkSubmit()" /> 			
                        <input class="ipt float_right" maxlength=50 value="搜索邮件..." name="searchMailFB.content" onfocus="clearValue()" id="input"/>
						</span>
					</form>
                </div>
        </div>
   </div>
   <!--下边-->
   <div class="bottom">
    <hr class="sperater"/>
   	<!--左边-->
    <div class="left" id="left">
    <table class="tbsb"  cellspacing=0 cellpadding=0 width="100%" border=0>
  	<tbody>
  		<tr>
   			 <td class="tbsbtop"><!-- 收写信大按钮 -->
     		 <h1 class="bigbtnwp"><a class="ashouxin" id="lnkinbox" title="收信" href="<%=basePath %>user/receive.action?folderType=1" target="content"></a>
             <a class="axiexin" title="写信"  href="<%=basePath %>user/sendMail.action" target="content"></a>
             </h1>
             </td>
        </tr>
        <tr>
		<td>
        <div class="list" id="list">
        <ul>
        <li class="receive">
        <a href="<%=basePath %>user/receive.action?folderType=1" target="content"><span>收件箱</span></a>
        </li>
        <li class="drift">
        <a href="<%=basePath %>user/receive.action?folderType=2" target="content"><span> 草稿箱</span></a>
        </li>
        <li class="sended">
        <a href="<%=basePath %>user/receive.action?folderType=3" target="content"><span> 已发送</span></a>
        </li>
        <li class="deleted">
        <a href="<%=basePath %>user/receive.action?folderType=4" target="content"><span>已删除</span></a>
        </li>
        <li class="spam">
        <a href="<%=basePath %>user/receive.action?folderType=5" target="content"><span>垃圾邮件</span></a>
        </li>
        </ul>
        <!--左边功能列表开始-->
        <div class="sb_line"></div><!--分割线-->	
        <!--通讯录-->
        <ul>
        <li class="linkman font_20">
        <a href="<%=basePath %>user/linkman.action" target="content"><span >通讯录</span></a>
        </li>
        </ul>
         <div class="sb_line"></div><!--分割线-->
          <!--自己的信息-->
        <ul>
        <li class="person font_20">
        <a href="<%=basePath %>user/user_set_info_welcome.jsp" target="content"><span >个人信息</span></a>
        </li>
        </ul>	
        </div>    
	  </td></tr>
     </tbody>
     </table>
    
    </div>
    <!--右边内容区-->
    <div class="right"  id="content">
 <iframe width="100%" align="center"  id="rightcontent" name="content" onload="SetWinHeight()" frameborder="0" scrolling="no" src="<%=basePath %>user/welcome.jsp"></iframe> 
    </div>
   </div>
</div>
</body>
</html>

