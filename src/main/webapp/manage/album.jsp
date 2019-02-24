<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<html>
<head>
    <title>Title</title>
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../themes/icon.css">
    <script type="text/javascript">
        var toolbar = [{
            text: "专辑详情",
            iconCls: 'icon-tip',
            handler: function () {
                var row = $("#tt").datagrid("getSelected");
                if (row == null || row.score == null) {
                    alert("请选要查看的专辑！");
                } else {
                    $("#albumDialog").dialog("open");
                    $("#album_ff").form("load", row);
                    $("#coverlmg").prop("src", "${pageContext.request.contextPath}/img/audioCollection/" + row.coverlmg);
                }

            }
        }, '-', {
            text: "添加专辑",
            iconCls: 'icon-add',
            handler: function () {
                $("#addAlbumDialog").dialog("open");
            }
        }, '-', {
            text: "添加章节",
            iconCls: 'icon-add',
            handler: function () {
                /*获取选中行*/
                var row = $("#tt").treegrid("getSelected");
                if (row == null || row.score == null) {
                    alert("请先选择专辑！");
                } else {
                    $("#addChapterDialog").dialog("open");
                    $("[name=album_id]").val(row.id);
                }
            }
        }, '-', {
            text: "下载音频",
            iconCls: 'icon-undo',
            handler: function () {
                var row = $("#tt").treegrid("getSelected");
                if (row != null) {
                    if (row.size != null) {
                        location.href = "${pageContext.request.contextPath}/chapter/download?downPath=" + row.downPath + "&title=" + row.title
                    }
                }
            }
        }];
        $(function () {
            $('#tt').treegrid({
                url: "${pageContext.request.contextPath}/album/getAll.do",
                idField: "id",
                treeField: "title",
                toolbar: toolbar,
                columns: [[
                    {field: 'title', title: '名称', width: 60},
                    {field: 'downPath', title: '下载路径', width: 180},
                    {field: 'size', title: '章节大小', width: 60, align: 'right'},
                    {field: 'duration', title: '播放时长', width: 80},
                    {field: 'uploadDate', title: '上传时间', width: 80}
                ]],
                fit: true,
                fitColumns: true,
                pagination: true,
                onDblClickRow: function (row) {
                    $("#audio").dialog("open")
                    $("#audio_id").prop("src", "${pageContext.request.contextPath}/upload/" + row.downPath)
                },
            });

            $("#albumDialog").dialog({
                title: "专辑详情",
                closed: true,
                minimized: true,
            });

            $("#addChapterDialog").dialog({
                title: "添加章节",
                closed: true,
                minimized: true,
                buttons: [{
                    text: '保存',
                    handler: function () {
                        addChapter();
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#addChapterDialog").dialog("close");
                    }
                }],

            });

            $('#audio').dialog({
                title: '播放',
                width: 400,
                height: 200,
                closed: true,
            });

            $("#addAlbumDialog").dialog({
                title: "添加",
                closed: true,
                minimized: true,
                buttons: [{
                    text: '保存',
                    handler: function () {
                        addAlbum();
                    }
                }, {
                    text: '关闭',
                    handler: function () {
                        $("#addAlbumDialog").dialog("close");
                    }
                }],
            });

            // 文件上传(文件域)的改变事件
            $("#fengmian").change(function (event) {
                //  HTML5 js 对象的获取
                var files = event.target.files, file;
                if (files && files.length > 0) {
                    // 获取目前上传的文件
                    file = files[0];
                    // 文件的限定类型什么的道理是一样的
                    if (file.size > 1024 * 1024 * 2) {
                        alert('图片大小不能超过 2MB!');
                        return false;
                    }
                    // file对象生成可用的图片
                    var URL = window.URL || window.webkitURL;
                    // 通过 file 生成目标 url
                    var imgURL = URL.createObjectURL(file);
                    // 用这个 URL 产生一个 <img> 将其显示出来
                    $("#image").prop('src', imgURL);
                }
            });


        })

        function addChapter() {
            $("#chapter_ff").form("submit", {
                url: "${pageContext.request.contextPath}/chapter/insert.do",
                success: function (data) {
                    data = JSON.parse(data);
                    alert(data);
                    if (data) {
                        $("#addChapterDialog").dialog("close");
                        $("#tt").treegrid("reload");
                    } else {
                        alert("添加失败，请重新添加");
                    }
                }

            });
        }

        function addAlbum() {
            $("#addAlbumForm").form("submit", {
                url: "${pageContext.request.contextPath}/album/insert.do",
                success: function (data) {
                    data = JSON.parse(data);
                    if (data) {
                        $("#addAlbumDialog").dialog("close");
                        $("#tt").treegrid("reload");
                    } else {
                        alert("添加失败，请重新添加");
                    }
                }

            });

        }
    </script>
</head>
<body>
<table id="tt"></table>
<div id="albumDialog">
    <form id="album_ff" method="post">
        <div>
            专题名称：<input type="text" name="title" data-options="required:true"/>
        </div>
        <div>
            作 者：<input type="text" name="author" data-options="required:true"/>
        </div>
        <div>
            评 分：<input type="text" name="score" data-options="required:true"/>
        </div>
        <div>
            播 音：<input type="text" name="broadCast" data-options="required:true"/>
        </div>
        <div>
            简 介：<input type="text" name="brief" data-options="required:true"/>
        </div>
        <img src="" id="coverlmg" width="80" height="80">
    </form>
</div>
<div id="addChapterDialog">
    <form id="chapter_ff" method="post" enctype="multipart/form-data">
        <input type="text" name="album_id" value="" data-options="required:true"/>
        <div>
            章节名称：<input type="text" name="title" data-options="required:true"/>
        </div>
        <div>
            上传音频：<input type="file" name="multipartFile" data-options="required:true"/>
        </div>
    </form>
</div>
<div id="audio">
    <audio id="audio_id" src="" autoplay="autoplay" controls="controls" loop="loop">
    </audio>
</div>

<div id="addAlbumDialog">
    <form id="addAlbumForm" method="post" enctype="multipart/form-data">
        <div>
            专题名称：<input type="text" name="title" data-options="required:true"/>
        </div>
        <div>
            专题封面：<input name="multipartFile" type="file" id="fengmian"/>
            <img src="" width="100" height="100" id="image"/>

        </div>
        <div>
            章节数量：<input type="text" name="count" data-options="required:true"/>
        </div>
        <div>
            评 分：<input type="text" name="score" data-options="required:true"/>
        </div>
        <div>
            作 者：<input type="text" name="author" data-options="required:true"/>
        </div>
        <div>
            播 音：<input type="text" name="broadCast" data-options="required:true"/>
        </div>
        <div>
            简 介：<input type="text" name="brief" data-options="required:true"/>
        </div>
    </form>
</div>
</body>
</html>
