package com.buildtrack.util;

import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class DBUtil {
    private static String DB_URL;
    private static String DB_USERNAME;
    private static String DB_PASSWORD;
    private static String DB_DRIVER;

    static {
        loadConfig();
        try{
//            Class.forName(DB_DRIVER);
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            System.err.println("[DBUtil] MySql driver not found!" + e.getMessage());
            throw new RuntimeException(e);
        }
        System.out.println("[DBUtil] Database utility initialized successfully.");
    }

    private static void loadConfig(){
        Properties props = new Properties();
        try(InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("application.properties")){
            if (is == null){
                throw new RuntimeException("Application Properties not found while injecting.");
            }
            props.load(is);
            DB_URL = props.getProperty("db.url");
            DB_USERNAME = props.getProperty("db.username");
            DB_PASSWORD = props.getProperty("db.password");
            DB_DRIVER = props.getProperty("db.driver");
            if (DB_URL == null || DB_USERNAME == null || DB_PASSWORD == null || DB_DRIVER == null){
                throw new RuntimeException(
                        "All credentials of database are missing in application.properties"
                );
            }
        } catch (Exception e) {
            System.err.println("[DBUtil] Error loading config:" + e.getMessage());
            throw new RuntimeException("Failed to load database configuration",e);
        }
    }
    public static Connection getConnection() throws SQLException {

        return DriverManager.getConnection(DB_URL,DB_USERNAME,DB_PASSWORD);
    }
    public static void close(Connection conn, PreparedStatement pstmt, ResultSet rs){
        if(rs!=null){
            try{
                rs.close();
            } catch (SQLException e) {
                System.err.println("[DBUtil] error closing in result set." + e.getMessage());
            }
        }
        if (pstmt !=null){
            try{
                pstmt.close();
            } catch (SQLException e) {
                System.err.println("[DBUtil] error closing in prepared Statement." + e.getMessage());
            }
        }
        if (conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("[DBUtil] Error in closing the connection." + e.getMessage());
            }
        }
    }
    public static void close(Connection conn, PreparedStatement pstmt){
        close(conn, pstmt, null);
    }
}
