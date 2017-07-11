package cn.edu.pdsu.action.user;

import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.struts2.interceptor.SessionAware;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import cn.edu.pdsu.bean.Group;
import cn.edu.pdsu.bean.Linkman;
import cn.edu.pdsu.bean.User;
import cn.edu.pdsu.dao.GroupDAO;
import cn.edu.pdsu.dao.LinkmanDAO;
import cn.edu.pdsu.dao.UserDAO;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 类说明：用户操作联系人action
 * 
 * @author 作者: LiuJunGuang
 * @version 创建时间：2011-8-5 上午02:08:04
 */
@Controller
@Scope("prototype")
public class UserLinkManAction extends ActionSupport implements SessionAware {
	private static final long serialVersionUID = 3465261926667022139L;
	private Map<String, Object> session;
	private Group group;
	private User user;
	private String linkmanIds;
	private Linkman linkman;
	private String name;
	private String operationPath = "user_linkman_welcome.jsp";// 添加联系人路径,默认是主页面
	private List<Linkman> linkmanList;
	private int oldGroupID = 0;// 移动联系人时的原分组id
	@Resource
	private UserDAO userDAO;
	@Resource
	private GroupDAO groupDAO;
	@Resource
	private LinkmanDAO linkmanDAO;

	// 用户加载联系人
	@Override
	public String execute() throws Exception {
		user = (User) session.get(UserLoginAction.USER_SESSION);
		user = userDAO.find(User.class, user.getName());// 查找用户
		return SUCCESS;
	}

	// 查找要更新联系人
	public String findLinkman() {
		user = (User) session.get(UserLoginAction.USER_SESSION);
		user = userDAO.find(User.class, user.getName());// 查找用户
		linkman = linkmanDAO.find(Linkman.class, linkman.getId());
		return "updateLinkman";
	}

	// 更新联系人
	public String upLinkman() {
		Linkman lk = setNewLinkman();
		Group g = groupDAO.find(Group.class, group.getId());
		lk.setGroup(g);
		linkmanDAO.update(lk);
		return "updateLinkmanSuccess";
	}

	// 添加联系人分组
	public String addGroup() {
		if (group.getName() != null && !"".equals(group.getName())) {
			user = (User) session.get(UserLoginAction.USER_SESSION);
			user = userDAO.find(User.class, user.getName());// 查找用户
			Group g = new Group(group.getName(), user);
			groupDAO.save(g);// 保存分组
			return "addGroupSuccess";
		}
		this.addFieldError("group.name", "请填写分组名称！");
		return "addGroupFail";
	}

	// 添加联系人（查找分组）的跳转
	public String addLinkmanSkip() {
		user = (User) session.get(UserLoginAction.USER_SESSION);
		user = userDAO.find(User.class, user.getName());// 查找用户
		return "addLinkmanSkip";
	}

	// 查找所有联系人
	public String linkmanList() {
		user = (User) session.get(UserLoginAction.USER_SESSION);
		user = userDAO.find(User.class, user.getName());// 查找用户
		if (group != null && group.getId() != 0) {
			group = groupDAO.find(Group.class, group.getId());
			return "linkmanListByGroup";
		} else {
			return "linkmanList";
		}
	}

	// 删除联系人
	public String delLinkman() {
		if (linkmanIds != null && !"".equals(linkmanIds))
			linkmanDAO.delete(linkmanIds);
		return "delLinkman";
	}

	// 删除分组
	public String delGroup() {
		Group g = groupDAO.find(Group.class, group.getId());
		if (g != null)
			groupDAO.delete(Group.class, group.getId());
		return "delGroupSuccess";
	}

	// 移动联系人
	public String moveLinkman() {
		user = (User) session.get(UserLoginAction.USER_SESSION);
		user = userDAO.find(User.class, user.getName());// 查找用户
		linkmanDAO.update(linkmanIds, group.getId());
		if (oldGroupID != 0) {
			group.setId(oldGroupID);
			return "delLinkman";
		}
		return "linkmanList";
	}

	// 添加联系人
	public String addLinkman() {
		try {
			Linkman lk = setNewLinkman();
			Group g = groupDAO.find(Group.class, group.getId());
			lk.setGroup(g);
			linkmanDAO.save(lk);
		} catch (Exception e) {
			e.printStackTrace();
			this.addFieldError("linkman.name", "添加联系人失败！");
			return "addLinkmanSkip";
		}
		return "addLinkmanSuccess";
	}

	// 搜索联系人
	public String searchLinkman() {
		if (name != null && !"".equals(name)) {
			user = (User) session.get(UserLoginAction.USER_SESSION);
			user = userDAO.find(User.class, user.getName());// 查找用户
			Set<Group> groups = user.getGroup();
			String groupIds = "";
			for (Group group : groups) {
				groupIds += group.getId() + ",";
			}
			if (groupIds.length() > 0)
				groupIds = groupIds.substring(0, groupIds.length() - 1);
			linkmanList = linkmanDAO.search(groupIds, name);
			return "searchLinkman";
		}
		return "welcome";
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
	}

	public Linkman getLinkman() {
		return linkman;
	}

	public void setLinkman(Linkman linkman) {
		this.linkman = linkman;
	}

	// 设置联系人的各项信息
	public Linkman setNewLinkman() {
		Linkman lk = new Linkman();
		if (linkman.getId() != 0)
			lk.setId(linkman.getId());
		lk.setAddress(linkman.getAddress());
		lk.setBirthday(linkman.getBirthday());
		lk.setEmailAdd(linkman.getEmailAdd());
		lk.setGender(linkman.getGender());
		lk.setMark(linkman.getMark());
		lk.setName(linkman.getName());
		lk.setPhoneNum(linkman.getPhoneNum());
		return lk;
	}

	public String getLinkmanIds() {
		return linkmanIds;
	}

	public void setLinkmanIds(String linkmanIds) {
		this.linkmanIds = linkmanIds;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Linkman> getLinkmanList() {
		return linkmanList;
	}

	public void setLinkmanList(List<Linkman> linkmanList) {
		this.linkmanList = linkmanList;
	}

	public String getOperationPath() {
		return operationPath;
	}

	public void setOperationPath(String operationPath) {
		this.operationPath = operationPath;
	}

	public int getOldGroupID() {
		return oldGroupID;
	}

	public void setOldGroupID(int oldGroupID) {
		this.oldGroupID = oldGroupID;
	}

}
