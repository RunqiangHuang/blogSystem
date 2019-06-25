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
            <div style="height: 215px;background: #f9f9f9">
                <div style="padding:2%">
                    <a href="${pageContext.request.contextPath}/article_toSaveOrUpdateArticle" target="_blank">
                        <button type="button" class="btn btn-primary" style="margin-bottom: 2%">发表文章</button>
                    </a>
                    <p style="margin-bottom: 1%">请选择筛选</p>
                    <form class="form-inline" action="${pageContext.request.contextPath}/article_toArticleManage"
                          method="post">
                        <div class="form-group">
                            <label for="selectForYear">年</label>
                            <select class="form-control" id="selectForYear" name="articleSearch.year">
                                <option value="不限">不限</option>
                                <c:forEach items="${timeList}" var="time">
                                    <option value="${time}">${time}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group" style="margin-left: 2%">
                            <label for="selectForMonth">月</label>
                            <select class="form-control" id="selectForMonth" name="articleSearch.month">
                                <option value="不限">不限</option>
                                <option value="01">1</option>
                                <option value="02">2</option>
                                <option value="03">3</option>
                                <option value="04">4</option>
                                <option value="05">5</option>
                                <option value="06">6</option>
                                <option value="07">7</option>
                                <option value="08">8</option>
                                <option value="09">9</option>
                                <option value="10">10</option>
                                <option value="11">11</option>
                                <option value="12">12</option>
                            </select>
                        </div>
                        <div class="form-group" style="margin-left: 5%">
                            <label for="selectForType">类别</label>
                            <select class="form-control" id="selectForType" name="articleSearch.typeId">
                                <option value="-1">不限</option>
                                <c:forEach var="type" items="${types}">
                                    <option value="${type.id}">${type.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group" style="margin-left: 5%">
                            <label for="keyword">标题关键字</label>
                            <input type="text" style="width: 320px" class="form-control" id="keyword"
                                   placeholder="标题关键字" name="articleSearch.keyword">
                        </div>
                        <button type="submit" class="btn btn-default" style="margin-left: 2%">搜索</button>
                    </form>
                </div>
            </div>

            <div style="margin-top: 2%">
                <!-- Stack the columns on mobile by making one full-width and the other half-width -->
                <c:if test="${empty pageModel.list}">
                    <h3>没有符合要求的文章</h3>
                </c:if>
                <c:if test="${!empty pageModel.list}">
                    <c:forEach items="${pageModel.list}" var="article">
                        <div class="row">
                            <div class="col-xs-18 col-md-12">.
                                <a href="${pageContext.request.contextPath}/blog_toArticle?articleId=${article.id}&flag=2" target="_blank">
                                    <h2>${article.title}</h2></a>
                            </div>
                        </div>
                        <br/>
                        <div class="row">
                            <div class="col-xs-4 col-md-2">
                                    ${article.type.name}
                            </div>
                            <div class="col-xs-7 col-md-5"><span class="glyphicon glyphicon-time"
                                                                 aria-hidden="true"></span>
                                    ${article.publishTime}&nbsp;&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-book"
                                                                                        aria-hidden="true"></span>&nbsp;${article.clickNum}&nbsp;&nbsp;&nbsp;&nbsp;
                                <span class="glyphicon glyphicon-comment"
                                      aria-hidden="true"></span>&nbsp;${article.commentNum}&nbsp;&nbsp;
                            </div>
                            <div class="col-xs-7 col-md-5" style="padding-left: 30%">
                                <a href="${pageContext.request.contextPath}/article_toSaveOrUpdateArticle?id=${article.id}&flag=2"
                                   target="_blank">修改</a>
                                <a href="#" onclick="deleteArticle(${article.id})">删除</a>
                            </div>
                        </div>
                        <hr style="margin-top: 1%"/>
                    </c:forEach>
                </c:if>
            </div>

            <!-- 分页区域 -->
            <c:if test="${flag == '1'}">
                <nav aria-label="Page navigation" style="margin-left: 35%">
                    <ul class="pagination">
                        <li
                                <c:if test="${pageModel.currentPageNum==pagenum}">
                                    class = "disabled"
                                </c:if>
                        ><a href="${pageContext.request.contextPath}/article_toArticleManage?page=1">&laquo;</a>
                        </li>

                        <c:forEach begin="${pageModel.startPage}" end="${pageModel.endPage}" var="pagenum">
                            <li
                                    <c:if test="${pageModel.currentPageNum==pagenum}">
                                        class = "active"
                                    </c:if>
                            >
                                <a href="${pageContext.request.contextPath}/article_toArticleManage?page=${pagenum}">${pagenum}</a>
                            </li>

                        </c:forEach>

                        <li
                                <c:if test="${pageModel.currentPageNum==totalPageNum}">
                                    class = "disabled"
                                </c:if>
                        >
                            <a href="${pageContext.request.contextPath}/article_toArticleManage?page=${pageModel.totalPageNum}">&raquo;</a>
                        </li>
                    </ul>
                </nav>
            </c:if>
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

    $(function () {
        //为条件重新赋值
        if ('${search.year}') {
            $("#selectForYear").val('${search.year}')
            $("#selectForMonth").val('${search.month}')
            $("#selectForType").val(${search.typeId})
            $("#keyword").val('${search.keyword}')
        }
    })

    function deleteArticle(id) {
        if (window.confirm('确定要删除这篇文章吗')) {
            window.location.href = '${pageContext.request.contextPath}/article_deleteArticle?id=' + id;
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

         $("#menu-articlePublish").addClass('layui-this');
         $("#menu-draft").removeClass('layui-this');

         $("#menu-comment").removeClass('layui-this');
         $("#menu-message").removeClass('layui-this');
    })
</script>
</body>
</html>