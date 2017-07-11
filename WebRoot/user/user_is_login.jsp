<%@ page language="java" import="java.util.*,cn.edu.pdsu.action.user.UserLoginAction,cn.edu.pdsu.bean.User" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
User user = (User)session.getAttribute(UserLoginAction.USER_SESSION);
if(user==null)
	 response.sendRedirect(basePath);
%>