package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.archivesManageDao;

public class searcharchivesAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	String search;
	int userType;
	String archivesType;
	archivesManageDao archivesManageDao = new archivesManageDao();

	@Override
	public String execute() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();

//		String cnsearch = "";
//		String cnarchivesType = "";
//		byte[] searchbytes=search.getBytes("ISO-8859-1");
//		byte[] archivesTypebytes=archivesType.getBytes("ISO-8859-1");
//	    cnsearch=new String(searchbytes,"utf-8");
//	    cnarchivesType = new String(archivesTypebytes,"utf-8");
		
		String list = archivesManageDao.searcharchives(search,userType,archivesType);
			
		request.setAttribute("data", list);
			
		return "success";
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

	public String getArchivesType() {
		return archivesType;
	}

	public void setArchivesType(String archivesType) {
		this.archivesType = archivesType;
	}
	

}
