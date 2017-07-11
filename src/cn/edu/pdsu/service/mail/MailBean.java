package cn.edu.pdsu.service.mail;

import java.util.Date;

import cn.edu.pdsu.service.mail.send.SmtpAuth;

/**
 * 类说明：封装邮件信息
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-22 下午06:03:06
 */
public class MailBean {
	/**
	 * 收件人
	 */
	private String to = null;
	/**
	 * 主题
	 */
	private String subject = null;
	/**
	 * 发件人
	 */
	private String from = null;
	/**
	 * 抄送人
	 */
	private String cc = null;
	/**
	 * 密送人
	 */
	private String bcc = null;
	/**
	 * 附件名称
	 */
	private String file = null;
	/**
	 * 用户名
	 */
	private String username = null;
	/**
	 * 密码
	 */
	private String password = null;
	/**
	 * 邮件夹的名称
	 */
	private String record = null; // name of folder in which to record mail
	/**
	 * 内嵌资源名称
	 */
	private String resource = null;
	/**
	 * 发件时间（接收时间）
	 */
	private Date date = new Date();
	/**
	 * 正文内容
	 */
	private String content = null;
	/**
	 * 用户认证类
	 */
	private SmtpAuth auth = null;
	/**
	 * 邮件大小
	 */
	private int size = 0;

	/**
	 * 邮件id
	 */
	private String messageID = null;
	private long messageUID = 0;
	/** 邮件标记 */
	private String flags = null;
	/** 邮件是否已读 */
	private boolean read = false;
	/** 是否紧急 */
	private boolean exigence = false;

	/** 是否保存到已发送 */
	private boolean sended = false;

	/** 所在邮件夹类型 */
	private int folderType;

	public MailBean() {
	}

	/**
	 * 基本的邮件信息
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @param from
	 *            发件人
	 * @param to
	 *            收件人
	 * @param subject
	 *            主题
	 * @param content
	 *            内容
	 */
	public MailBean(String username, String password, String from, String to,
			String subject, String content) {
		this.to = to;
		this.subject = subject;
		this.from = from;
		this.username = username;
		this.password = password;
		this.content = content;
		initSmtpAuth();// 初始化用户认证类
	}

	/**
	 * 基本的邮件信息
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @param from
	 *            发件人
	 * @param to
	 *            收件人
	 * @param subject
	 *            主题
	 * @param content
	 *            内容
	 * @param resource
	 *            资源名称
	 */
	public MailBean(String username, String password, String from, String to,
			String subject, String content, String resource) {
		super();
		this.to = to;
		this.subject = subject;
		this.from = from;
		this.username = username;
		this.password = password;
		this.resource = resource;
		this.content = content;
		initSmtpAuth();// 初始化用户认证类
	}

	/**
	 * 邮件信息初始化
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @param from
	 *            发件人
	 * @param to
	 *            收件人
	 * @param subject
	 *            主题
	 * @param content
	 *            内容
	 * @param cc
	 *            抄送
	 * @param bcc
	 *            密送
	 */
	public MailBean(String username, String password, String from, String to,
			String subject, String content, String cc, String bcc) {
		this.to = to;
		this.subject = subject;
		this.from = from;
		this.cc = cc;
		this.bcc = bcc;
		this.username = username;
		this.password = password;
		this.content = content;
		initSmtpAuth();// 初始化用户认证类
	}

	/**
	 * 邮件信息初始化
	 * 
	 * @param username
	 *            用户名
	 * @param password
	 *            密码
	 * @param from
	 *            发件人
	 * @param to
	 *            收件人
	 * @param subject
	 *            主题
	 * @param content
	 *            内容
	 * @param cc
	 *            抄送
	 * @param bcc
	 *            密送
	 * @param file
	 *            附件
	 * @param resource
	 *            资源
	 */
	public MailBean(String username, String password, String from, String to,
			String subject, String content, String cc, String bcc, String file,
			String resource) {
		super();
		this.to = to;
		this.subject = subject;
		this.from = from;
		this.cc = cc;
		this.bcc = bcc;
		this.file = file;
		this.username = username;
		this.password = password;
		this.resource = resource;
		this.content = content;
		initSmtpAuth();// 初始化用户认证类
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getCc() {
		return cc;
	}

	public void setCc(String cc) {
		this.cc = cc;
	}

	public String getBcc() {
		return bcc;
	}

	public void setBcc(String bcc) {
		this.bcc = bcc;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
		initSmtpAuth();// 初始化用户认证类
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
		initSmtpAuth();// 初始化用户认证类
	}

	public String getRecord() {
		return record;
	}

	public void setRecord(String record) {
		this.record = record;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getResource() {
		return resource;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public void setResource(String resource) {
		this.resource = resource;
	}

	/**
	 * 得到用户认证
	 * 
	 * @return
	 */
	public SmtpAuth getAuth() {
		return auth;
	}

	/**
	 * 初始化用户认证类
	 */
	public void initSmtpAuth() {
		if (username != null && !"".equals(username) && password != null
				&& !"".equals(password))
			setAuth(new SmtpAuth(username, password));
	}

	public void setAuth(SmtpAuth auth) {
		this.auth = auth;
	}

	public String getMessageID() {
		return messageID;
	}

	public void setMessageID(String messageID) {
		this.messageID = messageID;
	}

	public long getMessageUID() {
		return messageUID;
	}

	public void setMessageUID(long messageUID) {
		this.messageUID = messageUID;
	}

	public String getFlags() {
		return flags;
	}

	public void setFlags(String flags) {
		this.flags = flags;
	}

	/**
	 * 检测邮件是否已读
	 * 
	 * @return 已读 返回 true，否则返回false
	 */
	public boolean getRead() {
		if (flags != null && !"".equals(flags)) {
			String[] fs = flags.split(",");
			for (String falg : fs) {
				if ("SEEN".equalsIgnoreCase(falg))
					return true;
			}
		}
		return false;
	}

	public void setRead(boolean read) {
		this.read = read;
	}

	public boolean isExigence() {
		return exigence;
	}

	public void setExigence(boolean exigence) {
		this.exigence = exigence;
	}

	public boolean isSended() {
		return sended;
	}

	public void setSended(boolean sended) {
		this.sended = sended;
	}

	public int getFolderType() {
		return folderType;
	}

	public void setFolderType(int folderType) {
		this.folderType = folderType;
	}

}
