<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>持名法州主页</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath }/js/china.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">

    <script type="text/javascript">
        <!--菜单处理-->
        $(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/menu/getAll.do",
                type: "post",
                dataType: "json",//告知返回的json串，需要转为js对象
                success: function (data) {
                    //alert(data);
                    var list = data.list;
                    for (var j = 0; j < list.length; j++) {
                        var html = "";
                        $.each(list[j].menuList, function (index, menu) {
                            /*html += '<p align="center"><a id="btn" href="#" onclick="toAddTabs("'+menu.title+'","'+menu.iconCls+'","'+menu.url+'");"' +
                                'class="easyui-linkbutton" data-options="iconCls:\''+menu.iconCls+'\'">'+menu.title+'</a></p>';*/
                            html += "<p align='center'><a id=\"btn\" href=\"#\" class=\"easyui-linkbutton\" onclick=\"toAddTabs('" + menu.title + "','" + menu.iconCls + "','" + menu.url + "')\" " +
                                "data-options=\"iconCls:'" + menu.iconCls + "'\">" + menu.title + "</a></p>";
                        })
                        $('#aa').accordion('add', {
                            title: list[j].title,
                            content: html,
                            iconCls: list[j].iconCls,
                            selected: true
                        });
                    }
                }
            });

            //创建修改对话框
            $("#updateDialog").dialog({
                title: "修改密码",
                width: 400,
                height: 200,
                closed: true,
                cache: false,
                modal: true
            });
            //创建修改对话框===EN===

        });

        function toAddTabs(title, iconCls, url) {
            //console.log(title+iconCls+url);
            var isExist = $("#tt").tabs("exists", title);
            if (isExist) {
                $("#tt").tabs("select", title);
            } else {
                $("#tt").tabs("add", {
                    title: title,
                    iconCls: iconCls,
                    fit: true,
                    arrow: true,
                    pill: true,
                    closable: true,//关闭按钮
                    content: '<iframe src="${pageContext.request.contextPath}' + url + '" width="100%" height="100%"></iframe>'
                });
            }

        }

        //修改密码验证
        function check() {
            var passwoed1 = parseInt($("#password1").val());
            var passwoed2 = parseInt($("#password2").val());
            if (passwoed1 == passwoed2 && passwoed1 != 0 && passwoed2 != 0) {
                return true;
            } else {
                $("#password2").next().html("两次密码输入不一致");
                return false;
            }
        }

        function updatePassword() {
            $("#updateDialog").dialog("open");
        }

        //修改密码验证===END===
        function toUpdatePassword() {
            var password1 = parseInt($("#password1").val());
            if (check()) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/updatePassword.do",
                    data: "password1=" + password1,
                    dataType: "json",
                    success: function (data) {
                        if (data) {
                            //alert(data);
                            location = "${pageContext.request.contextPath}/login.jsp";
                        } else {
                            alert("修改失败");
                        }
                    }
                });
            }

        }

    </script>

</head>
<body class="easyui-layout">
<div data-options="region:'north',split:true" style="height:60px;background-color:  #5C160C">
    <div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px">
        持名法州后台管理系统
    </div>
    <div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">
        欢迎您:${sessionScope.admin.username}
        &nbsp;<a href="javascript:void(0)" onclick="updatePassword()" class="easyui-linkbutton"
                 data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;
        <a href="${pageContext.request.contextPath}/admin/logout.do" class="easyui-linkbutton"
           data-options="iconCls:'icon-01'">退出系统</a>
    </div>
</div>
<div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
    <div style="text-align: center;font-size:15px; color: #FAF7F7;font-family: 楷体">&copy;百知教育 htf@zparkhr.com.cn</div>
</div>

<div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    <div id="aa" class="easyui-accordion" data-options="fit:true">

    </div>
</div>
<div data-options="region:'center'">
    <div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">
        <div title="主页" data-options="iconCls:'icon-neighbourhood',"
             style="background-image:url(image/shouye.jpg);background-repeat: no-repeat;background-size:100% 100%;"></div>
    </div>
</div>

<!--  修改密码话框 -->
<div id="updateDialog">
    <form id="updateForm" method="post">
        新密码：<input type="password" id="password1" name="password1"/><br/>
        确&nbsp;&nbsp;认：<input type="password" id="password2" onblur="check()"/><span style="color: red"></span><br/>
        <input type="submit" value="修改" onclick="toUpdatePassword()"/>
    </form>
</div>
<!--  修改对话框 ===END===-->
</body>
</html>