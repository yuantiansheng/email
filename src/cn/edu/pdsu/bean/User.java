package cn.edu.pdsu.bean;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Version;

import cn.edu.pdsu.utils.PasswordEncode;

/**
 * 类说明：用户类（联系邮件服务器数据库和另一张表用户基本信息表）
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-15 上午01:51:04
 */
@Entity
@Table(name = "jamesuser")
public class User implements Serializable {
	private static final long serialVersionUID = 107717250835356582L;
	/**
	 * 用户名（邮件地址名）-- 主键
	 */
	private String name;
	/**
	 * 加密后的密码
	 */
	private String password;
	/**
	 * 密码加密算法
	 */
	private String alg = "MD5";

	/**
	 * 是否被禁用 ， enable = false 账号被禁用,默认为true（可用）
	 */
	private boolean enable = true;

	/**
	 * 用户基本信息表
	 */
	private UserInfo userInfo;// 一对一关系

	/**
	 * 联系人 分组(一对多)
	 */
	private Set<Group> group = new HashSet<Group>();

	/**
	 * 版本号
	 */
	private int version;

	public User() {
	}

	/**
	 * 加密密码
	 * 
	 * @param pwdHash
	 *            要加密的密码
	 */
	public void setPwdEncoded(String pwdHash) {
		setPassword(PasswordEncode.setPassword(pwdHash));
	}

	@Id
	@Column(length = 255, nullable = false)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAlg() {
		return alg;
	}

	public void setAlg(String alg) {
		this.alg = alg;
	}

	public Boolean getEnable() {
		return enable;
	}

	public void setEnable(boolean enable) {
		this.enable = enable;
	}

	@OneToOne(fetch = FetchType.LAZY, cascade = { CascadeType.PERSIST,
			CascadeType.REMOVE, CascadeType.REFRESH }, mappedBy = "user")
	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	@OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy = "user")
	public Set<Group> getGroup() {
		return group;
	}

	public void setGroup(Set<Group> group) {
		this.group = group;
	}

	public void setOneGroup(Group group) {
		Set<Group> set = new HashSet<Group>();
		set.add(group);
		this.setGroup(set);// 设置用户分组
	}

	@Version
	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
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
		User other = (User) obj;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

}
