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

    <div class="layui-body" style="position:absolute; height:80%; overflow:auto">
        <!-- 内容主体区域 -->
        <div style="padding: 30px;">
            <div class="container-fluid">
                <div class="row-fluid">
                    <div class="span12">
                        <div class="row-fluid">
                            <div class="span6">
                                <form class="form-search" method="post"
                                      action="${pageContext.request.contextPath}/type_findByKeyword">
                                    <input class="input-medium search-query" type="text" placeholder="请输入分类名"
                                           value="${keyword}" name="keyword"/>
                                    <button type="submit" class="btn"><span class="glyphicon glyphicon-search"></span>
                                        查找
                                    </button>
                                    <button class="btn btn-primary" type="button" style="float: right;margin-right: 10%"
                                            data-toggle="modal" data-target="#myModal" onclick="setInfo('','')"><span
                                            class="glyphicon glyphicon-plus"></span> 增加分类
                                    </button>
                                </form>
                            </div>
                        </div>
                        <p class="table-striped">
                        </p>
                        <c:if test="${empty typeList}">
                            还没有分类！
                        </c:if>
                        <c:if test="${!empty typeList}">
                            <table class="table table-hover table-striped" style="margin-top: 2%">
                                <thead>
                                <tr>
                                    <th>
                                        编号
                                    </th>
                                    <th>
                                        分类名
                                    </th>
                                    <th>
                                        操作
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${typeList}" var="type" varStatus="status">
                                    <tr>
                                        <td>
                                                ${status.index + 1}
                                        </td>
                                        <td>
                                                ${type.name}
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal"
                                                    data-target="#myModal" onclick="setInfo(${type.id},'${type.name}')">
                                                <span class="glyphicon glyphicon-pencil"></span> 修改
                                            </button>
                                            <button type="button" class="btn btn-danger btn-sm"
                                                    onclick="deleteType(${type.id},'${type.name}')">
                                                <span class="glyphicon glyphicon-minus"></span> 删除
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/pages/include/admin_footer.jsp" %>

</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    增加或修改类别
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post" id="typeForm"
                      action="${pageContext.request.contextPath}/type_saveOrUpdateType">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">类别名</label>
                        <div class="col-sm-10">
                            <input type="hidden" id="typeId" name="id">
                            <input type="text" class="form-control" id="typeName" placeholder="请输入分类名" name="name">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="return sumbmitForm()">
                    提交更改
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<script src="${pageContext.request.contextPath}/js/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function () {
        var element = layui.element;

    });

    function deleteType(id, temp) {
        if (window.confirm('确定要删除 ' + temp + " 吗？")) {
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/type_deleteType?id=' + id,
                dataType: 'json',
                success: function (returndata) {
                    if (returndata.state == '1') {
                        window.location.reload()
                    } else {
                        alert("删除失败。该分类有其他文章")
                    }
                    console.log(returndata)
                },
                error: function () {
                    alert("fail");
                }
            });
            return true;
        } else {
            //alert("取消");
            return false;
        }
    }

    function setInfo(id, name) {
        $("#typeId").val(id);
        $("#typeName").val(name);
    }

    function sumbmitForm() {
        if ($("#typeName").val().trim() == "") {
            alert("种类不能为空")
            return false;
        }
        $("#typeForm").submit();
    }

    $(function () {
        $("#menu-personInfo").removeClass('layui-nav-itemed');
        $("#menu-info").addClass('layui-nav-itemed');
        $("#menu-article").removeClass('layui-nav-itemed');
        $("#menu-messageAndComment").removeClass('layui-nav-itemed');

        $("#menu-infoUpdate").removeClass('layui-this');
        $("#menu-changePassword").removeClass('layui-this');

        $("#menu-typeManage").addClass('layui-this');

        $("#menu-articlePublish").removeClass('layui-this');
        $("#menu-draft").removeClass('layui-this');

        $("#menu-comment").removeClass('layui-this');
        $("#menu-message").removeClass('layui-this');
    })
</script>
</body>
</html>