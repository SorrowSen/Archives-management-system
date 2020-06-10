package cn.laojunsen.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.userManageDao;


public class ciAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	int id;
	private String inickName;

	@Override
	public String execute() throws Exception {
		
		String flag = userManageDao.ci(id,inickName);
		HttpServletRequest request = ServletActionContext.getRequest();
		
		if(flag == "nickName") {
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
			request.setAttribute("Message", "已存在此昵称！");
			return "input";
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
			request.setAttribute("Message", "修改失败，清联系管理员！");
			return "input";
		}
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getInickName() {
		return inickName;
	}

	public void setInickName(String inickName) {
		this.inickName = inickName;
	}
	
	

}
