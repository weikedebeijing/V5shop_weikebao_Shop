<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerBind.aspx.cs" Inherits="V5APP.Store.UI.member.CustomerBind" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>申请分销</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/form-fundation.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.tab.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>

<body class="body-gray">
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="javascript:window.history.go(-1)" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">账户绑定</h1>
            </section>
            <section class="right-small right-small-text2">
                <a href="javascript:void(0)" onclick="btnSave();" class="button [radius round] top-button">绑定</a>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--submit errow tip begin-->
    <div data-alert class="alert-box alert" style="display: none;" id="errerMsg"><a href="#" class="close">&times;</a></div>
    <!--submit errow tip end-->
    <!--table begin-->
    <dl class="tabs tab-title3" id="ul">
        <dd class="active" tag="login"><a href="javascript:void(0)">已有账号</a></dd>
        <dd><a href="javascript:void(0)">没有账号</a></dd>
    </dl>
    <!--table end-->
    <div class="tabs-content">
        <div class="content active" id="panel1">
            <!--form begin-->
            <form class="login-bind">
                <div class="row">
                    <div class="large-12 columns">
                        <h6 class="text-gary">输入已有的账号绑定</h6>
                    </div>
                </div>
                <div class="row">
                    <div class="large-12 columns">
                        <input type="text" placeholder="用户名" value="" id="oldLoginName" class="radius" />
                        <small class="error" style="display: none;">请填写用户名</small>
                    </div>
                </div>
                <div class="row">
                    <div class="large-12 columns">
                        <input type="password" class="radius" placeholder="密码" id="oldPassWord" value="" />
                        <small class="error" style="display: none;">请填写密码</small>
                    </div>
                </div>
                <div class="row">
                    <div class="large-12 columns">
                        或&nbsp;<a href="javascript:void(0)" onclick="changeTab('')">使用新帐号绑定</a>
                    </div>
                </div>
            </form>
            <!--form end-->
        </div>
        <div class="content" id="panel2">
            <form class="login-bind">
                <div class="row">
                    <div class="large-12 columns">
                        <h6 class="text-gary">使用新账号绑定</h6>
                    </div>
                </div>
                <div class="row">
                    <div class="large-12 columns">
                        <input type="text" placeholder="用户名" value="" class="radius" id="newLoginName" />
                        <small class="error" style="display: none;">请填写用户名</small>
                    </div>
                </div>
                <div class="row">
                    <div class="large-12 columns">
                        <input type="password" class="radius" placeholder="密码" id="newPassWord" value="" />
                        <small class="error" style="display: none;">请填写密码</small>
                    </div>
                </div>
                <div class="row">
                    <div class="large-12 columns">
                        <input type="password" class="radius" placeholder="确认密码" id="newPassWord2" value="" />
                        <small class="error" style="display: none;">两次密码不一致</small>
                    </div>
                </div>
                <div class="row">
                    <div class="large-12 columns">
                        或&nbsp;<a href="javascript:void(0)" onclick="changeTab('login')">使用已帐号</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script>
        $(document).foundation().foundation('joyride', 'start');
        $("#ul dd").click(function () {
            $("#ul dd").removeClass("active");
            $(this).addClass("active");
            if ($(this).attr("tag") == "login") {
                $("#panel1").show();
                $("#panel2").hide();
            } else {
                $("#panel2").show();
                $("#panel1").hide();
            }
        })
        function changeTab(obj) {
            $("#ul dd").removeClass("active");
            if (obj == "login") {
                $("#ul dd[tag='login']").addClass("active");
                $("#panel1").show();
                $("#panel2").hide();
            } else {
                $("#ul dd[tag!='login']").addClass("active");
                $("#panel2").show();
                $("#panel1").hide();
            }
        }

        function btnSave() {
            if ($("#ul dd[tag='login']").hasClass("active")) {
                var oldLoginName = $("#oldLoginName").val().trim();
                var oldPassWord = $("#oldPassWord").val().trim();
                if (oldLoginName == "") {
                    ShowMsg("请填写用户名");
                    $("#oldLoginName").focus();
                    return false;
                }
                if (oldPassWord == "") {
                    ShowMsg("请填写密码");
                    $("#oldPassWord").focus();
                    return false;
                }
                var reg = /^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$/;
                if (!reg.test(oldPassWord)) {
                    $("#oldPassWord").focus();
                    ShowMsg("密码不符合规则(6-16个字符)");
                    return false;
                }
                $.ajax({
                    url: "../member/ajax/gateway.aspx",
                    data: { "Action": "CheckLoginNameAndPassWord", "LoginName": oldLoginName, "PassWord": oldPassWord },
                    async: false,
                    cache: false,
                    success: function (res) {
                        // alert(res);
                        if (res == "true") {
                            window.location.href = "member.aspx?isshow=1";
                        } else if (res == "-1") {
                            ShowMsg("该帐号已被冻结");
                            return false;
                        } else if (res == "-2") {
                            ShowMsg("该帐号已经绑定过第三方帐号");
                            return false;
                        } else if (res == "-101") {
                            ShowMsg("帐号绑定失败");
                            return false;
                        } else {
                            ShowMsg("用户名或密码错误");
                            return false;
                        }
                    }
                })
            } else {
                var newLoginName = $("#newLoginName").val().trim();
                var newPassWord = $("#newPassWord").val().trim();
                var newPassWord2 = $("#newPassWord2").val().trim();
                if (newLoginName == "") {
                    ShowMsg("请填写用户名");
                    $("#newLoginName").focus();
                    return false;
                }
                if (newPassWord == "") {
                    ShowMsg("请填写密码");
                    $("#newPassWord").focus();
                    return false;
                }
                var reg = /^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$/;
                if (!reg.test(newPassWord)) {
                    $("#newPassWord").focus();
                    ShowMsg("密码不符合规则(6-16个字符)");
                    return false;
                }
                if (newPassWord2 == "") {
                    ShowMsg("请确认密码");
                    $("#newPassWord2").focus();
                    return false;
                }
                if (newPassWord != newPassWord2) {
                    $("#newPassWord").focus();
                    ShowMsg("两次输入密码不一致");
                    return false;
                }
                var checkLoginName = "false";
                $.ajax({
                    url: "../member/ajax/gateway.aspx",
                    data: { "action": "ClickLoginName", "LoginName": newLoginName },
                    async: false,
                    cache: false,
                    success: function (res) {
                        checkLoginName = res;
                    }
                })
                if (checkLoginName == "false") {
                    ShowMsg("用户名已存在");
                    return false;
                } else {
                    $.ajax({
                        url: "../member/ajax/gateway.aspx",
                        data: { "Action": "CustomerBind", "LoginName": newLoginName, "PassWord": newPassWord },
                        async: false,
                        cache: false,
                        success: function (res) {
                            if (res == "true") {
                                window.location.href = "member.aspx?isshow=1";
                            } else {
                                ShowMsg("帐号绑定失败");
                                return false;
                            }
                        }
                    })
                }
            }

        }

    </script>
</body>
</html>

