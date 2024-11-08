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
    <title>上传日记条目</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Courier New', Courier, monospace;
            background-color: #1c1c1c;
            color: #f8f8f2;
            margin: 0;
            padding: 20px;
            line-height: 1.6;
        }
        .upload-result {
            background-color: #272727;
            border-radius: 8px;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.8);
            padding: 20px;
            max-width: 600px;
            margin: auto;
        }
        h1 {
            text-align: center;
            color: #ff79c6; /* 紫色 */
            font-size: 2.5em;
            border-bottom: 2px solid #6272a4; /* 蓝色底线 */
            padding-bottom: 10px;
        }
        .message {
            margin: 20px 0;
            font-size: 1.4em;
            text-align: center;
        }
        .error-message {
            color: #ff5555; /* 红色 */
            font-weight: bold;
        }
        .success-message {
            color: #50fa7b; /* 绿色 */
            font-weight: bold;
        }
        .back-button {
            display: block;
            text-align: center;
            margin: 20px 0;
            text-decoration: none;
            color: #f8f8f2;
            background-color: #6272a4; /* 蓝色 */
            padding: 12px 20px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .back-button:hover {
            background-color: #44475a; /* 深色 */
        }
        /* 添加一些克苏鲁元素的背景 */
        .upload-result::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('/image/bg_w_to_b.png'); /* 替换为您的背景图 */
            opacity: 0.1; /* 背景透明度 */
            z-index: -1;
        }
    </style>
</head>
<body>

<div class="upload-result">
    <h1>上传结果</h1>
    <%
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String places = request.getParameter("places");
        String timess = request.getParameter("times");
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBUtil.getConnection();

            // 插入日记条目的 SQL 语句
            String sql = "INSERT INTO diary (diarys, datas,places, times ) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setString(3, places);
            pstmt.setString(4, timess);


            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                out.println("<p class='message success-message'>日记条目上传成功！</p>");
            } else {
                out.println("<p class='message error-message'>日记条目上传失败，请重试。</p>");
            }
        } catch (SQLException e) {
            out.println("<p class='message error-message'>数据库错误: " + e.getMessage() + "</p>");
        } catch (ClassNotFoundException e) {
            out.println("<p class='message error-message'>数据库驱动未找到: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) DBUtil.closeConnection(conn);
        }
    %>
    <a class="back-button" href="investigator_diary.jsp">返回首页</a>
</div>

</body>
</html>
-