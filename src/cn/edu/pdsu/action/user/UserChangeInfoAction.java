package cn.edu.pdsu.action.user;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.bean.UserInfo;
import cn.edu.pdsu.dao.UserDAO;
import cn.edu.pdsu.formbean.UserRegisterFB;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：用户修改个人信息action（个人基本信息，修改密码，修改密码查询问题，修改密码查询邮箱）
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-2 上午12:17:56
 */
@Controller
@Scope("prototype")
public class UserChangeInfoAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = -5206940536743990952L;
	private Map<String, Object> session;
	private UserRegisterFB user;
	private User u;
	private int type;
	private String message = "修改成功";

	@Resource
	private UserDAO userDAO;

	// 修改用户基本信息
	public String changeInfo() {
		u = (User) session.get(UserLoginAction.USER_SESSION);
		u = userDAO.find(User.class, u.getName());// 查找用户
		setUserRegisterFB();
		return "changeInfo";
	}

	// 保存用户信息
	public String updateInfo() {
		u = (User) session.get(UserLoginAction.USER_SESSION);
		u = userDAO.find(User.class, u.getName());// 查找用户
		setUserInfo();
		userDAO.update(u);// 保存用户
		message = "用户基本信息修改成功！";
		return SUCCESS;
	}

	// 修改密保问题
	public String changeQuestion() {
		u = (User) session.get(UserLoginAction.USER_SESSION);
		u = userDAO.find(User.class, u.getName());// 查找用户
		setQuestion();
		return "changeQuestion";
	}

	// 检测用户回答的密保问题答案
	public String checkAnswer() {
		u = (User) session.get(UserLoginAction.USER_SESSION);
		u = userDAO.find(User.class, u.getName());// 查找用户
		// 验证码信息验证
		if (u.getUserInfo().getAnswer().equals(user.getAnswer())) {
			user.setAnswer("");
			return "updateQuestion";
		}
		setQuestion();
		this.addFieldError("user.answer", "密码查询问题答案不正确！");
		return "changeQuestion";
	}

	// 设置密保问题从user到UserRegisterFB
	private UserRegisterFB setQuestion() {
		user = new UserRegisterFB();
		user.setQuestion(u.getUserInfo().getQuestion());
		return user;
	}

	// 更新密保问题
	public String updateQuestion() {
		u = (User) session.get(UserLoginAction.USER_SESSION);
		u = userDAO.find(User.class, u.getName());// 查找用户
		setUserQuestion();
		userDAO.update(u);// 保存用户
		message = "密码查询问题修改成功！";
		return SUCCESS;
	}

	// 修改密码
	public String changePassword() {
		u = (User) session.get(UserLoginAction.USER_SESSION);
		u = userDAO.find(User.class, u.getName());// 查找用户
		User us = null;
		if ((us = userDAO.checkUser(u.getName(), user.getPhoneNum(), false)) != null) {
			us.setPwdEncoded(user.getPassword());
			userDAO.update(us);
			message = "密码修改成功！";
			return SUCCESS;
		}
		this.addFieldError("user.phoneNum", "你输入的原密码不正确！");
		return "changePassword";
	}

	// 查找密码查询邮箱
	public String findPwdEmail() {
		u = (User) session.get(UserLoginAction.USER_SESSION);
		u = userDAO.find(User.class, u.getName());// 查找用户
		setUserRegisterFB();
		return "findPwdEmail";
	}

	// 修改密码查询邮箱
	public String changePwdEmail() {
		u = (User) session.get(UserLoginAction.USER_SESSION);
		u = userDAO.find(User.class, u.getName());// 查找用户
		User us = null;
		if ((us = userDAO.checkUser(u.getName(), user.getPassword(), false)) != null) {
			us.getUserInfo().setPwdEmail(user.getPwdEmail());
			userDAO.update(us);
			message = "密码查询邮箱修改成功！";
			return SUCCESS;
		}
		setUserRegisterFB();
		this.addFieldError("user.password", "你输入的密码不正确！");
		return "changePwdEmail";
	}

	// 设置密码查询问题从UserRegisterFB到user
	private void setUserQuestion() {
		UserInfo userInfo = u.getUserInfo();
		userInfo.setQuestion(user.getQuestion());
		userInfo.setAnswer(user.getAnswer());
	}

	// 设置用户UserRegisterFB中的信息到User中
	private void setUserInfo() {
		UserInfo userInfo = u.getUserInfo();
		userInfo.setAlias(user.getAlias());
		userInfo.setGender(user.getGender());
		userInfo.setPhoneNum(user.getPhoneNum());
		userInfo.setAddress(user.getAddress());
		userInfo.setMark(user.getMark());
	}

	// 设置user的个人信息到UserRegisterFB中
	private void setUserRegisterFB() {
		user = new UserRegisterFB();
		user.setAlias(u.getUserInfo().getAlias());
		user.setPhoneNum(u.getUserInfo().getPhoneNum());
		user.setAddress(u.getUserInfo().getAddress());
		user.setMark(u.getUserInfo().getMark());
		user.setGender(u.getUserInfo().getGender());
		user.setPwdEmail(u.getUserInfo().getPwdEmail());
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public UserRegisterFB getUser() {
		return user;
	}

	public void setUser(UserRegisterFB user) {
		this.user = user;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
