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
            href="${pageContext.request.contextPath}/blog_toMessage" class="n2">留言</a></h1>
    <div class="ab_box">
        <a href="#messageForm">
            <button class="btn btn-danger">发表留言</button>
        </a>
        <br><br><br><br>
        <c:forEach items="${pageModel.list }" var="message">
            <div class="row">
                <div class="col-md-2" style="text-align: center;">
                    <img alt="140x140" src="${message.user.headImg}" class="img-circle" height="50" width="50"
                         style="text-align: center;vertical-align: middle;margin-left: 35%"/>
                    <h6>
                            ${message.user.name}
                    </h6>
                </div>
                <div class="col-md-10">
                    <p>
                            ${message.content}
                    </p>
                    <p style="float: right;">
                        <em>${message.time}</em>
                    </p>
                </div>
            </div>
            <hr>
        </c:forEach>

        <nav aria-label="Page navigation" style="margin-left: 35%">
            <ul class="pagination">
                <li
                        <c:if test="${pageModel.currentPageNum==pagenum}">
                            class = "disabled"
                        </c:if>
                ><a href="${pageContext.request.contextPath}/blog_toMessage?page=1">&laquo;</a>
                </li>

                <c:forEach begin="${pageModel.startPage}" end="${pageModel.endPage}" var="pagenum">
                    <li
                            <c:if test="${pageModel.currentPageNum==pagenum}">
                                class = "active"
                            </c:if>
                    >
                        <a href="${pageContext.request.contextPath}/blog_toMessage?page=${pagenum}">${pagenum}</a>
                    </li>

                </c:forEach>

                <li
                        <c:if test="${pageModel.currentPageNum==totalPageNum}">
                            class = "disabled"
                        </c:if>
                >
                    <a href="${pageContext.request.contextPath}/blog_toMessage?page=${pageModel.totalPageNum}">&raquo;</a>
                </li>
            </ul>
        </nav>

        <form id="messageForm" action="${pageContext.request.contextPath}/message_makeMessage" method="post">
            <c:if test="${empty user}">
                <textarea class="form-control" rows="3" placeholder="请先登录再留言" disabled="disabled"></textarea>
                <br/>
                <a href="${pageContext.request.contextPath}/blog_toLogin" target="_blank"><button type="button" class="btn btn-primary">登录后再刷新页面</button></a>
            </c:if>
            <c:if test="${!empty user}">
                <textarea class="form-control" rows="3" placeholder="请输入留言信息" name="content" id="content"></textarea>
                <input type="hidden" name="user.account" value="${user.account}">
                <br/>
                <button type="button" class="btn btn-primary" onclick="return makeMessage()">留言</button>
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
        $("#message").addClass('currentNav')
        $("#about").removeClass('currentNav')
    })

    function makeMessage() {
        if ($("#content").val().trim() == "") {
            alert("留言不能为空！")
            return false;
        }
        $("#messageForm").submit();
    }
</script>
</html>
