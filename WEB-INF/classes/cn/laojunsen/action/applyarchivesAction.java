package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.archivesManageDao;

public class applyarchivesAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	int id;
	int userType;
	String userName;
	String archivesType;
	archivesManageDao archivesManageDao = new archivesManageDao();

	@Override
	public String execute() throws Exception {
		
//		String cnuserName = new String(userName.getBytes("ISO-8859-1"),"utf-8");
		
		String flag = archivesManageDao.applyarchivesfile(id,userName);
		
//		HttpSession session = ServletActionContext.getRequest().getSession();
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
//		String cnarchivesType = new String(archivesType.getBytes("ISO-8859-1"),"utf-8");
		
		String list = archivesManageDao.checkArchives(archivesType,userType);

		request.setAttribute("archivesType", archivesType);
		request.setAttribute("userType", userType);
		request.setAttribute("data", list);
		
		if(flag=="apply") {
			request.setAttribute("flag", "档案借阅申请成功！");
//			return "success";
		}else if(flag == "applying"){
			request.setAttribute("flag", "档案在审批中，请等待！");
//			return "success";
		}else if(flag == "pass") {
			request.setAttribute("flag", "档案申请已通过，请去借阅记录查看！");
//			return "success";
		}else if(flag == "refuse") {
			request.setAttribute("flag", "档案已被拒绝，正在重新申请！");
//			return "success";
		}else if(flag == "applyerror") {
			request.setAttribute("flag", "档案申请出现错误，请联系管理员！");
//			return "success";
		}else if(flag == "archiveserror") {
			request.setAttribute("flag", "未搜索到档案，请重新尝试！");
//			return "input";
		}
		return "success";
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getArchivesType() {
		return archivesType;
	}

	public void setArchivesType(String archivesType) {
		this.archivesType = archivesType;
	}
	
}
