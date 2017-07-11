package cn.edu.pdsu.service.mail;

import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.mail.Folder;
import javax.mail.internet.MimeUtility;

import org.junit.Test;

import cn.edu.pdsu.service.mail.receive.MailInfo;
import cn.edu.pdsu.service.mail.receive.ReceiveMail;

import com.sun.mail.imap.IMAPFolder;

/**
 * 类说明：
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-15 下午06:03:44
 */
public class ReceiveMailTest2 {

	@Test
	// 接收某个邮件夹下的所有邮件
	public void AllMailListTest() throws Exception {
		// 初始化接收邮件类
		ReceiveMail mail = new ReceiveMail("test2", "test");
		// 打开要接收邮件的邮件夹
		mail.openFolder(MailConstant.FOLDER_INBOX, Folder.READ_WRITE);
		MailInfo mailInfo = mail.getMailList();
		mail.close();
		List<MailBean> list = mailInfo.getMailBeanList();
		for (MailBean m : list) {
			pf(m);
		}
	}

	@Test
	// 测试所有邮件的uid
	public void SortListTest() throws Exception {
		// 初始化接收邮件类
		ReceiveMail mail = new ReceiveMail("test2", "test");
		// 打开要接收邮件的邮件夹
		IMAPFolder folder = mail.openFolder(MailConstant.FOLDER_INBOX,
				Folder.READ_WRITE);
		long[] uids = mail.getMessageUIDs(folder);
		mail.close();
		for (long uid : uids) {
			System.out.print(uid + "\t");
		}
	}

	@Test
	// 测试指定位置邮件的uid copy数组
	public void UidCopyTest() throws Exception {
		// 初始化接收邮件类
		ReceiveMail mail = new ReceiveMail("test2", "test");
		// 打开要接收邮件的邮件夹
		IMAPFolder folder = mail.openFolder(MailConstant.FOLDER_INBOX,
				Folder.READ_WRITE);
		long[] uids = mail.getMessageUIDs(folder);
		MailInfo mailInfo = mail.getMailList(0, 2, uids);
		mail.close();
		List<MailBean> list = mailInfo.getMailBeanList();
		for (MailBean m : list) {
			pf(m);
		}
	}

	@Test
	// 测试附件的中文名称问题
	public void attachmentFileNameTest() throws Exception {
		// 初始化接收邮件类
		ReceiveMail mail = new ReceiveMail("test2", "test");
		// 打开要接收邮件的邮件夹
		IMAPFolder folder = mail.openFolder(MailConstant.FOLDER_INBOX,
				Folder.READ_WRITE);
		MailBean MailBean = mail.getMessageByUID(116l);
		String filename = MailBean.getFile();
		System.out.println("附件名称: " + filename);
		pf(MailBean);
	}

	// 将邮件正文内容写入到readMail.html文件中
	private void writeMail(String content) throws IOException {
		FileWriter fw = new FileWriter("D:/readMail.html");
		fw.write(content);
		fw.close();
	}

	// 打印邮件信息
	public void pf(MailBean m) {
		System.out.println("抄送：" + m.getCc());
		System.out.println("发件人：" + m.getFrom());
		System.out.println("邮件id：" + m.getMessageID());
		System.out.println("大小：" + m.getSize());
		System.out.println("主题：" + m.getSubject());
		System.out.println("收件人：" + m.getTo());
		System.out.println("日期：" + m.getDate());
		System.out.println("MessageUID: " + m.getMessageUID());
		System.out.println("邮件标记是：" + m.getFlags());
		System.out.println("*********************************************");
	}

	// 测试空编码
	@Test
	public void testDecode() {
		try {
			MimeUtility.decodeText(null);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	// 测试邮件附件保存
	@Test
	public void attachmentSaveTest() throws Exception {
		// 初始化接收邮件类
		ReceiveMail mail = new ReceiveMail("test2", "test");
		// 打开要接收邮件的邮件夹
		IMAPFolder folder = mail.openFolder(MailConstant.FOLDER_INBOX,
				Folder.READ_WRITE);
		MailBean MailBean = mail.getMessageByUID(116l, true,
				"20110704_152731_024305_银月谷_艾米雪2011.jpg", "D:/attachment");
		String filename = MailBean.getFile();
		System.out.println("附件名称: " + filename);
		pf(MailBean);
	}
}
