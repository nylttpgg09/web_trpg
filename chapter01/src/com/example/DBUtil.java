package com.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    // 数据库连接信息

    private static final String URL = "jdbc:mysql://localhost:3306/school?useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";  // 替换为你的数据库用户名
    private static final String PASSWORD = "nylttp1018"; // 替换为你的数据库密码

    // 创建数据库连接
    public static Connection getConnection() throws SQLException {
        Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
        return connection;
    }

    // 可选：添加关闭连接的方法
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
