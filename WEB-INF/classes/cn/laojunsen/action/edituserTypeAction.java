package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.userManageDao;

public class edituserTypeAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String id;
	int userType;
	userManageDao userManageDao = new userManageDao();

	@Override
	public String execute() throws Exception {
		
		String flag = userManageDao.edituserType(id,userType);
		
		String list = userManageDao.checkuserType(0);
		
//		HttpSession session = ServletActionContext.getRequest().getSession();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
//		if (list.length() != 0 || null == list) {
//
//			System.out.println(list);
//			
//			request.setAttribute("data", list);
//			
//		} else {
//			System.out.println("没有权限！");
//		}
		
		if(flag=="success") {
			request.setAttribute("data", list);
			request.setAttribute("flag", "修改成功！");
			return "success";
		}else {
			request.setAttribute("data", list);
			request.setAttribute("flag", "修改失败！");
			return "input";
		}
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	

}
