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

<form id="register-form" action="#" class="form-horizontal"
      method="post" name="userLogin">
    <div class="register-box" style="margin-top: 5%">
        <div class="row" style="text-align: center">
            <div class="col-md-6 col-md-offset-4" style="margin-top: 4%">
                <ul class="nav nav-pills">
                    <li role="presentation"><a href="${pageContext.request.contextPath}/blog_toLogin">登录</a></li>
                    <li role="presentation" class="active"><a href="${pageContext.request.contextPath}/blog_toRegister">注册</a></li>
                </ul>
            </div>
        </div>
        <div class="login">
            <span id="wrongTips1" style="color:red;"></span>
            <div class="input-group login-user">
                <span class="input-group-addon">账号</span>
                <input type="text" class="username form-control" id="account" name="account" onblur="checkAccount()">
            </div>
            <span id="wrongTips3" style="color:red;"></span>
            <div class="input-group login-user">
                <span class="input-group-addon">用户名</span>
                <input type="text" class="username form-control" id="username" name="name">
            </div>
            <span id="wrongTips4" style="color:red;"></span>
            <div class="input-group login-user">
                <span class="input-group-addon">邮箱</span>
                <input type="email" class="username form-control" id="email" name="email">
            </div>
            <div class="input-group login-user">
                <span class="input-group-addon">密码</span>
                <input type="password" class="password form-control" id="password" name="password">
            </div>

            <span id="wrongTips2" style="color:red;"></span>
            <div class="input-group login-sub">
                <span class="input-group-addon">再次输入密码</span>
                <input type="password" class="username form-control" id="passwordAgain" name="passwordAgain" onblur="checkSamePassword()">
            </div>
            <span class="tips" style="color:red;"></span>
            <span id="wrongTips" style="color:red;">${wrongTips }</span>
            <div class="input-group log-sub">
                <input type="button" class="submit btn btn-primary " value="注册" style="margin-top: 10%" id="registerBtn"
                       onclick="return registerSubmit()">
                <input type="reset" class="reset btn btn-danger " value="重置" style="margin-top: 10%">
            </div>

        </div>
    </div>
</form>
</body>

<script type="text/javascript">
    function registerSubmit() {
        if (!checkEmail()){
            return false;
        }
        if(!checkSamePassword()){
            return false;
        }
        if(!checkAccount()){
            return false;
        }
        if ($("#username").val().trim() == "") {
            $("#registerBtn").attr("disabled", true);
            $("#wrongTips3").html('用户名不能为空')
            return false;
        }else{
            $("#registerBtn").attr("disabled", false);
            $("#wrongTips3").html('')
        }
        var data = $('#register-form').serialize();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/user_register',
            data: data,
            dataType: 'json',
            success: function (returndata) {
                console.log(returndata);
                window.location.href = '${pageContext.request.contextPath}/blog_toLogin'
            },
            error: function () {
                alert("fail");
            }
        });
        return true;
    }

    function checkAccount() {
        var registerAccount = $("#account").val();
        $.post("${pageContext.request.contextPath}/user_checkUser", {account: registerAccount},
            function (data) {
                var obj = JSON.parse(data);
                console.log(obj)
                console.log(obj.status)
                if (obj.status == 0) {
                    $("#registerBtn").attr("disabled", true);
                    $("#wrongTips1").html('账号已存在')
                    return false;
                } else {
                    $("#registerBtn").attr("disabled", false);
                    $("#wrongTips1").html('')
                }
            });
        return true;
    }

    function checkEmail(){
        var email = $("#email").val();
        var pattern = /^[a-zA-Z0-9#_\^\$\.\*\+\-\?\=\!\:\|\\\/\(\)\[\]\{\}]+@[a-zA-Z0-9]+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
        if (email.length == 0) {
            $("#wrongTips4").html('注意邮箱格式')
            return false;
        } else if (!pattern.test(email)) {
            $("#wrongTips4").html('注意邮箱格式')
            return false;
        }
        $("#wrongTips4").html('')
        return true;
    }

    function checkSamePassword(){
        var p1 = $("#password").val();
        var p2 = $("#passwordAgain").val();
        if(p1 != p2){
            $("#registerBtn").attr("disabled", true);
            $("#wrongTips2").html('两次密码不一致')
            return false;
        }else{
            $("#registerBtn").attr("disabled", false);
            $("#wrongTips2").html('')
            return true;
        }
    }
</script>
</html>
