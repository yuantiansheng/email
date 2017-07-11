package cn.edu.pdsu.action.user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.dao.UserDAO;

/**
 * 类说明：cookie的基本操作（增加，删除，取值）
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-28 下午11:03:03
 */
@Service
public class CookieUtils {
	public static final String USER_COOKIE = "user.cookie.ljg";

	// 添加一个cookie
	public Cookie addCookie(User user, String password) {
		Cookie cookie = new Cookie(USER_COOKIE, user.getName() + "," + password);
		cookie.setMaxAge(60 * 60 * 24 * 14);// cookie保存两周
		return cookie;
	}

	// 得到用户cookie中的值
	public boolean getCookie(HttpServletRequest request, UserDAO userDAO) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (CookieUtils.USER_COOKIE.equals(cookie.getName())) {
					String value = cookie.getValue();
					if (StringUtils.isNotBlank(value)) {
						String[] split = value.split(",");
						String username = split[0];
						String password = split[1];
						User user = userDAO
								.checkUser(username, password, false);
						if (user != null) {
							HttpSession session = request.getSession();
							session.setAttribute(UserLoginAction.USER_SESSION,
									user);// 添加用户到session中
							session.setAttribute(UserLoginAction.USER_PASSWORD,
									password);
							return true;
						}
					}
				}
			}
		}
		return false;
	}

	// 删除cookie
	public Cookie delCookie(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (USER_COOKIE.equals(cookie.getName())) {
					cookie.setValue("");
					cookie.setMaxAge(0);
					return cookie;
				}
			}
		}
		return null;
	}
}
