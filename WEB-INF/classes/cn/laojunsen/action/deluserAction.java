package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.userManageDao;

public class deluserAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String id;
//	String userType;
	userManageDao userManageDao = new userManageDao();

	@Override
	public String execute() throws Exception {
		
		String flag = userManageDao.deluserManage(id);
		
//		HttpSession session = ServletActionContext.getRequest().getSession();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String list = userManageDao.checkuserType(0);

		request.setAttribute("data", list);
		if(flag=="success") {
			request.setAttribute("flag", "É¾³ý³É¹¦£¡");
			return "success";
		}else {
			request.setAttribute("flag", "É¾³ýÊ§°Ü£¡");
			return "input";
		}
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

//	public String getUserType() {
//		return userType;
//	}
//
//	public void setUserType(String userType) {
//		this.userType = userType;
//	}
//	
	
}
