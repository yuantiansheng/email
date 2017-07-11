package cn.edu.pdsu.action.user;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.dao.UserDAO;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：用户登录action
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-16 下午05:00:27
 */
@Controller
@Scope("prototype")
public class UserLoginAction extends ActionSupport implements
		ServletResponseAware, SessionAware, ServletRequestAware {
	private static final long serialVersionUID = 5386429367683022172L;
	public static final String USER_SESSION = "user.session.ljg";
	public static final String USER_PASSWORD = "user.password";// 用户密码
	private HttpServletResponse response;
	private HttpServletRequest request;
	private Map<String, Object> session;

	@Resource
	private UserDAO userDAO;
	private String username;
	private String password;
	private boolean userCookie;

	@Resource
	private CookieUtils cookieUtils;

	// 登录跳转
	public String login() {
		if (cookieUtils.getCookie(request, userDAO)) {
			System.out.println("哈哈哈哈哈");
			return SUCCESS;
		} else
			return "login";
	}

	@Override
	// 用户登录
	public String execute() throws Exception {
		String username = getUsername();
		if (username != null && !"".equals(username) && password != null
				&& !"".equals(password)) {
			User user = userDAO.checkUser(username, password, false);
			if (user != null) {
				// 判断是否要添加到cookie中
				if (userCookie) {
					Cookie cookie = cookieUtils.addCookie(user, password);
					response.addCookie(cookie);// 添加cookie到response中
				}
				// 2.将user 设置到session中
				session.put(USER_SESSION, user);
				session.put(USER_PASSWORD, password);
				return SUCCESS;
			}
		}
		this.addFieldError("username", "用户名或密码错误!");
		return "login";
	}

	// 用户退出方法
	public String userLogout() {
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute(USER_SESSION);
			session.removeAttribute(USER_PASSWORD);// 移除用户密码
		}
		Cookie cookie = cookieUtils.delCookie(request);
		if (cookie != null)
			response.addCookie(cookie);
		return "login";
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean getUserCookie() {
		return userCookie;
	}

	public void setUserCookie(boolean userCookie) {
		this.userCookie = userCookie;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

}
