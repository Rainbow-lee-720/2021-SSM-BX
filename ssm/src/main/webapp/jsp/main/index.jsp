<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>登录</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- 新 Bootstrap3 核心 CSS 文件 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static.bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static.bootstrap/css/bootstrap-theme.css">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="${pageContext.request.contextPath}/resources/static.bootstrap/jquery/jquery.min.js"></script>

    <!-- 最新的 Bootstrap3 核心 JavaScript 文件 -->
    <script src="${pageContext.request.contextPath}/resources/static.bootstrap/js/bootstrap.min.js"></script>

    <!-- 引入自定义css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">

    <script type="text/javascript">
        $(function () {
            //首次获取服务端传过来的验证码
            $("#codeImg").attr("src","${pageContext.request.contextPath}/utilController/getVerifyCode");
            //更新验证码
            $("#changeImg").click(function () {
                $("#codeImg").attr("src","${pageContext.request.contextPath}/utilController/getVerifyCode?" + Math.random());
            });

            ajaxCheckId();
        });

        function ajaxCheckId() {
            //TODO 用户名输入框失去焦点时通过ajax校验用户名是否存在 不存在则先提示信息 然后提示用户注册
            $("#username").blur(function () {
                var username = $.trim($("#username").val());
                var json = {
                    username : username
                };
                var data = JSON.stringify(json);
                if(username == "" || username == null){
                    $("#errusername").html("请输入用户名");
                    $("#username").focus();
                }else{
                    $.ajax({
                        type : "post",
                        data : data,
                        cache : false,
                        async: false,
                        contentType : "application/json;charset=UTF-8",
                        dataType: "json",
                        url: "${pageContext.request.contextPath}/utilController/checkNoAjax",
                        success : function (data) {
                            if(data.result){
                               //用户名已注册 直接登录
                                var msg = data.msg1;
                                $("#errusername").css("color","snow").html(msg);
                            }else{
                                //用户名未注册 先注册
                                var msg = data.msg1;
                                $("#errusername").css("color","red").html(msg);
                                $("#username").focus(function () {
                                    $("#errusername").html("");
                                });
                            }
                        }
                    });
                }

            });
        }

        //登录校验
        function doLogin(){
            //获取用户输入的用户名、密码、验证码
            var username = $.trim($("#username").val());
            var password = $.trim($("#password").val());
            var power = $.trim($("input[type='radio']:checked").val());
            var checkCode = $.trim($("#checkCode").val());
            //校验
            //用户名密码正则表达式
            var regxUserPattern = /^(\w){6,10}$/;
            if(username == "" || username == null){
                $("#errusername").html("请输入用户名");
                $("#username").focus(function () {
                    $("#errusername").html("");
                });
            }else if(!(regxUserPattern.test(username))){
                alert("用户名必须由6-10位数字、字母或下划线组成!")
            }else if(password == "" || password == null){
                $("#errpassword").html("请输入密码")
                $("#password").focus(function () {
                    $("#errpassword").html("");
                });
            }else if(!(regxUserPattern.test(password))){
                alert("密码必须由6-10位数字、字母或下划线组成!")
            }else if(checkCode == "" || checkCode == null){
                $("#errCode").html("请输入验证码")
                $("#checkCode").focus(function () {
                    $("#errCode").html("");
                });
            }else if(checkCode.length != 4){
                $("#errCode").html("请输入四位验证码！");
            }else if(power == "" || power == null){
                $("#errPower").html("请选择用户类别");
            }else{
                //校验权限
                if(power == "学生"){
                    power = "1";
                }else if(power == "企业"){
                    power = "2";
                }else if(power == "管理员"){
                    power = "0";
                }else{
                    //用户未输入权限
                    power = "";
                }
                //输入不为空时 将数据转换成json格式传到后台校验
                var formData = {
                    username : username,
                    password : password,
                    checkCode : checkCode,
                    power : power
                };
                //通过jquery的格式转换成String
                var data = JSON.stringify({
                    "entityData" : formData
                });
                //通过ajax传送到服务端
                $.ajax({
                    type : "post",
                    data : data,
                    dataType : "json",
                    async : false,
                    cache : false,
                    contentType : "application/json;charset=UTF-8",
                    url : "${pageContext.request.contextPath}/utilController/doLogin",
                    success : function (resp) {
                        if(resp.result){
                            //校验成功,判断跳转到哪个权限用户的首页
                            // alert(resp.msg1);
                            //TODO msg2中存储了跳转的主页地址 用来替代"../student/main_stu.jsp"
                            window.location.href = resp.msg2;
                        }else{
                            //校验失败
                            alert(resp.msg1);
                        }
                    },
                    error : function () {
                        //验证码错误 登录失败
                        alert("验证码错误 登录失败！");
                    }
                });
            }

        }
    </script>
</head>
<body>
<div id="main">
    <div class="container">
        <form>
            <div class="mycenter">
                <div class="mysign">
                    <div class="col-lg-12 text-center text-info">
                        <h1 style="color: honeydew;font-size: 2.6em;font-weight: bold">大学毕业生就业信息管理系统</h1>
                    </div>

                    <div class="col-lg-8" style="margin-left:40px;">
                        <b><label for="username" style="color: whitesmoke;font-size: 20px;">用户名</label></b>
                        <input type="text" style="float: left;position:relative;left:40px;" id="username"class="form-control" name="username" placeholder="请输入用户名" required autofocus/>
                    </div>
                    <div class="col-lg-8" id="errusername" style="font-size: 17px;color: red;font-weight: bold;margin-top:10px;position: relative;left:110px;text-align: left;"></div>

                    <div class="col-lg-8" style="margin-left:40px;">
                        <b><label for="password" style="color: whitesmoke;font-size: 20px;">密码</label></b>
                        <input type="password" style="float: left;position:relative;left:40px;" id="password" class="form-control" name="password" placeholder="请输入密码" required autofocus/>
                    </div>
                    <div class="col-lg-8" id="errpassword" style="font-size: 17px;color:red;font-weight: bold;margin-top:10px;position: relative;left:110px;text-align: left;"></div>

                    <div class="col-lg-4" style="margin-left:60px;">
                        <b class="checkCode"><label for="checkCode" style="color: whitesmoke;font-size: 20px;">验证码</label></b>
                        <input type="text" style="float: left;position:relative;left:41px;" id="checkCode" class="form-control" name="checkCode"  placeholder="请输入验证码" required autofocus/>
                        <span class="codeImg" style="width:80px;height:45px;position: relative;left:140px;top: 37px;">
                            <img alt="加载失败" src="" id="codeImg" style="position: relative;left: 30px;"/>
					    </span>
                        <span class="codeImg" style="width:50px;height:45px;position: relative;left:287px;bottom: 30px;">
                            <a id="changeImg" οnclick="javascript:changeCodeImg();" style="color: whitesmoke;">&nbsp;&nbsp;换一张</a>
					    </span>
                    </div>
                    <div class="col-lg-8" id="errCode" style="font-size: 17px;color:red;font-weight: bold;margin-top:10px;position: relative;left:115px;text-align: left;"></div>

                    <div class="col-lg-10" style="margin-top: 10px;position: relative;left: 22px;">
                        <input class="power" name="power" type="radio" value="学生"><span style="font-weight: bold;color: #2C3E50;position: relative;"><span style="color: whitesmoke;font-size: 17px;">学生</span></span></input>
                        <input class="power" name="power" type="radio" value="企业"><span style="font-weight: bold;color: #2C3E50;position: relative;"><span style="color: whitesmoke;font-size: 17px;">企业</span></span></input>
                        <input class="power" name="power" type="radio" value="管理员"><span style="font-weight: bold;color: #2C3E50;position: relative;"><span style="color: whitesmoke;font-size: 17px;">管理员</span></span></input>
                    </div>
                    <div class="col-lg-8" id="errPower" style="color:red;font-weight: bold;margin-bottom: -10px;position: relative;left:60px;text-align: left;font-size: 17px;"></div>

                    <div class="col-lg-10" style="margin-left:25px;margin-top: 22px;">
                        <button type="button" id="login" class="btn btn-success col-lg-12" onclick="javascript:doLogin();" style="font-size: 22px;">登录</button>
                    </div>

                    <div class="col-lg-10 dropdown" style="margin-left:25px;margin-top: 5px;">
                        <button type="button" id="regist" class="btn btn-primary col-lg-12 dropbtn" style="font-size: 22px;">注册</button>
                        <div class="dropdown-content">
                            <a href="${pageContext.request.contextPath}/jsp/main/stuRegist.jsp" class="bg-success" style="background-color: darkorange;font-size: 20px;">学生注册</a>
                            <a href="${pageContext.request.contextPath}/jsp/main/comRegist.jsp" class="bg-warning" style="background-color: lightseagreen;font-size: 20px;">企业注册</a>
                        </div>
                    </div>

                    <div style="margin-left:25px;">
                        <a href="${pageContext.request.contextPath}/jsp/main/forgetPwd.jsp" class="forgetPwd" style="display: none;"><b>忘记密码？</b></a>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="bottom-div">
        <p style="font-size: 16px;text-align: center;font-weight: bold;font-family: Franklin Gothic Medium";>©NUIST  大学毕业生就业信息管理平台 Version1.0 2021-02-12</p>
        <p style="font-size: 14px;text-align: center;font-weight: bold;font-family: Franklin Gothic Medium";>-NUIST BX-</p>
    </div>
</div>
</body>
</html>