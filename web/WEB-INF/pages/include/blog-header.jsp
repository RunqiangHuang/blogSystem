<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/blog/css/base.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/blog/css/index.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/blog/css/m.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<!--[if lt IE 9]>
<script src="${pageContext.request.contextPath}/blog/js/modernizr.js"></script>
<![endif]-->
<header>
    <div class="tophead">
        <div class="logo"><a href="#">小菜鸡的个人博客</a></div>
        <div id="mnav">
            <h2><span class="navicon"></span></h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/blog_toIndex">网站首页</a></li>
                <li><a href="${pageContext.request.contextPath}/blog_toType">分类</a></li>
                <li><a href="${pageContext.request.contextPath}/blog_toMessage">留言</a></li>
                <li><a href="${pageContext.request.contextPath}/blog_toAbout">关于我</a></li>
                <c:if test="${empty user}">
                    <li><a href="${pageContext.request.contextPath}/blog_toLogin">登录</a></li>
                </c:if>
                <c:if test="${!empty user}">
                    <li><a href="#" onclick="logout()">退出登录</a></li>
                </c:if>
            </ul>
        </div>
        <nav class="topnav" id="topnav">
            <ul>
                <li><a id="index" href="${pageContext.request.contextPath}/blog_toIndex">网站首页</a></li>
                <li><a id="type" href="${pageContext.request.contextPath}/blog_toType">分类</a></li>
                <li><a id="message" href="${pageContext.request.contextPath}/blog_toMessage">留言</a></li>
                <li><a id="about" href="${pageContext.request.contextPath}/blog_toAbout">关于我</a></li>
                <c:if test="${empty user}">
                    <li><a href="${pageContext.request.contextPath}/blog_toLogin">登录</a></li>
                </c:if>
                <c:if test="${!empty user}">
                    <li><a href="#" onclick="logout()">退出登录</a></li>
                </c:if>
            </ul>
        </nav>
    </div>
</header>
<script>
    function logout() {
        $.ajax({
            url: '${pageContext.request.contextPath}/blog_toLogout',
            dataType: 'json',
            success: function () {
                window.location.reload()
            },
            error: function () {
                alert("fail");
            }
        });
    }
</script>