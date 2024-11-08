<%--
  Created by IntelliJ IDEA.
  User: gugu
  Date: 2024/10/28
  Time: 22:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.example.DBUtil" %>

<!DOCTYPE html>
<html lang="zh">
<head>
  <meta charset="UTF-8">
  <title>注册 - 深渊之门</title>
  <style>
    body {
      background-color: #1a1a1a; /* 深色背景 */
      color: #e0e0e0; /* 神秘的灰白色字体 */
      font-family: 'Courier New', Courier, monospace;
      text-align: center;
      padding-top: 10%;
    }
    h3 {
      color: #cc0000; /* 血红色提示文字 */
      margin-bottom: 20px;
    }
    .message-box {
      background-color: #2a2a2a;
      padding: 20px;
      border-radius: 8px;
      display: inline-block;
      box-shadow: 0px 0px 10px 5px #000;
    }
    .redirect-info {
      color: #777;
      font-size: 0.9em;
      margin-top: 15px;
    }
  </style>
  <meta http-equiv="refresh" content="5;url=login2_3.jsp"> <!-- 自动跳转至登录页面 -->
</head>
<body>
<div class="message-box">
  <%
    String newName = request.getParameter("newSNAME");
    String newPassword = request.getParameter("newSID");

    if (newName != null && newPassword != null) {
      Connection conn = null;
      PreparedStatement pstmt = null;
      try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DBUtil.getConnection();

        // 检查账号是否已存在
        String checkSql = "SELECT * FROM students WHERE SNAME = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, newName);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
          out.println("<h3>此凭证名已存在，另寻名号以行秘法。</h3>");
        } else {
          // 插入新用户信息
          String insertSql = "INSERT INTO students (SNAME, SID, is_online) VALUES (?, ?, FALSE)";
          pstmt = conn.prepareStatement(insertSql);
          pstmt.setString(1, newName);
          pstmt.setString(2, newPassword);
          pstmt.executeUpdate();
          out.println("<h3>注册成功！汝之凭证已生成，可回首以登深渊。</h3>");
          out.println("<div class='redirect-info'>片刻之后，汝将被引回登录界面……</div>");
        }
      } catch (SQLException e) {
        e.printStackTrace();
        out.println("<h3>神秘力量扰乱了注册过程，请稍后再试。</h3>");
      } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) DBUtil.closeConnection(conn);
      }
    }
  %>
</div>
</body>
</html>
