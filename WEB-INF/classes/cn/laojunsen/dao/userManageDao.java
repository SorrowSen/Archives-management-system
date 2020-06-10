package cn.laojunsen.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import java.util.ArrayList;
import java.util.LinkedList;
//import java.util.List;
import java.util.List;

import com.google.gson.Gson;

import cn.laojunsen.model.userManage;
import cn.laojunsen.util.DButil;

public class userManageDao {
	
//	用户搜索
	public String searchuserManage(String search,Object userType) throws Exception {

		List<userManage> list = new ArrayList<userManage>();
		int iuserType = Integer.parseInt(String.valueOf(userType));
		Gson gson = new Gson();
		
		if (iuserType == 0) {
			String sql = "select * from user where concat(userName,nickName) like '%"+ search +"%' and userType not in (0) ";
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					userManage userManage = new userManage();
					String cuserType = null;
					userManage.setId(rs.getString("Id"));
					userManage.setUserName(rs.getString("userName"));
					userManage.setNickName(rs.getString("nickName"));
					if (rs.getInt("userType") == 1) {
						cuserType = "管理员";
					} else {
						cuserType = "普通用户";
					}
					userManage.setUserType(cuserType);
					list.add(userManage);
				}
			} catch (SQLException ex) {
			}
			String json = gson.toJson(list);
			return json;
		} else {
			String json = "";
			return json;
		}
	}
	
//	用户注册
	
	public String register(String registeruserName,String registernickName,String registerpassword) throws Exception {
		String flag = null;
		String sql = "select * from user where userName='"+registeruserName+"'";
		Statement stat = null;
		ResultSet rs = null;
		Connection con = new DButil().getCon();
		stat = con.createStatement();
		rs = stat.executeQuery(sql);
		if(rs.next()==true) {
			flag = "userName";
		}else {
			sql = "select * from user where nickName='"+registernickName+"'";
			rs = stat.executeQuery(sql);
			if(rs.next()==true) {
				flag = "nickName";
			}else {
				sql = "insert into user(userName,nickName,passWord,userType) values ('"+ registeruserName +"','"+ registernickName +"','"+ registerpassword +"','2')";
				
				int rss = stat.executeUpdate(sql);
				
				if(rss>0) {
					flag = "success";
				}else {
					flag = "error";
				}
			}
		}
		
		
		
		
		
		return flag;
	}
	
	
//	用户类型修改
	
	public String edituserType(String id,int userType) throws Exception {
		String flag = null;
		String sql;
		Statement stat = null;
		Connection con = new DButil().getCon();
		stat = con.createStatement();
		
		if(userType == 1) {
			sql = "update user set userType=2 where id="+id;
		}else {
			sql = "update user set userType=1 where id="+id;
		}
		
		int rs = stat.executeUpdate(sql);
		
		if(rs>0) {
			flag = "success";
		}else {
			flag = "error";
		}
		return flag;
	}

//	用户删除
	
	public String deluserManage(String id) throws Exception {
		String flag = null;
		String sql = "delete from user where id = "+id;
		Statement stat = null;
		Connection con = new DButil().getCon();
		
		stat = con.createStatement();
		int rs = stat.executeUpdate(sql);
		
		if(rs>0) {
			flag = "success";
		}else {
			flag = "error";
		}
		return flag;

	}

//	用户列表
	
	public String checkuserType(int userType) throws Exception {

		List<userManage> list = new ArrayList<userManage>();
		Gson gson = new Gson();

		if (userType == 0) {
			String sql = "select * from user where userType not in (0)";
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					userManage userManage = new userManage();
					String cuserType = null;
					userManage.setId(rs.getString("Id"));
					userManage.setUserName(rs.getString("userName"));
					userManage.setNickName(rs.getString("nickName"));
					if (rs.getInt("userType") == 1) {
						cuserType = "管理员";
					} else {
						cuserType = "普通用户";
					}
					userManage.setUserType(cuserType);
					list.add(userManage);
				}
			} catch (SQLException ex) {
			}
			String json = gson.toJson(list);
			return json;
		} else {
			String json = "";
			return json;
		}
	}
	
//	用户信息修改
	
	public static String ci(int id,String inickName) throws Exception {
		String flag = null;
		String sql = "select * from user where nickName='"+inickName+"'";
		Statement stat = null;
		ResultSet rs = null;
		Connection con = new DButil().getCon();
		stat = con.createStatement();
		rs = stat.executeQuery(sql);
		if(rs.next()==true) {
			flag = "nickName";
		}else {
			sql = "update user set nickName='"+inickName+"' where id="+id;
			int rss = stat.executeUpdate(sql);
			
			if(rss>0) {
				flag = "success";
			}else {
				flag = "error";
			}
		}
		
		return flag;
	}
	
//	用户密码修改
	
	public static String cp(int id,String oldpassword,String newpassword) throws Exception {
		String flag = null;
		String sql = "select * from user where id="+id;
		Statement stat = null;
		ResultSet rs = null;
		Connection con = new DButil().getCon();
		stat = con.createStatement();
		rs = stat.executeQuery(sql);
		if(rs.next()==true) {
			String password = rs.getString("passWord");
			if(password.equals(oldpassword)) {
				sql = "update user set passWord='"+newpassword+"' where id="+id;
				int rss = stat.executeUpdate(sql);
				if(rss>0) {
					flag = "success";
				}else {
					flag = "error";
				}
			}else {
				flag = "oldpassword";
			}
		}else {
			flag = "iderror";
		}
		
		return flag;
	}
	
//	id获取用户信息
	
	public static List user(int id) throws Exception {
		String sql="select * from user where id="+id ;
        Statement stat=null;
        ResultSet rs = null;
        List list = new ArrayList();
        List listarchivesType = new ArrayList();
        Connection con=new DButil().getCon();
        try {
            stat=con.createStatement();
            rs=stat.executeQuery(sql);
            while (rs.next()) {
                list.add(rs.getString("Id"));
                list.add(rs.getString("userName"));
                list.add(rs.getString("nickName"));
                list.add(rs.getString("userType"));
            }
        } catch (SQLException ex) {}
        
        sql = "select * from archivestype";
        try {
            stat=con.createStatement();
            rs=stat.executeQuery(sql);
            while (rs.next()) {
            	listarchivesType.add("'"+rs.getString("archivesType")+"'");
            }
        } catch (SQLException ex) {}
    	list.add(listarchivesType);
        return list;
	}

}
