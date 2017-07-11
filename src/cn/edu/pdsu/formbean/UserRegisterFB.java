package cn.edu.pdsu.formbean;

import cn.edu.pdsu.bean.Gender;

/**
 * 类说明：用户注册信息存取bean
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-16 下午07:12:14
 */
public class UserRegisterFB {
	/**
	 * 邮箱名称
	 */
	private String username;
	/**
	 * 登录密码
	 */
	private String password;
	/**
	 * 确认密码
	 */
	private String password2;
	/**
	 * 密码查询邮箱
	 */
	private String pwdEmail;
	/**
	 * 密码查询问题
	 */
	private String question;
	/**
	 * 密码查询答案
	 */
	private String answer;
	/**
	 * 昵称
	 */
	private String alias;
	/**
	 * 性别
	 */
	private Gender gender;
	/**
	 * 手机号
	 */
	private String phoneNum;
	/**
	 * 家庭住址
	 */
	private String address;
	/**
	 * 备注信息
	 */
	private String mark;
	/**
	 * 验证码
	 */
	private String authCode;

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

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public String getPwdEmail() {
		return pwdEmail;
	}

	public void setPwdEmail(String pwdEmail) {
		this.pwdEmail = pwdEmail;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	public String getAuthCode() {
		return authCode;
	}

	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}

}
