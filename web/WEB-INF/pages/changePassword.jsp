<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
            <div style="margin-left: 30%;height: 500px;width: 500px;background: #F7F7F7;padding: 5%">
                <form id="changePasswordForm">
                    <div class="form-group">
                        <label for="oldPassword">原始密码</label>
                        <input type="hidden" name="login.account" value="admin">
                        <input type="password" class="form-control" id="oldPassword" placeholder="原始密码" name = "login.password">
                        <span id="tip1" style="color: #F00;"></span>
                    </div>
                    <div class="form-group">
                        <label for="password">新密码</label>
                        <input type="password" class="form-control" id="password" placeholder="新密码">
                    </div>
                    <div class="form-group">
                        <label for="passwordAgain">再次输入新密码</label>
                        <input type="password" class="form-control" id="passwordAgain" placeholder="再次输入新密码" name = "newPassword"
                               onblur="checkPasswordSame()">
                        <span id="tip2" style="color: #F00;"></span>
                    </div>
                    <button type="button" class="btn btn-default" onclick="return changePassword()">修改</button>
                </form>
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

    function checkPasswordSame() {
        var p1 = $("#password").val();
        var p2 = $("#passwordAgain").val();
        if (p1 != p2) {
            $("#tip2").html('两次密码输入不一致！');
            return false;
        }
        $("#tip2").html('');
        return true;
    }

    function checkCondition() {
        if ($("#oldPassword").val().trim() == "") {
            alert("原始密码不能为空")
            return false;
        }
        if (!checkPasswordSame()) {
            alert("两次密码输入不一致！");
            return false;
        }
        return true;
    }

    
    function changePassword() {
        if(!checkCondition()){
            return false;
        }
        var data = $('#changePasswordForm').serialize();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/admin_changePassword',
            data: data,
            dataType: 'json',
            success: function (returndata) {
                console.log(returndata);
                if(returndata.state == 1){
                    alert("修改成功")
                }else{
                    alert("原始密码错误")
                }
            },
            error: function () {
                alert("fail");
            }
        });
    }

    $(function () {
        $("#menu-personInfo").addClass('layui-nav-itemed');
        $("#menu-info").removeClass('layui-nav-itemed');
        $("#menu-article").removeClass('layui-nav-itemed');
        $("#menu-messageAndComment").removeClass('layui-nav-itemed');

        $("#menu-infoUpdate").removeClass('layui-this');
        $("#menu-changePassword").addClass('layui-this');

        $("#menu-typeManage").removeClass('layui-this');

        $("#menu-articlePublish").removeClass('layui-this');
        $("#menu-draft").removeClass('layui-this');

        $("#menu-comment").removeClass('layui-this');
        $("#menu-message").removeClass('layui-this');
    })
</script>
</body>
</html>