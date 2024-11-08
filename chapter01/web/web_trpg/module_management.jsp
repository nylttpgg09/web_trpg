<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="com.example.DBUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.io.File" %>
<%request.setCharacterEncoding("UTF-8");%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>模组管理</title>
  <link rel="stylesheet" href="styles.css">
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
    }
    .module-box {
      background-color: #2a2a2a;
      margin: 20px auto;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0px 0px 10px 5px #000;
      display: inline-block;
      width: 300px;
    }
    .upload-message {
      color: green;
      margin-top: 10px;
    }
    .error-message {
      color: red;
    }
  </style>
</head>

<body>
<header>
  <h1>模组管理</h1>
  <nav>
    <ul>
      <li><a href="index.html">首页</a></li>
      <li><a href="login2_3.jsp">登录</a></li>
      <li><a href="investigator_diary.jsp">调查员日记</a></li>
      <li><a href="#moduleOverview">模组概览</a></li>
      <li><a href="#moduleUpload">上传模组</a></li>
      <li><a href="#moduleData">模组数据</a></li>
    </ul>
  </nav>
</header>

<main>
  <!-- 搜索模组 -->
  <!-- 搜索模组 -->
  <section id="searchSection">
    <form id="searchForm" method="post">
      <input type="text" name="query" placeholder="搜索模组..." required>
      <button type="submit" name="searchType" value="fuzzy">模糊搜索</button>
      <button type="submit" name="searchType" value="exact">精确搜索</button>
    </form>
    <div id="results">
      <%
        String query = request.getParameter("query");
        String searchType = request.getParameter("searchType");
        if (query != null && searchType != null) {
          List<String> modules = new ArrayList<>();
          Connection conn = null;
          PreparedStatement pstmt = null;
          ResultSet rs = null;
          try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBUtil.getConnection();

            String sql;
            if ("exact".equals(searchType)) {
              sql = "SELECT `mod` FROM `mods` WHERE `mod` = ?";
              pstmt = conn.prepareStatement(sql);
              pstmt.setString(1, query); // 精确匹配
            } else { // 默认模糊搜索
              sql = "SELECT `mod` FROM `mods` WHERE `mod` LIKE ?";
              pstmt = conn.prepareStatement(sql);
              pstmt.setString(1, "%" + query + "%"); // 模糊匹配
            }

            rs = pstmt.executeQuery();

            while (rs.next()) {
              modules.add(rs.getString("mod")); // 确保字段名与数据库一致
            }
          } catch (SQLException e) {
            out.println("<p class='error-message'>数据库错误: " + e.getMessage() + "</p>");
          } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) DBUtil.closeConnection(conn);
          }

          if (!modules.isEmpty()) {
            for (String module : modules) {
              out.println("<div class='module-box'><h3>" + module + "</h3></div>");
            }
          } else {
            out.println("<p>未找到相关模组。</p>");
          }
        }
      %>
    </div>
  </section>


  <section id="moduleUpload" class="module-settings">
    <h2>上传模组</h2>
    <form action="module_management.jsp" method="post">
      <%--@declare id="modulename"--%><%--@declare id="moduledescription"--%><label for="moduleName">模组名称:</label>
      <input type="text" name="moduleName" required placeholder="输入模组名称">

      <label for="moduleDescription">模组描述:</label>
      <textarea name="moduleDescription" required placeholder="输入模组描述"></textarea>

      <button type="submit" name="upload">上传模组</button>
    </form>

    <div class="upload-message">
      <%
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("upload") != null) {
          String moduleName = request.getParameter("moduleName");
          String moduleDescription = request.getParameter("moduleDescription");

          // 数据库插入操作
          Connection conn = null;
          PreparedStatement pstmt = null;
          try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBUtil.getConnection();
            String insertSql = "INSERT INTO mods (`mod`, `intro`) VALUES (?, ?)"; // 不需要 modfile 字段
            pstmt = conn.prepareStatement(insertSql);
            pstmt.setString(1, moduleName);
            pstmt.setString(2, moduleDescription);
            pstmt.executeUpdate();

            out.println("<p>模组 \"" + moduleName + "\" 上传成功！</p>");
          } catch (SQLException e) {
            out.println("<p class='error-message'>数据库错误: " + e.getMessage() + "</p>");
          } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) DBUtil.closeConnection(conn);
          }
        }
      %>
    </div>
  </section>

  <section id="moduleOverview" class="module-info">
    <h2>模组概览</h2>
    <p>在此查看可用模组的详细信息。</p>
    <div id="moduleDisplay">
      <%
        // 展示已上传的模组
        List<String> uploadedModules = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DBUtil.getConnection();

          // 使用准确的字段名并包裹反引号
          String selectSql = "SELECT `mod`, `intro` FROM mods";
          pstmt = conn.prepareStatement(selectSql);
          rs = pstmt.executeQuery();

          while (rs.next()) {
            String module = rs.getString("mod");
            String description = rs.getString("intro");
            out.println("<div class='module-box'><h3>" + module + "</h3><p>" + description + "</p></div>");
          }


          // 显示模组信息
          if (!uploadedModules.isEmpty()) {
            for (String module : uploadedModules) {
              out.println("<div class='module-box'><h3>" + module + "</h3></div>");
            }
          } else {
            out.println("<p>当前没有可用的模组。</p>");
          }
        } catch (SQLException e) {
          out.println("<p class='error-message'>数据库错误: " + e.getMessage() + "</p>");
        } finally {
          if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
          if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
          if (conn != null) DBUtil.closeConnection(conn);
        }
      %>
    </div>
  </section>

</main>

<footer>
  <p>&copy; 2024 模组管理页面. 版权所有。</p>
</footer>
</body>
</html>
