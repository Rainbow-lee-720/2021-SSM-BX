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
    <title>个人中心</title>
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
        background-color: #EB7347;
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

        //Ajax校验用户名是否已被注册
        $("#adminId").blur(function () {
            var username = $.trim($("#adminId").val());
            var json = {
                username : username
            };
            var data = JSON.stringify(json);
            if(username == "" || username == null){
                $("#errAdminId").html("请输入用户名");
                $("#adminId").focus();
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
                            $("#errAdminId").css("color","red").html(msg);
                            $("#adminId").focus(function () {
                                $("#errAdminId").html("");
                            });
                        }else{
                            //用户名未注册 提示可以注册
                            var msg = data.msg1;
                            $("#errAdminId").css("color","green").html(msg);
                        }
                    }
                });
            }

        });

        //提交编辑的数据
        $("#submit").click(function () {
            //获取表单值
            var adminNo = $.trim($("#adminNo").val());
            var adminId = $.trim($("#adminId").val());
            var adminName = $.trim($("#adminName").val());
            var adminPhone = $.trim($("#adminPhone").val());
            var adminSex = $.trim($("#adminSex").val());
            //管理员权限
            var adminPower = $.trim($("#adminPower").val());

            //用户名密码正则表达式
            var regxUserPattern = /^a(\w){6,10}$/;
            //手机号正则表达式
            var regxPhonePattern = /^1[34578]\d{9}$/;
            //非空校验
            if(adminId == "" || adminId == null){
                $("#errAdminId").html("请输入用户名");
                $("#adminId").focus(function () {
                    $("#errAdminId").html("");
                });
            }else if(!(regxUserPattern.test(adminId))){
                $("#errAdminId").html("用户名必须由a开头的6-10位数字、字母或下划线组成");
                $("#adminId").focus(function () {
                    $("#errAdminId").html("");
                });
            }else if(adminName == "" || adminName == null){
                $("#errAdminName").html("请输入管理员姓名");
                $("#adminName").focus(function () {
                    $("#errAdminName").html("");
                });
            }else if(adminPhone == "" || adminPhone == null){
                $("#errAdminPhone").html("请输入管理员电话");
                $("#adminPhone").focus(function () {
                    $("#errAdminPhone").html("");
                });
            }else if(isNaN(adminPhone || adminPhone == "" || adminPhone == null)){
                $("#errAdminPhone").html("管理员电话号码由数字组成");
                $("#adminPhone").focus(function () {
                    $("#errAdminPhone").html("");
                });
            }else if(!(regxPhonePattern.test(adminPhone))){
                $("#errAdminPhone").html("管理员电话号码为数字1开头的11位数字组成");
                $("#adminPhone").focus(function () {
                    $("#errAdminPhone").html("");
                });
            }else{
                //提交表单数据
                var adminData = {
                    adminNo : adminNo,
                    adminId : adminId,
                    adminName : adminName,
                    adminPhone : adminPhone,
                    adminSex : adminSex,
                    adminPower : adminPower
                };
                //通过jquery的格式转换成String
                var data = JSON.stringify({
                    "admin" : adminData
                });
                //通过ajax传送到服务端
                $.ajax({
                    type : "post",
                    data : data,
                    dataType : "json",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/admin/updateAdmin",
                    success : function (resp) {
                        if(resp.result){
                            //修改成功
                            alert(resp.msg1);
                            //刷新表格数据
                            history.go(0);
                        }else{
                            //修改失败
                            alert(resp.msg1);
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/admin/adminCenter?adminNo=${admin.adminNo}";
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
            <div id="div3"><span class="glyphicon glyphicon-magnet"></span><span>&nbsp;个人中心</span></div>
        </div>

        <div id="div4">

            <div class="alert alert-success">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>您可以在此页面编辑您的个人资料
            </div>

            <div class="alert alert-info">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>管理员编号、管理员权限信息不可编辑
            </div>

            <div style="padding: 40px 100px 10px;">
                <p style="color: lightseagreen;font-weight: bold;font-size:20px;">丨<span>&nbsp;&nbsp;</span>个人信息编辑</p>
                <hr class="span2">
                <br>

                <form class="bs-example bs-example-form" role="form">
                    <div class="input-group">
                        <span class="input-group-addon span">编号：</span>
                        <input id="adminNo" type="text" class="form-control" placeholder="请编辑您的管理员编号" style="color: orange;" value="${adminInfo.adminNo}" disabled>
                    </div>
                    <br>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">ID：</span>
                        <input id="adminId" type="text" class="form-control" placeholder="请编辑您的ID" value="${adminInfo.adminId}">
                        <div id="errAdminId" style="color: orange;"></div>
                    </div>
                    <br>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">姓名：</span>
                        <input id="adminName" type="text" class="form-control" placeholder="请编辑您的姓名" value="${adminInfo.adminName}">
                        <div id="errAdminName" style="color: orange;"></div>
                    </div>
                    <br>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">电话：</span>
                        <input id="adminPhone" type="text" class="form-control" placeholder="请编辑您的电话" value="${adminInfo.adminPhone}">
                        <div id="errAdminPhone" style="color: orange;"></div>
                    </div>
                    <br>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">性别：</span>
                        <select  class="form-control" id="adminSex" name="adminSex">
                            <option>${adminInfo.adminSex}</option>
                            <!-- 判断性别 将原始数据带入 -->
                            <c:if test="${adminInfo.adminSex=='男'}">
                                <option value="女" style="color: orangered;">女</option>
                            </c:if>
                            <c:if test="${adminInfo.adminSex=='女'}">
                                <option value="男" style="color: lightgreen;">男</option>
                            </c:if>
                        </select>
                    </div>
                    <br>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">权限：</span>
                        <c:if test="${adminInfo.adminPower==0}">
                            <input id="adminPower" type="text" class="form-control" placeholder="请编辑您的管理员权限" style="color: orange;" value="Admin" disabled>
                        </c:if>

                    </div>

                    <div class="row form-group" style="margin: 50px auto;">
                        <button type="button" id="submit" class="btn btn-success" style="position:relative;left: 520px;">提交</button>
                        <button type="reset" id="reset" class="btn btn-warning" style="position:relative;left: 570px;">重置</button>
                        <button type="button" id="back" class="btn btn-danger" style="position:relative;left: 620px;">退出</button>
                    </div>
                </form>
            </div>

        </div>

    </div>
</body>
</html>
