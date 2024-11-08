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
    <title>霍咕咕的传奇调查员日记簿</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="diary-page">

    <div class="container">
        <header>
            <div class="logo">
                <h1>霍咕咕的传奇调查员日记簿</h1>
            </div>
            <nav>
                <ul>
                    <li><a href="index.html">首页</a></li>
                    <li><a href="login2_3.jsp">登录</a></li>
                    <li><a href="#">调查员日记</a></li>
                    <li><a href="module_management.jsp">待定模组</a></li>
                    <li><a href="#">冒险故事</a></li>
                </ul>
            </nav>
        </header>


        <section class="upload-diary">
            <h2>上传新日记条目</h2>
            <form action="upload_diary.jsp" method="post">
                <label for="title">标题：</label>
                <input type="text" id="title" name="title" required>

                <label for="places">地点：</label>
                <input type="text" id="places" name="places" required>

                <label for="times">时间：</label>
                <input type="text" id="times" name="times" required>


                <label for="content">内容：</label>
                <textarea id="content" name="content" rows="4" required></textarea>

                <button type="submit">上传日记条目</button>
            </form>
        </section>

        <section class="diary">
            <h2>调查员日记</h2>

            <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT diarys, datas ,places,times FROM diary ORDER BY diarys DESC"; // 假设 id 是主键
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
            String diaryTitle = rs.getString("diarys");
            String diaryContent = rs.getString("datas");
            String diaryplaces = rs.getString("places");
            String diarytimes = rs.getString("times");
            %>
            <article>
                <h5><%= diaryTitle %></h5>
                <h5><%= diaryplaces%></h5>
                <h5><%= diarytimes %></h5>
                <p><%= diaryContent %></p>
            </article>
            <%
            }
            } catch (SQLException e) {
            out.println("<p class='message error-message'>数据库错误: " + e.getMessage() + "</p>");
            } catch (ClassNotFoundException e) {
            out.println("<p class='message error-message'>数据库驱动未找到: " + e.getMessage() + "</p>");
            }
            finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) DBUtil.closeConnection(conn);
            }
            %>
        </section>

    <section class="diary">
        <h3>赞美太阳 - 调查员日记</h3>
        
        <!-- 精彩片段 -->
        <article class="diary-entry">
            <h4>精彩片段</h4>
            <p>在故事开端，主角们受命前往一座名为森瓦利镇的小镇，寻找失踪的凯文教授。这段描述了波尔教授的场景：</p>
            <blockquote>
                “白发苍苍的老教授波尔坐在接待桌旁边等待着你们的到来。等你们进入到房间之后，这位在考古学术方面很有资历的老前辈忧心忡忡的开口了：‘各位，我很感激你们能够在百忙之中抽出空闲前来。凯文教授是我们大学不可或缺的一部分，他在学术领域和教育领域有着举足轻重的作用。大概半个月前，凯文教授向学校发出了最后一封通讯之后就失踪了。通讯中表示，他在森瓦利镇发现了未知的古文明遗迹，因此会花费些时间。’”
            </blockquote>
        </article>
    
        <!-- 人物特写 -->
        <article class="diary-entry">
            <h4>人物特写</h4>
            <p>以下是《赞美太阳》中的几个关键人物的特写：</p>
    
            <div class="character-highlight">
                <h5>霍尔·霍金</h5>
                <p>霍尔是一位幽默感十足的老教授，虽然年纪大了，但仍然充满活力。以下是他的场景片段：</p>
                <blockquote>
                    “我能不去吗”霍尔此时提出了疑问。波尔教授回答：“当然，考虑到您的腿脚，您当然可以不去，但这样学校批下来的巨额经费可就和您没关系了。”
                </blockquote>
            </div>
    
            <div class="character-highlight">
                <h5>尼尔·沃夫</h5>
                <p>尼尔是一名冷静而专业的外籍调查员，善于处理紧急情况。他的坚定信念帮助团队在复杂的局势中前行。</p>
            </div>
        </article>
    </section>
    
        <section class="diary">
    <h3>赞美太阳 - 调查员日记</h3>

    <!-- 精彩片段 -->
    <article class="diary-entry">
        <h4>凯文</h4>
        <p>故事开头，主角们受命前往寻找凯文教授，以下是他们与波尔教授的一段对话：</p>
        <blockquote>
            “帮忙调查得加钱。”<br>
            “多出的钱校方会出的。”<br>
            “当然，如果你表示怀疑的话，我们可以先付一些定金。”&#8203;
        </blockquote>
        <p>这段对话展示了任务的复杂性，也带来了些幽默。</p>
    </article>

    <!-- 整活片段 -->
    <article class="diary-entry">
        <h4>酒馆</h4>
        <p>角色们在酒吧发生了一些有趣的对话，带来了轻松的气氛：</p>
        <blockquote>
            “那个，老板，可以让我试试吗？”<br>
            “别阿巴阿巴的，再阿巴阿巴，你这学期就白干了。”&#8203;
        </blockquote>
    </article>

    <!-- 关键节点片段 -->
    <article class="diary-entry">
        <h4>圣火</h4>
        <p>在调查祭祀仪式的过程中，富兰克林透露了关于圣火的重要线索：</p>
        <blockquote>
            “我们点燃了圣火...但雕像不见了！然后火焰燃起来了！”&#8203;
        </blockquote>
    </article>

    <article class="diary-entry">
        <h4>沃利之死</h4>
        <p>沃利的死和森林中的事件揭示了火焰的危险：</p>
        <blockquote>
            “沃利...他死了，火焰焚身，燃烧的狼群。”&#8203;
        </blockquote>
    </article>

    <article class="diary-entry">
        <h4>痕迹</h4>
        <p>调查员们在沃利家中发现了关于火焰的线索：</p>
        <blockquote>
            “地板上有着木炭笔写下的‘FIRE’，重复了许多次，房间里弥漫着硫磺的味道。”&#8203;
        </blockquote>
    </article>

        <!-- 火灾后的精彩段落 -->
        <article class="diary-entry">
            <h4>火灾后</h4>
            <p>火灾发生后，调查员们被迫面对迅速蔓延的火焰以及其中隐藏的恐怖力量：</p>
            <blockquote>
                “火焰爆发的一瞬间，几乎瞬间就引燃了周围的一切物体，火焰汇聚成了猩红色的炽焰浮在半空，扭曲而狂热，散发着深入灵魂的恶意。”&#8203;
            </blockquote>
        </article>
    
        <article class="diary-entry">
            <h4>火灾后</h4>
            <p>面对扑灭不了的火焰，富兰克林陷入了绝望：</p>
            <blockquote>
                “火焰燃烧，附在他们身上，无法扑灭。”&#8203;
            </blockquote>
        </article>
    
        <article class="diary-entry">
            <h4>火灾后</h4>
            <p>霍尔教授发现火焰似乎具有某种生命力，无法被控制：</p>
            <blockquote>
                “那火焰似乎有意识！火舌像是在跳舞，向他们逼近。”&#8203;
            </blockquote>
        </article>
    
        <article class="diary-entry">
            <h4>火灾后</h4>
            <p>调查员们面对火焰犬的逼近，处于生死边缘：</p>
            <blockquote>
                “火焰犬的出现让场面更加混乱，空气中弥漫着令人作呕的硫磺味。”&#8203;
            </blockquote>
        </article>
    
        <article class="diary-entry">
            <h4>火灾后</h4>
            <p>尽管霍尔教授努力挖掘防火带，火焰却似乎在嘲笑着他们的挣扎：</p>
            <blockquote>
                “防火带成为他们唯一的生存希望。火焰仍然在跳动，像是在嘲弄着他们的挣扎。”&#8203;
            </blockquote>
        </article>
    
</section>


        <section class="stories">
            <h2>冒险故事</h2>
            <div class="story-grid">
                <div class="story-item">
                    <h4>失落的神庙</h4>
                    <p>一支探险队在南美洲的丛林中发现了一座遗失千年的神庙，而这座神庙似乎隐藏着不可告人的秘密。</p>
                </div>
                <div class="story-item">
                    <h4>克苏鲁的召唤</h4>
                    <p>一名研究员在调查古老的文献时，意外地唤醒了沉睡的邪神，恐怖从此降临。</p>
                </div>
            </div>
        </section>
    </div>

    <footer>
        <p>&copy; 2024 霍咕咕的传奇调查员日记簿. 版权所有。</p>
    </footer>
<!-- 回到顶部按钮 -->
<button id="back-to-top" title="回到顶部">
    <i class="fas fa-chevron-up"></i>
</button>
<!-- 显示滚动百分比 -->
<div id="scroll-percentage">0%</div>

<!-- 回到底部按钮 -->
<button id="back-to-bottom" title="回到底部">
    <i class="fas fa-chevron-down"></i>
</button>


</body>


<script>
    // 获取按钮
    var backToTopButton = document.getElementById("back-to-top");
    var backToBottomButton = document.getElementById("back-to-bottom");
    
    // 当用户滚动时，显示或隐藏按钮
    window.addEventListener('scroll', scrollFunction);
    
    function scrollFunction() {
        // 页面总高度
        var documentHeight = document.body.scrollHeight || document.documentElement.scrollHeight;
        // 当前滚动位置
        var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
        // 可视区域高度
        var windowHeight = window.innerHeight || document.documentElement.clientHeight;
    
        if (scrollTop > 200) {
            backToTopButton.classList.add("show");
        } else {
            backToTopButton.classList.remove("show");
        }
    
        if (scrollTop + windowHeight < documentHeight - 200) {
            backToBottomButton.classList.add("show");
        } else {
            backToBottomButton.classList.remove("show");
        }
    }
    
    // 点击按钮，返回顶部
    backToTopButton.onclick = function() {
        window.scrollTo({top: 0, behavior: 'smooth'});
    };
    
    // 点击按钮，返回底部
    backToBottomButton.onclick = function() {
        window.scrollTo({top: document.body.scrollHeight, behavior: 'smooth'});
    };
    </script>
    
    
    <script>
        // 获取显示百分比的元素
        var scrollPercentageElement = document.getElementById("scroll-percentage");
        
        // 当用户滚动时，更新百分比
        window.addEventListener('scroll', function() {
            var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
            var scrollHeight = document.documentElement.scrollHeight || document.body.scrollHeight;
            var clientHeight = document.documentElement.clientHeight || window.innerHeight;
            
            // 计算滚动的百分比
            var scrollPercentage = Math.round((scrollTop / (scrollHeight - clientHeight)) * 100);
            
            // 更新百分比文本
            scrollPercentageElement.innerHTML = scrollPercentage + "%";
            
            // 当页面滚动时，显示百分比
            if (scrollTop > 100) {
                scrollPercentageElement.classList.add("show");
            } else {
                scrollPercentageElement.classList.remove("show");
            }
        });
        </script>
        
</html>
