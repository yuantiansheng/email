package cn.edu.pdsu.bean;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * 类说明：联系人实体类（name,Gender(性别),birthday,phoneNum,emailAdd,mark,address,
 * linkmanGroup,id,linkmanGroup）,联系人与分组是多对多的关系
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-14 下午09:54:10
 */
@Entity
public class Linkman implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	/**
	 * 联系人名称
	 */
	private String name;
	/**
	 * 联系人电话号码
	 */
	private String phoneNum;
	/**
	 * 电子邮件地址
	 */
	private String emailAdd;
	/**
	 * 备注
	 */
	private String mark;
	/**
	 * 住址
	 */
	private String address;
	/**
	 * 生日
	 */
	private Date birthday;

	/**
	 * 性别
	 */
	private Gender gender;
	/**
	 * 联系人分组(一个联系人只能属于一个分组)
	 */
	private Group group;

	public Linkman() {
	}

	/**
	 * 设置联系人信息
	 * 
	 * @param emailAdd
	 *            联系人邮箱地址
	 * @param group
	 *            联系人分组
	 */
	public Linkman(String emailAdd, Group group) {
		this.emailAdd = emailAdd;
		this.group = group;
	}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(length = 36)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(length = 14)
	public String getPhoneNum() {
		return phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	@Column(length = 50, nullable = false)
	public String getEmailAdd() {
		return emailAdd;
	}

	public void setEmailAdd(String emailAdd) {
		this.emailAdd = emailAdd;
	}

	@Column(length = 250)
	public String getMark() {
		return mark;
	}

	public void setMark(String mark) {
		this.mark = mark;
	}

	@Column(length = 150)
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Temporal(TemporalType.DATE)
	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	@Enumerated(EnumType.STRING)
	@Column(length = 5)
	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	@ManyToOne(optional = false, cascade = CascadeType.REFRESH)
	@JoinColumn(name = "group_id")
	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((emailAdd == null) ? 0 : emailAdd.hashCode());
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
		Linkman other = (Linkman) obj;
		if (emailAdd == null) {
			if (other.emailAdd != null)
				return false;
		} else if (!emailAdd.equals(other.emailAdd))
			return false;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("姓名：").append(getName()).append("\n性别: ")
				.append(getGender()).append("\n电话: ").append(getPhoneNum())
				.append("\n邮箱: ").append(getEmailAdd()).append("\n地址: ")
				.append(getAddress()).append("\n生日: ").append(getBirthday())
				.append("\n备注: ").append(getMark());
		return stringBuffer.toString();
	}
}
