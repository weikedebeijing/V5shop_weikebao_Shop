<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="V5APP.Store.UI.member.Login" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>会员登陆</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.alert.js"></script>
    <script src="../../member/js/Common.js"></script>
    <script src="../../member/js/addjs.js"></script>
</head>

<body class="body-gray">
    <!--other login popup begin-->
    <div class="fixed bottom" id="otherList" style="display: none;">

        <ul class="side-nav otherloginpopup">

            <%if (isWXBrowser)
              { %>
            <li class="thrid"><a href="<%=wxLoginUrl %>"><span><i class="icon-wechat"></i>微信</span></a></li>
            <%} %>
            <li class="thrid"><a href="javascript:void(0)" onclick="javascript:qqlogin()"><span><i class="icon-qq"></i>Q&nbsp;&nbsp;Q</span></a></li>
            <li class="li-button"><a href="javascript:void(0)" onclick="otherlogin()" class="button [radius round] gray">取消</a></li>
        </ul>
    </div>
    <!--other login popup begin-->
    <!--submit errow tip begin-->
    <div data-alert class="alert-box alert" id="errerMsg" style="display: none;"><a href="#" class="close">&times;</a></div>
    <!--submit errow tip end-->
    <!--submit success tip end-->
    <div data-alert class="alert-box success" style="display: none;">登录成功！</div>
    <!--submit success tip end-->

    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="javascript:window.history.go(-1);" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">登录</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--form begin-->
    <form class="mt-55 mlr-15">
        <div class="panel callout radius formstyle">
            <!--01 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix"><i class="icon-name"></i></span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="会员名称" class="pl0" id="LoginName">
                </div>
            </div>
            <!--01 end-->
            <!--02 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix last"><i class="icon-lock"></i></span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="password" placeholder="密码" id="PassWord" class="pl0 last">
                </div>
            </div>
            <!--02 end-->
        </div>
        <!--button begin-->
        <a href="javascript:void(0)" onclick="btnSave()" class="button [radius round] loginbtn">登录</a>
        <a href="register.aspx?url=<%=url %>" class="button [radius round] gray">注册</a>
        <!--button end-->
    </form>
    <!--form end-->
    <div style="display: none">
        <span id="qqLoginBtn">使用<i>QQ</i>登录</span>
    </div>
    <!--other begin-->
    <%if (IsShow)
      { %>
    <div class="fixed bottom" id="other" onclick="otherlogin()" style="display: ;">
        <div class="panel otherlogin">

            <a href="javascript:void(0)">其他方式登录</a>
        </div>
    </div>
    <%} %>
    <!--other end-->
    <script>
        $(document).foundation().foundation('joyride', 'start');

        function otherlogin() {
            $("#other").toggle();
            $("#otherList").toggle();
        }
        function btnSave() {
            $("#errerMsg").hide(300, "linear");
            var LoginName = $("#LoginName").val().trim();
            var password = $("#PassWord").val().trim();
            if (LoginName == "") {
                $("#LoginName").focus();
                ShowMsg("会员名称不能为空");
                return false;
            }
            //密码(6-16)位
            var reg = /^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$/;
            if (!reg.test(password)) {
                $("#PassWord").focus();
                ShowMsg("密码不符合规则(6-16个字符)");
                return false;
            }
            $.ajax({
                url: "../member/ajax/gateway.aspx",
                data: { "Action": "Login", "LoginName": LoginName, "PassWord": password },
                async: false,
                cache: false,
                success: function (res) {
                    if (res == "true") {
                        window.location.href = "<%=url%>";
                    } else if (res == "-1") {
                        ShowMsg("该帐号已被冻结");
                        return false;
                    } else {
                        ShowMsg("用户名或密码错误");
                        return false;
                    }
                }
            })

        }

    </script>
    <script type="text/javascript">
        function qqlogin() {
            $("#qqLoginBtn a").click();
        }
        if (QC.Login.check()) {
            QC.Login.signOut();
        }
        //调用QC.Login方法，指定btnId参数将按钮绑定在容器节点中
        QC.Login({
            //btnId：插入按钮的节点id，必选
            btnId: "qqLoginBtn",
            //用户需要确认的scope授权项，可选，默认all
            scope: "all",
            //按钮尺寸，可用值[A_XL| A_L| A_M| A_S|  B_M| B_S| C_S]，可选，默认B_S
            size: "A_XL"
        },
        function (reqData, opts) {//登录成功
            var bl = false;
            var OpenID = "";
            if (QC.Login.check()) {//如果已登录
                QC.Login.getMe(function (openId, accessToken) {
                    OpenID = openId;
                    //                alert(["当前登录用户的", "openId为：" + openId, "accessToken为：" + accessToken].join("\n"));
                    $.ajax({
                        url: "../member/authorise/QQLogin.aspx",
                        type: "get",
                        async: false,
                        dataType: "text",
                        data: { "Type": "IsLogin", "openId": openId },
                        cache: false,
                        success: function (res) {
                            if (res == "true") {
                                window.location.href = "<%=url%>";
                            } else {
                                alert("获取用户信息成功！当前用户昵称为：" + s.data.nickname);
                                $.ajax({
                                    url: "../member/authorise/QQLogin.aspx",
                                    type: "get",
                                    async: false,
                                    dataType: "text",
                                    data: { "Type": "UserInfo", "logourl": reqData.figureurl_qq_1, "gender": reqData.gender, "nickname": reqData.nickname, "openID": OpenID },
                                    cache: false,
                                    success: function (res) {
                                        if (res == "true") {

                                            ///需要跳转帐号绑定页面
                                            window.location.href = "<%=url%>";
                                        } else {
                                            //ShowMsg("密码或昵称错误");
                                            return false;
                                        }
                                    }
                                })
                            }
                        }
                    });
                });
            }
        }, function (opts) {//注销成功
            alert('QQ登录 注销成功');
        }
        );
    </script>
</body>
</html>

