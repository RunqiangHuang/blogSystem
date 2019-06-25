<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css">
<script src="${pageContext.request.contextPath}/js/layui.js"></script>

<div class="layui-header">
    <div class="layui-logo">博客管理系统1</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-right">
        <li class="layui-nav-item">
            <a href="javascript:;">
                <img id="topHeadimg" src="${adminInfo.headImg}" class="layui-nav-img">
                ${adminInfo.name}
            </a>
            <dl class="layui-nav-child">
                <dd><a href="${pageContext.request.contextPath}/admin_toInfo">基本资料</a></dd>
                <dd><a href="">通知</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/admin_toLogout">退出</a></li>
    </ul>
</div>

