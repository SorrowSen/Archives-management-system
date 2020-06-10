package cn.laojunsen.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.loginDao;

public class LoginAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userName;
	private String passWord;
	private int userType;
	

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	 loginDao loginDao = new loginDao(); 
	

	@Override
	public String execute() throws Exception {
			List list=loginDao.checkLogin(userName, passWord,userType);

			HttpServletRequest request = ServletActionContext.getRequest();
			
			if(list.size() > 1 || null == list) {

				request.setAttribute("Id", list.get(0));
	       		request.setAttribute("userName", list.get(1));
	       		request.setAttribute("nickName", list.get(2));
	       		request.setAttribute("userType", list.get(3));
	       		request.setAttribute("archivesType", list.get(4));
	       		
	       		return "success";
				
			}else {
				
	        	request.setAttribute("Message", "用户名或密码错误！");
                return "input";
                
			}
			
	}

}
