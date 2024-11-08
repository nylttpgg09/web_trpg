<%@ page import="java.sql.*" %>
<%@ page import="com.example.DBUtil" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>虚空之声 - 留言板</title>
    <li><a href="index.html">首页</a></li>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<div class="message-board">
    <h1>虚空之声</h1>

    <form action="message_board.jsp" method="post">
        <input type="text" name="username" placeholder="祭拜者的名字" required>
        <textarea name="message" placeholder="向深渊低语..." required></textarea>
        <button type="submit">献祭留言</button>
    </form>

    <hr>

    <h2>远古低语</h2>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 处理留言提交
        String username = request.getParameter("username");
        String message = request.getParameter("message");

        if (username != null && message != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DBUtil.getConnection(); // 确保在提交留言之前获取连接
                String insertSql = "INSERT INTO eemessages (username, message) VALUES (?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, username);
                pstmt.setString(2, message);
                pstmt.executeUpdate();

                // 刷新页面以显示新留言
                response.sendRedirect("message_board.jsp");
                return; // 确保在重定向后终止后续代码执行
            } catch (SQLException e) {
                out.println("<p class='error'>献祭失败: " + e.getMessage() + "</p>");
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                if (conn != null) DBUtil.closeConnection(conn);
            }
        }

        // 查询留言
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM eemessages ORDER BY created_at DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String user = rs.getString("username");
                String msg = rs.getString("message");
                Timestamp createdAt = rs.getTimestamp("created_at");

                out.println("<div class='message-item'>");
                out.println("<strong>" + user + "</strong> <em>(" + createdAt + ")</em>");
                out.println("<p>" + msg + "</p>");
                out.println("</div>");
            }
        } catch (SQLException e) {
            out.println("<p class='error'>深渊之力干扰了数据库: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) DBUtil.closeConnection(conn);
        }
    %>
</div>

<style>
    body {
        font-family: 'Courier New', monospace;
        background-color: #1a1a1a;
        color: #d3d3d3;
        margin: 0;
        padding: 20px;
    }
    .message-board {
        background: #222;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
        color: #adff2f;
        text-shadow: 0 0 8px #00ff66;
    }
    h1, h2 {
        color: #ff3333;
        text-shadow: 0 0 8px #ff3333;
    }
    input[type="text"], textarea {
        width: 100%;
        padding: 10px;
        border: none;
        border-radius: 5px;
        margin: 10px 0;
        background: #333;
        color: #adff2f;
    }
    button {
        background-color: #adff2f;
        color: #1a1a1a;
        border: none;
        padding: 10px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
        transition: background 0.3s ease;
    }
    button:hover {
        background-color: #ff3333;
        color: #fff;
    }
    .message-item {
        margin: 15px 0;
        padding: 15px;
        border: 1px solid #333;
        border-radius: 5px;
        background: #1e1e1e;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.4);
    }
    .error {
        color: #ff3333;
        font-weight: bold;
    }
</style>

</body>
</html>
