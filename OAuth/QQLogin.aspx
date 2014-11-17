<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QQLogin.aspx.cs" Inherits="V5APP.Store.UI.OAuth.QQLogin" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>QQ认证</title>
    <script type="text/javascript" src="http://qzonestyle.gtimg.cn/qzone/openapi/qc_loader.js"
        charset="utf-8" data-callback="true"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script type="text/javascript">
        var bl = false;
        var OpenID = "";
        var Access_token = "";
        var code = window.location.pathname.split('/')[1];
        var int_value;
        $("#JumpSpan").hide();
        if (QC.Login.check()) {//如果已登录
            QC.Login.getMe(function (openId, accessToken) {
                OpenID = openId;
                Access_token = accessToken;
                Login();
            });

            //int_value = window.setInterval("embed()", 1000);

            //function embed() {
            //    if (OpenID.length > 0) {
            //        window.clearInterval(int_value);
            //        Login();
            //    }
            //}
        }

        function Login() {

            //var Figureurl_qq_1 = "";
            //var Gender = "男";
            //var Nickname = "";

            $.ajax({
                url: "../member/authorise/QQLogin.aspx",
                type: "get",
                async: false,
                dataType: "text",
                data: { "Type": "IsLogin", "openId": OpenID },
                cache: false,
                success: function (res) {
                    if (res == "true") {
                        window.location.href = "../../" + code + "/member/member.aspx";
                        window.event.returnValue = false;
                        ShowNextJump();
                    } else if (res == "-1") {
                        //跳转到会员冻结页面
                        window.location.href = "../../" + code + "member/ShopError.aspx?msg=您的会员帐号已被冻结......";
                        window.event.returnValue = false;
                        ShowNextJump();
                    } else {
                        //从页面收集OpenAPI必要的参数。get_user_info不需要输入参数，因此paras中没有参数
                        //var paras = {};

                        ////用JS SDK调用OpenAPI
                        //QC.api("get_user_info", "")
                        ////指定接口访问成功的接收函数，s为成功返回Response对象
                        //.success(function (s) {
                        //    //成功回调，通过s.data获取OpenAPI的返回数据
                        //    Figureurl_qq_1 = s.data.figureurl_qq_1;
                        //    Gender = s.data.gender;
                        //    Nickname = s.data.nickname;
                        //    alert(Figureurl_qq_1 + Gender + Nickname);
                        //})
                        ////指定接口访问失败的接收函数，f为失败返回Response对象
                        //.error(function (f) {
                        //    //失败回调
                        //    alert("获取用户信息失败！");
                        //})
                        ////指定接口完成请求后的接收函数，c为完成请求返回Response对象
                        //.complete(function (c) {
                        //    //完成请求回调
                        //    alert("获取用户信息完成！");
                        //});

                        $.ajax({
                            url: "../member/authorise/QQLogin.aspx",
                            type: "get",
                            async: false,
                            dataType: "text",
                            data: { "Type": "UserInfo", "openID": OpenID, "access_token": Access_token },
                            cache: false,
                            success: function (res) {
                                if (res) {
                                    //window.location.href = "../../" + code + "/member/member.aspx#wechat_redirect";
                                    //window.event.returnValue = false;
                                    ShowNextJump();
                                } else {
                                }
                            }
                        });
                    }
                }
            });
        }

        function ShowNextJump() {
            int_value = window.setInterval("embed()", 4000);
        }

        function embed() {
            window.clearInterval(int_value);
            $('#NextJump').attr('href', '../../' + code + '/member/member.aspx');
            $("#JumpSpan").show();
        }
    </script>
</head>
<body>
    <div id="JumpSpan" style="position:absolute;top:50%;margin-top:-80px;width:100%;text-align:center;vertical-align:middle;font-family:'微软雅黑';line-height:30px;color:#999;font-size:16px;display:none">自动跳转失败，<br/>请手动点击<a id="NextJump" style="margin:0 5px;color:#29beff;">跳转</a>进入会员帐号绑定页面</div>
</body>
</html>
