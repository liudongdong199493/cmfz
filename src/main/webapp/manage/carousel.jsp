<%@page isELIgnored="false" pageEncoding="UTF-8" contentType="text/html; UTF-8" language="java" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>持名法州后台管理中心</title>

    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/datagrid-detailview.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.edatagrid.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../themes/icon.css">

    <script type="text/javascript">
        $(function () {
            var toolbar = [{
                title: "添加",
                iconCls: 'icon-add',
                handler: function () {
                    $("#addCarousel").dialog("open");
                }
            }, '-', {
                title: "删除",
                iconCls: 'icon-remove',
                handler: function () {
                    var row = $("#dg").edatagrid("getSelected");
                    //alert(row.carousel_id);
                    toDelete(row.carousel_id);
                }
            }, '-', {
                title: "编辑",
                iconCls: 'icon-edit',
                handler: function () {
                    /*获取选中行*/
                    var row = $("#dg").edatagrid("getSelected")
                    if (row == null) {
                        $.messager.show({
                            title: '警告',
                            msg: '请选中修改行。',
                            showType: 'show',
                            style: {
                                right: '',
                                top: document.body.scrollTop + document.documentElement.scrollTop,
                                bottom: ''
                            }
                        });
                    } else {
                        /*将当前行变成可编辑模式*/
                        var index = $("#dg").edatagrid("getRowIndex", row);
                        $("#dg").edatagrid("editRow", index);
                    }
                }
            }, '-', {
                title: "保存",
                iconCls: 'icon-save',
                handler: function () {
                    $("#dg").edatagrid("saveRow");
                }
            }];

            $('#dg').edatagrid({
                updateUrl: "${pageContext.request.contextPath}/carousel/update.do",
                url: "${pageContext.request.contextPath}/carousel/getAll.do",
                fit: true,
                fitColumns: true,
                pagination: true,
                singleSelect: true,
                toolbar: toolbar,
                pageSize: 3,
                pageList: [3, 6, 9],
                columns: [[
                    {field: 'carousel_id', width: 100, hidden: true},
                    {field: 'carousel_title', title: '标题', width: 100},
                    {field: 'carousel_imgPath', title: '图片路径', width: 100},
                    {field: 'carousel_desc', title: '描述', width: 100},
                    {
                        field: 'carousel_status', title: '状态', width: 100, editor: {
                            type: 'text',
                            options: {required: true}
                        }
                    },
                    {
                        field: 'carousel_date', title: '时间', width: 100, formatter: function (value, row, index) {
                            return formatDatebox(value);
                        }
                    }
                ]],
                view: detailview,
                detailFormatter: function (rowIndex, rowData) {
                    var data = formatDatebox(rowData.carousel_date);
                    return '<table><tr>' +
                        '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}' + rowData.carousel_imgPath + '" style="height:100px;"></td>' +
                        '<td style="border:0">' +
                        '<p>标题:' + rowData.carousel_title + '</p>' +
                        '<p>描述: ' + rowData.carousel_desc + '</p>' +
                        '<p>状态: ' + rowData.carousel_status + '</p>' +
                        '<p>时间: ' + data + '</p>' +
                        '</td>' +
                        '</tr></table>';
                }
            });

            /* 创建添加添加对话框 */
            $("#addCarousel").dialog({
                title: "添加轮播图",
                width: 600,
                height: 400,
                closed: true,
                minimized: true,
            });
            // 文件上传(文件域)的改变事件
            $(':file').change(function (event) {
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

        function formatDatebox(value) {
            var date = new Date(value);
            var year = date.getFullYear().toString();
            var month = (date.getMonth() + 1);
            var day = date.getDate().toString();
            var hour = date.getHours().toString();
            var minutes = date.getMinutes().toString();
            var seconds = date.getSeconds().toString();
            if (month < 10) {
                month = "0" + month;
            }
            if (day < 10) {
                day = "0" + day;
            }
            if (hour < 10) {
                hour = "0" + hour;
            }
            if (minutes < 10) {
                minutes = "0" + minutes;
            }
            if (seconds < 10) {
                seconds = "0" + seconds;
            }
            return year + "-" + month + "-" + day + " " + hour + ":" + minutes + ":" + seconds;
        }

        //删除
        function toDelete(id) {
            //发送ajax请求，删除数据
            $.ajax({
                url: "${pageContext.request.contextPath}/carousel/delete.do",
                //data:"ids="+ids,
                data: {"id": id},
                traditional: true,//以传统格式解析
                dataType: "json",
                success: function (data) {
                    //alert(data);
                    if (data) {
                        $.messager.alert("提示框", "删除成功！", "info");
                        $("#dg").edatagrid("reload");
                    } else {
                        //alert("删除失败");
                        $.messager.alert("提示框", "删除失败！", "warning");
                    }
                },
            });
        }

        //添加数据

        /* 使用form组件添加数据 */
        function addData() {
            $("#addCarouselForm").form("submit", {
                url: "${pageContext.request.contextPath}/carousel/insert.do",
                onSubmit: function () {
                    return true;
                },
                success: function (data) {
                    data = JSON.parse(data);
                    alert(data);
                    if (data) {
                        $("#addCarousel").dialog("close");
                        $("#dg").edatagrid("reload");
                    } else {
                        alert("添加失败，请重新添加");
                    }
                }
            });

        }

        /* 使用form组件添加数据 */
        function closeDialog() {
            $("#addCarousel").dialog("close");
        }

    </script>
</head>
<body>
<table id="dg"></table>

<div id="addCarousel" class="login logns produce">
    <h1 class="blues">拍卖品信息</h1>
    <form id="addCarouselForm" method="post" enctype="multipart/form-data">
        <dl>
            <dd>
                <label>上传图片：</label>
                <div><a href="#">
                    <img src="" width="100" height="100" id="image"/></a></div>
                <input name="file" type="file"/>
                <div></div>
            </dd>
            <dd>
                <label>图片主题：</label>
                <input type="text" name="carousel_title"/>
                <div></div>
            </dd>
            <dd>
                <label>图片描述：</label>
                <input type="text" name="carousel_desc"/>
                <div></div>
            </dd>
            <dd>
                <label>图片状态：</label>
                <input type="text" name="carousel_status"/>
                <div></div>
            </dd>
            <dd class="hegas">
                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'"
                   onclick="addData()">保存</a>
                <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="closeDialog()">取消</a>
            </dd>
        </dl>
    </form>
</div>
</body>
</html>