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
    <title>学生信息</title>
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
</style>

<script type="text/javascript">
    $(function () {
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

        //根据四个条件动态查询学生信息
        queryStuByFourCon();

    });


    //根据四个条件动态查询学生信息
    function queryStuByFourCon(){
        $("#search").click(function() {
            var stuNo = $("#stuNo").val();
            if(isNaN(stuNo)){
                alert("学号由数字组成 请重新输入！");
            }else{
                var stuName = $("#stuName").val();
                var stuSex = $("#stuSex").val();
                var stuSchool = $("#stuSchool").val();
                //提交表单数据
                var studentData = {
                    stuNo : stuNo,
                    stuName : stuName,
                    stuSex : stuSex,
                    stuSchool : stuSchool,
                };
                var data = JSON.stringify({
                    "student" : studentData
                });
                //通过jquery的格式转换成String 通过ajax传送到服务端
                $.ajax({
                    type : "post",
                    data : data,
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/student/queryStuByFourCon",
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
            }
        });
    }

    //删除学生 学生本人注销账号后权限为-1 随后管理员可以删除学生账号
    function delStu(stuNo,stuPower){
        if(confirm("确定删除学生信息?")){
            // if(stuPower == "1"){
            //     alert("该学生账号未注销！不可删除！");
            // }else{
                $.ajax({
                    type : "post",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/student/delStu?stuNo=" + stuNo,
                    success : function (resp) {
                        //处理查询结果
                        if(resp.result) {
                            //删除成功
                            alert("学生账号:s" + resp.msg1 + "删除成功！");
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/student/queryStuByPage";
                        }else{
                            //删除失败
                            alert("此账号下有关联数据 学生账号:s" + resp.msg1 + "删除失败！");
                            //刷新表格数据
                            window.location.href = "${pageContext.request.contextPath}/student/queryStuByPage";
                        }
                    }
                });
            //}
        }
    }

    //根据学号查询学生信息 用于显示学生详细信息 前端表格展示
    function queryStuInfo(stuNo) {
        $.ajax({
            type : "get",
            async : false,
            cache : false,
            contentType : "application/json;charset=UTF-8",
            url : "${pageContext.request.contextPath}/student/queryStuInfo?stuNo=" + stuNo,
            success : function (resp) {
                //处理查询结果
                if(resp.result) {
                    //将数据填充到模态框中
                    $("#studentId").html(resp.content.stuId);
                    $("#studentNo").html(resp.content.stuNo);
                    $("#studentName").html(resp.content.stuName);
                    $("#studentAge").html(resp.content.stuAge);
                    $("#studentSex").html(resp.content.stuSex);
                    $("#studentSchool").html(resp.content.stuSchool);
                    $("#studentSpecialty").html(resp.content.stuSpecialty);
                    $("#studentPhone").html(resp.content.stuPhone);
                    $("#studentAddress").html(resp.content.stuAddress);
                    $("#studentDegree").html(resp.content.stuDegree);
                    if(resp.content.stuPower == "1"){
                        $("#studentPower").html("Student").css("color","orange");
                    }else if(resp.content.stuPower == "-1"){
                        $("#studentPower").html("已注销").css("color","red");
                    }
                }
            }
        });
    }
</script>
<body>
    <div id="div1">
        <div id="div2">
            <div id="div3"><span class="glyphicon glyphicon-user"></span><span>学生信息</span></div>
        </div>

        <div id="div5">
            <form action="">
                <div class="row">
                    <div class="col-lg-2" style="font-size: 18px;">
                        <label for="stuNo">学号：</label>
                        <input type="text" id="stuNo" name="stuNo" class="form-control" placeholder="请输入学号">
                    </div>
                    <div class="col-lg-2"style="position: relative;left: 50px;font-size: 18px;">
                        <label for="stuName">姓名：</label>
                        <input type="text" id="stuName" name="stuName" class="form-control" placeholder="请输入姓名">
                    </div>
                    <div class="col-lg-2"style="position: relative;left: 100px;font-size: 18px;">
                        <label for="stuSex">性别：</label>
                        <select id="stuSex"  name="stuSex" class="form-control">
                            <option value="">-请选择-</option>
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                    <div class="col-lg-2"style="position: relative;left:140px;font-size: 18px;">
                        <label for="stuSchool">学校：</label>
                        <input type="text" id="stuSchool" name="stuSchool" class="form-control" placeholder="请输入学校">
                    </div>
                    <button  style="font-size: 18px;" type="button" id="search" class="btn btn-success"><span></span>搜索</button>
                </div>
            </form>
        </div>

        <div class="table-responsive" style="margin-top: 60px;">
            <table class="table table-striped table-bordered table-hover" id="tableId" style="font-size: 20px;">
                <thead>
                    <tr>
                        <th>学号</th>
                        <th>姓名</th>
                        <th>年龄</th>
                        <th>性别</th>
                        <th>学历</th>
                        <th>学校</th>
                        <th>专业</th>
                        <th>电话</th>
                        <th>地址</th>
                        <th>操作</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach items="${studentPageModel.dataList}" var="student">
                        <tr>
                            <td>${student.stuNo}</td>
                            <td>${student.stuName}</td>
                            <td>${student.stuAge}</td>
                            <td class="stuSexColor">${student.stuSex}</td>
                            <td>${student.stuDegree}</td>
                            <td>${student.stuSchool}</td>
                            <td>${student.stuSpecialty}</td>
                            <td>${student.stuPhone}</td>
                            <td>${student.stuAddress}</td>

                            <td class="td_a">
<%--                                <a src=""><span class="glyphicon glyphicon-tag"></span></a>&nbsp;--%>
<%--                                <a src=""><span class="glyphicon glyphicon-pencil"></span></a>&nbsp;--%>

                                <a href="#" onclick="queryStuInfo('${student.stuNo}')" data-toggle="modal" data-target="#myModal2">
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
                                                    学生详细信息
                                                </h4>
                                            </div>
                                            <div class="modal-body">
                                                <div class="form-group">
                                                    <label class="col-sm-2 control-label">用户名：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentId"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">学号：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentNo"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">姓名：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentName"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">年龄：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentAge"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">性别：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentSex"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">学历：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentDegree"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">学校：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentSchool"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">专业：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentSpecialty"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">电话：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentPhone"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">地址：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentAddress"></p>
                                                    </div>
                                                    <label class="col-sm-2 control-label">权限：</label>
                                                    <div class="col-sm-10">
                                                        <p class="form-control-static" id="studentPower"></p>
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
                                <%--<c:if test="${student.stuPower=='-1'}">--%>
                                    <a href="#" onclick="delStu('${student.stuNo}','${student.stuPower}')"><span class="glyphicon glyphicon-trash"></span></a>
                                <%--</c:if>--%>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div id="div6">
            <p id="spanPage"><span class="glyphicon glyphicon-asterisk"></span>每页显示第<span class="span2">1</span>到第<span class="span2">10</span>条记录，总共<span class="span3">${studentPageModel.totalPage}</span>页记录，总共<span class="span3">${studentPageModel.cnt}</span>条记录</p>
            <ul class="pagination" id="page">
                <li><a href="${pageContext.request.contextPath}/student/queryStuByPage?pageNo=${studentPageModel.firstPage}">&laquo;</a></li>
                <li><a href="${pageContext.request.contextPath}/student/queryStuByPage?pageNo=${studentPageModel.prePage}">Previous</a></li>
                <li><a href="#">${studentPageModel.pageNo}</a></li>
                <li><a href="${pageContext.request.contextPath}/student/queryStuByPage?pageNo=${studentPageModel.nextPage}">Next</a></li>
                <li><a href="${pageContext.request.contextPath}/student/queryStuByPage?pageNo=${studentPageModel.lastPage}">&raquo;</a></li>
            </ul>
        </div>

    </div>
</body>
</html>
