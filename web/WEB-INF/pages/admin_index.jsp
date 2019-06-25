<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>博客后台管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <%@ include file="/WEB-INF/pages/include/admin_header.jsp" %>
    <%@ include file="/WEB-INF/pages/include/admin_left.jsp"%>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">内容主体区域22</div>
    </div>

    <%@ include file="/WEB-INF/pages/include/admin_footer.jsp"%>

</div>
<script src="${pageContext.request.contextPath}/js/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use('element', function(){
        var element = layui.element;

    });
</script>
</body>
</html>