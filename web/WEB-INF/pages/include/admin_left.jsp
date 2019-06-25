<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item layui-nav-itemed" id="menu-personInfo">
                <a  href="#;">个人信息维护</a>
                <dl class="layui-nav-child">
                    <dd id="menu-infoUpdate"><a href="${pageContext.request.contextPath}/admin_toInfo;">&nbsp;&nbsp;查看/修改个人信息</a></dd>
                    <dd id="menu-changePassword"><a href="${pageContext.request.contextPath}/admin_toChangePassword;">&nbsp;&nbsp;修改密码</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" id="menu-info">
                <a href="#;">信息管理</a>
                <dl class="layui-nav-child">
                    <dd id="menu-typeManage"><a href="${pageContext.request.contextPath}/type_toTypeManage;">&nbsp;&nbsp;分类管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" id="menu-article">
                <a href="javascript:;">文章管理</a>
                <dl class="layui-nav-child">
                    <dd id="menu-articlePublish"><a href="${pageContext.request.contextPath}/article_toArticleManage;">&nbsp;&nbsp;发表的文章</a></dd>
                    <dd id="menu-draft"><a href="${pageContext.request.contextPath}/draft_list">&nbsp;&nbsp;草稿</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item" id="menu-messageAndComment">
                <a href="#">评论、留言管理</a>
                <dl class="layui-nav-child">
                    <dd id="menu-comment"><a href="${pageContext.request.contextPath}/comment_toCommentManage;">&nbsp;&nbsp;评论</a></dd>
                    <dd id="menu-message"><a href="${pageContext.request.contextPath}/message_getMessage;">&nbsp;&nbsp;留言</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>