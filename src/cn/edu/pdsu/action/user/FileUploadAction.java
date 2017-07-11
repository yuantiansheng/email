package cn.edu.pdsu.action.user;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：文件上传action
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-12 下午04:57:49
 */
@Controller
@Scope("prototype")
public class FileUploadAction extends ActionSupport {
	private static final long serialVersionUID = -5302064870145481992L;
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	HttpSession session = request.getSession();
	private String userName;// 用户名
	private File file;
	private String contentType;
	private String fileName;// 文件名

	@Override
	public String execute() throws Exception {
		try {
			String path = session.getServletContext().getRealPath("/")
					+ "fileUpload/" + userName + "/";
			System.out.println(path + fileName);
			File saveFile = new File(path + fileName);
			if (!saveFile.getParentFile().exists())
				saveFile.getParentFile().mkdirs();
			FileUtils.copyFile(file, saveFile);// 复制文件
		} catch (Exception e) {
			response.setCharacterEncoding("UTF-8");
			response.getWriter().print(0);
			e.printStackTrace();
			return NONE;
		}
		response.setCharacterEncoding("UTF-8");
		response.getWriter().print(1);
		return NONE;
	}

	// 删除附件
	public String deleteAtt() {
		String path = session.getServletContext().getRealPath("/")
				+ "fileUpload/" + userName + "/";
		File delFile = new File(path + fileName);
		System.out.println(delFile);
		if (delFile.exists())
			delFile.delete();
		return NONE;
	}

	public void setFileDateContentType(String contentType) {
		this.contentType = contentType;
	}

	public void setFileDate(File file) {
		this.file = file;
	}

	public void setFileDateFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

}
