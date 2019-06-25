<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>小菜鸡的个人博客</title>
</head>
<body>
<%@ include file="/WEB-INF/pages/include/blog-header.jsp" %>
<article>
    <div class="blogs">
        <c:if test="${empty pageModel.list}">
            <h3>没有文章</h3>
        </c:if>
        <c:if test="${!empty pageModel.list}">
            <c:forEach items="${pageModel.list}" var="article">
                <li><span class="blogpic"><a href="/"></a></span>
                    <h3 class="blogtitle"><a
                            href="${pageContext.request.contextPath}/blog_toArticle?articleId=${article.id}&flag=1">${article.title}</a>
                    </h3>
                    <div class="bloginfo">
                        <p>${article.content}</p>
                    </div>
                    <div class="autor"><span class="lm"><a href="${pageContext.request.contextPath}/blog_toType?page=1&type=${article.type.id}&typeName=${article.type.name}"
                                                           class="classname">${article.type.name}</a></span><span
                            class="dtime">${article.publishTime}</span><span
                            class="viewnum">浏览(${article.clickNum})&nbsp;&nbsp;<span
                            class="glyphicon glyphicon-comment" aria-hidden="true"></span>&nbsp评论(${article.commentNum})&nbsp;&nbsp;</span><span
                            class="readmore"><a
                            href="${pageContext.request.contextPath}/blog_toArticle?articleId=${article.id}&flag=1">阅读原文</a></span>
                    </div>
                </li>
            </c:forEach>
        </c:if>
        <nav aria-label="Page navigation" style="margin-left: 35%">
            <ul class="pagination">
                <li
                        <c:if test="${pageModel.currentPageNum==pagenum}">
                            class = "disabled"
                        </c:if>
                        style="background: #F7F7F7"
                ><a href="${pageContext.request.contextPath}/blog_toIndex?page=1">&laquo;</a>
                </li>

                <c:forEach begin="${pageModel.startPage}" end="${pageModel.endPage}" var="pagenum">
                    <li
                            <c:if test="${pageModel.currentPageNum==pagenum}">
                                class = "active"
                            </c:if>
                            style="background: #F7F7F7"
                    >
                        <a href="${pageContext.request.contextPath}/blog_toIndex?page=${pagenum}">${pagenum}</a>
                    </li>

                </c:forEach>

                <li
                        <c:if test="${pageModel.currentPageNum==totalPageNum}">
                            class = "disabled"
                        </c:if>
                        style="background: #F7F7F7"
                >
                    <a href="${pageContext.request.contextPath}/blog_toIndex?page=${pageModel.totalPageNum}">&raquo;</a>
                </li>
            </ul>
        </nav>

    </div>
    <div class="sidebar">
        <div class="about">
            <div class="avatar"><img src="${adminMsg.headImg}" alt="头像" style="width: 100%"></div>
            <p class="abname">${adminMsg.name}</p>
            <p class="abposition">学生</p>
            <div class="abtext"> ${adminMsg.summary} </div>
        </div>
        <div class="search">
            <form action="${pageContext.request.contextPath}/blog_toArticleSearch" method="post" name="searchform" id="searchform">
                <input name="keyword" id="keyword" class="input_text" placeholder="请输入关键字"
                       style="color: rgb(153, 153, 153);" type="text">
                <input name="Submit" class="input_submit" value="搜索" type="submit" onclick="return searchArticle()">
            </form>
        </div>
        <div class="cloud">
            <h2 class="hometitle">文章标签</h2>
            <ul>
                <c:forEach var="type" items="${types}">
                    <a href="${pageContext.request.contextPath}/blog_toType?page=1&type=${type.id}&typeName=${type.name}">${type.name}</a>
                </c:forEach>
            </ul>
        </div>
        <div class="paihang">
            <h2 class="hometitle">点击排行</h2>

            <ul>
                <c:forEach var="article" items="${top5Article}">
                    <a href="${pageContext.request.contextPath}/blog_toArticle?articleId=${article.id}&flag=1">
                        <li><b>${article.title}</b>
                            <p>${article.content}</p>
                        </li>
                    </a>
                </c:forEach>

            </ul>
        </div>
    </div>
</article>
<%@ include file="/WEB-INF/pages/include/blog-footer.jsp" %>
</body>
<script>
    $(function () {
        $("#index").addClass('currentNav')
        $("#type").removeClass('currentNav')
        $("#archive").removeClass('currentNav')
        $("#message").removeClass('currentNav')
        $("#about").removeClass('currentNav')
    })

    function searchArticle() {
        if($("#keyword").val().trim() == ""){
            alert("关键词不能为空");
            return false;
        }
    }
</script>
</html>
