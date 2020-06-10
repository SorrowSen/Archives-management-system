package cn.laojunsen.model;

public class archivesType {
	
	private String Id;
	private String archivesType;
	
	public String getId() {
		return Id;
	}
	public void setId(String id) {
		Id = id;
	}
	public String getArchivesType() {
		return archivesType;
	}
	public void setArchivesType(String archivesType) {
		this.archivesType = archivesType;
	}
	@Override
	public String toString() {
		return "archivesType [Id=" + Id + ", archivesType=" + archivesType + "]";
	}
	public archivesType() {
		super();
	}
	public archivesType(String id, String archivesType) {
		super();
		Id = id;
		this.archivesType = archivesType;
	}
	
}
