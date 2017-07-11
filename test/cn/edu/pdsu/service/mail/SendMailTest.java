package cn.edu.pdsu.service.mail;

import java.io.UnsupportedEncodingException;

import javax.activation.FileDataSource;
import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.junit.Test;

import cn.edu.pdsu.service.mail.send.SendMail;

/**
 * 类说明：
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-23 上午12:55:52
 */
public class SendMailTest {
	@Test
	public void test1() throws Exception {// 基本内容测试
		for (int i = 0; i < 1; i++) {

			MailBean mailBean = new MailBean("admin@ljg.com", "admin",
					"\"管理员\"<admin@ljg.com>", "\"孤独\"<test2@ljg.com>,",
					"test7主题" + i, i + "test7测试邮件");
			SendMail mail = new SendMail(mailBean);
			String attachment = "test/cn/edu/pdsu/service/mail/a_2011_08_07我的图片.gif";
			mailBean.setFile(attachment);
			mail.sendMail();
		}
	}

	@Test
	public void test2() throws AddressException, UnsupportedEncodingException,
			MessagingException {// 测试抄送密送
		MailBean mailBean = new MailBean("1@ljg.com", "1", "1@ljg.com",
				"\"你好\"<a@ljg.com>,b@ljg.com,abc@ljg.com", "邮件主题", "测试邮件",
				"b@ljg.com,abc@ljg.com", "abc@ljg.com");
		SendMail mail = new SendMail(mailBean);
		mail.sendMail();
	}

	@Test
	public void test3() throws AddressException, UnsupportedEncodingException,
			MessagingException {// 测试添加附件
		MailBean mailBean = new MailBean("1@ljg.com", "1", "1@ljg.com",
				"a@ljg.com", "邮件主题", "测试邮件", "b@ljg.com", "abc@ljg.com");
		String attachment = "test/cn/edu/pdsu/service/mail/a.gif";
		mailBean.setFile(attachment);
		SendMail mail = new SendMail(mailBean);
		mail.sendMail();
	}

	@Test
	public void test4() throws AddressException, UnsupportedEncodingException,
			MessagingException {// 测试添加资源
		MailBean mailBean = new MailBean("1@ljg.com", "1", "1@ljg.com",
				"a@ljg.com", "邮件主题", "测试邮件", "b@ljg.com", "abc@ljg.com");
		String res = "test/cn/edu/pdsu/service/mail/a.gif";
		mailBean.setResource(res);
		SendMail mail = new SendMail(mailBean);
		mail.sendMail();
	}

	@Test
	public void test5() throws AddressException, UnsupportedEncodingException,
			MessagingException {// 添加附件添加资源
		MailBean mailBean = new MailBean("1@ljg.com", "1", "1@ljg.com",
				"a@ljg.com", "测试邮件", "邮件主题", "abc@ljg.com", "b@ljg.com");
		String res = "test/cn/edu/pdsu/service/mail/a.gif";
		mailBean.setResource(res);
		String attachment = "test/cn/edu/pdsu/service/mail/a.gif,test/cn/edu/pdsu/service/mail/SendMailTest.java";
		mailBean.setFile(attachment);
		SendMail mail = new SendMail(mailBean);
		mail.sendMail();
	}

	@Test
	public void res() {
		String resources[] = "a.gif,send/SmtpAuth.java".split(",");
		for (String res : resources) {
			System.out.println(res);
			FileDataSource fds = new FileDataSource(res);
			System.out.println(fds.getName());
		}
	}

	private String file = "<html><body><h1>我是测试邮件</h1></body></html>";
}
