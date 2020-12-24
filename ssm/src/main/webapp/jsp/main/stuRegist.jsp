<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/4 0004
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>学生注册</title>
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
            width : 100%;
            height: 100%;
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
        $(document).ready(function () {
            //返回上一级
            $("#back").click(function () {
                history.go(-1);
            });

            //Ajax校验用户名是否已被注册
            ajaxCheckIdRegist();

            //注册
            stuRegist();
        });

        //Ajax校验用户名是否已被注册
        function ajaxCheckIdRegist() {
            //TODO 用户名输入框失去焦点时通过ajax校验用户名是否存在 不存在则先提示信息 然后提示用户注册
            $("#stuId").blur(function () {
                var username = $.trim($("#stuId").val());
                var json = {
                    username : username
                };
                var data = JSON.stringify(json);
                if(username == "" || username == null){
                    $("#errStuId").html("请输入用户名");
                    $("#stuId").focus();
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
                                $("#errStuId").css("color","red").html(msg);
                                $("#stuId").focus(function () {
                                    $("#errStuId").html("");
                                });
                            }else{
                                //用户名未注册 提示可以注册
                                var msg = data.msg1;
                                $("#errStuId").css("color","green").html(msg);
                            }
                        }
                    });
                }

            });
        }

        function stuRegist(){
            //校验表单数据
            $("#submit").click(function() {
                //获取表单值
                var stuId = $.trim($("#stuId").val());
                var stuPwd = $.trim($("#stuPwd").val());
                var confirmStuPwd = $.trim($("#confirmStuPwd").val());
                var stuNo = $.trim($("#stuNo").val());
                var stuName = $.trim($("#stuName").val());
                var stuAge = $.trim($("#stuAge").val());
                var stuSex = $.trim($("input[type='radio']:checked").val());
                var stuSchool = $.trim($("#stuSchool").val());
                var stuSpecialty = $.trim($("#stuSpecialty").val());
                var stuPhone = $.trim($("#stuPhone").val());
                var stuAddress = $.trim($("#stuAddress").val());
                var stuDegree = $.trim($("#stuDegree").val());
                //学生权限
                var stuPower = $.trim($("#stuPower").val());

                //用户名密码正则表达式
                var regxUserPattern = /^s(\w){6,10}$/;
                //手机号正则表达式
                var regxPhonePattern = /^1[34578]\d{9}$/;
                if(stuId == "" || stuId == null){
                    $("#errStuId").html("请输入用户名");
                    $("#stuId").focus(function () {
                        $("#errStuId").html("");
                    });
                }else if(!(regxUserPattern.test(stuId))){
                    $("#errStuId").html("用户名必须由s开头的6-10位数字、字母或下划线组成");
                    $("#stuId").focus(function () {
                        $("#errStuId").html("");
                    });
                }else if(stuPwd == "" || stuPwd == null){
                    $("#errStuPwd").html("请输入密码");
                    $("#stuPwd").focus(function () {
                        $("#errStuPwd").html("");
                    });
                }else if(!(regxUserPattern.test(stuPwd))){
                    $("#errStuPwd").html("密码必须由6-10位数字、字母或下划线组成");
                    $("#stuPwd").focus(function () {
                        $("#errStuPwd").html("");
                    });
                }else if(confirmStuPwd == "" || confirmStuPwd == null){
                    $("#errConfirmStuPwd").html("请确认密码");
                    $("#confirmStuPwd").focus(function () {
                        $("#errConfirmStuPwd").html("");
                    });
                }else if(stuPwd != confirmStuPwd){
                    $("#errConfirmStuPwd").html("两次输入的密码不一致！请重新输入");
                    $("#confirmStuPwd").focus(function () {
                        $("#errConfirmStuPwd").html("");
                    });
                }else if(stuNo == "" || stuNo == null){
                    $("#errStuNo").html("请输入学号");
                    $("#stuNo").focus(function () {
                        $("#errStuNo").html("");
                    });
                }else if(isNaN(stuNo) || stuNo == "" || stuNo == null){
                    $("#errStuNo").html("学号必须由数字组成");
                    $("#stuNo").focus(function () {
                        $("#errStuNo").html("");
                    });
                }else if(stuName == "" || stuName == null){
                    $("#errStuName").html("请输入姓名");
                    $("#stuName").focus(function () {
                        $("#errStuName").html("");
                    });
                }else if(stuAge == "" || stuAge == null){
                    $("#errStuAge").html("请输入年龄");
                    $("#stuAge").focus(function () {
                        $("#errStuAge").html("");
                    });
                }else if(isNaN(stuAge) || stuAge == "" || stuAge == null){
                    $("#errStuAge").html("年龄必须由数字组成");
                    $("#stuAge").focus(function () {
                        $("#errStuAge").html("");
                    });
                }else if(stuSex == "" || stuSex == null){
                    $("#errStuSex").html("请选择性别");
                }else if(stuSchool == "" || stuSchool == null){
                    $("#errStuSchool").html("请输入学校名称");
                    $("#stuSchool").focus(function () {
                        $("#errStuSchool").html("");
                    });
                }else if(stuSpecialty == "" || stuSpecialty == null){
                    $("#errStuSpecialty").html("请输入专业名称");
                    $("#stuSpecialty").focus(function () {
                        $("#errStuSpecialty").html("");
                    });
                }else if(stuPhone == "" || stuPhone == null){
                    $("#errStuPhone").html("请输入电话号码");
                    $("#stuPhone").focus(function () {
                        $("#errStuPhone").html("");
                    });
                }else if(isNaN(stuPhone) || stuPhone == "" || stuPhone == null){
                    $("#errStuPhone").html("电话号码由数字组成");
                    $("#stuPhone").focus(function () {
                        $("#errStuPhone").html("");
                    });
                }else if(!(regxPhonePattern.test(stuPhone))){
                    $("#errStuPhone").html("手机号码为数字1开头的11位数字组成");
                    $("#stuPhone").focus(function () {
                        $("#errStuPhone").html("");
                    });
                }else if(stuDegree == "-请选择-" || stuDegree == null){
                    $("#errStuDegree").html("请选择您的学历");
                    $("#stuDegree").focus(function () {
                        $("#errStuDegree").html("");
                    });
                }else if(stuAddress == "" || stuAddress == null){
                    $("#errStuAddress").html("请填写您的地址");
                    $("#stuAddress").focus(function () {
                        $("#errStuAddress").html("");
                    });
                }else{
                    //提交表单数据
                    var studentData = {
                        stuNo : stuNo,
                        stuId : stuId,
                        stuPwd : stuPwd,
                        stuName : stuName,
                        stuAge : stuAge,
                        stuSex : stuSex,
                        stuSchool : stuSchool,
                        stuSpecialty : stuSpecialty,
                        stuPhone : stuPhone,
                        stuAddress : stuAddress,
                        stuDegree : stuDegree,
                        stuPower : stuPower
                    };
                    var data = JSON.stringify({
                        "student" : studentData
                    });
                    //通过jquery的格式转换成String
                    //通过ajax传送到服务端
                    $.ajax({
                        type : "post",
                        data : data,
                        dataType : "json",
                        async : false,
                        cache : false,
                        contentType : "application/json;charset=UTF-8",
                        url : "${pageContext.request.contextPath}/student/stuRegist",
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
                            alert("注册失败!请重新注册！");
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
            <h2 style="color: lightseagreen;">学生注册</h2>
            <hr/>
        </div>

        <form class="form-horizontal">
            <div class="container">
                <div class="row" style="padding: 20px 0">
                    <h3 style="color: #26A65B;border-left: 6px solid #26A65B;">请填写您的个人信息>></h3>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2" for="stuId" style="color: #EB7347;">用户名：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="stuId" id="stuId" type="text" placeholder="请输入您的用户名(用户名由's'开头的6-10位数字、字母或下划线组成)">
                        <div id="errStuId" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuPwd" style="color: #EB7347">密码：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="stuPwd" id="stuPwd" type="password" placeholder="请输入您的登录密码(密码由6-10位数字、字母或下划线组成)">
                        <div id="errStuPwd" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="confirmStuPwd" style="color: #EB7347">确认密码：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="confirmStuPwd" id="confirmStuPwd" type="password" placeholder="请确认您的登录密码(密码由6-10位数字、字母或下划线组成)">
                        <div id="errConfirmStuPwd" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuNo">*学号：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="stuNo" id="stuNo" type="text" placeholder="请输入您的学号(学号由数字组成)">
                        <div id="errStuNo" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuName">*姓名：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="stuName" id="stuName" type="text" placeholder="请输入您的学生姓名">
                        <div id="errStuName" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuAge">*年龄：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="stuAge" id="stuAge" type="text" placeholder="请输入您的年龄">
                        <div id="errStuAge" style="color: orange"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" style="position: relative;top: -7px;">*性别：</label>
                    <div class="col-lg-7 col-md-6" style="color: white">
                        <input class="stuSex" name="stuSex" type="radio" value="男"><span style="color: #2C3E50;">男</span></input>&nbsp;&nbsp;&nbsp;
                        <input class="stuSex" name="stuSex" type="radio" value="女"><span style="color: #2C3E50;">女</span></input>
                        <div id="errStuSex" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuSchool">*学校：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="stuSchool" id="stuSchool" type="text" placeholder="请输入您的学校">
                        <div id="errStuSchool" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuSpecialty">*专业：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="stuSpecialty" id="stuSpecialty" type="text" placeholder="请输入您的专业">
                        <div id="errStuSpecialty" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuPhone">*手机号：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" name="stuPhone" id="stuPhone" type="text" placeholder="请输入您的手机号">
                        <div id="errStuPhone" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuDegree">*学历：</label>
                    <div class="col-lg-7 col-md-6">
                            <select class="form-control" name="stuDegree" id="stuDegree">
                                <option>-请选择-</option>
                                <option>大专</option>
                                <option>本科</option>
                                <option>硕士研究生</option>
                                <option>博士研究生</option>
                            </select>
                        <div id="errStuDegree" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuAddress">*个人地址：</label>
                    <div class="col-lg-7 col-md-6">
                        <textarea class="form-control" rows="5" name="stuAddress" id="stuAddress" placeholder="请填写您的个人真实地址"></textarea>
                        <div id="errStuAddress" style="color: orange;"></div>
                    </div>
                </div>

                <div class="row form-group">
                    <label class="control-label col-lg-2 text-success" for="stuPower">*用户权限(学生)：</label>
                    <div class="col-lg-7 col-md-6">
                        <input class="form-control" rows="5" name="stuPower" id="stuPower" value="1" style="background-color: #EB7347;" disabled></input>
                        <div id="errStuPower" style="color: orange;color: #c9302c">(提示：注册时系统默认提供学生权限)</div>
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
