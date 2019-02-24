<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<html>
<head>
    <meta charset="utf-8">
    <title>ECharts</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/echarts.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/china.js"></script>
</head>
<body>
<div id="main" style="width: 600px;height:400px;"></div></body>
<script type="text/javascript">
    $.ajax({
        url:"${pageContext.request.contextPath}/user/countByDate.do",
        dataType:"json",
        method:"post",
        success:function (data) {
            var myChart = echarts.init(document.getElementById('main'));
            var option = {
                title: {
                    text: '用户注册统计'
                },
                tooltip: {},
                legend: {
                    data:["柱状图","折线图"]
                },
                xAxis: {
                    data:['近一周','近两周','近三周']
                },
                yAxis: {},
                series: [{
                    name: '柱状图',
                    type: 'bar',
                    data: data,
                },{
                    name: '折线图',
                    type: 'line',
                    data: data,
                }]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }
    });

</script>

</html>