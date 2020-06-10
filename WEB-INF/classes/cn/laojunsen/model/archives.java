package cn.laojunsen.model;

import java.sql.Date;

public class archives {
	private String Id;
	private String title;
	private String archivesType;
	private String author;
	private String date;
	private String save;
	private int userType;
	public String getId() {
		return Id;
	}
	public void setId(String id) {
		Id = id;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public void setSave(String save) {
		this.save = save;
	}
	
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}
	@Override
	public String toString() {
		return "archives [Id=" + Id + ", title=" + title + ", archivesType=" + archivesType + ", author=" + author
				+ ", date=" + date + ", save=" + save + ", userType=" + userType + "]";
	}
	public archives() {
		super();
	}
	public archives(String id, String title, String archivesType, String author, String date, String save,
			int userType) {
		super();
		Id = id;
		this.title = title;
		this.archivesType = archivesType;
		this.author = author;
		this.date = date;
		this.save = save;
		this.userType = userType;
	}
	
	
	
}
