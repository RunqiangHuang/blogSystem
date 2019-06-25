<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>博客后台管理系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/infoManage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cropper.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ImgCropping.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/cropper.min.js"></script>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">

    <%@ include file="/WEB-INF/pages/include/admin_header.jsp" %>
    <%@ include file="/WEB-INF/pages/include/admin_left.jsp" %>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 30px;">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-xs-6" style="background: #EEEEEE;padding-top: 2%;height: 500px">
                        <h3>头像</h3>
                        <div style="width: 200px;height: 200px;border: solid 5px #ffffff;padding: 5px;margin-top: 70px;margin-left: 27%">
                            <img id="finalImg" src="${adminInfo.headImg}" width="100%">
                        </div>
                        <button id="replaceImg" class="l-btn"
                                style="margin-left: 35%;margin-top: 4%;margin-bottom: 10%">更换头像
                        </button>
                        <!--图片裁剪框 start-->
                        <div style="display: none" class="tailoring-container">
                            <div class="black-cloth" onclick="closeTailor(this)"></div>
                            <div class="tailoring-content">
                                <div class="tailoring-content-one">
                                    <label title="上传图片" for="chooseImg" class="l-btn choose-btn">
                                        <input type="file" accept="image/jpg,image/jpeg,image/png" name="file"
                                               id="chooseImg" class="hidden" onchange="selectImg(this)">
                                        选择图片
                                    </label>
                                    <div class="close-tailoring" onclick="closeTailor(this)">×</div>
                                </div>
                                <div class="tailoring-content-two">
                                    <div class="tailoring-box-parcel">
                                        <img id="tailoringImg">
                                    </div>
                                    <div class="preview-box-parcel">
                                        <p>图片预览：</p>
                                        <div class="square previewImg"></div>
                                        <div class="circular previewImg"></div>
                                    </div>
                                </div>
                                <div class="tailoring-content-three">
                                    <button class="l-btn cropper-reset-btn">复位</button>
                                    <button class="l-btn cropper-rotate-btn">旋转</button>
                                    <button class="l-btn cropper-scaleX-btn">换向</button>
                                    <button class="l-btn sureCut" id="sureCut">确定</button>
                                </div>
                            </div>
                        </div>
                        <!--图片裁剪框 end-->
                    </div>

                    <div class="col-xs-5 col-xs-offset-1" style="background: #EEEEEE;padding-top: 2%;height: 500px">
                        <h3>个人信息维护</h3>
                        <form class="form-horizontal" id="infoForm" style="margin-top: 2%">
                            <div class="control-group">
                                <label class="control-label">名字</label>
                                <div class="controls">
                                    <input id="inputName" type="input" name="name" value="${adminInfo.name}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">概述</label>
                                <div class="controls">
                                    <textarea class="form-control" rows="10" name="summary">${adminInfo.summary}</textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">邮箱</label>
                                <div class="controls">
                                    <input id="inputEmail" type="email" name="email" value="${adminInfo.email}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">联系方式</label>
                                <div class="controls">
                                    <input id="inputTel" type="text" name="tel" value="${adminInfo.tel}"/>
                                </div>
                            </div>
                            <div class="control-group" style="margin-top: 5%;margin-left: 40%">
                                <div>
                                    <button type="button" class="btn btn-info" onclick="return updateInfo()">修改</button>
                                </div>
                            </div>
                        </form>
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

    //弹出框水平垂直居中
    (window.onresize = function () {
        var win_height = $(window).height();
        var win_width = $(window).width();
        if (win_width <= 768) {
            $(".tailoring-content").css({
                "top": (win_height - $(".tailoring-content").outerHeight()) / 2,
                "left": 0
            });
        } else {
            $(".tailoring-content").css({
                "top": (win_height - $(".tailoring-content").outerHeight()) / 2,
                "left": (win_width - $(".tailoring-content").outerWidth()) / 2
            });
        }
    })();

    //弹出图片裁剪框
    $("#replaceImg").on("click", function () {
        $(".tailoring-container").toggle();
        var replaceSrc = $('#finalImg').attr("src")
        $('#tailoringImg').cropper('replace', replaceSrc, false);//默认false，适应高度，不失真
    });

    //图像上传
    function selectImg(file) {
        if (!file.files || !file.files[0]) {
            return;
        }
        var reader = new FileReader();
        reader.onload = function (evt) {
            var replaceSrc = evt.target.result;
            //更换cropper的图片
            $('#tailoringImg').cropper('replace', replaceSrc, false);//默认false，适应高度，不失真
        }
        reader.readAsDataURL(file.files[0]);
    }

    //cropper图片裁剪
    $('#tailoringImg').cropper({
        aspectRatio: 1 / 1,//默认比例
        preview: '.previewImg',//预览视图
        guides: false,  //裁剪框的虚线(九宫格)
        autoCropArea: 0.5,  //0-1之间的数值，定义自动剪裁区域的大小，默认0.8
        movable: false, //是否允许移动图片
        dragCrop: true,  //是否允许移除当前的剪裁框，并通过拖动来新建一个剪裁框区域
        movable: true,  //是否允许移动剪裁框
        resizable: true,  //是否允许改变裁剪框的大小
        zoomable: false,  //是否允许缩放图片大小
        mouseWheelZoom: false,  //是否允许通过鼠标滚轮来缩放图片
        touchDragZoom: true,  //是否允许通过触摸移动来缩放图片
        rotatable: true,  //是否允许旋转图片
        crop: function (e) {
            // 输出结果数据裁剪图像。
        }
    });
    //旋转
    $(".cropper-rotate-btn").on("click", function () {
        $('#tailoringImg').cropper("rotate", 45);
    });
    //复位
    $(".cropper-reset-btn").on("click", function () {
        $('#tailoringImg').cropper("reset");
    });
    //换向
    var flagX = true;
    $(".cropper-scaleX-btn").on("click", function () {
        if (flagX) {
            $('#tailoringImg').cropper("scaleX", -1);
            flagX = false;
        } else {
            $('#tailoringImg').cropper("scaleX", 1);
            flagX = true;
        }
        flagX != flagX;
    });

    //裁剪后的处理
    $("#sureCut").on("click", function () {
        if ($("#tailoringImg").attr("src") == null) {
            return false;
        } else {
            var cas = $('#tailoringImg').cropper('getCroppedCanvas');//获取被裁剪后的canvas
            var base64url = cas.toDataURL('image/png'); //转换为base64地址形式
            $("#finalImg").prop("src", base64url);//显示为图片的形式
            //上传
            uploadFile(encodeURIComponent(base64url))//编码后上传服务器
            //关闭裁剪框
            closeTailor();
        }
    });

    //关闭裁剪框
    function closeTailor() {
        $(".tailoring-container").toggle();
    }

    //上传
    function uploadFile(file) {
        $.ajax({
            url: '${pageContext.request.contextPath}/admin_changeHeadimg',
            type: 'POST',
            data: "headData=" + file,
            dataType: 'json',
            async: true,
            success: function (photo) {
                console.log(photo);
                var test = photo.path;
                $("#topHeadimg").attr("src",photo.path);
            },
            error: function (textStatus) {
                alert(textStatus);
            }
        });
    }
    
    function updateInfo() {
        //先判断邮件格式
        var pattern = /^[a-zA-Z0-9#_\^\$\.\*\+\-\?\=\!\:\|\\\/\(\)\[\]\{\}]+@[a-zA-Z0-9]+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/;
        var email = $("#inputEmail").val();
        if(!pattern.test(email)){
            alert('邮箱格式不正确！修改失败');
            return false;
        }
        var data = $('#infoForm').serialize();
        $.ajax({
            type:'POST',
            url:'${pageContext.request.contextPath}/admin_changeInfo',
            data:data,
            dataType:'json',
            success: function(returndata){
                alert("修改成功")
            },
            error:function () {
                alert("修改失败")
            }
        });
    }

    $(function () {
        $("#menu-personInfo").addClass('layui-nav-itemed');
        $("#menu-info").removeClass('layui-nav-itemed');
        $("#menu-article").removeClass('layui-nav-itemed');
        $("#menu-messageAndComment").removeClass('layui-nav-itemed');

        $("#menu-infoUpdate").addClass('layui-this');
        $("#menu-changePassword").removeClass('layui-this');

        $("#menu-typeManage").removeClass('layui-this');

        $("#menu-articlePublish").removeClass('layui-this');
        $("#menu-draft").removeClass('layui-this');

        $("#menu-comment").removeClass('layui-this');
        $("#menu-message").removeClass('layui-this');
    })

</script>
</body>
</html>