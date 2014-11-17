<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="V5APP.Store.UI.member.Register" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>会员注册</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.alert.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>

<body class="body-gray">

    <!--submit errow tip begin-->
    <div data-alert class="alert-box alert" style="display: none;" id="errerMsg"><a href="#" class="close">&times;</a></div>
    <!--submit errow tip end-->

    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="javascript:window.history.go(-1);" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">注册</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--form begin-->
    <form class="mt-55 mlr-15" action="?Action=Register" method="post" id="Register" name="Register">
        <div class="panel callout radius formstyle">
            <!--01 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix"><i class="icon-name"></i></span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="会员名称" class="pl0" name="LoginName" id="LoginName">
                      <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--01 end-->
            <!--02 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix"><i class="icon-lock"></i></span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="password" placeholder="密码" class="pl0" name="PassWord" id="PassWord">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--02 end-->
            <!--03 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix"><i class="icon-lock"></i></span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="password" placeholder="再次输入密码" class="pl0" name="PassWord2" id="PassWord2">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--03 end-->
            <%--  <!--04 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix"><i class="icon-tname"></i></span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="真实姓名" class="pl0" id="TrueName" name="TrueName">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--04 end-->
            <!--05 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix last"><i class="icon-mobile"></i></span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="手机" class="last pl0" id="Phone" name="Phone">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--05 end-->--%>
        </div>
        <!--button begin-->
        <a href="javascript:void(0)" id="btnSave" class="button [radius round]">注册</a>
        <!--button end-->
        <!--prerequisite begin-->
        <div class="row" style="display: none">
            <div class="large-6 columns">
                <input id="IsOK" type="checkbox" checked="checked" name="IsOK"><label for="checkbox1">我已阅读并接受<a href="">《用户协议》</a></label>
            </div>
        </div>
        <!--prerequisite end-->
    </form>
    <!--form end-->
    <script>
        $(document).foundation().foundation('joyride', 'start');
        $(function () {
            $("#btnSave").click(function () {
                $("#errerMsg").hide(300, "linear");
                var LoginName = $("#LoginName").val().trim();
                var checkLoginName = "false";
                if (LoginName != "") {
                    $.ajax({
                        url: "../member/ajax/gateway.aspx",
                        data: { "action": "ClickLoginName", "LoginName": LoginName },
                        async: false,
                        cache: false,
                        success: function (res) {
                            checkLoginName = res;
                        }
                    })
                } else {
                    $("#LoginName").focus();
                    ShowMsg("用户名不能为空");
                    return false;
                }
                if (checkLoginName == "false") {
                    ShowMsg("用户名已存在");
                    return false;
                }
                //密码(6-16)位
                var password = $("#PassWord").val();
                var reg = /^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$/;
                if (!reg.test(password)) {
                    $("#PassWord").focus();
                    ShowMsg("密码不符合规则(6-16个字符)");
                    return false;
                }
                var password2 = $("#PassWord2").val();
                if (password2 != password) {
                    $("#PassWord2").focus();
                    ShowMsg("两次输入密码不一致");
                    return false;
                }
                //var truename = $("#TrueName").val().trim();
                //if (truename == "") {
                //    $("#TrueName").focus();
                //    ShowMsg("真实姓名不能为空");
                //    return false;
                //}
                //var phone = $("#Phone").val().trim();
                ////手机11位
                //reg = /^\d{11}$/;
                //if (!reg.test(phone)) {
                //    $("#Phone").focus();
                //    ShowMsg("手机号码格式不正确");
                //    return false;
                //}

                //if (!$("#IsOK").is(':checked')) {
                //    $("#IsOK").focus();
                //    ShowMsg("请确认已阅读并接受《用户协议》");
                //    return false;
                //}
                $("#Register").submit();
            })
        })
    </script>
</body>
</html>
