package cn.edu.pdsu.dao.ipml;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.edu.pdsu.bean.Gender;
import cn.edu.pdsu.bean.Group;
import cn.edu.pdsu.bean.Linkman;
import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.bean.UserInfo;
import cn.edu.pdsu.dao.UserDAO;

/**
 * 类说明：用户信息测试
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-15 下午10:38:57
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class UsersDAOImplTest {

	@Resource
	private UserDAO usersDAO;

	@Test
	public void testDelete() {
		usersDAO.delete(User.class, "admin");
	}

	@Test
	public void testFind() {
		User user = usersDAO.find(User.class, "1");
		Set<Group> groups = user.getGroup();
		for (Group group : groups) {
			System.out.println(group.getName());
		}
		System.out.println(user);
	}

	@Test
	public void testSave() {
		// 添加用户
		User user = new User();

		user.setPwdEncoded("admin");
		user.setName("admin");

		UserInfo usersInfo = new UserInfo();
		usersInfo.setPwdEmail("admin@ljg.com");
		usersInfo.setAlias("管理员");
		usersInfo.setAddress("平顶山学院");
		usersInfo.setQuestion("我大学学校名全称？");
		usersInfo.setAnswer("平顶山学院");
		usersInfo.setGender(Gender.MAN);
		usersInfo.setMark("米林邮箱邮件管理员");
		usersInfo.setPhoneNum("13837591390");
		usersInfo.setUser(user);
		user.setUserInfo(usersInfo);

		Group group = new Group("默认分组", user);
		user.setOneGroup(group);

		Linkman linkman = new Linkman("zhagnsan@666.com", group);
		Linkman linkman2 = new Linkman("zhagnsan3@666.com", group);
		Linkman linkman3 = new Linkman("zhagnsan2@666.com", group);

		Set<Linkman> linkmans = new HashSet<Linkman>();
		linkmans.add(linkman);
		linkmans.add(linkman2);
		linkmans.add(linkman3);
		// group.setLinkmans(linkmans);
		usersDAO.save(user);
	}

	@Test
	public void testUpdate() {
	}

}
