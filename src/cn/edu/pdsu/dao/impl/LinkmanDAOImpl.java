package cn.edu.pdsu.dao.impl;

import java.util.List;

import javax.persistence.Query;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.edu.pdsu.bean.Linkman;
import cn.edu.pdsu.dao.LinkmanDAO;
import cn.edu.pdsu.dao.base.BaseDAOImpl;

/**
 * 类说明：联系人LinkmanDAO的基本实现类
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-14 下午11:03:38
 */
@Service
public class LinkmanDAOImpl extends BaseDAOImpl<Linkman> implements LinkmanDAO {

	@Override
	@Transactional
	public void delete(String ids) {
		String queryString = "delete from Linkman a  where a.id in(" + ids
				+ ")";
		Query query = em.createQuery(queryString);
		query.executeUpdate();
	}

	@Override
	@Transactional
	public void update(String ids, int groupID) {
		String queryString = "update Linkman a set a.group.id = " + groupID
				+ " where a.id in (" + ids + ")";
		Query query = em.createQuery(queryString);
		query.executeUpdate();
	}

	@Override
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public List<Linkman> search(String groupIds, String nameLike) {
		String queryString = "from Linkman l where l.group.id in( " + groupIds
				+ " ) and ( l.name like '%" + nameLike
				+ "%' or l.emailAdd like '%" + nameLike + "%' )";
		Query query = em.createQuery(queryString);
		return query.getResultList();
	}
}
