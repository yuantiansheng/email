package cn.edu.pdsu.action.user;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.validation.SkipValidation;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.formbean.UserRegisterFB;
import cn.edu.pdsu.service.user.UserRegisterService;
import cn.edu.pdsu.utils.CheckAuthCode;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：用户注册action //产生验证码
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-16 下午06:25:42
 */
@Controller
@Scope("prototype")
public class UserRegisterAction extends ActionSupport {
	private static final long serialVersionUID = 361303885547861102L;
	/**
	 * 用户注册信息bean
	 */
	private UserRegisterFB user;
	private HttpServletResponse response = ServletActionContext.getResponse();
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpSession session = request.getSession();
	private int type;// 找回密码的方式，1--密码提示，2--备用邮箱
	@Resource
	private UserRegisterService userRegisterService;

	@Override
	public String execute() throws Exception {
		// 验证码信息验证
		if (CheckAuthCode.checkAuthCode(request, user.getAuthCode())) {
			// 保存用户信息
			userRegisterService.saveUser(user);
			return SUCCESS;
		}
		this.addFieldError("user.authCode", "验证码错误！");
		return INPUT;
	}

	// 检测用户名是否重复
	@SkipValidation
	public String checkUser() throws IOException {
		ServletOutputStream out = response.getOutputStream();
		out.print(!userRegisterService.checkUser(user.getUsername()));
		return null;
	}

	// 找回密码第一步
	@SkipValidation
	public String findPassword1() {
		// 验证码信息验证
		if (CheckAuthCode.checkAuthCode(request, user.getAuthCode())) {
			// 查找用户信息
			User u = null;
			if ((u = userRegisterService.find(user.getUsername())) != null) {
				session.setAttribute("userFindPassword", u);
				return "findPassword2";
			} else {
				this.addFieldError("user.username", "没有找到该用户！");
				return "findPassword1";
			}
		}
		this.addFieldError("user.authCode", "验证码错误！");
		return "findPassword1";
	}

	// 找回密码第二步（选择找回密码方式）
	@SkipValidation
	public String findPassword2() {
		User u = (User) session.getAttribute("userFindPassword");
		if (u != null) {
			if (type == 1) {
				setUserRegisterFB();
				return "question";
			} else if (type == 2) {
				if (findByEmail()) {
					return "emailSuccess";
				} else {
					return "emailFailed";
				}
			}
		}
		return "findPassword1";
	}

	// 找回密码第三步(通过安全问题重设密码)
	@SkipValidation
	public String findByQuestion() {
		UserRegisterFB userinfoFb = user;
		if (CheckAuthCode.checkAuthCode(request, user.getAuthCode())) {
			// 查找用户信息
			User u = (User) session.getAttribute("userFindPassword");
			if (u != null) {
				if (userRegisterService.checkAnswer(u, user.getAnswer())) {
					userRegisterService.updatePassword(u, user.getPassword());// 更新用户的密码
					session.removeAttribute("userFindPassword");
					return "questionSuccess";
				} else {
					setUserRegisterFB().setAnswer(userinfoFb.getAnswer());
					this.addFieldError("user.answer", "你的密码查询问题答案不正确！");
					return "question";
				}
			} else
				return "findPassword1";
		}
		setUserRegisterFB().setAnswer(userinfoFb.getAnswer());
		this.addFieldError("user.authCode", "验证码错误！");
		return "question";
	}

	// 设置用于返回的用户信息
	public UserRegisterFB setUserRegisterFB() {
		User u = (User) session.getAttribute("userFindPassword");
		user = new UserRegisterFB();
		user.setQuestion(u.getUserInfo().getQuestion());
		return user;
	}

	// 找回密码第三步(通过邮件找回密码)
	public boolean findByEmail() {
		User u = (User) session.getAttribute("userFindPassword");
		setUserRegisterFB().setPwdEmail(u.getUserInfo().getPwdEmail());// 设置用于返回给用户的密码
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";
		if (userRegisterService.sendMailForPassword(u, basePath)) {
			session.removeAttribute("userFindPassword");
			return true;
		}
		return false;
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

}
