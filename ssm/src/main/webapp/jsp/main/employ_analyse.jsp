<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/12 0012
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>就业分析</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <!-- 响应式布局 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 新 Bootstrap3 核心 CSS 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static.bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static.bootstrap/css/bootstrap-theme.css">

    <!-- Bootstrap-table CSS 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap-table/bootstrap-table/bootstrap-table.min.css">

    <!-- 字体文件 -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- jQuery文件 务必在bootstrap.min.js 之前引入 -->
    <script src="${pageContext.request.contextPath}/resources/static.bootstrap/jquery/jquery.min.js"></script>

    <!-- 最新的 Bootstrap3 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/resources/static.bootstrap/js/bootstrap.min.js"></script>

    <!-- Bootstrap-table JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/resources/bootstrap-table/bootstrap-table/bootstrap-table.min.js"></script>
    <!-- Bootstrap-table-zh-CN JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/resources/bootstrap-table/bootstrap-table/bootstrap-table-zh-CN.min.js"></script>
    <!-- highcharts 文件 -->
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <!-- 引入 echarts.js -->
    <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
</head>
<style type="text/css">
    #div1{
        border: 0px solid lightgray;
        width : 1540px;
        height: 1400px;
        overflow: auto;
        overflow-x: hidden;
    }
    #div2{
        height : 50px;
        background-color: #2C3E50;
    }
    #div3{
        float: left;
        color: white;
        font-size: 18px;
        font-weight: bold;
        position: relative;
        top : 10px;
        left: 12px;
    }
    #div4{
        width : 1500px;
        height: 80px;
        position: relative;
        top : 20px;
        left: 18px;
        margin-bottom: 30px;
    }
    #div5{
        float: right;
        position: relative;
        top : 7px;
        right: 9px;
    }
    .span{
        color: #26A65B;
    }
    .span2{
        border:0px;
        border-bottom:3px solid lightseagreen;
    }
</style>

<script type="text/javascript">

    $(function () {
        //返回上一级
        $("#back").click(function () {
            history.go(-1);
        });
    });
</script>
<body>
    <div id="div1">
        <div id="div2">
            <div id="div3"><span class="glyphicon glyphicon-stats"></span><span>&nbsp;就业分析</span></div>
        </div>

        <div id="div4">

            <div class="alert alert-success">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>可视化大学生就业信息分析
            </div>

            <div class="alert alert-info">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>对就业薪资分布、就业地区分布等情况进行综合性分析
            </div>

        </div>

        <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<%--        <div id="main" style="width: 1200px;height:600px; margin-top: 180px;"></div>--%>

        <div id="container" style="width: 800px; height: 400px; margin-top: 100px;position:relative;left: 20px;float: left;"></div>
        <div id="container3" style="width: 650px; height: 400px; margin-top: 100px;float: left;position:relative;left: 50px;"></div>
        <div id="container2" style="width: 1350px; height: 500px; position:relative;left: 20px;top: 100px;"></div>
    </div>

<%--    <script type="text/javascript">--%>
<%--        // 基于准备好的dom，初始化echarts实例--%>
<%--        var myChart = echarts.init(document.getElementById('main'));--%>

<%--        // 指定图表的配置项和数据--%>
<%--        var option = {--%>
<%--            title: {--%>
<%--                text: '第一个 ECharts 实例'--%>
<%--            },--%>
<%--            tooltip: {},--%>
<%--            legend: {--%>
<%--                data:['销量']--%>
<%--            },--%>
<%--            xAxis: {--%>
<%--                data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]--%>
<%--            },--%>
<%--            yAxis: {},--%>
<%--            series: [{--%>
<%--                name: '销量',--%>
<%--                type: 'bar',--%>
<%--                data: [5, 20, 36, 10, 10, 20]--%>
<%--            }]--%>
<%--        };--%>

<%--        // 使用刚指定的配置项和数据显示图表。--%>
<%--        myChart.setOption(option);--%>
<%--    </script>--%>
    <script language="JavaScript">
        $(document).ready(function() {
            <!-- 就业薪资分析 -->
            var title = {
                text: '大学毕业生就业信息分析'
            };
            var subtitle = {
                text: '就业薪资分布'
            };
            var xAxis = {
                categories: ['<3k', '3k-5k', '5k-7k', '7k-10k', '>10k']
            };
            var yAxis = {
                title: {
                    text: '人数（人）'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            };

            var plotOptions = {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: true
                }
            };

            var legend = {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'middle',
                borderWidth: 0
            };

            var series =  [
                {
                    name: 'People count（人数）',
                    data: []
                },

            ];

            var json = {};

            json.title = title;
            json.subtitle = subtitle;
            json.xAxis = xAxis;
            json.yAxis = yAxis;
            json.legend = legend;
            json.series = series;
            json.plotOptions = plotOptions;

            /* 发送ajax请求 */
            var data = {};
            //发送key-value类型的请求数据
            //例如：data.xxx = 1;
            $.ajax({
                type: "POST",
                //当发送json数据时添加：
                /*  contentType: "application/json; charset=utf-8", */
                url: "${pageContext.request.contextPath}/employ/salaryAnalyse",
                data: data,
                error: function (data) {
                    alert("出错了！" );
                },
                success: function (data) {
                    //对echarts模板进行数据填充
                    series[0].data = data.count;
                    //重新加载图表显示
                    $('#container').highcharts(json);
                }
            });

            <!-- 就业地区分析 -->
            var chart2 = {
                type: 'bar'
            };
            var title2 = {
                text: '大学毕业生就业信息分析'
            };
            var subtitle2 = {
                text: '就业地区分布'
            };
            var xAxis2 = {
                categories: ['北京', '上海', '南京', '成都', '武汉', '广州', '西安', '南昌'],
                title: {
                    text: null
                }
            };
            var yAxis2 = {
                min: 0,
                title: {
                    text: '人数 (people)',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            };
            var tooltip2 = {
                valueSuffix: ' people'
            };
            var plotOptions2 = {
                bar: {
                    dataLabels: {
                        enabled: true
                    }
                }
            };
            var legend2 = {
                layout: 'vertical',
                align: 'right',
                verticalAlign: 'top',
                x: -40,
                y: 100,
                floating: true,
                borderWidth: 1,
                backgroundColor: ((Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'),
                shadow: true
            };
            var credits2 = {
                enabled: false
            };

            var series2= [{
                name: '就业人数',
                data: []
            }
            ];

            var json2 = {};
            json2.chart = chart2;
            json2.title = title2;
            json2.subtitle = subtitle2;
            json2.tooltip = tooltip2;
            json2.xAxis = xAxis2;
            json2.yAxis = yAxis2;
            json2.series = series2;
            json2.plotOptions = plotOptions2;
            json2.legend = legend2;
            json2.credits = credits2;

            /* 发送ajax请求 */
            var data2 = {};
            //发送key-value类型的请求数据
            //例如：data.xxx = 1;
            $.ajax({
                type: "POST",
                //当发送json数据时添加：
                /*  contentType: "application/json; charset=utf-8", */
                url: "${pageContext.request.contextPath}/employ/locationAnalyse",
                data: data2,
                error: function (data) {
                    alert("出错了！" );
                },
                success: function (data) {
                    //对echarts模板进行数据填充
                    series2[0].data = data.count
                    //重新加载图表显示
                    $('#container2').highcharts(json2);
                }
            });

            <!-- 就业企业性质分析 -->
            var chart3 = {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false
            };
            var title3 = {
                text: '大学毕业生就业信息分析-就业企业性质分布'
            };
            var tooltip3 = {
                pointFormat: '{series3.name}: <b>{point.percentage:.1f}%</b>'
            };
            var plotOptions3 = {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true
                }
            };
            var series3= [{
                type: 'pie',
                name: '占比',
                // data:  [
                //     ['自营',  5],
                //     ['私企',  3],
                //     ['国企',  3],
                //     ['合资',  8],
                //     ['外资',  9],
                //     ['事业单位',  7]
                // ]
                data : []
            }];

            var json3 = {};
            json3.chart = chart3;
            json3.title = title3;
            json3.tooltip = tooltip3;
            json3.series = series3;
            json3.plotOptions = plotOptions3;

            /* 发送ajax请求 */
            var data3 = {};
            //发送key-value类型的请求数据
            //例如：data.xxx = 1;
            $.ajax({
                type: "POST",
                //当发送json数据时添加：
                /*  contentType: "application/json; charset=utf-8", */
                url: "${pageContext.request.contextPath}/employ/kindAnalyse",
                data: data3,
                error: function (data) {
                    alert("出错了！" );
                },
                success: function (data) {
                    //对echarts模板进行数据填充
                    series3[0].data = data.number
                    //重新加载图表显示
                    $('#container3').highcharts(json3);
                }
            });
        });

    </script>
</body>
</html>
