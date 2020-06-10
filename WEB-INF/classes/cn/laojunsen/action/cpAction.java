package cn.laojunsen.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.userManageDao;


public class cpAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	int id;
	private String oldpassword;
	private String newpassword;

	@Override
	public String execute() throws Exception {
		
		String flag = userManageDao.cp(id,oldpassword,newpassword);
		HttpServletRequest request = ServletActionContext.getRequest();
		
		if(flag == "oldpassword") {
			List list = userManageDao.user(id);
			if(list.size() > 1 || null == list) {
				request.setAttribute("Id", list.get(0));
	       		request.setAttribute("userName", list.get(1));
	       		request.setAttribute("nickName", list.get(2));
	       		request.setAttribute("userType", list.get(3));
	       		request.setAttribute("archivesType", list.get(4));
			}else {
	        	request.setAttribute("Message", "系统出现错误请联系管理员！");
			}
			request.setAttribute("Message", "旧密码错误！");
			return "input";
		}else if(flag == "iderror") {
			List list = userManageDao.user(id);
			if(list.size() > 1 || null == list) {
				request.setAttribute("Id", list.get(0));
	       		request.setAttribute("userName", list.get(1));
	       		request.setAttribute("nickName", list.get(2));
	       		request.setAttribute("userType", list.get(3));
	       		request.setAttribute("archivesType", list.get(4));
			}else {
	        	request.setAttribute("Message", "系统出现错误请联系管理员！");
			}
			request.setAttribute("Message", "搜索不到用户，请联系管理员！");
			return "success";
		}else if(flag == "success") {
			List list = userManageDao.user(id);
			if(list.size() > 1 || null == list) {
				request.setAttribute("Id", list.get(0));
	       		request.setAttribute("userName", list.get(1));
	       		request.setAttribute("nickName", list.get(2));
	       		request.setAttribute("userType", list.get(3));
	       		request.setAttribute("archivesType", list.get(4));
			}else {
	        	request.setAttribute("Message", "系统出现错误请联系管理员！");
			}
			request.setAttribute("Message", "修改成功！");
			return "success";
		}else {
			List list = userManageDao.user(id);
			if(list.size() > 1 || null == list) {
				request.setAttribute("Id", list.get(0));
	       		request.setAttribute("userName", list.get(1));
	       		request.setAttribute("nickName", list.get(2));
	       		request.setAttribute("userType", list.get(3));
	       		request.setAttribute("archivesType", list.get(4));
			}else {
	        	request.setAttribute("Message", "系统出现错误请联系管理员！");
			}
			request.setAttribute("Message", "修改失败，请联系管理员！");
			return "input";
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getOldpassword() {
		return oldpassword;
	}

	public void setOldpassword(String oldpassword) {
		this.oldpassword = oldpassword;
	}

	public String getNewpassword() {
		return newpassword;
	}

	public void setNewpassword(String newpassword) {
		this.newpassword = newpassword;
	}

}
