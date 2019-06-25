<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>小菜鸡的个人博客</title>
</head>
<body>
<%@ include file="/WEB-INF/pages/include/blog-header.jsp" %>
<article>
    <h1 class="t_nav"><span></span><a href="${pageContext.request.contextPath}/blog_toIndex" class="n1">网站首页</a><a
            href="${pageContext.request.contextPath}/blog_toAbout" class="n2">关于我</a></h1>
    <div class="ab_box">
        <div class="leftbox">
            <div class="newsview">
                <div class="news_infos">
                    ${adminMsg.summary}
                </div>
            </div>
        </div>
        <div class="rightbox">
            <div class="aboutme">
                <h2 class="hometitle">关于我</h2>
                <div class="avatar"><img src="${adminMsg.headImg}"></div>
                <div class="ab_con">
                    <p>姓名：${adminMsg.name}</p>
                    <p>职业：学生 </p>
                    <p>邮箱：${adminMsg.email}</p>
                    <p>电话：${adminMsg.tel}</p>
                </div>
            </div>
        </div>
    </div>
</article>
<%@ include file="/WEB-INF/pages/include/blog-footer.jsp" %>
</body>
<script>
    $(function () {
        $("#index").removeClass('currentNav')
        $("#type").removeClass('currentNav')
        $("#archive").removeClass('currentNav')
        $("#message").removeClass('currentNav')
        $("#about").addClass('currentNav')
    })
</script>
</html>
