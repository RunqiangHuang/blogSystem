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
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">

                        <div class="alert alert-info">
                            <button type="button" class="close" data-dismiss="alert">×</button>
                            <h4>
                                --统计--!
                            </h4>
                            <p>共有<span class="badge" style="margin: 1%">${pageModel.totalRecords}</span>条留言</p>
                        </div>
                        <c:if test="${empty pageModel.list }">
                            <h3>暂时没有留言</h3>
                        </c:if>
                        <c:if test="${!empty pageModel.list }">
                        <table class="table table-striped table-hover" width="100%">
                            <thead>
                            <tr>
                                <th width="5%">
                                    编号
                                </th>
                                <th width="10%">
                                    留言者
                                </th>
                                <th width="10%">
                                    联系邮箱
                                </th>
                                <th width="50%">
                                    留言
                                </th>
                                <th width="10%">
                                    时间2
                                </th>
                                <th width="10%">
                                    操作
                                </th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageModel.list }" var="message" varStatus="status">
                                <tr>
                                    <td>
                                            ${status.index + 1}
                                    </td>
                                    <td>
                                            ${message.user.name}
                                    </td>
                                    <td>
                                            ${message.user.email}
                                    </td>
                                    <td>
                                            ${message.content}
                                    </td>
                                    <td>
                                            ${message.time}
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-danger btn-sm"
                                                onclick="deleteMessage( ${message.id})">
                                            <span class="glyphicon glyphicon-minus"></span> 删除
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        </c:if>
                        <nav aria-label="Page navigation" style="margin-left: 35%">
                            <ul class="pagination">
                                <li
                                        <c:if test="${pageModel.currentPageNum==pagenum}">
                                            class = "disabled"
                                        </c:if>
                                ><a href="${pageContext.request.contextPath}/message_getMessage?page=1">&laquo;</a>
                                </li>

                                <c:forEach begin="${pageModel.startPage}" end="${pageModel.endPage}" var="pagenum">
                                    <li
                                            <c:if test="${pageModel.currentPageNum==pagenum}">
                                                class = "active"
                                            </c:if>
                                    >
                                        <a href="${pageContext.request.contextPath}/message_getMessage?page=${pagenum}">${pagenum}</a>
                                    </li>

                                </c:forEach>

                                <li
                                        <c:if test="${pageModel.currentPageNum==totalPageNum}">
                                            class = "disabled"
                                        </c:if>
                                >
                                    <a href="${pageContext.request.contextPath}/message_getMessage?page=${pageModel.totalPageNum}">&raquo;</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>
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

    function deleteMessage(id) {
        if (window.confirm('确定要删除这条留言吗？')) {
            window.location.href = '${pageContext.request.contextPath}/message_deleteMessage?id=' + id;
            return true;
        } else {
            //alert("取消");
            return false;
        }
    }

    $(function () {
        $("#menu-personInfo").removeClass('layui-nav-itemed');
        $("#menu-info").removeClass('layui-nav-itemed');
        $("#menu-article").removeClass('layui-nav-itemed');
        $("#menu-messageAndComment").addClass('layui-nav-itemed');

        $("#menu-infoUpdate").removeClass('layui-this');
        $("#menu-changePassword").removeClass('layui-this');

        $("#menu-typeManage").removeClass('layui-this');

        $("#menu-articlePublish").removeClass('layui-this');
        $("#menu-draft").removeClass('layui-this');

        $("#menu-comment").removeClass('layui-this');
        $("#menu-message").addClass('layui-this');
    })
</script>
</body>
</html>