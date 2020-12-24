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
    <title>就业信息</title>
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
        left : 470px;
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

        //就业信息为空
        var tbody = $(".tbody").children().length;
        if(tbody == 0){
            $("#div1").children(":not('#div2')").remove();
            $("#div1").append("<div class=\"panel panel-primary noInter center-block\">\n" +
                "\t<div class=\"panel-heading text-center\">\n" +
                "\t\t<h2 class=\"panel-title\">提示</h2>\n" +
                "\t</div>\n" +
                "\t<div class=\"panel-body text-center\">\n" +
                "\t\t<span style=\"color: lightseagreen;font-weight: bold\">暂时没有就业信息 请等待企业审核...</span>\n" +
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

        //根据三个条件动态查询就业信息
        queryEmpByThreeCon();
    });


    //模态框提示就业确认 传输数据到模态框
    $(function(){
        $('.modal-dialog').modal("hide");
    });
    function values(empNo,empStuNo,empComNo,empComName,comState){
        $('#dateComName').text(empComName);
        $('#dateEmpNo').text(empNo);
        $('#dateEmpState').text(comState);
        $('#dateEmpComNo').text(empComNo);
        $('#dateEmpStuNo').text(empStuNo);
    }

    //根据三个条件动态查询就业信息
    function queryEmpByThreeCon(){
        $("#search").click(function() {
            var empComName = $("#empComName").val();
            var empSalary = $("#empSalary").val();
            var empPosition = $("#empPosition").val();
            //提交表单数据
            var employData = {
                empComName : empComName,
                empPosition : empPosition,
            };
            var data = JSON.stringify({
                "employ" : employData
            });
            //通过jquery的格式转换成String 通过ajax传送到服务端
            $.ajax({
                type : "post",
                data : data,
                async : false,
                cache : false,
                contentType : "application/json;charset=UTF-8",
                url : "${pageContext.request.contextPath}/employ/queryEmpByThreeCon?empSalary=" + empSalary + "&stuNo=${student.stuNo}",
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

    //确认就业
    function comfirmEmp(){
        var empComName = $.trim($('#dateComName').text());
        var empNo = $.trim($('#dateEmpNo').text());
        var empState = $.trim($('#dateEmpState').text());
        var empComNo = $.trim($('#dateEmpComNo').text());
        //提交表单数据
        var employData = {
            empComName : empComName,
            empNo : empNo,
            empState : empState,
            empComNo : empComNo
        };
        var data = JSON.stringify({
            "employ" : employData
        });
        //通过jquery的格式转换成String 通过ajax传送到服务端 data
        $.ajax({
            type : "post",
            data : data,
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/employ/comfirmEmp",
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //确认成功
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    就业反馈\n" +
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
                        "                                   就业反馈\n" +
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

    //删除就业信息
    function delEmp(){
        var empComName = $.trim($('#dateComName').text());
        var empNo = $.trim($('#dateEmpNo').text());
        var empState = $.trim($('#dateEmpState').text());
        var empStuNo = $.trim($('#dateEmpStuNo').text());
        //提交表单数据
        var employData = {
            empComName : empComName,
            empNo : empNo,
            empState : empState,
            empStuNo : empStuNo
        };
        var data = JSON.stringify({
            "employ" : employData
        });
        $.ajax({
            type : "post",
            async : false,
            cache : false,
            data : data,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/employ/delEmp",
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //删除就业信息执行成功
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    就业反馈\n" +
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
                    //parent.location.href = "${pageContext.request.contextPath}/jsp/company/main_com.jsp";
                }else{
                    //求删除就业信息执行失败
                    //alert(resp.msg1);
                    $("#myModal3").html("<div class=\"modal-dialog\">\n" +
                        "                        <div class=\"modal-content\">\n" +
                        "                            <div class=\"modal-header\">\n" +
                        "                                <button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">\n" +
                        "                                    <span class=\"glyphicon glyphicon-remove\"></span>\n" +
                        "                                </button>\n" +
                        "                                <h4 class=\"modal-title text-center\" id=\"myModalLabel2\" style=\"color: lightseagreen;font-weight: bold;;font-size: 22px;\">\n" +
                        "                                    就业反馈\n" +
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

</script>
<body>
    <div id="div1">
        <div id="div2">
            <div id="div3"><span class="glyphicon glyphicon-tags"></span><span>&nbsp;就业信息</span></div>
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
                        <label for="empComName">企业名称：</label>
                        <input type="text" id="empComName" name="empComName" class="form-control" placeholder="请输入企业名称">
                    </div>
                    <div class="col-lg-2" style="font-size: 18px;position: relative;left: 120px;">
                        <label for="empSalary">就业薪资：</label>
                        <select class="form-control" name="empSalary" id="empSalary">
                            <option value="">-请选择-</option>
                            <option value="小于3000">小于3000</option>
                            <option value="3000-5000">3000-5000</option>
                            <option value="5000-7000">5000-7000</option>
                            <option value="7000-10000">7000-10000</option>
                            <option value="大于10000">大于10000</option>
                        </select>
                    </div>
                    <div class="col-lg-2" style="font-size: 18px;position: relative;left: 260px;">
                        <label for="empPosition">就业职位：</label>
                        <input type="text" id="empPosition" name="empPosition" class="form-control" placeholder="请输入就业职位">
                    </div>
                    <button  style="font-size: 18px;" type="button" id="search" class="btn btn-success"><span></span>搜索</button>
                </div>
            </form>
        </div>

        <div class="table-responsive" style="margin-top: 60px;">
            <table class="table table-striped table-hover" id="tableId" style="font-size: 20px;">
                <thead>
                    <tr>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>年龄</th>
                        <th>专业</th>
                        <th>学历</th>
                        <th>企业名称</th>
                        <th>就业职位</th>
                        <th>就业薪资</th>
                        <th>专业技能</th>
                        <th>发布时间</th>
                        <th>就业操作</th>
                    </tr>
                </thead>

                <tbody class="tbody">
                    <c:forEach items="${employPageModel.dataList}" var="employ">
                        <tr>
                            <td>${employ.empName}</td>
                            <td class="stuSexColor">${employ.empSex}</td>
                            <td>${employ.empAge}</td>
                            <td>${employ.empSpecialty}</td>
                            <td>${employ.empDegree}</td>
                            <c:if test="${employ.empState==1}">
                                <td>${employ.empComName}<span class="label label-success">已就业</span></td>
                            </c:if>
                            <c:if test="${employ.empState==0}">
                                <td>${employ.empComName}<span class="label label-danger">未就业</span></td>
                            </c:if>
                            <td>${employ.empPosition}</td>
                            <td style="color: lightseagreen">${employ.empSalary}</td>
                            <td>${employ.empLocation}</td>
                            <td><fmt:formatDate value="${employ.empDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>

                            <td class="td_a">
<%--                                <a src=""><span class="glyphicon glyphicon-tag"></span></a>&nbsp;--%>
<%--                                <a src=""><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;--%>

                                <a href="#" style="color:#6739b6;" data-toggle="modal" data-target="#myModal3" onclick="values('${employ.empNo}','${employ.empStuNo}','${employ.empComNo}','${employ.empComName}','${employ.empState}')">
                                    <span class="glyphicon glyphicon-check"></span>
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
                                                    就业确认
                                                </h4>
                                            </div>
                                            <div class="modal-body text-center">
                                                <p style="font-weight: bold;font-size: 18px;color: #8799a3;">您所选择的就业企业:</p>
                                                <p style="font-weight: bold;color:#f37b1d;font-size: 18px;" id="dateComName" value=""></p>
                                                <p style="display: none;font-weight: bold;color:#f37b1d;font-size: 18px;" id="dateEmpNo" value=""></p>
                                                <p style="display: none;" id="dateEmpState" value=""></p>
                                                <p style="display: none;" id="dateEmpComNo" value=""></p>
                                                <p style="display: none;" id="dateEmpStuNo"></p>
                                                <p style="font-weight: bold;font-size: 18px;color: #8799a3;">点击“<span style="font-weight: bold;color:lightseagreen;">确认/舍弃</span>”提交就业结果</p>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-success" onclick="comfirmEmp()" data-dismiss="modal">
                                                    确认
                                                </button>
                                                <button id="refuse" type="button" class="btn btn-danger" onclick="delEmp()" data-dismiss="modal">
                                                    舍弃
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
            <p id="spanPage"><span class="glyphicon glyphicon-asterisk"></span>每页显示第<span class="span2">1</span>到第<span class="span2">10</span>条记录，总共<span class="span3">${employPageModel.totalPage}</span>页记录，总共<span class="span3">${employPageModel.cnt}</span>条记录</p>
            <ul class="pagination" id="page">
                <li><a href="${pageContext.request.contextPath}/employ/queryEmpByPage?stuNo=${student.stuNo}&pageNo=${employPageModel.firstPage}">&laquo;</a></li>
                <li><a href="${pageContext.request.contextPath}/employ/queryEmpByPage?stuNo=${student.stuNo}&pageNo=${employPageModel.prePage}">Previous</a></li>
                <li><a href="#">${employPageModel.pageNo}</a></li>
                <li><a href="${pageContext.request.contextPath}/employ/queryEmpByPage?stuNo=${student.stuNo}&pageNo=${employPageModel.nextPage}">Next</a></li>
                <li><a href="${pageContext.request.contextPath}/employ/queryEmpByPage?stuNo=${student.stuNo}&pageNo=${employPageModel.lastPage}">&raquo;</a></li>
            </ul>
        </div>

    </div>
</body>
</html>
