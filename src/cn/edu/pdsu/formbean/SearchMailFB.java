package cn.edu.pdsu.formbean;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * 类说明：搜索邮件FormBean
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-20 下午06:47:00
 */
public class SearchMailFB {
	private String content = null;// 正文中要搜索的内容
	private String keyword = null;// 搜索关键字
	private int folderType = -1;// 要搜索的邮件夹类型
	private boolean inSubject = false;// 是否在主题中搜素偶
	private boolean inFromOrTo = false;// 是否在收件人，发件人中搜索
	private int time = 1;// 时间范围
	private int timeType = 1;// 时间单位
	private Date date = null;// 通过time 和 timeType运算出的日期

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		try {
			content = new String(content.getBytes("ISO-8859-1"), "UTF-8");
			System.out.println("要搜索的内容是：" + content);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		this.content = content;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getFolderType() {
		return folderType;
	}

	public void setFolderType(int folderType) {
		this.folderType = folderType;
	}

	public boolean isInSubject() {
		return inSubject;
	}

	public void setInSubject(boolean inSubject) {
		this.inSubject = inSubject;
	}

	public boolean isInFromOrTo() {
		return inFromOrTo;
	}

	public void setInFromOrTo(boolean inFromOrTo) {
		this.inFromOrTo = inFromOrTo;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	public int getTimeType() {
		return timeType;
	}

	public void setTimeType(int timeType) {
		this.timeType = timeType;
	}

	public Date getDate() {
		date = calculateDate(time, timeType);
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Date calculateDate(int time, int timeType) {
		Calendar calendar = Calendar.getInstance();
		switch (timeType) {
		case 1:// 天
			calendar.add(Calendar.DAY_OF_MONTH, -time);
			break;
		case 2:// 周
			calendar.add(Calendar.DAY_OF_MONTH, -(time * 7));
			break;
		case 3:// 月
			calendar.add(Calendar.MONTH, -time);
			break;
		case 4:// 年
			calendar.add(Calendar.YEAR, -time);
			break;
		}
		return calendar.getTime();
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this).append("keyword", keyword)
				.append("folderType", folderType)
				.append("inSubject", inSubject)
				.append("inFromOrTo", inFromOrTo).append("time", time)
				.append("timeType", timeType).toString();
	}

	public static void main(String[] args) {
		SearchMailFB fb = new SearchMailFB();
		fb.setTime(10);
		fb.setTimeType(4);
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(df.format(fb.getDate()));
	}
}
