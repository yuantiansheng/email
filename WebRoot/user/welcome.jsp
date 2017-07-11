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
<title>欢迎页面</title>
<style type="text/css">
.fc{font-size:28px}
.c{color:#437ca0;}
.sperater{
	border:solid 2px #A5E6E9;
	width:800px;		
}
.me{font-size:20px}
.red{color:#FF3333}
/*万年历*/
body,td,.p1,.p2,.i{font-family:arial}
body{margin:6px 0 0 0;background-color:#fff;color:#000;position:relative}
input{padding-top:0;padding-bottom:0;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;box-sizing:border-box;}
table{border:0}
TD{FONT-SIZE:9pt;LINE-HEIGHT:18px;}
em{font-style:normal;color:#cc0000}
a em{text-decoration:underline;}

#cal{width:434px;border:1px solid #c3d9ff;font-size:12px;margin:8px 0 0 15px;}
#cal #top{height:29px;line-height:29px;background:#e7eef8;color:#003784;padding-left:70px;}
#cal #top select{font-size:12px;}
#cal #top input{padding:0;visibility: visible;}
#cal ul#wk{margin:0;padding:0;height:25px;}
#cal ul#wk li{float:left;width:60px;text-align:center;line-height:25px;list-style:none;}
#cal ul#wk li b{font-weight:normal;color:#c60b02;}
#cal #cm{clear:left;border-top:1px solid #ddd;border-bottom:1px dotted #ddd;position:relative;}
#cal #cm .cell{position:absolute;width:42px;height:36px;text-align:center;margin:0 0 0 9px;}
#cal #cm .cell .so{font:bold 16px arial;}
#cal #bm{text-align:right;height:24px;line-height:24px;padding:0 13px 0 0;}
#cal #bm a{color:#7977ce;}
#cal #fd{display:none;position:absolute;border:1px solid #dddddf;background:#feffcd;padding:10px;line-height:21px;width:150px;}
#cal #fd b{font-weight:normal;color:#c60a00;}
</style>
</head>
<body>
<center>
<samp class="fc c">欢迎&nbsp;<span class="red"><%=user.getName() %></span></samp>
<hr class="sperater" />
<table cellpadding="0" cellspacing="0"><tr><td>
<div id="cal"><div id="top">公元&nbsp;<select></select>&nbsp;年&nbsp;<select></select>&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;农历<span></span>年&nbsp;[&nbsp;<span></span>年&nbsp;]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="今天" title="点击后跳转回今天" /></div><ul id="wk"><li>一</li><li>二</li><li>三</li><li>四</li><li>五</li><li><b>六</b></li><li><b>日</b></li></ul><div id="cm"></div><div id="bm"><a target="_blank" onMouseDown="return c({'fm':'alop','title':this.innerHTML,'url':this.href,'p1':al_c(this),'p2':1})" href="javascript:void(0)">历史上的今天</a></div></div>
<script type="text/javascript" src="<%=basePath %>js/bdcalendar.js"></script>
</td></tr></table>
<br />
<br />
<br />
</center>
</body>
</html>

