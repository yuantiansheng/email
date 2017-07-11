package cn.edu.pdsu.dao;

import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.dao.base.BaseDAO;

/**
 * 类说明：用户数据库基本操作接口类
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-15 上午02:18:56
 */
public interface UserDAO extends BaseDAO<User> {

	/**
	 * 检测用户是否存在，并返回该用户
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @param isPasswordEncod
	 *            密码是否加过密(true 加过密)
	 * @return User 根据用户名与密码查询的结果，没有该用户或者密码不正确则返回null
	 */
	public User checkUser(String username, String password,
			boolean isPasswordEncode);
}
