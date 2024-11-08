<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.DBUtil" %>

<!DOCTYPE html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <title>用户登录 - 欢迎进入未知之域</title>
    <style>
        body {
            background-color: #1a1a1a;
            color: #e0e0e0;
            font-family: 'Courier New', Courier, monospace;
            text-align: center;
            padding-top: 5%;
        }
        h2 {
            color: #cc0000;
        }
        form {
            background-color: #2a2a2a;
            padding: 20px;
            border-radius: 8px;
            display: inline-block;
            box-shadow: 0px 0px 10px 5px #000;
            margin: 20px;
        }
        input[type="text"], input[type="password"] {
            background-color: #333;
            border: none;
            padding: 10px;
            color: #e0e0e0;
            width: 200px;
            margin: 5px 0;
        }
        input[type="submit"] {
            background-color: #990000;
            border: none;
            color: white;
            padding: 10px 20px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #cc0000;
        }
        h3 {
            color: #cc0000;
        }
    </style>
</head>
<body>
<h2>登陆深渊</h2>
<p>欢迎，旅人。输入凭证，若汝敢窥探不可见之物。</p>

<!-- 登录表单 -->
<form action="login2_3.jsp" method="post">
    <label>账号: <input type="text" name="SNAME" required></label><br>
    <label>密码: <input type="password" name="SID" required></label><br>
    <input type="submit" value="进入">
</form>

<h2>或是首次进入深渊？注册新的凭证</h2>

<!-- 注册表单 -->
<form action="register.jsp" method="post">
    <label>账号: <input type="text" name="newSNAME" required></label><br>
    <label>密码: <input type="password" name="newSID" required></label><br>
    <input type="submit" value="注册">
</form>

<%
    // 登录功能：检查用户凭证
    String NAME = request.getParameter("SNAME");
    String SID = request.getParameter("SID");

    if (NAME != null && SID != null) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBUtil.getConnection();

            String sql = "SELECT * FROM students WHERE SNAME = ? AND SID = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, NAME);
            pstmt.setString(2, SID);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String updateSql = "UPDATE students SET is_online = TRUE WHERE SNAME = ?";
                try (PreparedStatement updatePstmt = conn.prepareStatement(updateSql)) {
                    updatePstmt.setString(1, NAME);
                    updatePstmt.executeUpdate();
                }

                HttpSession sessions = request.getSession();
                sessions.setAttribute("SNAME", NAME);
                response.sendRedirect("index.html");
                return;
            } else {
                out.println("<h3>冒险者，汝之凭证无效，幽暗深处不接纳凡人。</h3>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<h3>汝的请求被神秘力量阻碍，请稍后再试。</h3>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) DBUtil.closeConnection(conn);
        }
    }
%>

</body>
</html>
