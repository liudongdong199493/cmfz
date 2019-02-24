<%--
  Created by IntelliJ IDEA.
  User: 刘东东
  Date: 2018/12/2
  Time: 20:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $.ajax({
            url:"${pageContext.request.contextPath}/user/registUser.do",
            data:{"phoneNum":"11111111111","password":"123456"},
            success:function (data) {
                console.log(data);
            }
        })
    </script>
</head>
<body>

</body>
</html>
