package cn.edu.pdsu.service.user;

import javax.mail.Folder;
import javax.mail.search.AndTerm;
import javax.mail.search.BodyTerm;
import javax.mail.search.ComparisonTerm;
import javax.mail.search.FromStringTerm;
import javax.mail.search.OrTerm;
import javax.mail.search.SearchTerm;
import javax.mail.search.SentDateTerm;
import javax.mail.search.SubjectTerm;

import org.springframework.stereotype.Service;

import cn.edu.pdsu.bean.PageView;
import cn.edu.pdsu.formbean.SearchMailFB;
import cn.edu.pdsu.service.mail.MailBean;
import cn.edu.pdsu.service.mail.MailConstant;
import cn.edu.pdsu.service.mail.receive.MailInfo;
import cn.edu.pdsu.service.mail.receive.ReceiveMail;

import com.sun.mail.imap.IMAPFolder;

/**
 * 类说明：用户搜索邮件服务类
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-20 下午06:42:18
 */
@Service
public class UserSearchMailService {

	// 搜索邮件正文内容
	public PageView<MailBean> searchMailContent(String username,
			String password, int folderType, int page, String content)
			throws Exception {
		String ft = UserReceiveMailService.folderType(folderType);// 得到邮件夹类型
		System.out.println("要搜索的内容是：" + content);
		PageView<MailBean> pageView = new PageView<MailBean>(
				MailConstant.MAXRESULT, page);
		ReceiveMail mail = new ReceiveMail(username, password);// 初始化接收邮件参数
		IMAPFolder folder = mail.openFolder(ft, Folder.READ_WRITE);
		BodyTerm bodyTerm = new BodyTerm(content);
		long[] uids = mail.getMessageUIDs(folder, bodyTerm);
		MailInfo mailinfo = mail.getMailList(pageView.getFirstResult(),
				pageView.getMaxresult() + pageView.getFirstResult(), uids);

		if (mailinfo != null) {
			pageView.setQueryResult(mailinfo.getMailBeanList(), uids.length);
		}
		mail.close();
		return pageView;
	}

	// 高级搜索邮件
	public PageView<MailBean> highSearchMail(String username, String password,
			int folderType, int page, SearchMailFB searchMailFB)
			throws Exception {

		PageView<MailBean> pageView = new PageView<MailBean>(
				MailConstant.MAXRESULT, page);
		ReceiveMail mail = new ReceiveMail(username, password);// 初始化接收邮件参数
		SearchTerm term = createSearchTerm(searchMailFB);
		if (searchMailFB.getFolderType() != -1) {
			String ft = UserReceiveMailService.folderType(searchMailFB
					.getFolderType());// 得到邮件夹类型
			IMAPFolder folder = mail.openFolder(ft, Folder.READ_WRITE);
			long[] uids = mail.getMessageUIDs(folder, term);
			MailInfo mailinfo = mail.getMailList(pageView.getFirstResult(),
					pageView.getMaxresult() + pageView.getFirstResult(), uids);
			if (mailinfo != null) {
				pageView.setQueryResult(mailinfo.getMailBeanList(), uids.length);
			}
		} else {// 在所有邮件夹中搜索
			int total = 0;
			for (int i = 1; i <= 5; i++) {
				String ft = UserReceiveMailService.folderType(i);// 得到邮件夹类型
				IMAPFolder folder = mail.openFolder(ft, Folder.READ_WRITE);
				long[] uids = mail.getMessageUIDs(folder, term);
				if (uids == null || uids.length == 0)
					continue;
				total += uids.length;
				MailInfo mailinfo = mail.getMailList(0, uids.length, uids);
				if (mailinfo != null) {
					if (pageView.getRecords() != null) {
						pageView.getRecords()
								.addAll(mailinfo.getMailBeanList());
					} else {
						pageView.setRecords(mailinfo.getMailBeanList());
					}
				}
			}
			pageView.setTotalrecord(total);// 设置总记录数
		}
		mail.close();
		return pageView;
	}

	// 创建搜素条件
	private SearchTerm createSearchTerm(SearchMailFB searchMailFB) {
		SentDateTerm sentDateTerm = new SentDateTerm(ComparisonTerm.GE,
				searchMailFB.getDate());// 日期搜索
		String keywork = searchMailFB.getKeyword();
		if (keywork == null || "".equals(keywork)) {
			return sentDateTerm;
		} else {
			BodyTerm bodyTerm = new BodyTerm(searchMailFB.getKeyword());// 在正文中搜索关键字
			FromStringTerm addTrem = null;
			SubjectTerm subjectTerm = null;
			OrTerm orTerm = null;
			if (searchMailFB.isInFromOrTo()) {// 在发件人中搜索
				addTrem = new FromStringTerm(searchMailFB.getKeyword());
				orTerm = new OrTerm(bodyTerm, addTrem);
			}
			if (searchMailFB.isInSubject()) {// 在主题中搜索
				subjectTerm = new SubjectTerm(searchMailFB.getKeyword());
				if (orTerm != null) {
					orTerm = new OrTerm(orTerm, subjectTerm);
				} else {
					orTerm = new OrTerm(bodyTerm, subjectTerm);
				}
			}
			if (orTerm != null) {
				return new AndTerm(sentDateTerm, orTerm);
			} else {
				return bodyTerm;
			}
		}
	}
}
