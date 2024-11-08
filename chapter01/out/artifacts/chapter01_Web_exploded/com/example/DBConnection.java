package com.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            // 加载 MySQL JDBC 驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 连接数据库
            String url = "jdbc:mysql://localhost:3306/school?useSSL=false&serverTimezone=UTC";
            String username = "root"; // 替换为你的数据库用户名
            String password = "nylttp1018"; // 替换为你的数据库密码
            conn = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}
