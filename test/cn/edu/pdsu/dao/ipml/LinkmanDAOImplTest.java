package cn.edu.pdsu.dao.ipml;

import java.util.LinkedHashMap;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import cn.edu.pdsu.bean.Gender;
import cn.edu.pdsu.bean.Group;
import cn.edu.pdsu.bean.Linkman;
import cn.edu.pdsu.bean.PageView;
import cn.edu.pdsu.bean.QueryResult;
import cn.edu.pdsu.dao.GroupDAO;
import cn.edu.pdsu.dao.LinkmanDAO;

/**
 * 类说明：
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-15 下午10:39:45
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/beans.xml")
public class LinkmanDAOImplTest {

	@Resource
	GroupDAO linkmanGroupDAO;
	@Resource
	LinkmanDAO linkmanDAO;

	@Test
	public void testDelete() {
		linkmanDAO.delete("2,3");
	}

	@Test
	public void testFind() {
		PageView<Linkman> pageView = new PageView<Linkman>(9, 3);
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("id", "desc");
		String where = "o.group.id=?1";
		Object[] values = { 25 };
		QueryResult<Linkman> qr = linkmanDAO.getScrollData(Linkman.class,
				pageView.getFirstResult(), pageView.getMaxresult(), where,
				values, orderby);
		pageView.setQueryResult(qr);

		// 结果的输出
		for (Linkman linkman : pageView.getRecords()) {
			System.out.println(linkman.getEmailAdd());
			System.out.println(linkman.getId());
		}
		System.out.println("总页数: " + pageView.getTotalpage());
		System.out.println("当前页: " + pageView.getCurrentpage());
		System.out.println("开始索引: " + pageView.getFirstResult());
		System.out.println("最大记录数: " + pageView.getMaxresult());
		System.out.println("得到页码数量: " + pageView.getPagecode());
		System.out.println("记录总数: " + pageView.getTotalrecord());
		System.out
				.println("开始页面索引: " + pageView.getPageindex().getStartIndex());
	}

	@Test
	public void testSave() {

		Group group = linkmanGroupDAO.find(Group.class, 3);
		System.out.println(group.getName());
		for (int i = 0; i < 5; i++) {
			Linkman linkman = new Linkman();
			linkman.setName("张晓红" + i);
			linkman.setGender(Gender.MAN);
			linkman.setPhoneNum("12345678912");
			linkman.setEmailAdd("xiaohong" + i + "@163.com");
			linkman.setGroup(group);
			linkmanDAO.save(linkman);
		}

	}

	@Test
	public void testUpdate() {
		linkmanDAO.update("17,18,19", 43);
	}

	@Test
	public void testFindByLike() {
		List<Linkman> list = linkmanDAO.search("74", "a");
		System.out.println(list);
		for (Linkman linkman : list) {
			System.out.println(linkman.getName());
		}
	}
}
