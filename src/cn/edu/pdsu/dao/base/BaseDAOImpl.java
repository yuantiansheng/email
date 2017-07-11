package cn.edu.pdsu.dao.base;

import java.io.Serializable;
import java.util.LinkedHashMap;

import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.edu.pdsu.bean.QueryResult;

/**
 * 类说明：基础的数据操作类。所有与DAO类的父类，抽象类
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-13 下午09:08:19
 */
@Transactional
public abstract class BaseDAOImpl<T> implements BaseDAO<T> {

	@PersistenceContext
	protected EntityManager em;

	@Override
	// 删除
	public void delete(Class<T> entityClass, Serializable... entityids) {
		for (Object id : entityids) {
			em.remove(em.getReference(entityClass, id));
		}
	}

	@Override
	// 查找
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public T find(Class<T> entityClass, Serializable entityId) {
		if (entityId == null)
			throw new RuntimeException(entityClass.getName() + ":传入的实体id不能为空");
		return em.find(entityClass, entityId);
	}

	@Override
	// 添加
	public void save(T entity) {
		em.persist(entity);
	}

	@Override
	// 更新
	public void update(T entity) {
		em.merge(entity);
	}

	@Override
	// 返回所有数据
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public QueryResult<T> getScrollData(Class<T> entityClass) {
		return getScrollData(entityClass, -1, -1, null, null, null);
	}

	// 分页
	@Override
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public QueryResult<T> getScrollData(Class<T> entityClass, int firstIndex,
			int maxResult) {
		return getScrollData(entityClass, firstIndex, maxResult, null);// 调用分页排序查询
	}

	@Override
	// 返回符合where条件的语句
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public QueryResult<T> getScrollData(Class<T> entityClass, String whereHql,
			Object[] values) {
		return getScrollData(entityClass, -1, -1, whereHql, values, null);// 调用分页排序查询
	}

	@Override
	// 返回符合orderby条件的语句
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public QueryResult<T> getScrollData(Class<T> entityClass,
			LinkedHashMap<String, String> orderBy) {
		return getScrollData(entityClass, -1, -1, null, null, orderBy);// 调用分页排序查询
	}

	@Override
	// 能够排序的分页查询 where o.name=?1 and 0.id=?2
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public QueryResult<T> getScrollData(Class<T> entityClass, int firstIndex,
			int maxResult, LinkedHashMap<String, String> orderBy) {
		return getScrollData(entityClass, firstIndex, maxResult, null, null,
				orderBy);// 调用分页排序查询
	}

	@Override
	// 返回符合where语句的分页数据
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public QueryResult<T> getScrollData(Class<T> entityClass, int firstIndex,
			int maxResult, String whereHql, Object[] values) {
		return getScrollData(entityClass, firstIndex, maxResult, whereHql,
				values, null);// 调用分页排序查询
	}

	@Override
	// 能够排序的符合where的分页查询 where o.name=?1 and 0.id=?2
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public QueryResult<T> getScrollData(Class<T> entityClass, int firstIndex,
			int maxResult, String whereHql, Object[] values,
			LinkedHashMap<String, String> orderBy) {
		QueryResult<T> queryResult = new QueryResult<T>();
		String entityName = getEntityName(entityClass);
		String whereString = (whereHql == null || "".equals(whereHql)) ? ""
				: "where " + whereHql;// 构建where语句
		Query query = em.createQuery("select o from " + entityName + " o "
				+ whereString + orderBy(orderBy));
		whereHql(query, values);
		if (firstIndex != -1 && maxResult != -1)
			query.setFirstResult(firstIndex).setMaxResults(maxResult);
		queryResult.setResultList(query.getResultList());// 设置返回对象
		queryResult
				.setTotalRecord(getTotalRecord(entityClass, whereHql, values));// 设置返回记录总数
		return queryResult;
	}

	@Override
	// 返回总记录数
	public long getTotalRecord(Class<T> entityClass) {
		return getTotalRecord(entityClass, null, null);
	}

	@Override
	// 返回符合条件的总记录数
	public long getTotalRecord(Class<T> entityClass, String whereHql,
			Object[] values) {
		String whereString = (whereHql == null || "".equals(whereHql)) ? ""
				: "where " + whereHql;// 构建where语句
		String entityName = getEntityName(entityClass);
		Query query = em.createQuery("select count(o) from " + entityName
				+ " o " + whereString);
		whereHql(query, values);
		return (Long) (query.getSingleResult());
	}

	/**
	 * 构建where语句
	 * 
	 * @param where
	 *            LinkedHashMap<String, Object> String 对象属性，Object对象的属性值
	 * @return 构建好的where语句 where o.name = ?1 and o.name like ?2
	 */
	protected String whereHql(Query query, Object[] values) {
		StringBuffer whereBuffer = new StringBuffer();
		if (values != null && values.length > 0) {
			for (int i = 0; i < values.length; i++) {
				query.setParameter(i + 1, values[i]);
			}
		}
		return whereBuffer.toString();

	}

	/**
	 * 构建orderby语句
	 * 
	 * @param orderBy
	 *            LinkedHashMap<String, String>类型，1：对象的属性，2：排序方式
	 * @return 返回order by 语句
	 */
	protected String orderBy(LinkedHashMap<String, String> orderBy) {
		StringBuffer orderBuffer = new StringBuffer();
		// 构建order by语句，order by o.key desc,o.key2 asc
		if (orderBy != null && orderBy.size() > 0) {
			orderBuffer.append(" order by ");
			for (String key : orderBy.keySet()) {
				orderBuffer.append(" o.").append(key).append(" ")
						.append(orderBy.get(key)).append(" ,");
			}
			orderBuffer.deleteCharAt(orderBuffer.length() - 1);
		}
		return orderBuffer.toString();
	}

	/**
	 * 获取实体的名称
	 * 
	 * @param entityClass
	 *            实体类
	 * @return 实体的名称
	 */
	protected String getEntityName(Class<T> entityClass) {
		String entityName = entityClass.getName();
		Entity eitity = entityClass.getAnnotation(Entity.class);
		if (eitity.name() != null && !"".equals(eitity.name())) {
			entityName = eitity.name();
		}
		return entityName;
	}
}
