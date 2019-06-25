<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>登录界面</title>
</head>

<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/bootstrap.css">
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/login.css">

<body>

<form id="login-form" action="${pageContext.request.contextPath }/loginAction" class="form-horizontal"
      method="post" name="userLogin">
    <div class="login-box" style="margin-top: 10%">
        <div class="row" style="text-align: center">
            <div class="col-md-6 col-md-offset-4" style="margin-top: 4%">
                <ul class="nav nav-pills">
                    <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/blog_toLogin">登录</a></li>
                    <li role="presentation"><a href="${pageContext.request.contextPath}/blog_toRegister">注册</a></li>
                </ul>
            </div>
        </div>
        <div class="login">
            <div class="input-group login-user">
                <span class="input-group-addon">账号</span>
                <input type="text" class="username form-control" id="account" name="account">
            </div>
            <div class="input-group login-pwd">
                <span class="input-group-addon">密码</span>
                <input type="password" class="password form-control" id="password" name="password">
            </div>
            <span class="tips" style="color:red;"></span>
            <span id="wrongTips" style="color:red;">${msg }</span>
            <div class="input-group log-sub">
                <input type="submit" class="submit btn btn-primary " value="登录" style="margin-top: 10%"
                       onclick="return checkNull()">
                <input type="reset" class="reset btn btn-danger " value="重置" style="margin-top: 10%">
            </div>

        </div>
    </div>
</form>
</body>

<script type="text/javascript">
    function checkNull() {
        if ($("#account").val().trim() == "" || $("#password").val().trim() == "") {
            alert("账号或密码不能为空！")
            return false;
        }
    }
</script>
</html>
