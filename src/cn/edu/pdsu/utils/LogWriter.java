package cn.edu.pdsu.utils;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Service;

/**
 * 日志记录类 ，主要记录运行过程
 * 
 * @author 作者：
 * @version 创建时间：2011-7-12 下午05:38:47
 */
@Service
@Aspect
public class LogWriter {

	@Around("execution(* cn.edu.pdsu..*.*(..))")
	public Object doBasicProfiling(ProceedingJoinPoint pjp) throws Throwable {
		Class clazz = pjp.getTarget().getClass();
		Logger logger = Logger.getLogger(clazz);
		StringBuffer log = new StringBuffer();// 日志信息
		log.append("执行 ").append(clazz).append("类的 ")
				.append(pjp.getSignature().getName()).append("方法！");
		logger.info(log);
		Object retVal = null;
		try {
			retVal = pjp.proceed();
		} catch (Exception e) {
			logger.error(log);
			logger.error(e.getMessage(), e.fillInStackTrace());// 记录异常信息
		}
		return retVal;
	}
}
