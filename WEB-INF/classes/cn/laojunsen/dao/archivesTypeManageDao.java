package cn.laojunsen.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

import cn.laojunsen.model.archivesType;
import cn.laojunsen.util.DButil;

public class archivesTypeManageDao {
	
//	档案类目列表
	public static String checkarchivesType(int userType) throws Exception {

		List<archivesType> list = new ArrayList<archivesType>();
		Gson gson = new Gson();

		if (userType != 2) {
			String sql = "select * from archivestype";
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					archivesType archivesType = new archivesType();
					archivesType.setId(rs.getString("Id"));
					archivesType.setArchivesType(rs.getString("archivesType"));
					list.add(archivesType);
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
	
//	搜索档案
	public static String searcharchivesType(String search,int userType) throws Exception {
		
		List<archivesType> list = new ArrayList<archivesType>();
		Gson gson = new Gson();

		if (userType != 2) {
			String sql = "select * from archivestype where archivestype like '%"+ search +"%'";
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					archivesType archivesType = new archivesType();
					archivesType.setId(rs.getString("Id"));
					archivesType.setArchivesType(rs.getString("archivesType"));
					list.add(archivesType);
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
	
//	新增档案类目
	public static String addarchivesType(String archivestype) throws Exception {
		String flag = "";
		String sql = "select * from archivestype where archivestype='"+archivestype+"'";
		Statement stat = null;
		ResultSet rs = null;
		Connection con = new DButil().getCon();
		stat = con.createStatement();
		rs = stat.executeQuery(sql);
		if(rs.next()==true) {
			flag = "archivestype";
		}else {
			sql = "insert into archivestype(archivestype) values ('"+ archivestype +"')";
			
			int rss = stat.executeUpdate(sql);
			
			if(rss>0) {
				flag = "success";
			}else {
				flag = "error";
			}
		}
		
		return flag;
	}
	
//	编辑档案类目
	public static String editarchivesType(int archivesTypeid,String archivestype) throws Exception {
		String flag = "";
		String sql = "select * from archivestype where archivestype='"+archivestype+"' and id not in ("+archivesTypeid+")";
		Statement stat = null;
		ResultSet rs = null;
		Connection con = new DButil().getCon();
		stat = con.createStatement();
		rs = stat.executeQuery(sql);
		if(rs.next()==true) {
			flag = "archivestype";
		}else {
			sql = "update archivestype set archivestype='"+archivestype+"' where id = "+archivesTypeid;
			
			int rss = stat.executeUpdate(sql);
			
			if(rss>0) {
				flag = "success";
			}else {
				flag = "error";
			}
		}
		
		return flag;
	}
	
//	删除档案类目
	public static String delarchivesType(int archivesTypeid) throws Exception {
		String flag = null;
		String sql = "delete from archivestype where id = "+archivesTypeid;
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
}
