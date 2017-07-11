package cn.edu.pdsu.service.user;

import java.io.UnsupportedEncodingException;
import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.springframework.stereotype.Service;

import cn.edu.pdsu.bean.Group;
import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.bean.UserInfo;
import cn.edu.pdsu.dao.UserDAO;
import cn.edu.pdsu.formbean.UserRegisterFB;
import cn.edu.pdsu.service.mail.MailBean;
import cn.edu.pdsu.service.mail.MailConstant;
import cn.edu.pdsu.service.mail.send.SendMail;
import cn.edu.pdsu.utils.FindPasswordByEmailUtils;

/**
 * 类说明：用户注册服务类
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-16 下午09:54:35
 */
@Service
public class UserRegisterService {
	@Resource
	private UserDAO usersDAO;

	public void saveUser(UserRegisterFB u) {
		User user = new User();
		UserInfo info = new UserInfo();
		user.setName(u.getUsername());
		user.setPwdEncoded(u.getPassword());
		user.setUserInfo(info);
		info.setPwdEmail(u.getPwdEmail());
		info.setQuestion(u.getQuestion());
		info.setAnswer(u.getAnswer());
		info.setAlias(u.getAlias());
		info.setGender(u.getGender());
		info.setPhoneNum(u.getPhoneNum());
		info.setAddress(u.getAddress());
		info.setMark(u.getMark());
		info.setUser(user);
		// 为用户新建一个默认分组
		Group group = new Group("默认分组", user);
		Group group1 = new Group("朋友", user);
		Group group2 = new Group("亲人", user);
		Group group3 = new Group("同事", user);
		Group group4 = new Group("同学", user);
		Set<Group> set = new HashSet<Group>();
		set.add(group);
		set.add(group1);
		set.add(group2);
		set.add(group3);
		set.add(group4);
		user.setGroup(set);// 设置用户的默认分组
		usersDAO.save(user);
	}

	// 检测用户名是否存在
	public boolean checkUser(String username) {
		User user = find(username);
		if (user != null)
			return true;
		return false;
	}

	// 查找用户
	public User find(String username) {
		return usersDAO.find(User.class, username);
	}

	// 检测用户的密码查询问题是否正确
	public boolean checkAnswer(User user, String answer) {
		String answerString = user.getUserInfo().getAnswer();
		if (answer.equals(answerString))
			return true;
		return false;
	}

	// 更新用户密码
	public void updatePassword(User user, String password) {
		user.setPwdEncoded(password);
		usersDAO.update(user);
	}

	// 为用户发送密码重置邮件
	public boolean sendMailForPassword(User u, String path) {
		try {
			// 重新生成6位数的密码
			String newPassword = FindPasswordByEmailUtils.createPassword();
			// 发送电子邮件
			sendMail(u, newPassword, path);
			// 重置用户密码
			updatePassword(u, newPassword);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

	}

	// 发送电子邮件到用户注册的安全邮箱中
	public void sendMail(User u, String password, String path)
			throws AddressException, MessagingException,
			UnsupportedEncodingException {
		MailBean mailBean = new MailBean(MailConstant.SENDMAIL_USERNAME,
				MailConstant.SENDMAIL_PASSWORD, MailConstant.SENDMAIL_FROM, u
						.getUserInfo().getPwdEmail(), "米林邮箱密码重置",
				FindPasswordByEmailUtils.createFindPasswrdMail(password, path));
		SendMail mail = new SendMail(mailBean);
		mail.sendMail();
	}
}
