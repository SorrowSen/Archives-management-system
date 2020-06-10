package cn.laojunsen.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;

import cn.laojunsen.model.borrow;
import cn.laojunsen.util.DButil;

public class borrowManageDao {
	
//	审批和申请列表
	public static String checkborrow(int userType,String userName) throws Exception {

		List<borrow> list = new ArrayList<borrow>();
		Gson gson = new Gson();

		if (userType != 2) {
			String sql = "select * from borrowing where progress=1";
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					borrow borrow = new borrow();
					borrow.setId(rs.getInt("id"));
					borrow.setUserName(rs.getString("userName"));
					borrow.setTitle(rs.getString("title"));
					borrow.setAuthor(rs.getString("author"));
					borrow.setArchivestype(rs.getString("archivestype"));
					borrow.setDate(rs.getString("date"));
					list.add(borrow);
				}
			} catch (SQLException ex) {
			}
			String json = gson.toJson(list);
			return json;
		} else {
			String sql = "select * from borrowing where userName='"+userName+"'";
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					borrow borrow = new borrow();
					borrow.setId(rs.getInt("id"));
					borrow.setUserName(rs.getString("userName"));
					borrow.setTitle(rs.getString("title"));
					borrow.setAuthor(rs.getString("author"));
					borrow.setArchivestype(rs.getString("archivestype"));
					borrow.setProgress(rs.getInt("progress"));
					borrow.setDate(rs.getString("date"));
					list.add(borrow);
				}
			} catch (SQLException ex) {
			}
			String json = gson.toJson(list);
			return json;
		}
	}
	
//	通过或拒绝审批
	public static String passorrefuseapprove(int id,String pof) throws Exception {
		String flag = null;
		String sql;
		Statement stat = null;
		Connection con = new DButil().getCon();
		stat = con.createStatement();
		
		if(pof.equals("pass")) {
			sql = "update borrowing set progress=2 where id="+id;
		}else {
			sql = "update borrowing set progress=3 where id="+id;
		}
		
		int rs = stat.executeUpdate(sql);
		
		if(rs>0) {
			flag = "success";
		}else {
			flag = "error";
		}
		return flag;
		
	}
	
//	再次申请
	public static String applyagain(int id) throws Exception {
		String flag = null;
		String sql =  "update borrowing set progress=1 where id="+id;;
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
	
//	搜索审批和申请
	public static String searchapproveorborrow(int userType,String userName,String search) throws Exception {

		List<borrow> list = new ArrayList<borrow>();
		Gson gson = new Gson();

		if (userType != 2) {
			String sql = "select * from borrowing where progress=1 and concat(userName,title,archivestype) like '%"+ search +"%'";
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					borrow borrow = new borrow();
					borrow.setId(rs.getInt("id"));
					borrow.setUserName(rs.getString("userName"));
					borrow.setTitle(rs.getString("title"));
					borrow.setAuthor(rs.getString("author"));
					borrow.setArchivestype(rs.getString("archivestype"));
					borrow.setDate(rs.getString("date"));
					list.add(borrow);
				}
			} catch (SQLException ex) {
			}
			String json = gson.toJson(list);
			return json;
		} else {
			String sql = "select * from borrowing where userName='"+userName+"' and concat(title,archivestype) like '%"+ search +"%'";
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					borrow borrow = new borrow();
					borrow.setId(rs.getInt("id"));
					borrow.setUserName(rs.getString("userName"));
					borrow.setTitle(rs.getString("title"));
					borrow.setAuthor(rs.getString("author"));
					borrow.setArchivestype(rs.getString("archivestype"));
					borrow.setProgress(rs.getInt("progress"));
					borrow.setDate(rs.getString("date"));
					list.add(borrow);
				}
			} catch (SQLException ex) {
			}
			String json = gson.toJson(list);
			return json;
		}
	}
}
