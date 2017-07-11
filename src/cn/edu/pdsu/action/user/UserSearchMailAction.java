package cn.edu.pdsu.action.user;

import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.edu.pdsu.bean.PageView;
import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.formbean.SearchMailFB;
import cn.edu.pdsu.service.mail.MailBean;
import cn.edu.pdsu.service.user.UserReceiveMailService;
import cn.edu.pdsu.service.user.UserSearchMailService;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：用户搜索邮件action
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-20 下午06:27:08
 */
@Controller
@Scope("prototype")
public class UserSearchMailAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 498319842020496260L;
	private int folderType = 1;// 默认在收件夹中进行搜索
	private Map<String, Object> session = null;
	private PageView<MailBean> pageView;
	private int page = 1;// 当前页(默认是第一页)
	private String type;// 操作类型
	private SearchMailFB searchMailFB = null;
	private String mailUid;// 用户UID
	@Resource
	private UserSearchMailService userSearchMailService;
	@Resource
	private UserReceiveMailService userReceiveMailService;

	@Override
	// 默认搜索邮件内容
	public String execute() throws Exception {
		User user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
		String password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
		pageView = userSearchMailService.searchMailContent(user.getName(),
				password, folderType, page, searchMailFB.getContent());
		return SUCCESS;
	}

	// 高级搜索
	public String highSearch() {
		System.out.println(searchMailFB);
		try {
			User user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			String password = (String) session
					.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			pageView = userSearchMailService.highSearchMail(user.getName(),
					password, folderType, page, searchMailFB);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "highSearchSuccess";
	}

	// 删除邮件
	public String deleteMail() {
		User user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
		String password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
		try {
			userReceiveMailService.deleteMail(user.getName(), password,
					folderType, mailUid);
		} catch (Exception e) {
			e.printStackTrace();
		}// 将邮件移动到“已删除”收件夹下
		return "searchMail";
	}

	// 彻底删除邮件
	public String deleteMailForever() {
		try {
			User user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			String password = (String) session
					.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			userReceiveMailService.deleteMailForever(user.getName(), password,
					folderType, mailUid);// 将邮件"彻底删除"收件夹下
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "searchMail";
	}

	// 标记邮件是否已读
	public String markMail() {
		try {
			User user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			String password = (String) session
					.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			if (userReceiveMailService.setMailFlags(user.getName(), password,
					folderType, mailUid, type)) {
				return "searchMail";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "searchMail";
	}

	// 移动邮件到指定的邮件夹
	public String moveMail() {
		try {
			User user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			String password = (String) session
					.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			userReceiveMailService.moveMail(user.getName(), password,
					folderType, type, mailUid);// 移动邮件到指定的邮件夹中
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "searchMail";
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public int getFolderType() {
		return folderType;
	}

	public void setFolderType(int folderType) {
		this.folderType = folderType;
	}

	public PageView<MailBean> getPageView() {
		return pageView;
	}

	public void setPageView(PageView<MailBean> pageView) {
		this.pageView = pageView;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public SearchMailFB getSearchMailFB() {
		return searchMailFB;
	}

	public void setSearchMailFB(SearchMailFB searchMailFB) {
		this.searchMailFB = searchMailFB;
	}

	public String getMailUid() {
		return mailUid;
	}

	public void setMailUid(String mailUid) {
		this.mailUid = mailUid;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}
