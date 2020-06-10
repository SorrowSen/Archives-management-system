package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.archivesManageDao;

public class delarchivesAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	int id;
	int userType;
	String archivesType;
	archivesManageDao archivesManageDao = new archivesManageDao();

	@Override
	public String execute() throws Exception {
		//删除原有文件
		String delfile = archivesManageDao.delarchivesfile(id);
		//删除数据库信息
		String flag = archivesManageDao.delarchives(id);
		
		if(delfile=="success") {
			System.out.println("文件删除成功！");
		}else {
			System.out.println("文件删除失败！");
		}
		
//		HttpSession session = ServletActionContext.getRequest().getSession();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
//		String cn = new String(archivesType.getBytes("ISO-8859-1"),"utf-8");
		
		String list = archivesManageDao.checkArchives(archivesType,userType);

		request.setAttribute("archivesType", archivesType);
		request.setAttribute("userType", userType);
		request.setAttribute("data", list);
		
		if(flag=="success") {
			request.setAttribute("flag", "删除成功！");
			return "success";
		}else {
			request.setAttribute("flag", "删除失败！");
			return "input";
		}
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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
