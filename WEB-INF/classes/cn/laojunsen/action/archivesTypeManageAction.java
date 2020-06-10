package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.archivesTypeManageDao;

public class archivesTypeManageAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	int userType;
	
	@Override
	public String execute() throws Exception {

		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String list = archivesTypeManageDao.checkarchivesType(userType);
		
		request.setAttribute("userType", userType);
		
		if (list.length() != 0 || null == list) {
			
			request.setAttribute("data", list);
			
			return "success";
		} else {
			request.setAttribute("data", "[]");
			request.setAttribute("flag", "对不起您没有权限");
			return "input";
		}
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}
	

}
