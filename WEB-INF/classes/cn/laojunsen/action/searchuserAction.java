package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.userManageDao;

public class searchuserAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	String search;
	int userType;
	userManageDao userManageDao = new userManageDao();

	@Override
	public String execute() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();

//		Object userType = session.getAttribute("userType");
//		String cn = "";
//		byte[] bytes=search.getBytes("ISO-8859-1");
//	    cn=new String(bytes,"utf-8");
		
		String list = userManageDao.searchuserManage(search,userType);
		
		if (list.length() != 0 || null == list) {
			
			request.setAttribute("data", list);
			
			return "success";
		} else {
			request.setAttribute("data", "[]");
			request.setAttribute("flag", "对不起您没有权限");
			return "input";
		}
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}
	
	

}
