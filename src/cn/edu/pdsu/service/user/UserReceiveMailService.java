package cn.edu.pdsu.service.user;

import javax.mail.Folder;
import javax.mail.MessagingException;
import javax.mail.search.FlagTerm;
import javax.mail.search.SearchTerm;

import org.springframework.stereotype.Service;

import cn.edu.pdsu.bean.PageView;
import cn.edu.pdsu.service.mail.MailBean;
import cn.edu.pdsu.service.mail.MailConstant;
import cn.edu.pdsu.service.mail.receive.Flag;
import cn.edu.pdsu.service.mail.receive.MailInfo;
import cn.edu.pdsu.service.mail.receive.ReceiveMail;

import com.sun.mail.imap.IMAPFolder;

/**
 * 类说明：接收邮件服务层
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-2 下午11:45:41
 */
@Service
public class UserReceiveMailService {

	// 设置邮件信息（并将邮件信息封装到PageView中）
	public PageView<MailBean> getMailInfoPageView(String username,
			String password, int folderType, int page) throws Exception {
		PageView<MailBean> pageView = new PageView<MailBean>(
				MailConstant.MAXRESULT, page);
		ReceiveMail mail = new ReceiveMail(username, password);// 初始化接收邮件参数
		IMAPFolder folder = mail.openFolder(folderType(folderType),
				Folder.READ_WRITE);
		long[] uids = mail.getMessageUIDs(folder);
		MailInfo mailinfo = mail.getMailList(pageView.getFirstResult(),
				pageView.getMaxresult() + pageView.getFirstResult(), uids);
		if (mailinfo != null) {
			pageView.setQueryResult(mailinfo.getMailBeanList(),
					mailinfo.getMessageCount());
			pageView.setNewAndUnreadMail(mailinfo.getNewMessageCount(),
					mailinfo.getUnreadMessageCount());
		}
		mail.close();
		return pageView;
	}

	// 根据邮件夹类型设置邮件夹的名称
	public static String folderType(int type) {
		switch (type) {
		case MailConstant.INBOX:
			return MailConstant.FOLDER_INBOX;
		case MailConstant.DRAFT:
			return MailConstant.FOLDER_DRAFT;
		case MailConstant.DELETE:
			return MailConstant.FOLDER_DELETE;
		case MailConstant.SENDED:
			return MailConstant.FOLDER_SENDED;
		case MailConstant.SPAM:
			return MailConstant.FOLDER_SPAM;
		}
		return MailConstant.FOLDER_INBOX;
	}

	// 根据邮件夹名称返回邮件夹类型
	public static int folderType(String folderName) {
		if (folderName.equals(MailConstant.FOLDER_INBOX)) {
			return MailConstant.INBOX;
		} else if (folderName.equals(MailConstant.FOLDER_DRAFT)) {
			return MailConstant.DRAFT;
		} else if (folderName.equals(MailConstant.FOLDER_DELETE)) {
			return MailConstant.DELETE;
		} else if (folderName.equals(MailConstant.FOLDER_SENDED)) {
			return MailConstant.SENDED;
		} else if (folderName.equals(MailConstant.FOLDER_SPAM)) {
			return MailConstant.SPAM;
		}
		return MailConstant.INBOX;
	}

	// 设置邮件标记
	public boolean setMailFlags(String name, String password, int folderType,
			String mailUid, String type) {
		try {
			ReceiveMail mail = new ReceiveMail(name, password);
			mail.openFolder(folderType(folderType), Folder.READ_WRITE);// 打开指定的邮件夹
			setFlag(type, mail, getLongUid(mailUid));// 设置邮件标记
			mail.close();
		} catch (MessagingException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	// 设置邮件的标记
	private void setFlag(String type, ReceiveMail mail, long[] longUid)
			throws MessagingException {
		if ("markRead".equalsIgnoreCase(type)) {// 标志为已读邮件
			mail.setMessagesFlags(longUid, Flag.SEEN, true);
		} else if ("markUnread".equalsIgnoreCase(type)) {// 标志为未读
			mail.setMessagesFlags(longUid, Flag.SEEN, false);
		}
	}

	// 移动邮件到“已删除”
	public void deleteMail(String name, String password, int folderType,
			String mailUid) throws Exception {
		moveMail(name, password, folderType, "moveDelete", mailUid);// 移动邮件到"已删除"

	}

	// 彻底删除邮件
	public void deleteMailForever(String name, String password, int folderType,
			String mailUid) throws MessagingException {
		ReceiveMail mail = new ReceiveMail(name, password);
		mail.deleteMessage(folderType(folderType), getLongUid(mailUid));
		mail.close();// 关闭连接
	}

	// 通过字符串类型的uid返回long[]类型的uid数组
	private long[] getLongUid(String mailUid) {
		String uids[] = mailUid.split(",");// 要删除的邮件的UID
		long longUid[] = new long[uids.length];
		for (int i = 0; i < uids.length; i++) {
			longUid[i] = Long.parseLong(uids[i]);
		}
		return longUid;
	}

	// 移动邮件到指定的邮件夹中
	public void moveMail(String name, String password, int folderType,
			String type, String mailUid) throws Exception {
		ReceiveMail mail = new ReceiveMail(name, password);
		mail.moveMessage(folderType(folderType), getMailFolderName(type),
				getLongUid(mailUid));
		mail.close();// 关闭连接
	}

	// 查看指定的(已读、未读)邮件
	public PageView<MailBean> seeMail(String name, String password,
			int folderType, String type, int page) throws Exception {
		PageView<MailBean> pageView = new PageView<MailBean>(
				MailConstant.MAXRESULT, page);
		ReceiveMail mail = new ReceiveMail(name, password);// 初始化接收邮件参数
		IMAPFolder folder = mail.openFolder(folderType(folderType),
				Folder.READ_WRITE);
		long[] uids = mail.getMessageUIDs(folder, getSearchTerm(type));
		MailInfo mailinfo = mail.getMailList(pageView.getFirstResult(),
				pageView.getMaxresult() + pageView.getFirstResult(), uids);
		System.out.println("页面总数：" + pageView.getTotalpage());
		if (mailinfo != null) {
			pageView.setQueryResult(mailinfo.getMailBeanList(), uids.length);
			pageView.setNewAndUnreadMail(mailinfo.getNewMessageCount(),
					mailinfo.getUnreadMessageCount());
		}
		mail.close();
		return pageView;
	}

	// 根据uid查看邮件
	public MailBean getMailBean(String name, String password, int folderType,
			long uid) throws Exception {
		ReceiveMail mail = new ReceiveMail(name, password);// 初始化接收邮件参数
		mail.openFolder(folderType(folderType), Folder.READ_WRITE);
		MailBean mailBean = mail.getMessageByUID(uid);
		mail.close();
		return mailBean;
	}

	// 得到邮件指定的查看方式
	private SearchTerm getSearchTerm(String type) {
		if ("seeUnread".equalsIgnoreCase(type)) {
			return new FlagTerm(Flag.SEEN.getFlag(), false);// 查看未读邮件
		} else if ("seeRead".equalsIgnoreCase(type)) {
			return new FlagTerm(Flag.SEEN.getFlag(), true);// 查看已读邮件
		}
		return new FlagTerm(Flag.SEEN.getFlag(), false);
	}

	// 根据前台string类型的数据返回邮件夹类型
	private String getMailFolderName(String type) {
		if ("moveDraft".equalsIgnoreCase(type)) {
			return MailConstant.FOLDER_DRAFT;
		} else if ("moveSended".equalsIgnoreCase(type)) {
			return MailConstant.FOLDER_SENDED;
		} else if ("moveDelete".equalsIgnoreCase(type)) {
			return MailConstant.FOLDER_DELETE;
		} else if ("moveInbox".equalsIgnoreCase(type)) {
			return MailConstant.FOLDER_INBOX;
		} else if ("moveSpam".equalsIgnoreCase(type)) {
			return MailConstant.FOLDER_SPAM;
		}
		return MailConstant.FOLDER_DELETE;
	}

	// 下载附件（将附件保存到指定的路径中）
	public void attachmentDownLoad(String name, String password,
			int folderType, long uid, String fileName, String path)
			throws Exception {
		ReceiveMail mail = new ReceiveMail(name, password);// 初始化接收邮件参数
		mail.openFolder(folderType(folderType), Folder.READ_WRITE);
		mail.getMessageByUID(uid, true, fileName, path);// 保存附件到指定的路径中
		mail.close();
	}
}
