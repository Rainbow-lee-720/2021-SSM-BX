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
    <title>求职信息</title>
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
    .noInter{
        width: 700px;
        height: 190px;
        font-size: 19px;

    }
</style>

<script type="text/javascript">
    $(function () {
        //返回上一级
        $("#back").click(function () {
            history.go(-1);
        });

        //提交编辑的数据
        $("#submit").click(function () {
            //获取表单值
            var interNo = $.trim($("#interNo").val());
            var interStuNo = $.trim($("#interStuNo").val());
            var interName = $.trim($("#interName").val());
            var interSex = $.trim($("#interSex").val());
            var interAge = $.trim($("#interAge").val());
            var interSpecialty = $.trim($("#interSpecialty").val());
            var interSchool = $.trim($("#interSchool").val());
            var interDegree = $.trim($("#interDegree").val());
            var interPhone = $.trim($("#interPhone").val());
            var interPosition = $.trim($("#interPosition").val());
            var interSalary = $.trim($("#interSalary").val());
            var interLocation = $.trim($("#interLocation").val());

            //手机号正则表达式
            var regxPhonePattern = /^1[34578]\d{9}$/;
            //非空校验
            if(interName == "" || interName == null){
                $("#errInterName").html("请输入姓名");
                $("#interName").focus(function () {
                    $("#errInterName").html("");
                });
            }else if(interAge == "" || interAge == null){
                $("#errInterAge").html("请选择性别");
            }else if(interAge == "" || interAge == null){
                $("#errInterAge").html("请输入年龄");
                $("#interAge").focus(function () {
                    $("#errInterAge").html("");
                });
            }else if(isNaN(interAge) || interAge == "" || interAge == null){
                $("#errInterAge").html("年龄必须由数字组成");
                $("#interAge").focus(function () {
                    $("#errInterAge").html("");
                });
            }else if(interSchool == "" || interSchool == null){
                $("#errInterSchool").html("请输入学校名称");
                $("#interSchool").focus(function () {
                    $("#errInterSchool").html("");
                });
            }else if(interDegree == "-请选择-" || interDegree == null){
                $("#errInterDegree").html("请选择您的学历");
                $("#interDegree").focus(function () {
                    $("#errInterDegree").html("");
                });
            }else if(interSpecialty == "" || interSpecialty == null){
                $("#errInterSpecialty").html("请输入专业名称");
                $("#interSpecialty").focus(function () {
                    $("#errInterSpecialty").html("");
                });
            }else if(interPhone == "" || interPhone == null){
                $("#errInterPhone").html("请输入电话号码");
                $("#interPhone").focus(function () {
                    $("#errInterPhone").html("");
                });
            }else if(isNaN(interPhone) || interPhone == "" || interPhone == null){
                $("#errInterPhone").html("电话号码由数字组成");
                $("#interPhone").focus(function () {
                    $("#errInterPhone").html("");
                });
            }else if(!(regxPhonePattern.test(interPhone))){
                $("#errInterPhone").html("电话号码为数字1开头的11位数字组成");
                $("#interPhone").focus(function () {
                    $("#errInterPhone").html("");
                });
            }else if(interPosition == "" || interPosition == null){
                $("#errInterPosition").html("请填写您的求职职位");
                $("#interPosition").focus(function () {
                    $("#errInterPosition").html("");
                });
            }else if(interSalary == "" || interSalary == null){
                $("#errInterSalary").html("请输入期望薪资");
                $("#interSalary").focus(function () {
                    $("#errInterSalary").html("");
                });
            }else if(isNaN(interSalary) || interSalary == "" || interSalary == null){
                $("#errInterSalary").html("期望薪资必须由数字组成");
                $("#interSalary").focus(function () {
                    $("#errInterSalary").html("");
                });
            }else if(interLocation == "" || interLocation == null){
                $("#errInterLocation").html("请填写您的求职工作地");
                $("#interLocation").focus(function () {
                    $("#errInterLocation").html("");
                });
            }else{
                //提交表单数据
                var interData = {
                    interNo : interNo,
                    interStuNo : interStuNo,
                    interName : interName,
                    interSex : interSex,
                    interAge : interAge,
                    interSpecialty : interSpecialty,
                    interSchool : interSchool,
                    interDegree : interDegree,
                    interPhone : interPhone,
                    interPosition : interPosition,
                    interSalary : interSalary,
                    interLocation : interLocation
                };
                //通过jquery的格式转换成String
                var data = JSON.stringify({
                    "interview" : interData
                });
                //通过ajax传送到服务端
                $.ajax({
                    type : "post",
                    data : data,
                    dataType : "json",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/interview/updateInterview",
                    success : function (resp) {
                        if(resp.result){
                            //添加成功
                            alert(resp.msg1);
                            //刷新表格数据
                            history.go(0);
                        }else{
                            //修改失败
                            alert(resp.msg1);
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/interview/queryInterByStuNo?interStuNo=${student.stuNo}";
                        }
                    },
                    error : function () {
                        //请求失败
                        alert("请求失败!请重试！");
                    }
                });
            }

        });

        //校验
        var interStuNo = $("#interStuNo").val();
        if(interStuNo == "" || interStuNo == null){
            $("#div4").html("<div class=\"panel panel-primary noInter center-block\">\n" +
                "\t<div class=\"panel-heading text-center\">\n" +
                "\t\t<h2 class=\"panel-title\">提示</h2>\n" +
                "\t</div>\n" +
                "\t<div class=\"panel-body text-center\">\n" +
                "\t\t提示：您还未填写学生求职信息 请点击右上角的\"<span style=\"color: lightseagreen;font-weight: bold\">新增</span>\"按钮填写\n" +
                "\t</div>\n" +
                "</div>");
            $("#delInfo").css("display","none");
        }else{
            $("#div5").html("<button id=\"delInfo\" onclick=\"delInter('${stuInfo.stuNo}')\" class=\"btn btn-danger\" data-toggle=\"modal\" data-target=\"#myModal\">\n" +
                "                    <span class=\"glyphicon glyphicon-remove\"></span>&nbsp;删除\n" +
                "                </button>");
        }
    });

    //添加求职信息
    function addInter() {
        location.href = "${pageContext.request.contextPath}/jsp/student/interview_add_stu.jsp";
    }

    //删除求职信息
    function delInter(stuNo){
        if(confirm("确定删除求职信息?")){
                $.ajax({
                    type : "post",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/interview/delInter?interStuNo=" + stuNo,
                    success : function (resp) {
                        //处理查询结果
                        if(resp.result) {
                            //删除成功
                            //alert("学号" + resp.msg1 + "的求职信息删除成功！");
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/interview/queryInterByStuNo?interStuNo=${student.stuNo}";
                        }else{
                            //删除失败
                            alert("学号" + resp.msg1 + "的求职信息删除失败！");
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/interview/queryInterByStuNo?interStuNo=${student.stuNo}";
                        }
                    }
                });
        }
    }
</script>
<body>
    <div id="div1">
        <div id="div2">
            <div id="div3"><span class="glyphicon glyphicon-leaf"></span><span>&nbsp;求职信息</span></div>
            <div id="div5">
                <!-- 新增Add按钮 -->
                <button id="add" onclick="addInter()" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;新增
                </button>
            </div>
        </div>
        <br>

        <div class="alert alert-success">
            <a href="#" class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove-sign"></span>
            </a>
            <strong>提示：</strong>您可以在此页面查看或修改您的求职信息<b>(学生个人中心数据可能有更新的情况 请随时更新求职信息)</b>
        </div>

        <div class="alert alert-info" id="delInfo">
            <a href="#" class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove-sign"></span>
            </a>
            <strong>提示：</strong>点击右上角的"<span style="color: orangered;font-weight: bold">删除</span>"按钮可删除求职信息
        </div>

        <div class="alert alert-danger">
            <a href="#" class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove-sign"></span>
            </a>
            <strong>注意：</strong>求职信息只能添加一次 添加后只能进行修改和删除操作！
        </div>

        <div id="div4">
            <div style="padding: 25px 100px 10px;">
                <p style="color: lightseagreen;font-weight: bold;font-size:20px;">丨<span>&nbsp;&nbsp;</span>求职信息更新</p>
                <hr class="span2">
                <br>

                <form class="bs-example bs-example-form" role="form">
                    <div class="input-group" style="display: none;">
                        <span class="input-group-addon span">编号：</span>
                        <input id="interNo" type="text" class="form-control" value="${interInfo.interNo}" disabled>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">学号：</span>
                        <input id="interStuNo" type="text" class="form-control" value="${stuInfo.stuNo}" disabled>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">姓名：</span>
                        <input id="interName" type="text" class="form-control" value="${stuInfo.stuName}" disabled>
                        <div id="errInterName" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">性别：</span>
                        <select  class="form-control" id="interSex" name="interSex" disabled>
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
                        <input id="interAge" type="text" class="form-control" value="${stuInfo.stuAge}" disabled>
                        <div id="errInterAge" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">学校：</span>
                        <input id="interSchool" type="text" class="form-control" value="${stuInfo.stuSchool}" disabled>
                        <div id="errInterSchool" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">学历：</span>
                        <select class="form-control" name="interDegree" id="interDegree" disabled>
                            <option>${stuInfo.stuDegree}</option>
                            <option>-请选择-</option>
                            <option>大专</option>
                            <option>本科</option>
                            <option>硕士研究生</option>
                            <option>博士研究生</option>
                        </select>
                        <div id="errInterDegree" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">专业：</span>
                        <input id="interSpecialty" type="text" class="form-control" value="${stuInfo.stuSpecialty}" disabled>
                        <div id="errInterSpecialty" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">电话：</span>
                        <input id="interPhone" type="text" class="form-control" value="${stuInfo.stuPhone}" disabled>
                        <div id="errInterPhone" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">求职职位：</span>
                        <input id="interPosition" type="text" class="form-control" style="font-weight: bold;color: #f37b1d;" placeholder="请编辑您的求职职位" value="${interInfo.interPosition}"></input>
                        <div id="errInterPosition" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">期望薪资：</span>
                        <input id="interSalary" type="text" class="form-control"  style="font-weight: bold;color: #f37b1d;" placeholder="请编辑您的期望薪资" value="${interInfo.interSalary}">
                        <div id="errInterSalary" style="color: orange;"></div>
                    </div>
                    <br>
                    <div class="input-group">
                        <span class="input-group-addon span">专业技能：</span>
                        <input id="interLocation" type="text" class="form-control"  style="font-weight: bold;color: #f37b1d;" placeholder="请编辑您的专业技能" value="${interInfo.interLocation}"></input>
                        <div id="errInterLocation" style="color: orange;"></div>
                    </div>
                    <br>

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
