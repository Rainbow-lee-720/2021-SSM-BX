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
    <title>企业中心</title>
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

        //提交编辑的数据
        $("#submit").click(function () {
            //获取表单值
            var comId = $.trim($("#comId").val());
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
            }else if(comName == "" || comName == null){
                $("#errComName").html("请输入企业名称");
                $("#comName").focus(function () {
                    $("#errComName").html("");
                });
            }else if(comNum == "" || comNum == null){
                $("#errComNum").html("请输入企业人数规模");
                $("#comNum").focus(function () {
                    $("#errComNum").html("");
                });
            }else if(isNaN(comNum) || comNum == "" || comNum == null){
                $("#errComNum").html("企业人数规模必须由数字组成");
                $("#comNum").focus(function () {
                    $("#errComNum").html("");
                });
            }else if(comAddress == "" || comAddress == null){
                $("#errComAddress").html("请输入企业地址");
                $("#comAddress").focus(function () {
                    $("#errComAddress").html("");
                });
            }else if(comPhone == "" || comPhone == null){
                $("#errComPhone").html("请输入电话号码");
                $("#comPhone").focus(function () {
                    $("#errComPhone").html("");
                });
            }else if(isNaN(comPhone) || comPhone == "" || comPhone == null){
                $("#errComPhone").html("电话号码由数字组成");
                $("#comPhone").focus(function () {
                    $("#errComPhone").html("");
                });
            }else if(!(regxPhonePattern.test(comPhone))){
                $("#errComPhone").html("手机号码为数字1开头的11位数字组成");
                $("#comPhone").focus(function () {
                    $("#errComPhone").html("");
                });
            }else if(comKind == "-请选择-" || comKind == null){
                $("#errComKind").html("请选择企业性质");
                $("#comKind").focus(function () {
                    $("#errComKind").html("");
                });
            }else if(comType == "-请选择-" || comType == null){
                $("#errComType").html("请选择企业类型");
                $("#comType").focus(function () {
                    $("#errComType").html("");
                });
            }else if(comBack == "" || comBack == null){
                $("#errComBack").html("请填写您的地址");
                $("#comBack").focus(function () {
                    $("#errComBack").html("");
                });
            }else{
                //提交表单数据
                var companyData = {
                    comNo : comNo,
                    comId : comId,
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
                    url : "${pageContext.request.contextPath}/company/updateCom",
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
                            window.location.href = "${pageContext.request.contextPath}/company/comCenter?comNo=${company.comNo}";
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
    function logOutCom(comNo){
        $.ajax({
            type : "get",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/company/logOutCom?comNo=" + comNo,
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
            <div id="div3"><span class="glyphicon glyphicon-briefcase"></span><span>&nbsp;企业中心</span></div>
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
                                    企业账号注销
                                </h4>
                            </div>
                            <div class="modal-body text-center">
                                <p style="font-weight: bold;font-size: 18px;color: #8799a3;">当前企业账号为：<span style="font-weight: bold;color:#f37b1d;">${company.comId}</span></p>
                                <p style="font-weight: bold;font-size: 18px;color: #8799a3;">确认注销此账号？</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-warning" onclick="logOutCom('${company.comNo}')" data-dismiss="modal">
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
                <strong>提示：</strong>您可以在此页面编辑您的企业资料
            </div>

            <div class="alert alert-info">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>提示：</strong>企业编号、企业权限信息不可编辑
            </div>

            <div class="alert alert-danger">
                <a href="#" class="close" data-dismiss="alert">
                    <span class="glyphicon glyphicon-remove-sign"></span>
                </a>
                <strong>注意：</strong>企业信息更新后 <b>企业招聘信息需及时更新!</b>
            </div>

            <div style="padding: 25px 100px 10px;">
                <p style="color: lightseagreen;font-weight: bold;font-size:20px;">丨<span>&nbsp;&nbsp;</span>企业信息编辑</p>
                <hr class="span2">
                <br>

                <form class="bs-example bs-example-form" role="form">
                    <div class="input-group">
                        <span class="input-group-addon span">编号：</span>
                        <input id="comNo" type="text" class="form-control" placeholder="请编辑您的企业编号" style="color: orange;" value="${comInfo.comNo}" disabled>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">ID：</span>
                        <input id="comId" type="text" class="form-control" placeholder="请编辑您的ID" value="${comInfo.comId}">
                        <div id="errComId" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">名称：</span>
                        <input id="comName" type="text" class="form-control" placeholder="请编辑您的企业名称" value="${comInfo.comName}">
                        <div id="errComName" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">电话：</span>
                        <input id="comPhone" type="text" class="form-control" placeholder="请编辑您的企业电话" value="${comInfo.comPhone}">
                        <div id="errComPhone" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">规模：</span>
                        <input id="comNum" type="text" class="form-control" placeholder="请编辑您的企业规模" value="${comInfo.comNum}">
                        <div id="errComNum" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">性质：</span>
                        <select class="form-control" name="comKind" id="comKind">
                            <option>${comInfo.comKind}</option>
                            <option>-请选择-</option>
                            <option>私企</option>
                            <option>国企</option>
                            <option>合资</option>
                            <option>外资</option>
                            <option>事业单位</option>
                        </select>
                        <div id="errComKind" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">类型：</span>
                        <select class="form-control" name="comType" id="comType">
                            <option>${comInfo.comType}</option>
                            <option>-请选择-</option>
                            <%--                            <c:forEach var="companys" items="${comTypeList}">--%>
                            <%--                                <option>--%>
                            <%--                                    ${companys.comType}--%>
                            <%--                                </option>--%>
                            <%--                            </c:forEach>--%>
                            <option>医疗</option>
                            <option>金融</option>
                            <option>法律</option>
                            <option>物流</option>
                            <option>设计</option>
                            <option>互联网</option>
                            <option>服务业</option>
                        </select>
                        <div id="errComType" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">地址：</span>
                        <textarea id="comAddress" type="text" class="form-control" placeholder="请编辑您的企业地址" value="">${comInfo.comAddress}</textarea>
                        <div id="errComAddress" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">简介：</span>
                        <textarea id="comBack" type="text" class="form-control" placeholder="请编辑您的企业简介" value="">${comInfo.comBack}</textarea>
                        <div id="errComBack" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">权限：</span>
                        <c:if test="${comInfo.comPower==2}">
                            <input id="comPower" type="text" class="form-control" placeholder="请编辑您的企业权限" style="color: green;" value="Company" disabled>
                        </c:if>
                        <c:if test="${comInfo.comPower==-1}">
                            <input id="comPower" type="text" class="form-control" placeholder="请编辑您的企业权限" style="color: orangered;" value="已注销" disabled>
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
