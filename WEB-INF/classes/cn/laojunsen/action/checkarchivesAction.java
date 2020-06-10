package cn.laojunsen.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

import cn.laojunsen.dao.archivesManageDao;

public class checkarchivesAction extends ActionSupport {
	
	private static final long serialVersionUID = 1L;
	
	private String title;
	
	@Override
	public String execute() throws Exception {
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String filename = archivesManageDao.findfilename(title);
		if(filename != "" || filename != null) {
			request.setAttribute("filename", filename);
		}else {
			request.setAttribute("flag", "Î´ÕÒµ½ÎÄ¼þ");
		}
		return "success";
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

}
