package cn.edu.pdsu.dao.ipml;

import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.edu.pdsu.bean.Group;
import cn.edu.pdsu.bean.Linkman;
import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.dao.GroupDAO;

/**
 * 类说明：联系人分组测试类
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-15 下午10:39:23
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class LinkmanGroupDAOImplTest {
	@Resource
	private GroupDAO linkmanGroupDAO;

	@Test
	public void testDelete() {
		linkmanGroupDAO.delete(Group.class, 16);
	}

	@Test
	public void testFind() {
		linkmanGroupDAO.find(Group.class, 1);
	}

	@Test
	public void testSave() {
		User user = new User();
		user.setName("admin");
		Group group = new Group("管理员联系人", user);

		Set<Linkman> linkmans = new HashSet<Linkman>();
		Linkman linkman = new Linkman();
		linkman.setEmailAdd("zhansahnd@sdf.com");
		linkman.setGroup(group);
		Linkman linkman2 = new Linkman();
		linkman2.setEmailAdd("zhansahnds@sdf.com");
		linkman2.setGroup(group);
		Linkman linkman3 = new Linkman();
		linkman3.setEmailAdd("zhansahndd@sdf.com");
		linkman3.setGroup(group);
		linkmans.add(linkman3);
		linkmans.add(linkman2);
		linkmans.add(linkman);
		// group.setLinkmans(linkmans);

		linkmanGroupDAO.save(group);

	}

	@Test
	public void testUpdate() {
	}

}
