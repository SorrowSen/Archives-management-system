package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.archivesManageDao;

public class archivesManageAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	String archivesType;
	String userName;
	int userType;
	archivesManageDao archivesManageDao = new archivesManageDao();
	
	@Override
	public String execute() throws Exception {

//		HttpSession session = ServletActionContext.getRequest().getSession();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
//		Object userType = session.getAttribute("userType");
		
//		String cn = new String(archivesType.getBytes("ISO-8859-1"),"utf-8");
	    
		String list = archivesManageDao.checkArchives(archivesType,userType);
		
		request.setAttribute("archivesType", archivesType);
		request.setAttribute("userType", userType);
		request.setAttribute("userName", userName);
		request.setAttribute("data", list);

		return "success";
	}

	public String getArchivesType() {
		return archivesType;
	}

	public void setArchivesType(String archivesType) {
		this.archivesType = archivesType;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}
	

}
