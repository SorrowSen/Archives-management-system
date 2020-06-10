package cn.laojunsen.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.google.gson.Gson;

import cn.laojunsen.model.archives;
import cn.laojunsen.util.DButil;

public class archivesManageDao {
	
//	档案列表
	public static String checkArchives(String archivesType,int userType) throws Exception {
		
		String sql;
		List<archives> list = new ArrayList<archives>();
		Gson gson = new Gson();
			if(archivesType.equals("all")){
				sql = "select * from archives";
			}else {
				sql = "select * from archives where archivesType='"+archivesType+"'";
			}
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					archives archives = new archives();
					archives.setId(rs.getString("Id"));
					archives.setTitle(rs.getString("title"));
					archives.setArchivesType(rs.getString("archivesType"));
					archives.setAuthor(rs.getString("author"));
					archives.setDate(rs.getString("date"));
//					archives.setSave(rs.getString("save"));
					archives.setUserType(userType);
					list.add(archives);
				}
			} catch (SQLException ex) {
			}
			String json = gson.toJson(list);
			return json;
			
	}
	
//	搜索档案
	public String searcharchives(String search,int userType,String archivesType) throws Exception {

		List<archives> list = new ArrayList<archives>();
		
		Gson gson = new Gson();
		String sql;
		
		if(archivesType.equals("all")){
			sql = "select * from archives where concat(title,author) like '%"+ search +"%'";
		}else {
			sql = "select * from archives where concat(title,author) like '%"+ search +"%' and archivesType='"+archivesType+"'";
		}
		Statement stat = null;
		ResultSet rs = null;
		Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					archives archives = new archives();
					archives.setId(rs.getString("Id"));
					archives.setTitle(rs.getString("title"));
					archives.setArchivesType(rs.getString("archivesType"));
					archives.setAuthor(rs.getString("author"));
					archives.setDate(rs.getString("date"));
					archives.setSave(rs.getString("save"));
					archives.setUserType(userType);
					list.add(archives);
				}
			} catch (SQLException ex) {
			}
			String json = gson.toJson(list);
			return json;
	}
	
	
//	添加档案
	public static String addarchives(String title,String archivestype,String author,String save,String fileName) throws Exception {
		
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String flag = null;
		String sql;
		ResultSet rs = null;
		Connection con = new DButil().getCon();
		Statement stat = null;
		
		sql = "select * from archives where title='"+title+"'";
		stat = con.createStatement();
		rs = stat.executeQuery(sql);
//		如果标题存在则返回标题存在
		if(rs.next() == true) {
			flag = "archivestitle";
		}else {
			sql = "select * from archives where fileName='"+fileName+"'";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
//			如果文件名存在则返回文件名存在
			if(rs.next() == true) {
				flag = "fileName";
			}else {
//				否则添加数据
				sql = "insert into archives(title,archivestype,author,date,save,fileName) values('"+ title +"','"+ archivestype +"','"+ author +"','"+ df.format(date) +"','"+ save +"','"+fileName+"')";
	
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
	
//	删除档案
	public String delarchives(int id) throws Exception {
		String flag = null;
		String sql = "delete from archives where id = "+id;
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
	
//	编辑档案
	public static String editarchives(int archivesid,String title,String archivestype,String author,String save,String fileName) throws Exception {
		
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String flag = null;
		String sql;
		ResultSet rs = null;
		Connection con = new DButil().getCon();
		Statement stat = null;
		
		sql = "select * from archives where title='"+title+"' and id not in ("+archivesid+")";
		stat = con.createStatement();
		rs = stat.executeQuery(sql);
//		如果标题存在则返回标题存在添加失败
		if(rs.next() == true) {
			flag = "archivestitle";
		}else {
//			如果文件名存在则返回文件名存在添加失败
			sql = "select * from archives where fileName='"+fileName+"' and id not in ("+archivesid+")";
			stat = con.createStatement();
			rs = stat.executeQuery(sql);
			if(rs.next() == true) {
				flag = "fileName";
			}else {
				//否则修改数据
				sql = "update archives set title='"+title+"',archivestype='"+archivestype+"',author='"+author+"',date='"+df.format(date)+"',save='"+save+"',fileName='"+fileName+"' where id = "+archivesid;
	
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
	
//删除档案文件
	public static String delarchivesfile(int id) throws Exception {
		
			String sql = "select * from archives where id="+id;
			String flag = null;
			Statement stat = null;
			ResultSet rs = null;
			Connection con = new DButil().getCon();
			try {
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				while (rs.next()) {
					try{
			            File file = new File(rs.getString("save"));
			            if(file.delete()){
			            	flag = "success";
			            }else{
			            	flag = "error";
			            }
			        }catch(Exception e){
			            e.printStackTrace();
			        }	
				}
			} catch (SQLException ex) {
			}
			return flag;

	}
	
//申请查阅档案
	public static String applyarchivesfile(int id,String userName) throws Exception {
		
		
		Date date = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String flag = null;
		String sql;
		ResultSet rs = null;
		ResultSet rss = null;
		Connection con = new DButil().getCon();
		Statement stat = null;
		sql = "select * from archives where id='"+id+"' ";
		stat = con.createStatement();
		rs = stat.executeQuery(sql);
		//查看是否存在档案
		if(rs.next() == true) {
			String title = rs.getString("title");
			String archivestype = rs.getString("archivestype");
			String author = rs.getString("author");
			sql = "select * from borrowing where userName='" + userName + "' and title='" + title + "' and author='" + author + "'";
			stat = con.createStatement();
			rss = stat.executeQuery(sql);
			if(rss.next() == true) {
				if(rss.getInt("progress")==1) {
					flag = "applying";
//					flag = "档案在审批中，请等待";
				}else if(rss.getInt("progress")==2) {
					flag = "pass";
//					flag = "档案申请已通过，请去借阅记录查看";
				}else {
					int borrowingid = rss.getInt("id");
					sql = "update borrowing set progress=1,date='"+df.format(date)+"' where id = "+borrowingid;
					stat.executeUpdate(sql);
					flag = "refuse";
//					flag = "档案已被拒绝，正在重新申请";
				}
			}else {
				sql = "insert into borrowing(userName,title,archivestype,author,progress,date) values('"+userName+"','"+title+"','"+archivestype+"','"+author+"',1,'"+df.format(date)+"')";
				int rsss = stat.executeUpdate(sql);
				if(rsss>0) {
					flag = "apply";
				}else {
					flag = "applyerror";
				}
			}
			
		}else {
			flag = "archiveserror";
		}
		return flag;
	}
	
//		查看档案文件
		public static String findfilename(String title) throws Exception {
			
				String filename = "";
				String sql = "select * from archives where title='"+title+"'";
				String flag = null;
				Statement stat = null;
				ResultSet rs = null;
				Connection con = new DButil().getCon();
				stat = con.createStatement();
				rs = stat.executeQuery(sql);
				if(rs.next() == true) {
					filename = rs.getString("fileName");
				}
				
				return filename;

		}
	
}
