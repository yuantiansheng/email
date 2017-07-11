package cn.edu.pdsu.utils;

import org.apache.commons.lang.RandomStringUtils;

/**
 * 类说明：随机生成6位的用户密码
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-7-28 下午02:40:42
 */
public class FindPasswordByEmailUtils {
	private static char[] chars = new char[92];
	static {
		for (int i = 0; i < 26; i++) {
			chars[i] = (char) ('a' + i);
			chars[i + 26] = (char) ('A' + i);
		}
		for (int i = 0; i < 10; i++) {
			chars[52 + i] = (char) ('0' + i);
			chars[62 + i] = (char) ('0' + i);
			chars[72 + i] = (char) ('0' + i);
			chars[82 + i] = (char) ('0' + i);
		}
	}

	public static String createPassword() {
		String string = RandomStringUtils.random(6, chars);
		return string;
	}

	public static String createFindPasswrdMail(String password, String path) {
		StringBuffer message = new StringBuffer();
		message.append("<html xmlns=\"http://www.w3.org/1999/xhtml\">")
				.append("<head>")
				.append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />")
				.append("<title>米林邮箱密码重置邮件</title>").append("</head>")
				.append("<body>").append("<center>")
				.append("<h2>非常感谢你使用米林LJG邮箱</h2>")
				.append("<br />我们已将你的密码重新设置成为<b>").append(password)
				.append("</b>，请使用新的密码&nbsp;<a href=\"").append(path)
				.append("\"  target=\"_blank\">").append("登录")
				.append("</a>&nbsp;邮箱。<br /><br />")
				.append("如果不能登录邮箱，请与客服联系，联系电话：400-900-008").append("</center>")
				.append("</body>").append("</html>");

		return message.toString();
	}

	public static void main(String[] args) {
		System.out.println(createPassword());
		System.err.println(createFindPasswrdMail("1234556",
				"http://localhost:8080/email/"));
	}
}
