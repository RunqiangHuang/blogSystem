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
            href="#" class="n2">详情</a></h1>
    <div class="ab_box">
        <h3 class="news_title">${article.title}</h3>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <span class="glyphicon glyphicon-book" aria-hidden="true"></span>&nbsp;&nbsp;${article.clickNum}&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;<span class="glyphicon glyphicon-comment"
                                  aria-hidden="true"></span>&nbsp;&nbsp;${article.commentNum}&nbsp;
                &nbsp;&nbsp;<span class="glyphicon glyphicon-time"
                                  aria-hidden="true"></span>&nbsp;&nbsp;${article.publishTime}&nbsp;
            </div>
        </div>
        <hr>
        <p>
            ${article.content}&nbsp;&nbsp;&nbsp;
        </p>
        <hr>
        <h4>评论：</h4>
        <a href="#commentForm">
            <button class="btn btn-info" style="float:right;">发表评论</button>
        </a>
        <br>
        <br>
        <br>
        <c:if test="${empty article.comments}">
            暂时没有评论
            <br/>
            <br/>
        </c:if>
        <c:if test="${!empty article.comments}">
            <c:forEach var="comment" items="${article.comments}">
                <div class="row">
                    <div class="col-md-2" style="text-align: center;">
                        <img alt="140x140" src="${comment.user.headImg}" class="img-circle" height="50" width="50"
                             style="text-align: center;vertical-align: middle;margin-left: 35%"/>
                        <h6>
                                ${comment.user.name}
                        </h6>
                    </div>
                    <div class="col-md-10">
                        <p>
                                ${comment.content}
                        </p>
                        <p style="float: right;margin-top: 5%">
                            <em>${comment.time}</em>
                        </p>
                    </div>
                </div>
                <hr>
            </c:forEach>
        </c:if>
        <form id="commentForm" method="post" action="${pageContext.request.contextPath}/comment_makeComment">
            <c:if test="${empty user}">
                <textarea class="form-control" rows="3" placeholder="请先登录再进行评论" disabled="disabled"></textarea>
                <br/>
                <a href="${pageContext.request.contextPath}/blog_toLogin" target="_blank"><button type="button" class="btn btn-primary">登录后再刷新页面</button></a>
            </c:if>
            <c:if test="${!empty user}">
                <textarea class="form-control" rows="3" placeholder="请输入评论" name="content" id="content"></textarea>
                <input type="hidden" name="user.account" value="${user.account}">
                <input type="hidden" name="article.id" value="${article.id}">
                <br/>
                <button type="button" class="btn btn-primary" onclick="return makeComment()">提交</button>
            </c:if>
        </form>
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

    function makeComment() {
        if ($("#content").val().trim() == "") {
            alert("评论不能为空！")
            return false;
        }
        $("#commentForm").submit();
    }
</script>
</html>
