package cn.edu.pdsu.action;

import javax.annotation.Resource;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.edu.pdsu.action.user.UserLoginAction;

/**
 * 类说明：
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-16 下午05:35:11
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class UserLoginActionTest {
	@Resource
	private UserLoginAction userLoginAction;

	@Test
	public void testExecute() {
		userLoginAction.setUsername("as");
		userLoginAction.setPassword("sa");
		try {
			Assert.assertEquals("error", userLoginAction.execute());

			userLoginAction.setUsername("a");
			userLoginAction.setPassword("asdf");
			Assert.assertEquals("error", userLoginAction.execute());

			userLoginAction.setUsername("");
			userLoginAction.setPassword("asdf");
			Assert.assertEquals("error", userLoginAction.execute());

			userLoginAction.setUsername("a");
			userLoginAction.setPassword("");
			Assert.assertEquals("error", userLoginAction.execute());

			userLoginAction.setUsername("asfasdfasd");
			userLoginAction.setPassword("asdf");
			Assert.assertEquals("error", userLoginAction.execute());

			userLoginAction.setUsername("a");
			userLoginAction.setPassword("a");
			Assert.assertEquals("success", userLoginAction.execute());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
