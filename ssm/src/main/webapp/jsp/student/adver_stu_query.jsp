<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/12 0012
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>招聘查询</title>
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
        background-color: #2C3E50;
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

    .row div{
        margin-right: 50px;
    }

    #search{
        position: relative;
        top : 24px;
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
    .div5{
        position: relative;
        top : 30px;
    }
    #div6{
        position: relative;
        top : 30px;
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

        //招聘信息为空
        var tbody = $(".tbody").children().length;
        if(tbody == 0){
            $("#div1").children(":not('#div2')").remove();
            $("#div1").append("<div class=\"panel panel-primary noInter center-block\">\n" +
                "\t<div class=\"panel-heading text-center\">\n" +
                "\t\t<h2 class=\"panel-title\">提示</h2>\n" +
                "\t</div>\n" +
                "\t<div class=\"panel-body text-center\">\n" +
                "\t\t<span style=\"color: lightseagreen;font-weight: bold\">查询结果为空 请重新查询...</span>\n" +
                "\t</div>\n" +
                "</div>");
        }

    });

    $(function(){
        $('.modal-dialog').modal("hide");
    });
    function values(name,no){
        $('#dateName').text(name);
        $('#dateNo').text(no);
    }
    function values2(name,no){
        $('#dateName2').text(name);
        $('#dateNo2').text(no);
    }

    //学生求职 将comNo修改到求职信息表中的interComNo
    function findJob(){
        var comNo = $.trim($('#dateNo').text());
        $.ajax({
            type : "post",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/advertise/findJob?adverComNo=" + comNo + "&stuNo=${student.stuNo}",
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //求职成功
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    申请求职反馈\n" +
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
                }else{
                    //求职失败
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    申请求职反馈\n" +
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

    //撤回求职申请 将comNo在求职信息表中的interComNo去除字符串String.replace()
    function quitJob(){
        var comNo = $.trim($('#dateNo2').text());
        $.ajax({
            type : "post",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/advertise/quitJob?adverComNo=" + comNo + "&stuNo=${student.stuNo}",
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //撤回申请成功
                    //alert(resp.msg1);
                    $("#myModal4").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    撤回申请反馈\n" +
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
                }else{
                    //撤回申请失败
                    //alert(resp.msg1);
                    $("#myModal4").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    撤回申请反馈\n" +
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

    //根据企业编号查询招聘信息 用于显示企业招聘详细信息 前端表格展示
    function queryAdverInfo(comNo) {
        $.ajax({
            type : "get",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/advertise/queryAdverInfo?adverComNo=" + comNo,
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //将数据填充到模态框中
                    $("#advertiseComNo").html(resp.content.adverComNo);
                    $("#advertiseComName").html(resp.content.adverComName);
                    $("#advertiseComAddress").html(resp.content.adverComAddress);
                    $("#advertiseComPhone").html(resp.content.adverComPhone);
                    $("#advertisePosition").html(resp.content.adverPosition);
                    $("#advertiseCount").html(resp.content.adverCount);
                    $("#advertiseSalary").html(resp.content.adverSalary);
                    $("#advertiseLocation").html(resp.content.adverLocation);
                    $("#advertiseRequire").html(resp.content.adverRequire);
                }
            }
        });
    }
</script>
<body>
<div id="div1">
    <div id="div2">
        <div id="div3"><span class="glyphicon glyphicon-th-list"></span><span>&nbsp;招聘查询</span></div>
        <div id="div4">
            <button type="button" id="back" class="btn btn-success">&nbsp;返回</button>
        </div>
    </div>

    <div class="table-responsive div5">
        <table class="table table-striped table-hover" id="tableId" style="font-size: 20px;">
            <caption style="color: #8799a3;font-weight: bold;font-size: 22px;margin-bottom: 20px;" class="text-center">查询结果</caption>
            <thead>
            <tr>
                <th>企业编号</th>
                <th>企业名称</th>
                <th>招聘职位</th>
                <th>招聘人数</th>
                <th>薪资待遇</th>
                <th>工作地点</th>
                <th>发布时间</th>
                <th>求职操作</th>
            </tr>
            </thead>

            <tbody class="tbody">
            <c:forEach items="${advertisePageModel.dataList}" var="advertise">
                <tr>
                    <td>${advertise.adverComNo}</td>
                    <td>${advertise.adverComName}<span class="label label-info">Hot</span></td>
                    <td>${advertise.adverPosition}</td>
                    <td><span class="badge">${advertise.adverCount}</span></td>
                    <td style="color: lightseagreen">${advertise.adverSalary}</td>
                    <td>${advertise.adverLocation}</td>
                    <td><fmt:formatDate value="${advertise.adverDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>

                    <td class="td_a">
                            <%--                                <a src=""><span class="glyphicon glyphicon-tag"></span></a>&nbsp;--%>
                            <%--                                <a src=""><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;--%>

                        <a href="#" onclick="queryAdverInfo('${advertise.adverComNo}')" data-toggle="modal" data-target="#myModal2">
                            <span class="glyphicon glyphicon-tag"></span>
                        </a>
                        <!-- 模态框（Modal） -->
                        <div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="font-size: 16px;">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            <span class="glyphicon glyphicon-remove-sign"></span>
                                        </button>
                                        <h4 class="modal-title" id="myModalLabel2" style="color: lightseagreen;font-weight: bold;">
                                            企业招聘详细信息
                                        </h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">企编：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertiseComNo"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">企名：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertiseComName"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">地址：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertiseComAddress"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">电话：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertiseComPhone"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">职位：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertisePosition"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">聘数：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertiseCount"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">薪资：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertiseSalary" style="color: lightseagreen"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">工作地：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertiseLocation"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">条件：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="advertiseRequire"></p>
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

                        <a href="#" style="color:#6739b6;" data-toggle="modal" data-target="#myModal3" onclick="values('${advertise.adverComName}','${advertise.adverComNo}')">
                            <span class="glyphicon glyphicon-heart"></span>
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
                                            申请求职
                                        </h4>
                                    </div>
                                    <div class="modal-body text-center">
                                        <p style="font-weight: bold;font-size: 18px;color: #8799a3;">您申请应聘的企业:</p>
                                        <p style="font-weight: bold;color:#f37b1d;font-size: 18px;" id="dateName" value=""></p>
                                        <p style="display: none;" id="dateNo" value=""></p>
                                        <p style="font-weight: bold;font-size: 18px;color: #8799a3;">点击“<span style="font-weight: bold;color:lightseagreen;">确认</span>”提交求职申请</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-success" onclick="findJob()" data-dismiss="modal">
                                            确认
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <a href="#" style="color:#9c26b0;" data-toggle="modal" data-target="#myModal4" onclick="values2('${advertise.adverComName}','${advertise.adverComNo}')">
                            <span class="glyphicon glyphicon-exclamation-sign"></span>
                        </a>
                        <!-- 模态框（Modal） -->
                        <div class="modal fade" id="myModal4" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                            <span class="glyphicon glyphicon-remove"></span>
                                        </button>
                                        <h4 class="modal-title text-center" id="myModalLabel4" style="color: lightseagreen;font-weight: bold;;font-size: 22px;">
                                            求职申请撤回
                                        </h4>
                                    </div>
                                    <div class="modal-body text-center">
                                        <p style="font-weight: bold;font-size: 18px;color: #8799a3;">您将撤回申求职请的企业：</p>
                                        <p style="font-weight: bold;color:#f37b1d;font-size: 18px;" id="dateName2" value=""></p>
                                        <p style="display: none;" id="dateNo2" value=""></p>
                                        <p style="font-weight: bold;font-size: 18px;color: #8799a3;">点击“<span style="font-weight: bold;color:lightseagreen;">确认</span>”撤回求职申请</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-success" onclick="quitJob()" data-dismiss="modal">
                                            确认
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
        <p id="spanPage"><span class="glyphicon glyphicon-asterisk"></span>每页显示第<span class="span2">1</span>到第<span class="span2">10</span>条记录，总共<span class="span3">${advertisePageModel.totalPage}</span>页记录，总共<span class="span3">${advertisePageModel.cnt}</span>条记录</p>
        <ul class="pagination" id="page">
            <li><a href="${pageContext.request.contextPath}/advertise/queryAdverByPage?pageNo=${advertisePageModel.firstPage}">&laquo;</a></li>
            <li><a href="${pageContext.request.contextPath}/advertise/queryAdverByPage?pageNo=${advertisePageModel.prePage}">Previous</a></li>
            <li><a href="#">${advertisePageModel.pageNo}</a></li>
            <li><a href="${pageContext.request.contextPath}/advertise/queryAdverByPage?pageNo=${advertisePageModel.nextPage}">Next</a></li>
            <li><a href="${pageContext.request.contextPath}/advertise/queryAdverByPage?pageNo=${advertisePageModel.lastPage}">&raquo;</a></li>
        </ul>
    </div>
</div>

</body>
</html>

