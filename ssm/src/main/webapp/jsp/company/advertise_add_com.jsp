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
    <title>发布招聘</title>
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
</head>
<style type="text/css">
    #div1{
        border: 2px solid lightgray;
        width : 1540px;
        height: 900px;
        overflow: auto;
        overflow-x: hidden;
    }
    #div2{
        height : 50px;
        background-color: #f37b1d;
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
        height: 70px;
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
        $(".back").click(function () {
            history.go(-1);
        });

        //提交编辑的数据
        $("#submit").click(function () {
            //获取表单值
            var adverComNo = $.trim($("#adverComNo").val());
            var adverComName = $.trim($("#adverComName").val());
            var adverComPhone = $.trim($("#adverComPhone").val());
            var adverComAddress = $.trim($("#adverComAddress").val());
            var adverPosition = $.trim($("#adverPosition").val());
            var adverCount = $.trim($("#adverCount").val());
            var adverSalary = $.trim($("#adverSalary").val());
            var adverLocation = $.trim($("#adverLocation").val());
            var adverRequire = $.trim($("#adverRequire").val());

            //非空校验
            if(adverPosition == "" || adverPosition == null){
                $("#errAdverPosition").html("请填写招聘职位");
                $("#adverPosition").focus(function () {
                    $("#errAdverPosition").html("");
                });
            }else if(adverCount == "" || adverCount == null){
                $("#errAdverCount").html("请填写招聘人数");
                $("#adverCount").focus(function () {
                    $("#errAdverCount").html("");
                });
            }else if(isNaN(adverCount) || adverCount == "" || adverCount == null){
                $("#errAdverCount").html("招聘人数必须由数字组成");
                $("#adverCount").focus(function () {
                    $("#errAdverCount").html("");
                });
            }else if(adverSalary == "" || adverSalary == null){
                $("#errAdverSalary").html("请填写招聘薪资待遇");
                $("#adverSalary").focus(function () {
                    $("#errAdverSalary").html("");
                });
            }else if(isNaN(adverSalary) || adverSalary == "" || adverSalary == null){
                $("#errAdverSalary").html("招聘薪资待遇必须由数字组成");
                $("#adverSalary").focus(function () {
                    $("#errAdverSalary").html("");
                });
            }else if(adverLocation == "" || adverLocation == null){
                $("#errAdverLocation").html("请填写入职工作地");
                $("#adverLocation").focus(function () {
                    $("#errAdverLocation").html("");
                });
            }else if(adverRequire == "-请选择-" || adverRequire == null){
                $("#errAdverRequire").html("请填写企业招聘要求");
                $("#adverRequire").focus(function () {
                    $("#errAdverRequire").html("");
                });
            }else{
                //提交表单数据
                var adverComNo = $.trim($("#adverComNo").val());
                var adverComName = $.trim($("#adverComName").val());
                var adverComPhone = $.trim($("#adverComPhone").val());
                var adverComAddress = $.trim($("#adverComAddress").val());

                var adverPosition = $.trim($("#adverPosition").val());
                var adverCount = $.trim($("#adverCount").val());
                var adverSalary = $.trim($("#adverSalary").val());
                var adverLocation = $.trim($("#adverLocation").val());
                var adverRequire = $.trim($("#adverRequire").val());

                var adverData = {
                    adverComNo : adverComNo,
                    adverComName : adverComName,
                    adverComPhone : adverComPhone,
                    adverComAddress : adverComAddress,
                    adverPosition : adverPosition,
                    adverCount : adverCount,
                    adverSalary : adverSalary,
                    adverLocation : adverLocation,
                    adverRequire : adverRequire
                };
                //通过jquery的格式转换成String
                var data = JSON.stringify({
                    "advertise" : adverData
                });
                //通过ajax传送到服务端
                $.ajax({
                    type : "post",
                    data : data,
                    dataType : "json",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/advertise/addAdvertise",
                    success : function (resp) {
                        if(resp.result){
                            //添加成功
                            alert(resp.msg1);
                            //刷新表格数据
                            parent.location.href = resp.msg2;
                        }else{
                            //修改失败
                            alert(resp.msg1);
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/advertise/queryAdverByPageNew?adverComNo=${company.comNo}";
                        }
                    },
                    error : function () {
                        //请求失败
                        alert("请求失败!请重试！");
                    }
                });
            }

        });
    });
</script>
<body>
    <div id="div1">
        <div id="div2">
            <div id="div3"><span class="glyphicon glyphicon-th-list"></span><span>&nbsp;发布招聘</span></div>
            <div id="div5">
                <!-- 新增Back按钮 -->
                <button class="btn btn-default back" data-toggle="modal" data-target="#myModal">
                    <span class="glyphicon glyphicon-remove-sign"></span>&nbsp;返回
                </button>
            </div>
        </div>

        <div id="div4">

            <div class="alert alert-success">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>您可以在此页面发布企业招聘信息
            </div>

            <div class="alert alert-info">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>招聘信息上的企业相关默认信息与企业信息保持一致<b>(当前企业相关默认信息可能未更新)</b>
            </div>

            <div class="alert alert-danger">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>注意：</strong>招聘信息上的企业相关默认信息在招聘信息更新后自动更新！
            </div>

            <div style="padding: 25px 100px 10px;">
                <p style="color: lightseagreen;font-weight: bold;font-size:20px;">丨<span>&nbsp;&nbsp;</span>新增招聘信息</p>
                <hr class="span2">
                <br>

                <form class="bs-example bs-example-form" role="form">
                    <div class="input-group">
                        <span class="input-group-addon span">企编：</span>
                        <input id="adverComNo" type="text" class="form-control" value="${company.comNo}" disabled>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">名称：</span>
                        <input id="adverComName" type="text" class="form-control" value="${company.comName}" disabled>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">电话：</span>
                        <input id="adverComPhone" type="text" class="form-control" value="${company.comPhone}" disabled>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">地址：</span>
                        <textarea id="adverComAddress" type="text" class="form-control" disabled>${company.comAddress}</textarea>
                    </div>
                    <br>

                    <div class="input-group">
                        <span class="input-group-addon span">职位：</span>
                        <input id="adverPosition" type="text" class="form-control" style="font-weight: bold;color: #f37b1d;" placeholder="请编辑您的招聘职位">
                        <div id="errAdverPosition" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">人数：</span>
                        <input id="adverCount" type="text" class="form-control" style="font-weight: bold;color: #f37b1d;" placeholder="请编辑您的招聘人数">
                        <div id="errAdverCount" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">薪资：</span>
                        <input id="adverSalary" type="text" class="form-control" style="font-weight: bold;color: #f37b1d;" placeholder="请编辑您的招聘薪资待遇"/>
                        <div id="errAdverSalary" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">工作地：</span>
                        <textarea id="adverLocation" type="text" class="form-control"  style="font-weight: bold;color: #f37b1d;" placeholder="请编辑您的入职工作地"></textarea>
                        <div id="errAdverLocation" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">要求：</span>
                        <textarea id="adverRequire" type="text" class="form-control"  style="font-weight: bold;color: #f37b1d;" placeholder="请编辑您的招聘要求"></textarea>
                        <div id="errAdverRequire" style="color: orange;"></div>
                    </div>
                    <br>

                    <div class="row form-group" style="margin: 50px auto;">
                        <button type="button" id="submit" class="btn btn-success" style="position:relative;left: 520px;">新增</button>
                        <button type="reset" id="reset" class="btn btn-warning" style="position:relative;left: 570px;">重置</button>
                        <button type="button" id="back" class="btn btn-danger back" style="position:relative;left: 620px;">退出</button>
                    </div>
                </form>
            </div>

        </div>

    </div>
</body>
</html>
