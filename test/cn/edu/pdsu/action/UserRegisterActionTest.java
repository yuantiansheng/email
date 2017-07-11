package cn.edu.pdsu.action;

import static org.junit.Assert.fail;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.edu.pdsu.action.user.UserRegisterAction;
import cn.edu.pdsu.formbean.UserRegisterFB;

/**
 * 类说明：用户注册测试类
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-27 下午06:29:03
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class UserRegisterActionTest {

	@Resource
	UserRegisterAction userRegisterAction;

	@Test
	public void testExecute() {
		fail("Not yet implemented");
	}

	@Test
	public void testFindPassword1() {
		UserRegisterFB user = new UserRegisterFB();
		user.setUsername("123");
		System.out.println(userRegisterAction.findPassword1());
	}

	@Test
	public void testFindPassword3() {
		fail("Not yet implemented");
	}

}
