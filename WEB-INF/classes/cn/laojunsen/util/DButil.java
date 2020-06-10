package cn.laojunsen.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DButil {
	private String dbUrl="jdbc:mysql:///jbdb?characterEncoding=utf8";
    private String dbUserName="root";
    private String dbPassword="123456";
    private String jdbcName="com.mysql.jdbc.Driver";

    /**
     * 获取数据库链接
     * @return
     * @throws Exception
     */
    public Connection getCon() throws Exception{
        Class.forName(jdbcName);
        Connection con= DriverManager.getConnection(dbUrl,dbUserName,dbPassword);
        return con;
    }

    /**
     * 关闭数据库链接
     * @param con
     * @throws Exception
     */
    public void closeCon(Connection con) throws  Exception{
        if (con!=null){
            con.close();
        }
    }

    /**
     * 测试数据库链接
     * @param args
     */
    public static void main(String[] args){
        DButil dbUtil = new DButil();
        try {
            dbUtil.getCon();
            System.out.println("数据库连接成功");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
