package cn.edu.pdsu.action.user;

import java.io.File;
import java.io.IOException;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.dao.UserDAO;
import cn.edu.pdsu.formbean.MailInfoFB;
import cn.edu.pdsu.service.mail.MailBean;
import cn.edu.pdsu.service.mail.MailConstant;
import cn.edu.pdsu.service.mail.receive.ReceiveMail;
import cn.edu.pdsu.service.mail.send.SendMail;
import cn.edu.pdsu.service.user.UserReceiveMailService;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：发送电子邮件
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-9 下午05:05:35
 */
@Controller
@Scope("prototype")
public class UserSendMailAction extends ActionSupport {
	private static final long serialVersionUID = -5711645379969519270L;
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = request.getSession();
	private String password = (String) session
			.getAttribute(UserLoginAction.USER_PASSWORD);
	private User user = (User) session
			.getAttribute(UserLoginAction.USER_SESSION);
	private MailInfoFB mailInfoFB;// 邮件信息
	@Resource
	private UserDAO userDAO;
	@Resource
	private UserReceiveMailService userReceiveMailService;

	// 查找用户相关信息
	@Override
	public String execute() throws Exception {
		user = userDAO.find(User.class, user.getName());// 查找用户
		deleteAttachment();// 刷新写信时删除附件信息
		return SUCCESS;
	}

	// 发送电子邮件
	public String sendEmail() {
		MailBean mailBean = setMailBean();
		try {
			// 发送邮件
			SendMail mail = new SendMail(mailBean);
			MimeMessage message = mail.createMimeMessage();
			mail.sendMail(message);// 发送邮件
			if (mailInfoFB.getSended()) {// 是否保存到已发送
				ReceiveMail receiveMail = new ReceiveMail(user.getName(),
						password);
				Message m[] = { message };
				receiveMail.copyMessage(m, MailConstant.FOLDER_SENDED);// 将邮件保存到已发送邮件夹中
				receiveMail.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			mailInfoFB.setSended(false);
			mailInfoFB.setFrom("邮件发送失败！请稍后再发...");
			deleteAttachment();// 发完信息时删除硬盘中的附件信息
			return "sendMailSuccess";
		} finally {
			deleteAttachment();// 发完信息时删除硬盘中的附件信息
		}
		mailInfoFB.setSended(true);
		mailInfoFB.setFrom("邮件发送成功！");
		return "sendMailSuccess";
	}

	// 保存到草稿箱
	public String saveDraft() {
		try {
			MailBean mailBean = setMailBean();
			// 发送邮件
			SendMail mail = new SendMail(mailBean);
			MimeMessage message = mail.createMimeMessage();
			ReceiveMail receiveMail = new ReceiveMail(user.getName(), password);
			Message m[] = { message };
			receiveMail.copyMessage(m, MailConstant.FOLDER_DRAFT);//
			// 将邮件保存到草稿箱邮件夹中
			receiveMail.close();
			response.getWriter().print("true");// 邮件发送成功
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.getWriter().print("false");// 邮件发送失败
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		return NONE;
	}

	// 设置邮件基本信息
	private MailBean setMailBean() {
		System.out.println(mailInfoFB);
		MailBean mailBean = new MailBean(user.getName(), password,
				mailInfoFB.getFrom(), mailInfoFB.getTo(),
				mailInfoFB.getSubject(), mailInfoFB.getContent(),
				mailInfoFB.getCc(), mailInfoFB.getBcc());
		mailBean.setExigence(mailInfoFB.getExigence());// 是否紧急
		// 附件
		String path = session.getServletContext().getRealPath("/")
				+ "fileUpload/" + user.getName() + "/";
		File attachment = new File(path);
		if (attachment.exists() && attachment.isDirectory()) {// 有附件
			String files[] = attachment.list();
			StringBuffer attas = new StringBuffer();
			for (int i = 0; i < files.length; i++) {
				attas.append(path).append(files[i]).append(",");
			}
			System.out.println(attas);
			if (attas.length() > 0) {
				attas.deleteCharAt(attas.length() - 1);
				mailBean.setFile(attas.toString());// 将附件添加到附件列表中
			}
		}
		return mailBean;
	}

	// 发送快速回复邮件
	public String sendQuckyReply() {
		try {
			MailBean mailBean = new MailBean(user.getName(), password,
					setMailFrom(user.getName()), mailInfoFB.getTo(), "回复给："
							+ mailInfoFB.getTo(), new String(mailInfoFB
							.getContent().getBytes("ISO-8859-1"), "UTF-8"));
			// 发送邮件
			SendMail mail = new SendMail(mailBean);
			MimeMessage message = mail.createMimeMessage();
			mail.sendMail(message);// 发送邮件
		} catch (Exception e) {
			e.printStackTrace();
			mailInfoFB.setSended(false);
			mailInfoFB.setFrom("邮件发送失败！请稍后再发...");
			return "sendMailSuccess";
		}
		mailInfoFB.setSended(true);
		mailInfoFB.setFrom("邮件发送成功！");
		return "sendMailSuccess";
	}

	// 回复邮件
	public String replyMail() {
		try {
			user = userDAO.find(User.class, user.getName());// 查找用户
			MailBean mailBean = userReceiveMailService.getMailBean(
					user.getName(), password, mailInfoFB.getFolderType(),
					mailInfoFB.getUid());
			mailInfoFB.setSubject(mailBean.getSubject());// 主题
			mailInfoFB.setContent(mailBean.getContent());// 设置正文
		} catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	// 设置发件人
	private String setMailFrom(String username) {
		user = userDAO.find(User.class, username);// 查找用户
		String alias = user.getUserInfo().getAlias();
		if (alias != null && !"".equals(alias)) {
			return ("\"" + alias + "\"<" + username + "@abc.com>");
		} else {
			return ("\"" + username + "\"<" + username + "@abc.com>");
		}
	}

	// 删除硬盘中的附件信息
	private void deleteAttachment() {
		String path = session.getServletContext().getRealPath("/")
				+ "fileUpload/" + user.getName() + "/";
		File attachment = new File(path);
		if (attachment.exists() && attachment.isDirectory()) {
			File files[] = attachment.listFiles();
			for (File file : files) {
				file.delete();// 删除上传的附件
			}
			attachment.delete();// 删除目录
		}
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public MailInfoFB getMailInfoFB() {
		return mailInfoFB;
	}

	public void setMailInfoFB(MailInfoFB mailInfoFB) {
		this.mailInfoFB = mailInfoFB;
	}

}
