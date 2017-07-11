package cn.edu.pdsu.bean;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * 类说明：联系人组类。一个用户对应多个联系人组，一个联系人组对应多个用户
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-14 下午09:26:03
 */
@Entity
@Table(name = "usergroup")
public class Group implements Serializable {

	private static final long serialVersionUID = 1L;
	/**
	 * 自增主键
	 */
	private int id;
	/**
	 * 联系人所属组的名称
	 */
	private String name;
	/**
	 * 联系人列表(一对多关系)
	 */
	private Set<Linkman> linkmans = new HashSet<Linkman>();

	/**
	 * 用户信息（多对一）
	 */
	private User user;

	public Group() {
		super();
	}

	public Group(String name, User user) {
		super();
		this.name = name;
		this.user = user;
	}

	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(length = 30)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "group", cascade = CascadeType.ALL)
	public Set<Linkman> getLinkmans() {
		return linkmans;
	}

	public void setLinkmans(Set<Linkman> linkmans) {
		this.linkmans = linkmans;
	}

	@ManyToOne(fetch = FetchType.LAZY, optional = false)
	@JoinColumn(name = "user_name")
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
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
		Group other = (Group) obj;
		if (id != other.id)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		return true;
	}

}
