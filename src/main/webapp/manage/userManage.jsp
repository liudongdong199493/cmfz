<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<html>
<head>

    <title></title>
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
            text: "全部导入",
            iconCls: 'icon-add',
            handler: function () {

            }
        }, '-', {
            text: "全部导出",
            iconCls: 'icon-undo',
            handler: function () {
            }
        }];
        $(function () {
            $("#userManage").datagrid({
                url:"${pageContext.request.contextPath}/user/getAll.do",
                fit: true,
                fitColumns: true,
                pagination: true,
                singleSelect: true,
                toolbar:toolbar,
                pageSize: 3,
                pageList: [3, 6, 9],
                columns:[[
                    {field:'user_id',title:'编号',width:100},
                    {field:'username',title:'用户名',width:100},
                    {field:'registDate',title:'注册日期',width:100}
                ]]
            });

        })
    </script>
</head>
<body>
    <table id="userManage"></table>
</body>
</html>