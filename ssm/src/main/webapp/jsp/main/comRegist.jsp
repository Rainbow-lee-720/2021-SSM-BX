<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/4 0004
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>企业注册</title>
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
        body{
            padding: 0;
            margin: 0;
            overflow: auto;
            background-color: whitesmoke;
        }
        .main_div{
            width : 100%;
            height: 100%;
            overflow: auto;
        }
        label{
            font-size: 1em;
            font-weight: bold;
            color: snow;
        }
        .bottom-div{
            color: #EB7347;
            font-weight: bold;
            font-size: 1em;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            //返回上一级
            $("#back").click(function () {
                history.go(-1);
            });

            //Ajax校验用户名是否已被注册
            ajaxCheckIdRegist();

            //注册
            comRegist();
        });

        //Ajax校验用户名是否已被注册
        function ajaxCheckIdRegist() {
            //TODO 用户名输入框失去焦点时通过ajax校验用户名是否存在 不存在则先提示信息 然后提示用户注册
            $("#comId").blur(function () {
                var username = $.trim($("#comId").val());
                var json = {
                    username : username
                };
                var data = JSON.stringify(json);
                if(username == "" || username == null){
                    $("#errComId").html("请输入用户名");
                    $("#comId").focus();
                }else{
                    $.ajax({
                        type : "post",
                        data : data,
                        cache : false,
                        async: false,
                        contentType : "application/json;charset=UTF-8",
                        dataType: "json",
                        url: "${pageContext.request.contextPath}/utilController/checkNoAjaxRegist",
                        success : function (data) {
                            if(data.result){
                                //用户名已注册 提示换一个用户名
                                var msg = data.msg1;
                                $("#errComId").css("color","red").html(msg);
                                $("#comId").focus(function () {
                                    $("#errComId").html("");
                                });
                            }else{
                                //用户名未注册 提示可以注册
                                var msg = data.msg1;
                                $("#errComId").css("color","green").html(msg);
                            }
                        }
                    });
                }

            });
        }

        function comRegist() {
            //校验表单数据
            $("#submit").click(function() {
                //获取表单值
                var comId = $.trim($("#comId").val());
                var comPwd = $.trim($("#comPwd").val());
                var confirmComPwd = $.trim($("#confirmComPwd").val());
                var comNo = $.trim($("#comNo").val());
                var comName = $.trim($("#comName").val());
                var comPhone = $.trim($("#comPhone").val());
                var comAddress = $.trim($("#comAddress").val());
                var comNum = $.trim($("#comNum").val());
                var comKind = $.trim($("#comKind").val());
                var comType = $.trim($("#comType").val());
                var comBack = $.trim($("#comBack").val());
                //企业权限
                var comPower = $.trim($("#comPower").val());

                //用户名密码正则表达式
                var regxUserPattern = /^c(\w){6,10}$/;
                //手机号正则表达式
                var regxPhonePattern = /^1[34578]\d{9}$/;
                //非空校验
                if(comId == "" || comId == null){
                    $("#errComId").html("请输入用户名");
                    $("#comId").focus(function () {
                        $("#errComId").html("");
                    });
                }else if(!(regxUserPattern.test(comId))){
                    $("#errComId").html("用户名必须由c开头的6-10位数字、字母或下划线组成");
                    $("#comId").focus(function () {
                        $("#errComId").html("");
                    });
                }else if(comPwd == "" || comPwd == null){
                    $("#errComPwd").html("请输入密码");
                    $("#comPwd").focus(function () {
                        $("#errComPwd").html("");
                    });
                }else if(!(regxUserPattern.test(comPwd))){
                    alert("密码必须由6-10位数字、字母或下划线组成!")
                }else if(confirmComPwd == "" || confirmComPwd == null){
                    $("#errConfirmComPwd").html("请确认密码");
                    $("#confirmComPwd").focus(function () {
                        $("#errConfirmComPwd").html("");
                    });
                }else if(comPwd != confirmComPwd){
                    alert("两次输入的密码不一致！请重新输入！");
                }else if(comNo == "" || comNo == null){
                    $("#errComNo").html("请输入企业编号");
                    $("#comNo").focus(function () {
                        $("#errComNo").html("");
                    });
                }else if(isNaN(comNo) || comNo == "" || comNo == null){
                    $("#errComNo").html("企业编号必须由数字组成!");
                    $("#comNo").focus(function () {
                        $("#errComNo").html("");
                    });
                }else if(comName == "" || comName == null){
                    $("#errComName").html("请输入企业名称");
                    $("#comName").focus(function () {
                        $("#errComName").html("");
                    });
                }else if(comPhone == "" || comPhone == null){
                    $("#errComPhone").html("请输入企业电话");
                    $("#comPhone").focus(function () {
                        $("#errComPhone").html("");
                    });
                }else if(isNaN(comPhone || comPhone == "" || comPhone == null)){
                    $("#errComPhone").html("企业电话号码由数字组成");
                    $("#comPhone").focus(function () {
                        $("#errComPhone").html("");
                    });
                }else if(!(regxPhonePattern.test(comPhone))){
                    $("#errComPhone").html("企业电话号码为数字1开头的11位数字组成");
                    $("#comPhone").focus(function () {
                        $("#errComPhone").html("");
                    });
                }else if(comNum == "" || comNum == null){
                    $("#errComNum").html("请输入企业规模");
                    $("#comNum").focus(function () {
                        $("#errComNum").html("");
                    });
                }else if(isNaN(comNum) || comNum == "" || comNum == null){
                    $("#errComNum").html("企业规模由数字组成");
                    $("#comNum").focus(function () {
                        $("#errComNum").html("");
                    })
                }else if(comType == "-请选择-" || comType == null){
                    $("#errComType").html("请选择企业类型");
                    $("#comType").focus(function () {
                        $("#errComType").html("");
                    });
                }else if(comKind == "-请选择-" || comKind == null){
                    $("#errComKind").html("请选择企业性质");
                    $("#comKind").focus(function () {
                        $("#errComKind").html("");
                    });
                }else if(comAddress == "" || comAddress == null){
                    $("#errComAddress").html("请填写企业地址");
                    $("#comAddress").focus(function () {
                        $("#errComAddress").html("");
                    });
                }else if(comBack == "" || comBack == null){
                    $("#errComBack").html("请填写公司简介");
                    $("#comBack").focus(function () {
                        $("#errComBack").html("");
                    });
                }else{
                    //提交表单数据
                    var companyData = {
                        comNo : comNo,
                        comId : comId,
                        comPwd : comPwd,
                        comName : comName,
                        comPhone : comPhone,
                        comAddress : comAddress,
                        comKind : comKind,
                        comNum : comNum,
                        comType : comType,
                        comBack : comBack,
                        comPower : comPower
                    };
                    //通过jquery的格式转换成String
                    var data = JSON.stringify({
                        "company" : companyData
                    });
                    //通过ajax传送到服务端
                    $.ajax({
                        type : "post",
                        data : data,
                        dataType : "json",
                        async : false,
                        cache : false,
                        contentType : "application/json;charset=UTF-8",
                        url : "${pageContext.request.contextPath}/company/comRegist",
                        success : function (resp) {
                            if(resp.result){
                                //注册成功 提示登录
                                alert(resp.msg1);
                                //注册成功跳转到登录页面
                                window.location.href = resp.msg2;
                            }else{
                                //校验失败
                                alert(resp.msg1);
                            }
                        },
                        error : function () {
                            //注册失败
                            alert("注册失败!请重新输入！");
                        }
                    });
                }
            });
        }

    </script>
</head>
<body>
    <div id="main_div">
        <div class="jumbotron text-center" style="margin-bottom:0;background-color: #09192A;height: 200px;background: url('../../resources/images/head2.png') no-repeat;background-size: cover;">
            <h1 style="color: lightseagreen;margin-top: -20px;">大学毕业生就业信息管理平台</h1><br>
            <h2 style="color: lightseagreen;">企业注册</h2>
            <hr/>
        </div>

        <form class="form-horizontal">
            <div class="container">
                <div class="row" style="padding: 20px 0">
                    <h3 style="color: #26A65B;border-left: 6px solid #26A65B;">请填写您的企业信息>></h3>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comId" style="color: #EB7347;">用户名：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="comId" id="comId" type="text" placeholder="请输入用户名(用户名由'c'开头的6-10位数字、字母或下划线组成)">
                        <div id="errComId" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comPwd" style="color: #EB7347;">密码：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="comPwd" id="comPwd" type="password" placeholder="请输入您的登录密码(密码由6-10位数字、字母或下划线组成)">
                        <div id="errComPwd" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="confirmComPwd" style="color: #EB7347;">确认密码：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="confirmComPwd" id="confirmComPwd" type="password" placeholder="请确认您的登录密码(密码由6-10位数字、字母或下划线组成)">
                        <div id="errConfirmComPwd" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comNo">*企业编号：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="comNo" id="comNo" type="text" placeholder="请输入企业编号(企业编号由数字组成)">
                        <div id="errComNo" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comName">*企业名称：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="comName" id="comName" type="text" placeholder="请输入您的企业名称">
                        <div id="errComName" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comPhone">*企业电话：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="comPhone" id="comPhone" type="text" placeholder="请输入您的企业电话号码">
                        <div id="errComPhone" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comNum">*企业规模：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="comNum" id="comNum" type="text" placeholder="请填写您的企业人数规模(数字)">
                        <div id="errComNum" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comType">*企业类型：</label>
                    <div class="col-lg-7 col-md-6">
                        <select class="form-control" name="comType" id="comType">
                            <option>-请选择-</option>
<%--                            <c:forEach var="companys" items="${comTypeList}">--%>
<%--                                <option>--%>
<%--                                    ${companys.comType}--%>
<%--                                </option>--%>
<%--                            </c:forEach>--%>
                            <option>医疗</option>
                            <option>金融</option>
                            <option>法律</option>
                            <option>教育</option>
                            <option>旅游</option>
                            <option>物流</option>
                            <option>设计</option>
                            <option>互联网</option>
                            <option>服务业</option>
                        </select>
                        <div id="errComType" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comKind">*企业性质：</label>
                    <div class="col-lg-7 col-md-6">
                        <select class="form-control" name="comKind" id="comKind">
                            <option>-请选择-</option>
                            <option>自营</option>
                            <option>私企</option>
                            <option>国企</option>
                            <option>合资</option>
                            <option>外资</option>
                            <option>事业单位</option>
                        </select>
                        <div id="errComKind" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comAddress">*企业地址：</label>
                    <div class="col-lg-7 col-md-6">
                        <textarea class="form-control" rows="5" name="comAddress" id="comAddress" placeholder="请填写您的企业真实地址"></textarea>
                        <div id="errComAddress" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comBack">*企业背景：</label>
                    <div class="col-lg-7 col-md-6">
                        <textarea class="form-control" rows="5" name="comBack" id="comBack" placeholder="请填写您的公司背景"></textarea>
                        <div id="errComBack" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="comPower">*企业权限(公司)：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" rows="5" name="comPower" id="comPower" value="2" style="background-color: #EB7347;" disabled></input>
                        <div id="errComPower" style="color: #c9302c">(提示：注册时系统默认提供企业权限)</div>
                    </div>
                </div>

                <div class="row form-group" style="margin: 50px auto;">
                    <button type="button" id="submit" class="btn btn-success" style="position:relative;left: 380px;">提交</button>
                    <button type="reset" id="reset" class="btn btn-warning" style="position:relative;left: 430px;">重置</button>
                    <button type="button" id="back" class="btn btn-danger" style="position:relative;left: 480px;">返回</button>
                </div>
            </div>
        </form>

        <div class="bottom-div">
            <p style="font-size: 14px;text-align: center">©NUIST  大学毕业生就业信息管理平台 Version1.0 2021-02-12</p>
            <p style="font-size: 12px;text-align: center">-NUIST BX-</p>
        </div>
    </div>
</body>
</html>

