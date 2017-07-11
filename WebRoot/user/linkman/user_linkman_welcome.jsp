<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link  href="<%=basePath %>css/linkman_welcome.css" type="text/css" rel="stylesheet"/>
		<script type="text/javascript">
			function resend(){
				window.location.href="<%=basePath%>user/linkman!linkmanList.action?group.id=0";
			}
		</script>
	</head>
	<body>
		<div class="main">
			<div class="top">
				<input type="button" title="查看所有的联系人" value="查看所有联系人" onclick="resend()"/>
				<a href="javascript:window.history.back()">&lt;&lt;返回</a>
			</div>
			<div class="bottom">
				<h3>
					通讯录
				</h3>
				<span class="font_color">“通讯录”是存储和查看所有联系人信息的位置。</span>
				<br />
				<span class="font_color">您也可以创建和编辑自己的联系人组，以便能轻松地一次向多人发送电子邮件。</span>
				<br />
				<br />
				<hr color="#99B1C4" />
				<div class="hb">
					<div class="fx">
						<b class="dE user_group"></b>
						<p class="dR">
							<a id="_js4_link_1183_2809" title="" hidefocus="hidefocus"
								href="<%=basePath %>user/linkman/user_add_group.jsp" target="linkman_content">新建联系人分组</a>
						</p>
						<p class="dS">
							以便轻松地一次向多人发信
						</p>
					</div>
					<div class="fx">
						<b class="dE user_add"></b>
						<p class="dR">
							<a id="_js4_link_1183_2809" title="" hidefocus="hidefocus"
								href="<%=basePath %>user/linkman!addLinkmanSkip.action">新建联系人</a>
						</p>
						<p class="dS">
							以便轻松地向某个联系人发信
						</p>
					</div>
				</div>
			</div> 
		</div>
	<br /><br /><br /><br /><br />
	</body>
</html>

