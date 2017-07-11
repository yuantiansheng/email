package cn.edu.pdsu.action.user;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：文件下载action(主要是附件的下载)
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-19 上午02:51:35
 */
@Controller
@Scope("prototype")
public class FileDownLoadAction extends ActionSupport {
	private static final long serialVersionUID = -1784267515898231045L;
	private String fileName = null;// 要下载的文件名
	private String path = null;// 要下载文件的路径
	HttpServletRequest request = ServletActionContext.getRequest();

	public String execute() throws Exception {
		return SUCCESS;
	}

	// 下载文件
	public InputStream getDownloadFile() {
		InputStream is = null;
		try {
			is = new FileInputStream(path + "/" + fileName);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		return is;
	}

	public void setFileName(String fileName) {
		try {// 解决中文文件名问题
			this.fileName = new String(fileName.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public String getFileName() {
		try {// 解决下载文件中文文件名问题
			fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return fileName;
	}

	public String getPath() {
		try {// 解决下载文件中文路径
			path = new String(path.getBytes("UTF-8"), "ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return path;
	}

	public void setPath(String path) {
		try {// 解决中文文件路径
			this.path = new String(path.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

}
