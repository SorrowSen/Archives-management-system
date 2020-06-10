package cn.laojunsen.model;

public class borrow {
	
	int id,progress;
	private String userName,title,author,archivestype,date;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getProgress() {
		return progress;
	}
	public void setProgress(int progress) {
		this.progress = progress;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getArchivestype() {
		return archivestype;
	}
	public void setArchivestype(String archivestype) {
		this.archivestype = archivestype;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return "borrow [id=" + id + ", progress=" + progress + ", userName=" + userName + ", title=" + title
				+ ", author=" + author + ", archivestype=" + archivestype + ", date=" + date + "]";
	}
	
	public borrow() {
		super();
	}
	public borrow(int id, int progress, String userName, String title, String author, String archivestype,
			String date) {
		super();
		this.id = id;
		this.progress = progress;
		this.userName = userName;
		this.title = title;
		this.author = author;
		this.archivestype = archivestype;
		this.date = date;
	}
}
