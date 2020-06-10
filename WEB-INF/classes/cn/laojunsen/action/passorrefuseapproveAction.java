package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.borrowManageDao;

public class passorrefuseapproveAction extends ActionSupport{
	
	private static final long serialVersionUID = 1L;

	int id;
	int userType;
	String userName;
	String pof;
	
	@Override
	public String execute() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String flag = borrowManageDao.passorrefuseapprove(id,pof);
		
		String list = borrowManageDao.checkborrow(userType,userName);

		request.setAttribute("userType", userType);
		request.setAttribute("userName", userName);

		request.setAttribute("data", list);
		if(pof.equals("pass")) {
			if(flag == "success") {
				request.setAttribute("flag", "“—Õ¨“‚…Í«Î");
			}else {
				request.setAttribute("flag", "Õ¨“‚…Í«Î ß∞‹");
			}
		}else {
			if(flag == "success") {
				request.setAttribute("flag", "“—æ‹æ¯…Í«Î");
			}else {
				request.setAttribute("flag", "æ‹æ¯…Í«Î ß∞‹");
			}
		}
		
		return "success";
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPof() {
		return pof;
	}

	public void setPof(String pof) {
		this.pof = pof;
	}
	
}
