package cn.laojunsen.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import cn.laojunsen.util.DButil;

public class loginDao {
	 public List checkLogin(String userName,String passWord,int userType)throws Exception{
	        String sql="select * from user where userName='"+userName+"' and passWord='"+passWord+"' and userType='"+userType+"' " ;
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
