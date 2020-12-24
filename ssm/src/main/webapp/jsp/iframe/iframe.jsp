<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/3 0003
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>new jsp</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 新 Bootstrap3 核心 CSS 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static.bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static.bootstrap/css/bootstrap-theme.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="${pageContext.request.contextPath}/resources/static.bootstrap/jquery/jquery.min.js"></script>

    <!-- 最新的 Bootstrap3 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/resources/static.bootstrap/js/bootstrap.min.js"></script>

    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <style type="text/css">

        body {
            position: relative;
            background-color: snow;
        }

        .carousel-inner img{
            width : 100%;
            height: auto;
        }
        p{
            font-size: 19px;
        }

        #section1 {padding-top:50px;height:500px;color: #fff; background-color: #1E88E5;}
        #section2 {padding-top:50px;height:500px;color: #fff; background-color: #673ab7;}
        #section3 {padding-top:50px;height:500px;color: #fff; background-color: #ff9800;}
        #section41 {padding-top:50px;height:500px;color: #fff; background-color: #00bcd4;}
        #section42 {padding-top:50px;height:500px;color: #fff; background-color: #009688;}

    </style>
</head>
<body data-spy="scroll" data-target=".navbar" data-offset="50">
        <div id="myCarousel" class="carousel slide" style="width: 1550px;height: 200px;overflow:hidden;">
            <!-- 轮播（Carousel）指标 -->
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <!-- 轮播（Carousel）项目 -->
            <div class="carousel-inner">
                <div class="item active">
                    <img src="../../resources/images/stu1.png" alt="First slide">
                </div>
                <div class="item">
                    <img src="../../resources/images/stu2.png" alt="Second slide">
                </div>
                <div class="item">
                    <img src="../../resources/images/stu3.png" alt="Third slide">
                </div>
                <div class="item">
                    <img src="../../resources/images/stu4.png" alt="Third slide">
                </div>
                <div class="item">
                    <img src="../../resources/images/stu5.png" alt="Third slide">
                </div>
            </div>

            <!-- 轮播（Carousel）导航 -->
            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Welcome</a>
                </div>
                <div>
                    <div class="collapse navbar-collapse" id="myNavbar">
                        <ul class="nav navbar-nav">
                            <li><a href="#section1">平台简介</a></li>
                            <li><a href="#section2">平台指南</a></li>
                            <li><a href="#section3">关于作者</a></li>
                            <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">专题<span class="caret"></span></a>
                                <ul class="dropdown-menu">
                                    <li><a href="#section41">高校动态</a></li>
                                    <li><a href="#section42">就业政策</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <div id="section1" class="container-fluid" style="overflow: auto;">
            <h2>Welcome</h2>
            <hr/>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;此项目的实施的目的在于为大学毕业生提供一个便捷准确的就业信息收集及管理的平台、为社会上的企业提供丰富的、及时的大学毕业生求职信息</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;极大地简化了传统的人工信息收集管理操作，显著地提高了大学毕业生求职效率和企业招聘人才的效率，为社会带来了巨大的便利</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;就业是大学毕业生至关重要的问题，它的有与否决定了大学毕业生的前途，当今社会中每一位大学毕业生都会将就业问题视为自己的命脉</p>
            <p>&nbsp;&nbsp;&nbsp;&nbsp;因此，“大学毕业生就业信息管理系统”恰好是供大学生择业的最好途径之一，它将大学生择业的方式优化到了最佳，具有很高的实际应用价值和便捷性</p>
        </div>
        <div id="section2" class="container-fluid">
            <h2>平台指南</h2>
            <hr/>
            <p>可视化的大学毕业生就业信息管理系统</p>
            <p>>>平台分为三个用户体系：</p>
            <p>①学生</p>
            <p>②企业</p>
            <p>③管理员</p>
            <p>提示：不同用户体系的功能不同 可通过网页左侧导航栏进入相应的功能</p>
        </div>
        <div id="section3" class="container-fluid">
            <h2>关于作者</h2>
            <hr/>
            <p>NUIST BX</p>
            <p>2021毕业设计</p>
        </div>
        <div id="section41" class="container-fluid">
            <h2>高校动态</h2>
            <hr/>
            <p>南京信息工程大学是国家“双一流”建设高校，是江苏高水平大学建设重点支持高校</p>
            <p>学校始建于1960年，应新中国国家战略和国民经济建设需求而生，隶属中央（军委）气象局，前身为南京大学气象学院，1963年独立建校为南京气象学院</p>
            <p>1978年列入全国重点大学，2004年更名为南京信息工程大学。2007年以来，先后实现了江苏省人民政府、中国气象局、教育部、国家海洋局的多方共建</p>
            <p>现为以江苏省管理为主的中央与地方共建高校</p>
        </div>
        <div id="section42" class="container-fluid">
            <h2>就业政策</h2>
            <hr/>
            <p>①扩大研招和专升本规模</p>
            <p>②扩大就业渠道</p>
            <p>③加强网上就业服务</p>
            <p>④支持毕业生多渠道就业</p>
            <p>⑤引导用人单位适当延长招聘时间</p>
            <p>⑥重点关注湖北高校毕业生</p>
            <p>⑦适当减免实习学分</p>
            <p>Please wait!</p>
        </div>

</body>
</html>
