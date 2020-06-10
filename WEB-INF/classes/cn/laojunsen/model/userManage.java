package cn.laojunsen.model;

public class userManage {
	private String Id;
	private String userName;
	private String nickName;
	private String userType;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getId() {
		return Id;
	}

	public void setId(String id) {
		Id = id;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	@Override
	public String toString() {
		return "userManage [userName=" + userName + ", Id=" + Id + ", nickName=" + nickName + ", userType=" + userType
				+ "]";
	}

	public userManage() {
		super();
	}

	public userManage(String id, String userName, String nickName, String userType) {
		super();
		Id = id;
		this.userName = userName;
		this.nickName = nickName;
		this.userType = userType;
	}

}
