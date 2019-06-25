<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>小菜鸡的个人博客</title>
</head>
<body>
<%@ include file="/WEB-INF/pages/include/blog-header.jsp" %>
<article>
    <h1 class="t_nav"><span></span><a href="${pageContext.request.contextPath}/blog_toIndex" class="n1">网站首页</a><a
            href="${pageContext.request.contextPath}/blog_toType" class="n2">分类</a></h1>
    <input type="hidden" name="type" value="${type}" id="typeId">
    <input type="hidden" name="typeName" value="${typeName}" id="typeName">
    <input type="hidden" name="page" value="${page}" id="page">
    <div class="ab_box">
        <div class="row">
            <div class="col-md-12">
                <div class="cloud">
                    <h2 class="hometitle">文章标签</h2>
                    <c:if test="${flag == 1}">
                        <h2 class="hometitle">当前标签：${typeName}</h2>
                    </c:if>
                    <ul>
                        <c:forEach var="type" items="${types}">
                            <a href="#" onclick="findArticleWithType(${type.id},1,'${type.name}')">${type.name}</a>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
        <c:if test="${empty pageModel.list}">
            <h3>没有文章</h3>
        </c:if>
        <c:if test="${!empty pageModel.list}">
            <c:forEach items="${pageModel.list}" var="article">
                <li><span class="blogpic"><a href="#"></a></span>
                    <h3 class="blogtitle"><a
                            href="${pageContext.request.contextPath}/blog_toArticle?articleId=${article.id}&flag=1">${article.title}</a>
                    </h3>
                    <div class="bloginfo">
                        <p>${article.content}</p>
                    </div>
                    <div class="autor"><span class="lm"><a
                            href="${pageContext.request.contextPath}/blog_toType?page=1&type=${article.type.id}&typeName=${article.type.name}"
                            target="_blank"
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
    <nav aria-label="Page navigation" style="margin-left: 35%">
        <ul class="pagination">
            <li
                    <c:if test="${pageModel.currentPageNum==pagenum}">
                        class = "disabled"
                    </c:if>
                    style="background: #F7F7F7"
            ><a onclick="findArticleWithType('temp',1,'temp')">&laquo;</a>
            </li>

            <c:forEach begin="${pageModel.startPage}" end="${pageModel.endPage}" var="pagenum">
                <li
                        <c:if test="${pageModel.currentPageNum==pagenum}">
                            class = "active"
                        </c:if>
                        style="background: #F7F7F7"
                >
                    <a onclick="findArticleWithType('temp',${pagenum},'temp')">${pagenum}</a>
                </li>

            </c:forEach>

            <li
                    <c:if test="${pageModel.currentPageNum==totalPageNum}">
                        class = "disabled"
                    </c:if>
                    style="background: #F7F7F7"
            >
                <a onclick="findArticleWithType('temp',${pageModel.totalPageNum},'temp')">&raquo;</a>
            </li>
        </ul>
    </nav>
</article>
<%@ include file="/WEB-INF/pages/include/blog-footer.jsp" %>
</body>
<script>
    $(function () {
        $("#index").removeClass('currentNav')
        $("#type").addClass('currentNav')
        $("#archive").removeClass('currentNav')
        $("#message").removeClass('currentNav')
        $("#about").removeClass('currentNav')
    })

    function findArticleWithType(typeId, page, typeName) {
        if (typeId == 'temp') {
            if ($("#typeName").val() == undefined || $("#typeName").val().trim() == '') {
                window.location.href = '${pageContext.request.contextPath}/blog_toType?page=' + page + '&type=0';
            } else {
                var tempTypeName = $("#typeName").val();
                var tempTypeId = $("#typeId").val();
                window.location.href = '${pageContext.request.contextPath}/blog_toType?page=' + page + '&type=' + tempTypeId + "&typeName=" + tempTypeName;
            }
        } else {
            window.location.href = '${pageContext.request.contextPath}/blog_toType?page=' + page + '&type=' + typeId + "&typeName=" + typeName;
        }
    }
</script>
</html>
