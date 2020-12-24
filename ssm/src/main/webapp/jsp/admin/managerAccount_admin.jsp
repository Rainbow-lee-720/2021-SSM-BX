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
    <title>账号管理</title>
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
    }
    #div2{
        height : 50px;
        background-color: #8799a3;
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
</style>

<script type="text/javascript">

    $(function () {
        //返回上一级
        $("#back").click(function () {
            history.go(-1);
        });

        //Ajax校验原密码是否输入正确
        $("#oldPwd").blur(function () {
            var oldPwd = $.trim($("#oldPwd").val());
            var json = {
                oldPwd : oldPwd
            };
            var data = JSON.stringify(json);
            if(oldPwd == "" || oldPwd == null){
                $("#errOldPwd").html("请输入原密码");
                $("#oldPwd").focus();
            }else{
                $.ajax({
                    type : "post",
                    data : data,
                    cache : false,
                    async: false,
                    contentType : "application/json;charset=UTF-8",
                    dataType: "json",
                    url: "${pageContext.request.contextPath}/utilController/checkOldPwdRight",
                    success : function (data) {
                        if(data.result){
                            //原密码输入正确
                            var msg = data.msg1;
                            $("#errOldPwd").css("color","green").html(msg);
                            $("#oldPwd").focus(function () {
                                $("#errOldPwd").html("");
                            });
                        }else{
                            //原密码输入错误 提示用户错误信息
                            var msg = data.msg1;
                            $("#errOldPwd").css("color","red").html(msg);
                        }
                    }
                });
            }

        });

        //提交编辑的数据 账号管理 修改用户密码
        $("#submit").click(function () {
            //获取表单值
            var newPwd = $.trim($("#newPwd").val());
            var confirmPwd = $.trim($("#confirmPwd").val());

            //用户名密码正则表达式
            var regxUserPattern = /^(\w){6,10}$/;
            //非空校验
            if(newPwd == "" || newPwd == null){
                $("#errNewPwd").html("请输入您的新密码");
                $("#newPwd").focus(function () {
                    $("#errNewPwd").html("");
                });
            }else if(confirmPwd == "" || confirmPwd == null){
                $("#errConfirmPwd").html("请确认您的密码");
                $("#confirmPwd").focus(function () {
                    $("#errConfirmPwd").html("");
                });
            }else if(!(regxUserPattern.test(newPwd))){
                $("#errNewPwd").html("密码必须由6-10位数字、字母或下划线组成");
                $("#newPwd").focus(function () {
                    $("#errNewPwd").html("");
                });
            }else if(!(regxUserPattern.test(confirmPwd))){
                $("#errConfirmPwd").html("密码必须由6-10位数字、字母或下划线组成");
                $("#confirmPwd").focus(function () {
                    $("#errConfirmPwd").html("");
                });
            }else{
                //提交表单数据
                var newPwd = {
                    newPwd : newPwd,
                    confirmPwd : confirmPwd,
                };
                //通过jquery的格式转换成String
                var data = JSON.stringify({
                    "entityData" : newPwd
                });
                //通过ajax传送到服务端
                $.ajax({
                    type : "post",
                    data : data,
                    dataType : "json",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/utilController/managerAccount",
                    success : function (resp) {
                        if(resp.result){
                            //修改成功
                            alert(resp.msg1);
                            //跳转到登录页面
                            parent.location.href = "${pageContext.request.contextPath}/utilController/visitLogin";
                        }else{
                            //修改失败
                            alert(resp.msg1);
                            //刷新重试
                            history.go(0);
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
            <div id="div3"><span class="glyphicon glyphicon-wrench"></span><span>&nbsp;账号管理</span></div>
        </div>

        <div id="div4">

            <p style="color:lightseagreen;font-weight: bold;font-size: 28px;">密码重置</p>

            <hr class="span2">

            <div class="alert alert-danger">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>修改账号密码前请先输入原密码
            </div>

            <div class="alert alert-info">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>待原密码正确且两次新密码校验正确后将会跳转到登录界面
            </div>

            <div style="padding: 40px 0px;">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="oldPwd" class="col-sm-2 control-label"><span style="font-weight: bold;font-size: 20px;">原密码</span></label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="oldPwd" placeholder="请输入原密码">
                            <div id="errOldPwd" style="color: orange;"></div>
                        </div>
                    </div>
                    <br>
                    <br>
                    <div class="form-group">
                        <label for="newPwd" class="col-sm-2 control-label"><span style="font-weight: bold;font-size: 20px;">新密码</span></label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="newPwd" placeholder="请输入新密码">
                            <div id="errNewPwd" style="color: orange;"></div>
                        </div>
                    </div>
                    <br>
                    <br>
                    <div class="form-group">
                        <label for="confirmPwd" class="col-sm-2 control-label"><span style="font-weight: bold;font-size: 20px;">确认密码</span></label>
                        <div class="col-sm-10">
                            <input type="password" class="form-control" id="confirmPwd" placeholder="请确认新密码">
                            <div id="errConfirmPwd" style="color: orange;"></div>
                        </div>
                    </div>
                    <br>
                    <br>

                    <hr class="span2">

                    <div class="row form-group" style="margin: 50px auto;">
                        <button type="button" id="submit" class="btn btn-success" style="position:relative;left: 530px;">提交</button>
                        <button type="reset" id="reset" class="btn btn-warning" style="position:relative;left: 580px;">重置</button>
                        <button type="button" id="back" class="btn btn-danger" style="position:relative;left: 630px;">退出</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</body>
</html>
