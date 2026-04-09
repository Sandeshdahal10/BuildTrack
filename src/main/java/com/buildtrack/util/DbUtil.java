package com.buildtrack.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbUtil {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/buildtrack_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD="sandesh123";

    static {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("JDBC Driver not found",e);
        }
    }
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
    }
    public static void close(Connection conn){
        if (conn != null) {
            try{
                conn.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
