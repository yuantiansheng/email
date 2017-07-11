package cn.edu.pdsu.formbean;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 类说明：发送邮件的基本信息
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-13 上午12:07:17
 */
public class MailInfoFB {
	/** 邮件uid */
	private long uid;
	/** 发件人 */
	private String from;
	/** 收件人 */
	private String to;
	/** 抄送人 */
	private String cc;
	/** 密送人 */
	private String bcc;
	/** 主题 */
	private String subject;
	/** 内容 */
	private String content;
	/** 保存到已发送 */
	private boolean sended;
	/** 紧急邮件 */
	private boolean exigence;
	/** 存文本 */
	private boolean text;
	/** 定时发送 */
	private boolean time;

	/** 邮件所在的邮件夹 */
	private int folderType;

	public long getUid() {
		return uid;
	}

	public void setUid(long uid) {
		this.uid = uid;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = checkEmailAddress(to);
	}

	public String getCc() {
		return cc;
	}

	public void setCc(String cc) {
		this.cc = checkEmailAddress(cc);
	}

	public String getBcc() {
		return bcc;
	}

	public void setBcc(String bcc) {
		this.bcc = checkEmailAddress(bcc);
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public boolean getSended() {
		return sended;
	}

	public void setSended(boolean sended) {
		this.sended = sended;
	}

	public boolean getExigence() {
		return exigence;
	}

	public void setExigence(boolean exigence) {
		this.exigence = exigence;
	}

	public boolean isText() {
		return text;
	}

	public void setText(boolean text) {
		this.text = text;
	}

	public boolean getTime() {
		return time;
	}

	public void setTime(boolean time) {
		this.time = time;
	}

	public int getFolderType() {
		return folderType;
	}

	public void setFolderType(int folderType) {
		this.folderType = folderType;
	}

	public String checkEmailAddress(String emailAddress) {
		String email = null;
		if (emailAddress != null && !"".equals(emailAddress)
				&& emailAddress.length() > 0) {
			emailAddress = emailAddress.replaceAll("；", ";");
			email = emailAddress;
			int index = emailAddress.lastIndexOf(";");
			if (index == emailAddress.length() - 1) {
				email = emailAddress.substring(0, emailAddress.length() - 1);
			}
			if (emailAddress.indexOf(";") != -1) {
				email = emailAddress(emailAddress);// 检测email地址的有效性
			}
		}
		return email;
	}

	// 检测每个email地址的有效性
	public String emailAddress(String emailAdd) {
		String emails[] = emailAdd.split(";");
		StringBuffer sb = new StringBuffer();
		for (String email : emails) {
			if (isEmail(email)) {
				sb.append(email).append(",");
			}
		}
		if (sb.length() > 0)
			sb.deleteCharAt(sb.length() - 1);
		return sb.toString();
	}

	// 检测是否是email地址
	public boolean isEmail(String emailAddress) {
		boolean ise = false;
		Pattern pt = Pattern
				.compile("^\".+\"<[\\w[-_.]]+@[\\w[-_.]]+\\.\\w+>$");
		Pattern pt2 = Pattern.compile("[\\w[-_.]]+@[\\w[-_.]]+\\.\\w+");
		Matcher matcher = pt.matcher(emailAddress);
		if (matcher.matches()) {
			ise = true;
		} else {
			Matcher matcher2 = pt2.matcher(emailAddress);
			if (matcher2.matches()) {
				ise = true;
			}
		}
		return ise;
	}

	public String toString() {
		return new ToStringBuilder(this).append("From", from).append("To", to)
				.append("Cc", cc).append("Bcc", bcc).append("Subject", subject)
				.append("Content", content).append("Sended", sended)
				.append("Exigence", exigence).append("Text", text)
				.append("Time", time).toString();
	}

	public static void main(String[] args) {
		MailInfoFB fb = new MailInfoFB();
		System.out.println("1 : " + fb.isEmail("\"abc\"<abc@163.com>"));
		System.out.println("2 : " + fb.isEmail("\"abcd\"<abc@163.com>"));
		System.out.println("3 : " + fb.isEmail("\"abc\"abc@163.com>"));
		System.out.println("4 : " + fb.isEmail("\"abc\"<abc@163.com"));
		System.out.println("5 : " + fb.isEmail("\"abc\"<abc163.com>"));
		System.out.println("6 : " + fb.isEmail("\"abc<abc@163.com>"));
		System.out.println("7 : " + fb.isEmail("abc\"<abc@163.com>"));
		System.out.println("8 : " + fb.isEmail("abc@163.com"));
		System.out.println("9 : " + fb.isEmail("abc@163.com>"));
		System.out.println("10 : " + fb.isEmail("<abc@163.com"));
		System.out.println("11 : " + fb.isEmail("abc@1.63.com"));
		String email = "\"abc\"<abc@163.com>;" + "\"abcd\"<abc@163.com>;"
				+ "\"abc\"abc@163.com>;" + "\"abc\"<abc@163.com;"
				+ "\"abc\"<abc163.com>;" + "\"abc<abc@163.com>;"
				+ "abc\"<abc@163.com>;" + "abc@163.com;" + "abc@163.com>;"
				+ "<abc@163.com;" + "abc@1.63.com";

		System.out.println(fb
				.emailAddress("\"张晓红3\"<xiaohong3@163.com>;2011@abc.com"));
		fb.checkEmailAddress("\"张晓红3\"<xiaohong3@163.com>;2011@abc.com");
		System.out.println(fb.emailAddress(email));
		System.out.println(fb.checkEmailAddress("test2@abc.com"));
	}
}
