<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="zh-cmn">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>发表文章</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addArticle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sumernote/summernote.css">
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/sumernote/summernote.js"></script>
    <script src="${pageContext.request.contextPath}/sumernote/lang/summernote-zh-CN.js"></script>
</head>
<body>
<form class="form-horizontal required-validate" id="addArticle"
      action="${pageContext.request.contextPath}/article_publishArticle"
      enctype="multipart/form-data" method="post">
    <div class="add-article-box" style="overflow-y:auto">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/img/pencil.jpg" style="width: 75px">
            <span style="font-size: 20px">发表文章</span>
        </div>
        <div class="add-article" style="overflow-y:auto">
            <div class="input-group col-md-12">
                <span class="input-group-addon">标题</span>
                <input type="hidden" name="id" value="${article.id}">
                <input type="hidden" name="draftId" id="draftId" value="${article.draftId}">
                <input type="text" class="pill-title form-control " name="title" id="title" value="${article.title}">
            </div>
            <div class="form-group">
                <div class="col-md-12">
                    <div id="summernote" class="summernote" name="summernote" placeholder="写下你的文章吧！"
                         action="${ctx}/file"></div>
                </div>
            </div>
            <input type="hidden" name="content" id="content" />
            <div class="form-inline">
                <div class="form-inline" style="margin-left: 5%">
                    <label for="selectForType">分类</label>
                    <select class="form-control" id="selectForType" style="width: 100px;margin-left: 5%" name="type.id">

                    </select>
                    <button class="form-control" type="button" style="margin-left: 5%" data-toggle="modal"
                            data-target="#myModal" onclick="setData()">添加分类
                    </button>
                </div>
            </div>
            <div class="input-group col-md-offset-4" style="margin-top: 5%">
                <c:if test="${flag == 1}">
                    <input type="button" class="btn btn-primary" onclick="return modifyArticle()" value="修改文章">
                </c:if>
                <c:if test="${flag != 1}">
                    <input type="button" class="btn btn-primary" onclick="return publishArticle()" value="发表文章">
                </c:if>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <input type="button" class="btn btn-warning" onclick="return publishDraft()" value="存为草稿">
            </div>
        </div>
    </div>
</form>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    增加类别
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" method="post" id="typeForm"
                      action="#">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">类别名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="typeName" placeholder="请输入分类名" name="name">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary" onclick="return addType()">
                    提交1
                </button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>

    $(document).ready(function () {
        $(".summernote").summernote({
            height: 450,
            lang: 'zh-CN',
            toolbar: [
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['fontsize', ['fontsize']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert', ['picture']]
            ],
            callbacks: {
                onImageUpload: function (files, editor, $editable) {
                    sendFile(files[0], editor, $editable);
                }
            }
        })
    })

    function sendFile(file, editor, $editable) {
        var filename = false;
        try {
            filename = file['name'];
            //alert('filename:' + filename)
        } catch (e) {
            filename = false;
        }
        if (!filename) {
            $(".note-alarm").remove();
        }

        data = new FormData();
        data.append("file", file);
        data.append("fileFileName", filename);
        $.ajax({
            data: data,
            type: "post",
            url: '${pageContext.request.contextPath}/article_fileUpload',
            cache: false,
            dataType: 'json',
            contentType: false,
            processData: false,
            success: function (url) {
                var path = url.path;
                console.log(path);
                $("#summernote").summernote('insertImage', path);
            },
            error: function () {
                alert("上传失败");
            }
        })
    }

    // 加载类别
    $(function () {
        $.ajax({
            type: "post",
            url: "${pageContext.request.contextPath}/type_getAlltype",
            success: function (data, status) {
                $.each($.parseJSON(data), function (index, item) {
                    $("#selectForType").append(  //此处向select中循环绑定数据
                        "<option value=" + item.id + ">" + item.name + "</option>");
                });
                var flag = ${flag};
                if (flag == 1) {
                    $("#selectForType").val(${article.type.id});
                }
            },
        });
    })

    //回显文章
    $(function () {
        var flag = ${flag};
        if (flag == 1 || flag == 2) {
            var content = '${article.content}';
            $('#summernote').summernote('code', content);
        }

    })

    function addType() {
        if ($("#typeName").val().trim() == "") {
            alert("种类不能为空")
            return false;
        }
        var data = $('#typeForm').serialize();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/type_addType',
            data: data,
            dataType: 'json',
            success: function (returndata) {
                $("#selectForType").append(  //此处向select中循环绑定数据
                    "<option value=" + returndata.id + ">" + returndata.name + "</option>");
                if (returndata == "fail") {
                    alert("添加失败。存在相同分类");
                }
            },
            error: function () {
                alert("添加失败，存在相同分类");
            }
        });
        $("#myModal").modal('hide');  //关闭模态框
    }

    function setData() {
        $("#typeName").val("");
    }

</script>

<script>

    function publishArticle() {
        var info = $("#summernote").summernote("code");
        if ($("#title").val().trim() == "") {
            alert("标题为空")
            return false;
        }
        $('#content').val(info);
        $('#addArticle').submit();
    }

    function modifyArticle() {
        var info = $("#summernote").summernote("code");
        $('#content').val(info);
        var data = $('#addArticle').serialize();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/article_updateArticle',
            data: data,
            dataType: 'json',
            success: function (returndata) {
                console.log(returndata);
                alert("修改成功！")

            },
            error: function () {
                alert("fail");
            }
        });
    }

    function publishDraft() {
        if ($("#title").val().trim() == "") {
            alert("标题为空")
            return false;
        }
        var info = $("#summernote").summernote("code");
        $('#content').val(info);
        //ajax异步保存为草稿
        var data = $('#addArticle').serialize();
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/draft_saveOrUpdate',
            data: data,
            dataType: 'json',
            success: function (returndata) {
                alert("保存成功！")
                console.log(returndata)
                if (returndata.state == 1) {
                    $("#draftId").val(returndata.draftId);
                }
            },
            error: function () {
                alert("fail");
            }
        });
    }
</script>
</body>
</html>