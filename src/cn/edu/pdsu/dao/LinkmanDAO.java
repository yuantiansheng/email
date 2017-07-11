package cn.edu.pdsu.dao;

import java.util.List;

import cn.edu.pdsu.bean.Linkman;
import cn.edu.pdsu.dao.base.BaseDAO;

/**
 * 类说明：联系人操作的基本接口类
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-14 下午11:02:41
 */
public interface LinkmanDAO extends BaseDAO<Linkman> {

	/**
	 * 通过联系人 id删除联系人，ids= "1,2,3";
	 * 
	 * @param ids
	 *            要删除的联系人id字符串 ids= "1,2,3";
	 */
	public void delete(String ids);

	/**
	 * 更新联系人的分组
	 * 
	 * @param ids
	 *            要更新的联系人 id
	 * @param groupID
	 *            要移动到的分组（group） id
	 */
	public void update(String ids, int groupID);

	/**
	 * 查找联系人（根据用户名或email，like来匹配）
	 * 
	 * @param groupIds
	 *            需要查找的分组id
	 * 
	 * @param nameLike
	 *            联系人名称或email要匹配的字符串
	 * @return List<Linkman> Linkman列表
	 */
	public List<Linkman> search(String groupIds, String nameLike);
}
