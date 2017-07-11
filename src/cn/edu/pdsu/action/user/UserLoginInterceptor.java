package cn.edu.pdsu.action.user;

import java.util.Map;

import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 类说明：用户登录拦截器（判断用户是否登录）
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-28 下午09:46:32
 */
@Controller
public class UserLoginInterceptor extends AbstractInterceptor {
	private static final long serialVersionUID = -8189985345900537566L;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		ActionContext actionContext = invocation.getInvocationContext();
		Map<String, Object> session = actionContext.getSession();// 获得session
		if (session != null
				&& session.get(UserLoginAction.USER_SESSION) != null) {// session中有值
			return invocation.invoke();
		}
		return "index";
	}
}
