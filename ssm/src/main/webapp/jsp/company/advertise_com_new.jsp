<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/12/12 0012
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>招聘信息</title>
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
        left : 275px;
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
    #div4{
        float: right;
        position: relative;
        top : 7px;
        right: 9px;
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
                "\t\t<span style=\"color: lightseagreen;font-weight: bold\">企业还未发布招聘信息 请等待...</span>\n" +
                "\t</div>\n" +
                "</div>");
        }

        //企业根据三个条件动态查询招聘信息
        queryAdverByThreeConNew();

    });


    //根据三个条件动态查询招聘信息
    function queryAdverByThreeConNew(){
        $("#search").click(function() {
            var adverPosition = $("#adverPosition").val();
            var adverSalary = $("#adverSalary").val();
            var adverLocation = $("#adverLocation").val();
            //提交表单数据
            var adverData = {
                adverPosition : adverPosition,
                adverLocation : adverLocation
            };
            var data = JSON.stringify({
                "advertise" : adverData
            });
            //通过jquery的格式转换成String 通过ajax传送到服务端
            $.ajax({
                type : "post",
                data : data,
                async : false,
                cache : false,
                contentType : "application/json;charset=UTF-8",
                url : "${pageContext.request.contextPath}/advertise/queryAdverByThreeConNew?adverSalary=" + adverSalary + "&adverComNo=${company.comNo}",
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
                }
            });
        });
    }

    //添加招聘信息
    function addAdver() {
        location.href = "${pageContext.request.contextPath}/jsp/company/advertise_add_com.jsp";
    }

    //修改招聘信息
    function updateAdver(adverNo) {
        location.href = "${pageContext.request.contextPath}/advertise/updateAdverBefore?adverNo=" + adverNo;
    }

    //删除招聘信息
    function delAdver(adverNo){
        if(confirm("确定删除招聘信息?")){
            $.ajax({
                type : "post",
                async : false,
                cache : false,
                contentType : "application/json;charset=UTF-8",
                url : "${pageContext.request.contextPath}/advertise/delAdver?adverNo=" + adverNo,
                success : function (resp) {
                    //处理查询结果
                    if(resp.result) {
                        //删除成功
                        alert("招聘信息编号为" + resp.msg1 + "的招聘信息删除成功！");
                        //刷新表格数据
                        window.location.href = "${pageContext.request.contextPath}/advertise/queryAdverByPageNew?adverComNo=${company.comNo}";
                    }else{
                        //删除失败
                        alert("招聘信息编号为" + resp.msg1 + "的招聘信息删除失败！");
                        //刷新表格数据
                        window.location.href = "${pageContext.request.contextPath}/advertise/queryAdverByPageNew?adverComNo=${company.comNo}";
                    }
                }
            });
        }
    }
</script>
<body>
    <div id="div1">
        <div id="div2">
            <div id="div3"><span class="glyphicon glyphicon-th-list"></span><span>&nbsp;招聘信息</span></div>
            <div id="div4">
                <!-- 新增Add按钮 -->
                <button id="add" onclick="addAdver()" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                    <span class="glyphicon glyphicon-plus"></span>&nbsp;新增
                </button>
            </div>
        </div>

        <div class="alert alert-info" id="delInfo">
            <a href="#" class="close" data-dismiss="alert">
                <span class="glyphicon glyphicon-remove-sign"></span>
            </a>
            <strong>提示：</strong>点击右上角的"<span style="color: lightseagreen;font-weight: bold">新增</span>"按钮可发布招聘信息
        </div>

        <div id="div5">
            <form action="">
                <div class="row">
                    <div class="col-lg-2" style="font-size: 18px;">
                        <label for="adverPosition">招聘职位：</label>
                        <input type="text" id="adverPosition" name="adverPosition" class="form-control" placeholder="请输入招聘职位">
                    </div>
                    <div class="col-lg-3" style="font-size: 18px;position: relative;left: 70px;">
                        <label for="adverSalary">招聘薪资：</label>
                        <select class="form-control" name="adverSalary" id="adverSalary">
                            <option value="">-请选择-</option>
                            <option value="小于3000">小于3000</option>
                            <option value="3000-5000">3000-5000</option>
                            <option value="5000-7000">5000-7000</option>
                            <option value="7000-10000">7000-10000</option>
                            <option value="大于10000">大于10000</option>
                        </select>
                    </div>
                    <div class="col-lg-3" style="font-size: 18px;position: relative;left:160px;">
                        <label for="adverLocation">工作地点：</label>
                        <input type="text" id="adverLocation" name="adverLocation" class="form-control" placeholder="请输入工作地点">
                    </div>
                    <button style="font-size: 18px; "type="button" id="search" class="btn btn-success"><span></span>搜索</button>
                </div>
            </form>
        </div>

        <div class="table-responsive" style="margin-top: 60px;">
            <table class="table table-striped table-bordered table-hover" id="tableId" style="font-size: 20px;">
                <thead>
                    <tr>
                        <th>编号</th>
                        <th>企业名称</th>
                        <th>企业地址</th>
                        <th>企业电话</th>
                        <th>招聘职位</th>
                        <th>招聘人数</th>
                        <th>薪资待遇</th>
                        <th>工作地点</th>
                        <th>发布时间</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody class="tbody">
                    <c:forEach items="${advertisePageModel.dataList}" var="advertise">
                        <tr>
                            <td>${advertise.adverNo}</td>
                            <td>${advertise.adverComName}</td>
                            <td>${advertise.adverComAddress}</td>
                            <td>${advertise.adverComPhone}</td>
                            <td>${advertise.adverPosition}</td>
                            <td><span class="badge">${advertise.adverCount}</span></td>
                            <td style="color: lightseagreen">${advertise.adverSalary}</td>
                            <td>${advertise.adverLocation}</td>
                            <td><fmt:formatDate value="${advertise.adverDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td class="td_a">
<%--                                <a src=""><span class="glyphicon glyphicon-tag"></span></a>&nbsp;--%>
<%--                                <a src=""><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;--%>

                                <a href="#" onclick="updateAdver('${advertise.adverNo}')">
                                    <span class="glyphicon glyphicon-tag"></span>
                                </a>
                                <a href="#" onclick="delAdver('${advertise.adverNo}')">
                                    <span class="glyphicon glyphicon-trash"></span>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="div6">
            <p id="spanPage"><span class="glyphicon glyphicon-asterisk"></span>每页显示第<span class="span2">1</span>到第<span class="span2">10</span>条记录，总共<span class="span3">${advertisePageModel.totalPage}</span>页记录，总共<span class="span3">${advertisePageModel.cnt}</span>条记录</p>
            <ul class="pagination" id="page">
                <li><a href="${pageContext.request.contextPath}/advertise/queryAdverByPageNew?adverComNo=${company.comNo}&pageNo=${advertisePageModel.firstPage}">&laquo;</a></li>
                <li><a href="${pageContext.request.contextPath}/advertise/queryAdverByPageNew?adverComNo=${company.comNo}&pageNo=${advertisePageModel.prePage}">Previous</a></li>
                <li><a href="#">${advertisePageModel.pageNo}</a></li>
                <li><a href="${pageContext.request.contextPath}/advertise/queryAdverByPageNew?adverComNo=${company.comNo}&pageNo=${advertisePageModel.nextPage}">Next</a></li>
                <li><a href="${pageContext.request.contextPath}/advertise/queryAdverByPageNew?adverComNo=${company.comNo}&pageNo=${advertisePageModel.lastPage}">&raquo;</a></li>
            </ul>
        </div>

    </div>
</body>
</html>
