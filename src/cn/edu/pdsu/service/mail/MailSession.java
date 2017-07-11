package cn.edu.pdsu.service.mail;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.mail.Session;

import cn.edu.pdsu.service.mail.send.SendMail;
import cn.edu.pdsu.service.mail.send.SmtpAuth;

/**
 * 类说明：用于创建session
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-22 下午11:46:09
 */
public class MailSession {
	/**
	 * 创建session
	 * 
	 * @param props
	 *            属性配置
	 * @param auth
	 *            用户认证
	 * @return Session 对象
	 */
	public static Session createSession(String name, SmtpAuth auth) {
		Session session = null;
		Properties props = MailSession.getProperties(name);
		session = Session.getInstance(props, auth);
		return session;
	}

	/**
	 * 加载邮件服务器属性配置文件
	 * 
	 * @param name
	 *            文件名（com/../类名）
	 * @return Properties
	 */
	public static Properties getProperties(String name) {
		Properties props = null;
		InputStream is = null;
		try {
			is = SendMail.class.getClassLoader().getResourceAsStream(name);
			props = new Properties();
			props.load(is);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (is != null)
					is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return props;
	}

	// 得到Session对象
	public static Session getInstance(String propsName) {
		return Session.getInstance(getProperties(propsName));
	}
}
