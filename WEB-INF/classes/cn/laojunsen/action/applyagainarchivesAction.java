package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.borrowManageDao;

public class applyagainarchivesAction extends ActionSupport{
	
	private static final long serialVersionUID = 1L;

	int id;
	int userType;
	String userName;
	
	@Override
	public String execute() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String flag = borrowManageDao.applyagain(id);
		
		String list = borrowManageDao.checkborrow(userType,userName);

		request.setAttribute("userType", userType);
		request.setAttribute("userName", userName);

		request.setAttribute("data", list);
		if(flag == "success") {
			request.setAttribute("flag", "重新申请成功");
		}else {
			request.setAttribute("flag", "重新申请失败");
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
}
