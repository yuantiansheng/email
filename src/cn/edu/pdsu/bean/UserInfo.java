package cn.edu.pdsu.bean;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

/**
 * 类说明：用户基本信息表，与用户是一对一的关系
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-15 上午02:25:15
 */
@Entity
public class UserInfo implements Serializable {
	private static final long serialVersionUID = -8813865046818415714L;
	/**
	 * 主键
	 */
	private int id;
	/**
	 * 安全问题
	 */
	private String question;
	/**
	 * 安全问题答案
	 */
	private String answer;
	/**
	 * 家庭住址
	 */
	private String address;
	/**
	 * 电话号码
	 */
	private String phoneNum;
	/**
	 * 性别
	 */
	private Gender gender = Gender.MAN;
	/**
	 * 安全邮箱
	 */
	private String pwdEmail;
	/**
	 * 备注
	 */
	private String mark;

	/**
	 * 用户主信息
	 */
	private User user;

	/**
	 * 别名
	 */
	private String alias;

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(length = 30)
	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	@Column(length = 30)
	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Column(length = 36)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(length = 14)
	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	@Enumerated(EnumType.STRING)
	@Column(length = 5)
	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	@Column(length = 64)
	public String getPwdEmail() {
		return pwdEmail;
	}

	public void setPwdEmail(String pwdEmail) {
		this.pwdEmail = pwdEmail;
	}

	@Column(length = 255)
	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	@OneToOne(cascade = CascadeType.ALL, optional = false)
	@JoinColumn(name = "user_id")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(length = 50)
	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserInfo other = (UserInfo) obj;
		if (id != other.id)
			return false;
		return true;
	}

}
