package cn.laojunsen.action;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import cn.laojunsen.dao.archivesManageDao;
import jdk.nashorn.internal.ir.RuntimeNode.Request;

public class editarchivesAction extends ActionSupport {

	private static final long serialVersionUID = 1L;

	private String inarchivesType;
	int userType;
	int archivesid;
	private String title;
	private String archivesType;
	private String author;
	private String save;
	private File file;
	private String fileFileName;
	private String fileContentType;
	private String SavePath;

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		
		//删除原有文件
		String delfile = archivesManageDao.delarchivesfile(archivesid);
		
		String savereplace = null;
		HttpServletRequest request = ServletActionContext.getRequest();
		// 文件上传
		String filePath = ServletActionContext.getServletContext().getRealPath(getSavePath());
		File fileFolder = new File(filePath);
		FileUtils.copyFile(file, new File(fileFolder, fileFileName));

		if (!fileFolder.exists()) {
			fileFolder.mkdirs();
		}
		try {
			FileUtils.copyFile(file, new File(fileFolder, fileFileName));
			save = fileFolder + "\\" + fileFileName;
			savereplace = save.replace("\\","/");
		} catch (Exception e) {

		}
			
//			String cninarchivesType =  new String(inarchivesType.getBytes("ISO-8859-1"), "utf-8");

			String flag = archivesManageDao.editarchives(archivesid,title,archivesType, author, savereplace, fileFileName);
	
			String list = archivesManageDao.checkArchives(inarchivesType, userType);

			request.setAttribute("archivesType", inarchivesType);
			request.setAttribute("userType", userType);
			request.setAttribute("data", list);
			if(flag=="success"){
				request.setAttribute("flag", "修改成功！");
				return "success";
			}else if(flag=="archivestitle"){
				request.setAttribute("flag", "标题已存在！");
				return "input";
			}else if(flag=="fileName"){
				request.setAttribute("flag", "文件名已存在！");
				return "input";
			}else{
				request.setAttribute("flag", "编辑失败！");
				return "input";
			}

	}

	public String getInarchivesType() {
		return inarchivesType;
	}

	public void setInarchivesType(String inarchivesType) {
		this.inarchivesType = inarchivesType;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}

	public int getArchivesid() {
		return archivesid;
	}

	public void setArchivesid(int archivesid) {
		this.archivesid = archivesid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getArchivesType() {
		return archivesType;
	}

	public void setArchivesType(String archivesType) {
		this.archivesType = archivesType;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getSave() {
		return save;
	}

	public void setSave(String save) {
		this.save = save;
	}

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getFileFileName() {
		return fileFileName;
	}

	public void setFileFileName(String fileFileName) {
		this.fileFileName = fileFileName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public String getSavePath() {
		return SavePath;
	}

	public void setSavePath(String savePath) {
		SavePath = savePath;
	}

}