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
        border: 1px solid lightgray;
        width : 1540px;
        height: 900px;
        overflow: auto;
        overflow-x: hidden;
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

        //Ajax校验用户名是否已被注册
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

        //提交编辑的数据
        $("#submit").click(function () {
            //获取表单值
            var stuId = $.trim($("#stuId").val());
            var stuNo = $.trim($("#stuNo").val());
            var stuName = $.trim($("#stuName").val());
            var stuAge = $.trim($("#stuAge").val());
            var stuSex = $.trim($("#stuSex").val());
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
            //非空校验
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
                //通过jquery的格式转换成String
                var data = JSON.stringify({
                    "student" : studentData
                });
                //通过ajax传送到服务端
                $.ajax({
                    type : "post",
                    data : data,
                    dataType : "json",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/student/updateStu",
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
                            window.location.href = "${pageContext.request.contextPath}/student/stuCenter?stuNo=${student.stuNo}";
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
    //账号注销
    function logOutCom(stuNo){
        $.ajax({
            type : "get",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/student/logOutCom?stuNo=" + stuNo,
            success : function (resp) {
                //处理注销结果
                if(resp.result) {
                    //注销成功后清除session 跳转到登录页面
                    $("myModal").css("display","none");
                    parent.location.href = "${pageContext.request.contextPath}/utilController/visitLogin";
                }else{
                    //注销失败
                    alert(resp.msg1);
                    history.go(0);
                }
            }
        });
    }
</script>
<body>
    <div id="div1">
        <div id="div2">
            <div id="div3"><span class="glyphicon glyphicon-magnet"></span><span>&nbsp;个人中心</span></div>
            <div id="div5">
                <!-- 新增Add按钮 -->
                <button class="btn btn-default" data-toggle="modal" data-target="#myModal" disabled>
                    <span class="glyphicon glyphicon-remove-sign"></span>&nbsp;注销
                </button>
                <!-- 模态框（Modal） -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    <span class="glyphicon glyphicon-remove"></span>
                                </button>
                                <h4 class="modal-title text-center" id="myModalLabel2" style="color: lightseagreen;font-weight: bold;;font-size: 22px;">
                                    学生账号注销
                                </h4>
                            </div>
                            <div class="modal-body text-center">
                                <p style="font-weight: bold;font-size: 18px;color: #8799a3;">当前学生账号为：<span style="font-weight: bold;color:#f37b1d;">${student.stuId}</span></p>
                                <p style="font-weight: bold;font-size: 18px;color: #8799a3;">确认注销此账号？</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-warning" onclick="logOutCom('${student.stuNo}')" data-dismiss="modal">
                                    确认
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
                <strong>提示：</strong>学生学号、学生权限信息不可编辑
            </div>

            <div class="alert alert-danger">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>注意：</strong>学生个人信息更新后 <b>学生求职信息需及时更新!</b>
            </div>

            <div style="padding: 25px 100px 10px;">
                <p style="color: lightseagreen;font-weight: bold;font-size:20px;">丨<span>&nbsp;&nbsp;</span>个人信息编辑</p>
                <hr class="span2">
                <br>

                <form class="bs-example bs-example-form" role="form">
                    <div class="input-group">
                        <span class="input-group-addon span">学号：</span>
                        <input id="stuNo" type="text" class="form-control" placeholder="请编辑您的学号" style="color: orange;" value="${stuInfo.stuNo}" disabled>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">ID：</span>
                        <input id="stuId" type="text" class="form-control" placeholder="请编辑您的ID" value="${stuInfo.stuId}">
                        <div id="errStuId" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">姓名：</span>
                        <input id="stuName" type="text" class="form-control" placeholder="请编辑您的姓名" value="${stuInfo.stuName}">
                        <div id="errStuName" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">性别：</span>
                        <select  class="form-control" id="stuSex" name="stuSex">
                            <option>${stuInfo.stuSex}</option>
                            <!-- 判断性别 将原始数据带入 -->
                            <c:if test="${stuInfo.stuSex=='男'}">
                                <option value="女" style="color: orangered;">女</option>
                            </c:if>
                            <c:if test="${stuInfo.stuSex=='女'}">
                                <option value="男" style="color: lightgreen;">男</option>
                            </c:if>
                        </select>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">年龄：</span>
                        <input id="stuAge" type="text" class="form-control" placeholder="请编辑您的年龄" value="${stuInfo.stuAge}">
                        <div id="errStuAge" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">学校：</span>
                        <input id="stuSchool" type="text" class="form-control" placeholder="请编辑您的学校" value="${stuInfo.stuSchool}">
                        <div id="errStuSchool" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">学历：</span>
                        <select class="form-control" name="stuDegree" id="stuDegree">
                            <option>${stuInfo.stuDegree}</option>
                            <option>-请选择-</option>
                            <option>大专</option>
                            <option>本科</option>
                            <option>硕士研究生</option>
                            <option>博士研究生</option>
                        </select>
                        <div id="errStuDegree" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">专业：</span>
                        <input id="stuSpecialty" type="text" class="form-control" placeholder="请编辑您的专业" value="${stuInfo.stuSpecialty}">
                        <div id="errStuSpecialty" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">电话：</span>
                        <input id="stuPhone" type="text" class="form-control" placeholder="请编辑您的电话" value="${stuInfo.stuPhone}">
                        <div id="errStuPhone" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">地址：</span>
                        <textarea id="stuAddress" type="text" class="form-control" placeholder="请编辑您的地址" value="">${stuInfo.stuAddress}</textarea>
                        <div id="errStuAddress" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">权限：</span>
                        <c:if test="${stuInfo.stuPower==1}">
                            <input id="comPower" type="text" class="form-control" placeholder="请编辑您的学生权限" style="color: green;" value="Student" disabled>
                        </c:if>
                        <c:if test="${stuInfo.stuPower==-1}">
                            <input id="comPower" type="text" class="form-control" placeholder="请编辑您的学生权限" style="color: orangered;" value="已注销" disabled>
                        </c:if>
                    </div>

                    <div class="row form-group" style="margin: 50px auto;">
                        <button type="button" id="submit" class="btn btn-success" style="position:relative;left: 520px;">更新</button>
                        <button type="reset" id="reset" class="btn btn-warning" style="position:relative;left: 570px;">重置</button>
                        <button type="button" id="back" class="btn btn-danger" style="position:relative;left: 620px;">退出</button>
                    </div>
                </form>
            </div>

        </div>

    </div>
</body>
</html>
