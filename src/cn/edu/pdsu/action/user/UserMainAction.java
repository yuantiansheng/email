package cn.edu.pdsu.action.user;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.edu.pdsu.bean.User;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：用户登录主界面action
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-29 下午05:21:17
 */
@Controller
@Scope("prototype")
public class UserMainAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = -719026902071678340L;
	private User user;
	private Map<String, Object> session;

	@Override
	public String execute() throws Exception {
//		user = (User) session.get(UserLoginAction.USER_SESSION);
//		if (user != null) {
//			setUser(user);
//		}
		return SUCCESS;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
