<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>小菜鸡的个人博客</title>
</head>
<body>
<%@ include file="/WEB-INF/pages/include/blog-header.jsp" %>
<article>
    <h1 class="t_nav"><span></span><a href="${pageContext.request.contextPath}/blog_toIndex" class="n1">网站首页</a><a
            href="#" class="n2">搜索</a></h1>
    <input type="hidden" name="type" value="${type}" id="typeId">
    <input type="hidden" name="typeName" value="${typeName}" id="typeName">
    <input type="hidden" name="page" value="${page}" id="page">
    <div class="ab_box">
        <div class="row">
            <div class="col-md-12">
                <div class="cloud">
                    <h2 class="hometitle">关于"${keyword}"的文章共有${fn:length(articles)}篇</h2>
                </div>
            </div>
        </div>
        <c:if test="${empty articles}">
            <h3>没有相关文章</h3>
        </c:if>
        <c:if test="${!empty articles}">
            <c:forEach items="${articles}" var="article">
                <li><span class="blogpic"><a href="#"></a></span>
                    <h3 class="blogtitle"><a href="${pageContext.request.contextPath}/blog_toArticle?articleId=${article.id}&flag=1">${article.title}</a></h3>
                    <div class="bloginfo">
                        <p>${article.content}</p>
                    </div>
                    <div class="autor"><span class="lm"><a href="${pageContext.request.contextPath}/blog_toType?page=1&type=${article.type.id}&typeName=${article.type.name}" target="_blank"
                                                           class="classname">${article.type.name}</a></span><span
                            class="dtime">${article.publishTime}</span><span
                            class="viewnum">浏览(<a href="#">${article.clickNum}&nbsp;&nbsp;</a>) <span
                            class="glyphicon glyphicon-comment" aria-hidden="true"></span>&nbsp评论(${article.commentNum})&nbsp;&nbsp;</span><span
                            class="readmore"><a
                            href="${pageContext.request.contextPath}/blog_toArticle?articleId=${article.id}&flag=1">阅读原文</a></span>
                    </div>
                </li>
                <hr>
            </c:forEach>
        </c:if>
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
        $("#about").removeClass('currentNav')
    })

</script>
</html>
