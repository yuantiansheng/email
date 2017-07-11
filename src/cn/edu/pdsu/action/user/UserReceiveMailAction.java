package cn.edu.pdsu.action.user;

import java.io.FileWriter;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.edu.pdsu.bean.PageView;
import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.service.mail.MailBean;
import cn.edu.pdsu.service.user.UserReceiveMailService;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：用户收取邮件action
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-1 下午06:44:48
 */
@Controller
@Scope("prototype")
public class UserReceiveMailAction extends ActionSupport implements
		SessionAware {
	private Map<String, Object> session;
	private static final long serialVersionUID = -5112690940070586282L;
	private User user;
	private long uid;// 要阅读的邮件的uid
	private MailBean mailBean;// 要阅读的邮件信息
	private String password;
	private PageView<MailBean> pageView;
	private int page = 1;// 当前页(默认是第一页)
	private String mailUid;// 用户UID
	private String type;// 操作类型
	private int folderType = 1;// 邮件夹的类型
	private String fileName = null;// 要下载的附件的名称
	private String path = null;// 要下载的附件的路径
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpSession httpsession = request.getSession();
	@Resource
	private UserReceiveMailService userReceiveMailService;

	@Override
	public String execute() throws Exception {
		user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
		password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
		pageView = userReceiveMailService.getMailInfoPageView(user.getName(),
				password, folderType, page);
		return SUCCESS;
	}

	// 删除邮件
	public String deleteMail() {
		try {
			user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			userReceiveMailService.deleteMail(user.getName(), password,
					folderType, mailUid);// 将邮件移动到“已删除”收件夹下
			pageView = userReceiveMailService.getMailInfoPageView(
					user.getName(), password, folderType, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// 彻底删除邮件
	public String deleteMailForever() {
		try {
			user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			userReceiveMailService.deleteMailForever(user.getName(), password,
					folderType, mailUid);// 将邮件"彻底删除"收件夹下
			pageView = userReceiveMailService.getMailInfoPageView(
					user.getName(), password, folderType, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// 标记邮件是否已读
	public String markMail() {
		try {
			user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			if (userReceiveMailService.setMailFlags(user.getName(), password,
					folderType, mailUid, type)) {
				pageView = userReceiveMailService.getMailInfoPageView(
						user.getName(), password, folderType, page);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// 移动邮件到指定的邮件夹
	public String moveMail() {
		try {
			user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			userReceiveMailService.moveMail(user.getName(), password,
					folderType, type, mailUid);// 移动邮件到指定的邮件夹中
			pageView = userReceiveMailService.getMailInfoPageView(
					user.getName(), password, folderType, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// 查看指定类型的邮件（已读、未读）
	public String seeMail() {
		try {
			user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			pageView = userReceiveMailService.seeMail(user.getName(), password,
					folderType, type, page);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// 阅读邮件
	public String readMail() {
		try {
			user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			mailBean = userReceiveMailService.getMailBean(user.getName(),
					password, folderType, uid);
			writeMail(mailBean.getContent());// 将邮件的正文内容写入到readMail.html文件中
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "readMail";
	}

	// 将邮件正文内容写入到readMail.html文件中
	private void writeMail(String content) throws IOException {
		String path = httpsession.getServletContext().getRealPath("/")
				+ "readMail.html";
		FileWriter fw = new FileWriter(path);
		fw.write(content);
		fw.close();
	}

	// 邮件附件的下载
	public String attachmentDownload() {
		try {
			user = (User) session.get(UserLoginAction.USER_SESSION);// 得到session中的用户信息
			password = (String) session.get(UserLoginAction.USER_PASSWORD);// 得到用户密码
			path = httpsession.getServletContext().getRealPath("/")
					+ "fileDownLoad/" + user.getName();
			userReceiveMailService.attachmentDownLoad(user.getName(), password,// 将附件保存到指定的路径中
					folderType, uid, fileName, path);
		} catch (Exception e) {
			e.printStackTrace();
			return "downloadFail";
		}
		return "download";
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
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

	public int getFolderType() {
		return folderType;
	}

	public void setFolderType(int folderType) {
		this.folderType = folderType;
	}

	public long getUid() {
		return uid;
	}

	public void setUid(long uid) {
		this.uid = uid;
	}

	public MailBean getMailBean() {
		return mailBean;
	}

	public void setMailBean(MailBean mailBean) {
		this.mailBean = mailBean;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		try {
			fileName = new String(fileName.trim().getBytes("ISO-8859-1"),
					"UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		this.fileName = fileName;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

}
