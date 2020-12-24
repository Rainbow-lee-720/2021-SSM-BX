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
    <title>求职审核</title>
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
    #tableId{
        width : 1500px;
        position: relative;
        left: 18px;
    }
    td{
        height: 58px;
    }
    table th{
        font-size: 15px;
        font-weight: bold;
        text-align: center;
    }
    table tr{
        text-align: center;
    }
    #div1{
        border: 2px solid lightgray;
        width : 1540px;
        height: 892px;
    }
    #div2{
        height : 50px;
        background-color: #6698cb;
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
        float: right;
        position: relative;
        top : 7px;
        right: 9px;
    }
    #div5{
        width : 1500px;
        height: 70px;
        position: relative;
        top : 20px;
        left: 18px;
        margin-bottom: 30px;
    }
    .row div{
        margin-right: 50px;
    }
    #search{
        position: relative;
        top : 24px;
        left : 210px;
    }
    .td_a a{
        cursor: pointer;
    }
    #page{
        position: relative;
        left: 1286px;
        top: -50px;
    }
    #spanPage{
        position: relative;
        left: 17px;
        top : 13px;
    }
    .span2{
        font-weight: bold;
        color: #2C3E50;
    }
    .span3{

        font-weight: bold;
        color: #EB7347;
    }
    .noInter{
        width: 700px;
        height: 190px;
        font-size: 19px;
        margin-top: 50px;
    }
</style>

<script type="text/javascript">
    $(function () {
        //返回上一级
        $("#back").click(function () {
            history.go(-1);
        });

        //求职审核信息为空
        var tbody = $(".tbody").children().length;
        if(tbody == 0){
            $("#div1").children(":not('#div2')").remove();
            $("#div1").append("<div class=\"panel panel-primary noInter center-block\">\n" +
                "\t<div class=\"panel-heading text-center\">\n" +
                "\t\t<h2 class=\"panel-title\">提示</h2>\n" +
                "\t</div>\n" +
                "\t<div class=\"panel-body text-center\">\n" +
                "\t\t<span style=\"color: lightseagreen;font-weight: bold\">求职申请信息暂时无人提交 请等待...</span>\n" +
                "\t</div>\n" +
                "</div>");
        }

        //性别区分显示
        var stuSexObjs = $(".stuSexColor");
        for(var i=0;i<stuSexObjs.length;i++){
            var stuSexObj = $(stuSexObjs[i])
            var stuSex = $(stuSexObjs[i]).html();
            var result = (stuSex == "男")?true:false;
            if(!result){
                stuSexObj.css("color","red");
            }else{
                stuSexObj.css("color","#26A65B");
            }
        }

        //根据四个条件动态查询求职信息
        queryInterByFourCon();
    });


    //模态框提示求职审核操作 传输数据到模态框
    $(function(){
        $('.modal-dialog').modal("hide");
    });
    function values(stuNo,comNo,stuName,stuSex,stuAge,stuSpecialty,stuSchool,stuDegree,stuPhone,stuPosition,stuSalary,stuLocation){
        $('#dateStuNo').text(stuNo);
        $('#dateComNo').text(comNo);
        $('#dateStuName').text(stuName);
        $('#dateStuSex').text(stuSex);
        $('#dateStuAge').text(stuAge);
        $('#dateStuSpecialty').text(stuSpecialty);
        $('#dateStuSchool').text(stuSchool);
        $('#dateStuDegree').text(stuDegree);
        $('#dateStuPhone').text(stuPhone);
        $('#dateStuPosition').text(stuPosition);
        $('#dateStuSalary').text(stuSalary);
        $('#dateStuLocation').text(stuLocation);
    }

    //根据四个条件动态查询求职信息
    function queryInterByFourCon(){
        $("#search").click(function() {
            var interSex = $("#interSex").val();
            var interDegree = $("#interDegree").val();
            var interSalary = $("#interSalary").val();
            var interLocation = $("#interLocation").val();

            //提交表单数据
            var interviewData = {
                interSex : interSex,
                interDegree : interDegree,
                interLocation : interLocation,
            };
            var data = JSON.stringify({
                "interview" : interviewData
            });
            //通过jquery的格式转换成String 通过ajax传送到服务端
            $.ajax({
                type : "post",
                data : data,
                async : false,
                cache : false,
                contentType : "application/json;charset=UTF-8",
                url : "${pageContext.request.contextPath}/interview/queryInterByFourCon?interSalary=" + interSalary,
                success : function (resp) {
                    //处理查询结果
                    if(resp) {
                        $("body").html("");
                        $("body").html(resp);
                    }
                },
                error : function (xhr, textStatus, errorThrown) {
                    //处理失败
                    alert("进入error---");
                    alert("状态码："+xhr.status);
                    alert("状态:"+xhr.readyState);//当前状态,0-未初始化，1-正在载入，2-已经载入，3-数据进行交互，4-完成。
                    alert("错误信息:"+xhr.statusText );
                    alert("返回响应信息："+xhr.responseText );//这里是详细的信息
                    alert("请求状态："+textStatus);
                }
            });
        });
    }

    //审核通过 后台先判断此学生求职申请是否已经审核通过（查询就业信息中是否有次学生和对应的企业） 后台自动生成学生就业信息 并把interview表中的InterComNo字段对应的审核通过的企业编号去除
    function giveJob(){
        var interStuNo = $.trim($('#dateStuNo').text());
        var interComNo = $.trim($('#dateComNo').text());
        var interName = $.trim($('#dateStuName').text());
        var interSex = $.trim($('#dateStuSex').text());
        var interAge = $.trim($('#dateStuAge').text());
        var interSpecialty = $.trim($('#dateStuSpecialty').text());
        var interSchool = $.trim($('#dateStuSchool').text());
        var interDegree = $.trim($('#dateStuDegree').text());
        var interPhone = $.trim($('#dateStuPhone').text());
        var interPosition = $.trim($('#dateStuPosition').text());
        var interSalary = $.trim($('#dateStuSalary').text());
        var interLocation = $.trim($('#dateStuLocation').text());
        //提交表单数据
        var interviewData = {
            interStuNo : interStuNo,
            interComNo : interComNo,
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
        var data = JSON.stringify({
            "interview" : interviewData
        });
        //通过jquery的格式转换成String 通过ajax传送到服务端 data
        $.ajax({
            type : "post",
            data : data,
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/interview/giveJob?comName=${company.comName}&comNo=${company.comNo}",
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //审核求职申请成功
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    求职审核反馈\n" +
                        "                                </h4>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"modal-body text-center\">\n" +
                        "                                <p style=\"font-weight: bold;font-size: 18px;color: #8799a3;\">" + resp.msg1 + "</p>\n" +
                        "                                " +
                        "                            </div>\n" +
                        "                            <div class=\"modal-footer\">\n" +
                        "                                <button type=\"button\" class=\"btn btn-success\"  data-dismiss=\"modal\">\n" +
                        "                                    关闭\n" +
                        "                                </button>\n" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                    </div>");
                    //移除不通过按钮
                    //$("#refuse").css("display","none");
                    //刷新表格数据
                    //history.go(0);
                    //parent.location.href = "${pageContext.request.contextPath}/jsp/company/main_com.jsp";
                }else{
                    //审核求职申请失败
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    求职审核反馈\n" +
                        "                                </h4>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"modal-body text-center\">\n" +
                        "                                <p style=\"font-weight: bold;font-size: 18px;color: #8799a3;\">" + resp.msg1 + "</p>\n" +
                        "                                " +
                        "                            </div>\n" +
                        "                            <div class=\"modal-footer\">\n" +
                        "                                <button type=\"button\" class=\"btn btn-danger\"  data-dismiss=\"modal\">\n" +
                        "                                    关闭\n" +
                        "                                </button>\n" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                    </div>");
                    //刷新表格数据
                    //history.go(0);
                }
            }
        });
    }

    //审核不通过 通过在interiew表中的interComNo字段去除（与学生撤回求职申请一样实现） 表示该学生的求职申请审核不通过
    function refuseJob(){
        var interStuNo = $.trim($('#dateStuNo').text());
        var interComNo = $.trim($('#dateComNo').text());

        $.ajax({
            type : "post",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/interview/refuseJob?comNo=${company.comNo}&interComNo=" + interComNo + "&interStuNo=" + interStuNo,
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //求职审核不通过操作执行成功
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    求职审核反馈\n" +
                        "                                </h4>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"modal-body text-center\">\n" +
                        "                                <p style=\"font-weight: bold;font-size: 18px;color: #8799a3;\">" + resp.msg1 + "</p>\n" +
                        "                                " +
                        "                            </div>\n" +
                        "                            <div class=\"modal-footer\">\n" +
                        "                                <button type=\"button\" class=\"btn btn-success\"  data-dismiss=\"modal\">\n" +
                        "                                    关闭\n" +
                        "                                </button>\n" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                    </div>");
                    //刷新表格数据
                    //history.go(0);
                    parent.location.href = "${pageContext.request.contextPath}/jsp/company/main_com.jsp";
                }else{
                    //求职审核不通过操作执行失败
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    求职审核反馈\n" +
                        "                                </h4>\n" +
                        "                            </div>\n" +
                        "                            <div class=\"modal-body text-center\">\n" +
                        "                                <p style=\"font-weight: bold;font-size: 18px;color: #8799a3;\">" + resp.msg1 + "</p>\n" +
                        "                                " +
                        "                            </div>\n" +
                        "                            <div class=\"modal-footer\">\n" +
                        "                                <button type=\"button\" class=\"btn btn-danger\"  data-dismiss=\"modal\">\n" +
                        "                                    关闭\n" +
                        "                                </button>\n" +
                        "                            </div>\n" +
                        "                        </div>\n" +
                        "                    </div>");
                    //刷新表格数据
                    //history.go(0);
                }
            }
        });
    }

    //根据学号、企业编号查询学生求职信息 用于显示学生求职详细信息 前端模态框展示'',''
    function queryInterInfo(stuNo) {
        $.ajax({
            type : "get",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/interview/queryInterInfo?stuNo=" + stuNo + "&comNo=${company.comNo}",
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //将数据填充到模态框中
                    $("#interviewName").html(resp.content.interName);
                    $("#interviewSex").html(resp.content.interSex);
                    $("#interviewAge").html(resp.content.interAge);
                    $("#interviewSpecialty").html(resp.content.interSpecialty);
                    $("#interviewSchool").html(resp.content.interSchool);
                    $("#interviewDegree").html(resp.content.interDegree);
                    $("#interviewPhone").html(resp.content.interPhone);
                    $("#interviewPosition").html(resp.content.interPosition);
                    $("#interviewSalary").html(resp.content.interSalary);
                    $("#interviewLocation").html(resp.content.interLocation);
                }
            }
        });
    }
</script>
<body>
    <div id="div1">
        <div id="div2">
            <div id="div3"><span class="glyphicon glyphicon-saved"></span><span>&nbsp;求职审核</span></div>
            <div id="div4">
                <!-- 新增Back按钮 -->
                <button id="back" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                    <span class="glyphicon glyphicon-remove-sign"></span>&nbsp;返回
                </button>
            </div>
        </div>

        <div id="div5">
            <form action="">
                <div class="row">
                    <div class="col-lg-2" style="font-size: 18px;">
                        <label for="interSex">性别：</label>
                        <select id="interSex"  name="interSex" class="form-control">
                            <option value="">-请选择-</option>
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                    <div class="col-lg-2" style="position: relative;left: 20px;font-size: 18px;">
                        <label for="interDegree">学历：</label>
                        <select class="form-control" name="interDegree" id="interDegree">
                            <option value="">-请选择-</option>
                            <option value="大专">大专</option>
                            <option value="本科">本科</option>
                            <option value="硕士研究生">硕士研究生</option>
                            <option value="博士研究生">博士研究生</option>
                        </select>
                    </div>
                    <div class="col-lg-2" style="position: relative;left: 60px;font-size: 18px;">
                        <label for="interSalary">期望薪资：</label>
                        <select class="form-control" name="interSalary" id="interSalary">
                            <option value="">-请选择-</option>
                            <option value="小于3000">小于3000</option>
                            <option value="3000-5000">3000-5000</option>
                            <option value="5000-7000">5000-7000</option>
                            <option value="7000-10000">7000-10000</option>
                            <option value="大于10000">大于10000</option>
                        </select>
                    </div>
                    <div class="col-lg-2" style="position: relative;left: 100px;font-size: 18px;">
                        <label for="interLocation">专业技能：</label>
                        <input type="text" id="interLocation" name="interLocation" class="form-control" placeholder="请输入专业技能">
                    </div>
                    <button style="font-size: 18px;" type="button" id="search" class="btn btn-success"><span></span>搜索</button>
                </div>
            </form>
        </div>

        <div class="table-responsive" style="margin-top: 60px;">
            <table class="table table-striped table-hover" id="tableId" style="font-size: 20px;">
                <thead>
                    <tr>
                        <th>学生姓名</th>
                        <th>性别</th>
                        <th>年龄</th>
                        <th>专业</th>
                        <th>学历</th>
                        <th>应聘职位</th>
                        <th>期望薪资</th>
                        <th>专业技能</th>
                        <th>求职审核</th>
                    </tr>
                </thead>

                <tbody class="tbody">
                    <c:forEach items="${interviewPageModel.dataList}" var="interview">
                        <tr>
                            <td>${interview.interName}</td>
                            <td class="stuSexColor">${interview.interSex}</td>
                            <td>${interview.interAge}</td>
                            <td>${interview.interSpecialty}</td>
                            <td>${interview.interDegree}</td>
                            <td>${interview.interPosition}</td>
                            <td style="color: lightseagreen">${interview.interSalary}</td>
                            <td>${interview.interLocation}</td>

                            <td class="td_a">
<%--                                <a src=""><span class="glyphicon glyphicon-tag"></span></a>&nbsp;--%>
<%--                                <a src=""><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;--%>

                                <a href="#" onclick="queryInterInfo('${interview.interStuNo}')" data-toggle="modal" data-target="#myModal2">
                                    <span class="glyphicon glyphicon-tag"></span>
                                </a>&nbsp;
                                <!-- 模态框（Modal） -->
                                <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="font-size: 16px;">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                                    <span class="glyphicon glyphicon-remove-sign"></span>
                                                </button>
                                                <h4 class="modal-title" id="myModalLabel2" style="color: lightseagreen;font-weight: bold;">
                                                    学生求职申请信息
                                                </h4>
                                            </div>
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">姓名：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewName"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">性别：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewSex"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">年龄：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewAge"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">专业：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewSpecialty"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">学校：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewSchool"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">学历：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewDegree"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">电话：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewPhone"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">职位：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewPosition"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">薪资：</label>
                                                    <div class="col-sm-10" style="color: lightseagreen">
                                                        <p class="form-control-static" id="interviewSalary"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">技能：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="interviewLocation"></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-warning" data-dismiss="modal">
                                                    关闭
                                                </button>
                                            </div>
                                        </div><!-- /.modal-content -->
                                    </div><!-- /.modal -->
                                </div>

                                <a href="#" style="color:#6739b6;" data-toggle="modal" data-target="#myModal3" onclick="values('${interview.interStuNo}','${interview.interComNo}','${interview.interName}','${interview.interSex}','${interview.interAge}','${interview.interSpecialty}','${interview.interSchool}','${interview.interDegree}','${interview.interPhone}','${interview.interPosition}','${interview.interSalary}','${interview.interLocation}')">
                                    <span class="glyphicon glyphicon-ok-sign"></span>
                                </a>
                                <!-- 模态框（Modal） -->
                                <div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                                    <span class="glyphicon glyphicon-remove"></span>
                                                </button>
                                                <h4 class="modal-title text-center" id="myModalLabel3" style="color: lightseagreen;font-weight: bold;;font-size: 22px;">
                                                    求职审核
                                                </h4>
                                            </div>
                                            <div class="modal-body text-center">
                                                <p style="font-weight: bold;font-size: 18px;color: #8799a3;">求职申请人:</p>
                                                <p style="font-weight: bold;color:#f37b1d;font-size: 18px;" id="dateStuName" value=""></p>
                                                <p style="display: none;" id="dateStuNo" value=""></p>
                                                <p style="display: none;" id="dateComNo" value=""></p>
                                                <p style="display: none;" id="dateStuSex" value=""></p>
                                                <p style="display: none;" id="dateStuAge" value=""></p>
                                                <p style="display: none;" id="dateStuSpecialty" value=""></p>
                                                <p style="display: none;" id="dateStuSchool" value=""></p>
                                                <p style="display: none;" id="dateStuDegree" value=""></p>
                                                <p style="display: none;" id="dateStuPhone" value=""></p>
                                                <p style="display: none;" id="dateStuPosition" value=""></p>
                                                <p style="display: none;" id="dateStuSalary" value=""></p>
                                                <p style="display: none;" id="dateStuLocation" value=""></p>
                                                <p style="font-weight: bold;font-size: 18px;color: #8799a3;">点击“<span style="font-weight: bold;color:lightseagreen;">通过/不通过</span>”提交求职审核</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-success" onclick="giveJob()" data-dismiss="modal">
                                                    通过
                                                </button>
                                                <button id="refuse" type="button" class="btn btn-danger" onclick="refuseJob()" data-dismiss="modal">
                                                    不通过
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="div6">
            <p id="spanPage"><span class="glyphicon glyphicon-asterisk"></span>每页显示第<span class="span2">1</span>到第<span class="span2">10</span>条记录，总共<span class="span3">${interviewPageModel.totalPage}</span>页记录，总共<span class="span3">${interviewPageModel.cnt}</span>条记录</p>
            <ul class="pagination" id="page">
                <li><a href="${pageContext.request.contextPath}/interview/queryInterByPage?pageNo=${interviewPageModel.firstPage}&interComNo=${company.comNo}">&laquo;</a></li>
                <li><a href="${pageContext.request.contextPath}/interview/queryInterByPage?pageNo=${interviewPageModel.prePage}&interComNo=${company.comNo}">Previous</a></li>
                <li><a href="#">${interviewPageModel.pageNo}</a></li>
                <li><a href="${pageContext.request.contextPath}/interview/queryInterByPage?pageNo=${interviewPageModel.nextPage}&interComNo=${company.comNo}">Next</a></li>
                <li><a href="${pageContext.request.contextPath}/interview/queryInterByPage?pageNo=${interviewPageModel.lastPage}&interComNo=${company.comNo}">&raquo;</a></li>
            </ul>
        </div>

    </div>
</body>
</html>
