package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.borrowManageDao;

public class searchapproveorborrowAction extends ActionSupport{
	
	private static final long serialVersionUID = 1L;

	int userType;
	String userName;
	String search;
	
	@Override
	public String execute() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();
	
//		String cnsearch = "";
//		byte[] searchbytes=search.getBytes("ISO-8859-1");
//	    cnsearch=new String(searchbytes,"utf-8");
		
		String list = borrowManageDao.searchapproveorborrow(userType,userName,search);

		request.setAttribute("userType", userType);
		request.setAttribute("userName", userName);

		request.setAttribute("data", list);
		
		if(userType != 2) {
//			管理员搜索

			return "success1";
		}else {
//			普通用户搜索
			
			return "success2";
		}
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}
	
}
