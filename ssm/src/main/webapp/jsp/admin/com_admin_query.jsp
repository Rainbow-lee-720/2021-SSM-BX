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
    <title>企业查询</title>
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
    .deleteRemove{
        display: none;
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
        //学生系统中不能有删除权限
        <%--var stu = "${student}";--%>
        <%--if(stu != null || stu != "") {--%>
        <%--    $("#delete").addClass("deleteRemove");--%>
        <%--}--%>

        //返回上一级
        $("#back").click(function () {
            history.back(-1);
        });

        //企业信息为空
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

    //删除企业 企业注销账号后权限为-1 随后管理员可以删除企业账号
    function delCom(comNo,comPower){
        if(confirm("确定删除企业信息?")){
            // if(comPower == "2"){
            //     alert("该企业账号未注销！不可删除！");
            // }else{
                $.ajax({
                    type : "post",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/company/delCom?comNo=" + comNo,
                    success : function (resp) {
                        //处理查询结果
                        if(resp.result) {
                            //删除成功
                            alert("企业账号:c" + resp.msg1 + "删除成功！");
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/company/queryComByPage";
                        }else{
                            //删除失败
                            alert("此账号下有关联数据 企业账号:c" + resp.msg1 + "删除失败！");
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/company/queryComByPage";
                        }
                    }
                });
            }
        // }
    }

    //根据企业编号查询企业信息 用于显示企业详细信息 前端表格展示
    function queryComInfo(comNo) {
        $.ajax({
            type : "get",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/company/queryComInfo?comNo=" + comNo,
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //将数据填充到模态框中
                    $("#companyId").html(resp.content.comId);
                    $("#companyNo").html(resp.content.comNo);
                    $("#companyName").html(resp.content.comName);
                    $("#companyAddress").html(resp.content.comAddress);
                    $("#companyKind").html(resp.content.comKind);
                    $("#companyNum").html(resp.content.comNum);
                    $("#companyType").html(resp.content.comType);
                    $("#companyPhone").html(resp.content.comPhone);
                    $("#companyBack").html(resp.content.comBack);
                    $("#companyPower").html(resp.content.comPower);
                    if(resp.content.comPower == "2"){
                        $("#companyPower").html("Company").css("color","orange");
                    }else if(resp.content.comPower == "-1"){
                        $("#companyPower").html("已注销").css("color","red");
                    }
                }
            }
        });
    }
</script>
<body>
<div id="div1">
    <div id="div2">
        <div id="div3"><span class="glyphicon glyphicon-user"></span><span>企业查询</span></div>
        <div id="div4">
            <button type="button" id="back" class="btn btn-success">返回</button>
        </div>
    </div>

    <div class="table-responsive div5">
        <table class="table table-striped table-bordered table-hover" id="tableId" style="font-size: 20px;">
            <caption style="color: #8799a3;font-weight: bold;font-size: 22px;margin-bottom: 20px;" class="text-center">查询结果</caption>
            <thead>
            <tr>
                <th>企业编号</th>
                <th>名称</th>
                <th>地址</th>
                <th>类型</th>
                <th>性质</th>
                <th>规模(人数)</th>
                <th>电话</th>
                <th>操作</th>
            </tr>
            </thead>

            <tbody class="tbody">
            <c:forEach items="${companyPageModel.dataList}" var="company">
                <tr>
                    <td>${company.comNo}</td>
                    <td>${company.comName}</td>
                    <td>${company.comAddress}</td>
                    <td>${company.comType}</td>
                    <td>${company.comKind}</td>
                    <td style="color: #f37b1d">${company.comNum}</td>
                    <td>${company.comPhone}</td>

                    <td class="td_a">
<%--                        <a src=""><span class="glyphicon glyphicon-tag"></span></a>&nbsp;--%>
<%--                        <a src=""><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;--%>
                        <a href="#" onclick="queryComInfo('${company.comNo}')" data-toggle="modal" data-target="#myModal2">
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
                                            企业详细信息
                                        </h4>
                                    </div>
                                    <div class="modal-body">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">用户名：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyId"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">编号：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyNo"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">名称：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyName"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">地址：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyAddress"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">性质：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyKind"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">规模：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyNum"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">类型：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyType"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">电话：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyPhone"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">简介：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyBack"></p>
                                            </div>
                                            <label class="col-sm-2 control-label">权限：</label>
                                            <div class="col-sm-10">
                                                <p class="form-control-static" id="companyPower"></p>
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

                        <c:if test="${student==null}">
                            <a id="delete"  class="del" href="#" onclick="delCom('${company.comNo}','${company.comPower}')"><span class="glyphicon glyphicon-trash"></span></a>
                        </c:if>

                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div id="div6">
        <p id="spanPage"><span class="glyphicon glyphicon-asterisk"></span>每页显示第<span class="span2">1</span>到第<span class="span2">10</span>条记录，总共<span class="span3">${companyPageModel.totalPage}</span>页记录，总共<span class="span3">${companyPageModel.cnt}</span>条记录</p>
        <ul class="pagination" id="page">
            <li><a href="${pageContext.request.contextPath}/company/queryComByPage?pageNo=${companyPageModel.firstPage}">&laquo;</a></li>
            <li><a href="${pageContext.request.contextPath}/company/queryComByPage?pageNo=${companyPageModel.prePage}">Previous</a></li>
            <li><a href="#">${companyPageModel.pageNo}</a></li>
            <li><a href="${pageContext.request.contextPath}/company/queryComByPage?pageNo=${companyPageModel.nextPage}">Next</a></li>
            <li><a href="${pageContext.request.contextPath}/company/queryComByPage?pageNo=${companyPageModel.lastPage}">&raquo;</a></li>
        </ul>
    </div>

</div>
</body>
</html>

