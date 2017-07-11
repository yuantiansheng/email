package cn.edu.pdsu.dao.impl;

import org.springframework.stereotype.Service;

import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.dao.UserDAO;
import cn.edu.pdsu.dao.base.BaseDAOImpl;
import cn.edu.pdsu.utils.PasswordEncode;

/**
 * 类说明：用户基本操作类UsersDAO接口的实现类（BaseDAOImpl）
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-15 上午02:20:15
 */
@Service
public class UserDAOImpl extends BaseDAOImpl<User> implements UserDAO {

	@Override
	public User checkUser(String username, String password,
			boolean isPasswordEncode) {

		User user = this.find(User.class, username);
		if (user != null) {// 找到该用户
			String pw = user.getPassword();
			if (!isPasswordEncode) {// 未加密
				if (PasswordEncode.isPasswordEnable(password, pw))// 密码验证成功
					return user;
			} else {
				if (password.equals(pw))
					return user;
			}
		}
		return null;
	}
}
