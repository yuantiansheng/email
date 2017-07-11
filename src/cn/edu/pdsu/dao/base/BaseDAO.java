package cn.edu.pdsu.dao.base;

import java.io.Serializable;
import java.util.LinkedHashMap;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.edu.pdsu.bean.QueryResult;

/**
 * 类说明：基础的数据操作接口，增删改查和分页
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-13 下午09:12:37
 */
public interface BaseDAO<T> {

	/**
	 * 删除实体对象，传入的参数可以是：（User.class,1,2,3），1,2,3分别是要删除的id号
	 * 
	 * @param entityClass
	 *            实体类
	 * @param entityids
	 *            要删除的id
	 */
	public abstract void delete(Class<T> entityClass, Serializable... entityids);

	/**
	 * 根据id查找数据
	 * 
	 * @param entityClass
	 *            实体类
	 * @param entityId
	 *            要查找的实体id
	 * @return 返回一个与实体相对应的对象
	 */
	@Transactional(readOnly = true, propagation = Propagation.NOT_SUPPORTED)
	public abstract T find(Class<T> entityClass, Serializable entityId);

	/**
	 * 保存实体对象
	 * 
	 * @param entity
	 *            要保存的实体对象
	 */
	public abstract void save(T entity);

	/**
	 * 更新实体对象
	 * 
	 * @param entity
	 *            要更新的实体对象
	 */
	public abstract void update(T entity);

	/**
	 * 返回总记录数
	 * 
	 * @param entityClass
	 *            实体类
	 * @return long 返回总的记录数
	 */
	public long getTotalRecord(Class<T> entityClass);

	/**
	 * 返回符合where条件的总记录数
	 * 
	 * @param entityClass
	 *            实体类
	 * @param whereHql
	 *            o.name=?1 and o.id =?2 ,where条件部分
	 * @param values
	 *            where 参数的的值
	 * @return long 符和条件的记录数
	 */
	public long getTotalRecord(Class<T> entityClass, String whereHql,
			Object[] values);

	/**
	 * 查询所有对象
	 * 
	 * @param entityClass
	 *            实体类
	 * @return
	 */
	public QueryResult<T> getScrollData(Class<T> entityClass);

	/**
	 * 获取分页数据
	 * 
	 * @param entityClass
	 *            实体类
	 * @param firstIndex
	 *            开始索引
	 * @param maxResult
	 *            需要获取的记录数
	 * @return QueryResult，存放记录的总数和对象列表
	 */
	public QueryResult<T> getScrollData(Class<T> entityClass, int firstIndex,
			int maxResult);

	/**
	 * 可以根据具体的where语句进行分页数据查询
	 * 
	 * @param entityClass
	 *            实体类
	 * @param whereHql
	 *            where 查询语句，像 o.name=?1 and o.id = ?2
	 * @param values
	 *            查询语句中?1,?2...对应的值
	 * @return 没有排序的结果QueryResult，存放记录的总数和对象列表
	 */
	public QueryResult<T> getScrollData(Class<T> entityClass, String whereHql,
			Object[] values);

	/**
	 * 根据属性排序,获取分页数据
	 * 
	 * @param entityClass
	 *            实体类
	 * @param orderBy
	 *            排序方式
	 * @return QueryResult对象， 排序后的结果QueryResult，存放记录的总数和对象列表
	 */
	public QueryResult<T> getScrollData(Class<T> entityClass,
			LinkedHashMap<String, String> orderBy);

	/**
	 * 根据属性排序,获取分页数据
	 * 
	 * @param entityClass
	 *            实体类
	 * @param firstIndex
	 *            开始索引
	 * @param maxResult
	 *            需要获取的记录数
	 * @param orderBy
	 *            排序方式
	 * @return QueryResult对象， 排序后的结果QueryResult，存放记录的总数和对象列表
	 */
	public QueryResult<T> getScrollData(Class<T> entityClass, int firstIndex,
			int maxResult, LinkedHashMap<String, String> orderBy);

	/**
	 * 可以根据具体的where语句进行分页数据查询
	 * 
	 * @param entityClass
	 *            实体类
	 * @param firstIndex
	 *            开始索引
	 * @param maxResult
	 *            需要获取的记录数
	 * @param whereHql
	 *            where 查询语句，像 o.name=?1 and o.id = ?2
	 * @param values
	 *            查询语句中?1,?2...对应的值
	 * @return 没有排序的结果QueryResult，存放记录的总数和对象列表
	 */
	public QueryResult<T> getScrollData(Class<T> entityClass, int firstIndex,
			int maxResult, String whereHql, Object[] values);

	/**
	 * 可以根据具体的where语句进行分页数据查询
	 * 
	 * @param entityClass
	 *            实体类
	 * @param firstIndex
	 *            开始索引
	 * @param maxResult
	 *            需要获取的记录数
	 * @param whereHql
	 *            where 查询语句，像 o.name=?1 and o.id = ?2
	 * @param values
	 *            查询语句中?1,?2...对应的值
	 * @param orderBy
	 *            排序方式
	 * @return 排序后的结果QueryResult，存放记录的总数和对象列表
	 */
	public QueryResult<T> getScrollData(Class<T> entityClass, int firstIndex,
			int maxResult, String whereHql, Object[] values,
			LinkedHashMap<String, String> orderBy);
}