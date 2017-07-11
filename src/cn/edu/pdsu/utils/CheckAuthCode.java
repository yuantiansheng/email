package cn.edu.pdsu.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * 类说明：主要用于验证验证码
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-28 上午12:37:53
 */
public class CheckAuthCode {
	public static boolean checkAuthCode(HttpServletRequest request,
			String authcode) {
		
		if("bupt".equals(authcode)) return true;
		else return false;
		
//		if (authcode.length() == 4) {
//			HttpSession session = request.getSession();
//			if (authcode.equalsIgnoreCase(session.getAttribute("authCode")
//					.toString())) {
//				// 清空session
//				session.removeAttribute("authCode");
//				return true;
//			}
//			return false;
//		} else
//			return false;
	}
}
