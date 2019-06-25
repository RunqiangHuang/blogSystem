<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>博客后台管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <%@ include file="/WEB-INF/pages/include/admin_header.jsp" %>
    <%@ include file="/WEB-INF/pages/include/admin_left.jsp" %>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 30px;">

            <div style="margin-top: 2%">
                <div class="alert alert-info" role="alert">草稿箱</div>
                <c:if test="${empty drafts}">
                    <h3>还没有草稿</h3>！
                </c:if>
                <c:if test="${!empty drafts}">
                    <c:forEach items="${drafts}" var="draft">
                        <div class="row">
                            <div class="col-xs-18 col-md-12">.
                                <a href="${pageContext.request.contextPath}/draft_draftContent?id=${draft.draftId}" target="_blank">
                                    <h2>${draft.title}</h2>
                                </a>
                            </div>
                        </div>
                        <br/>
                        <div class="row">
                            <div class="col-xs-9 col-md-6">
                                &nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-time"
                                                              aria-hidden="true"></span>
                                    ${draft.time}&nbsp;&nbsp;&nbsp;
                            </div>
                            <div class="col-xs-9 col-md-6" style="padding-left: 30%">
                                <a href="#" onclick="deleteDraft(${draft.draftId})">删除</a>
                            </div>
                        </div>
                        <hr style="margin-top: 1%"/>
                    </c:forEach>
                </c:if>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/pages/include/admin_footer.jsp" %>

</div>


<script src="${pageContext.request.contextPath}/js/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;

    });

    function deleteDraft(articleId) {
        if (window.confirm('确定要删除这篇草稿吗')) {
            window.location.href = '${pageContext.request.contextPath}/draft_deleteDraft?id=' + articleId;
            return true;
        } else {
            //alert("取消");
            return false;
        }
    }

    $(function () {
        $("#menu-personInfo").removeClass('layui-nav-itemed');
        $("#menu-info").removeClass('layui-nav-itemed');
        $("#menu-article").addClass('layui-nav-itemed');
        $("#menu-messageAndComment").removeClass('layui-nav-itemed');

        $("#menu-infoUpdate").removeClass('layui-this');
        $("#menu-changePassword").removeClass('layui-this');

        $("#menu-typeManage").removeClass('layui-this');

        $("#menu-articlePublish").removeClass('layui-this');
        $("#menu-draft").addClass('layui-this');

        $("#menu-comment").removeClass('layui-this');
        $("#menu-message").removeClass('layui-this');
    })
</script>
</body>
</html>