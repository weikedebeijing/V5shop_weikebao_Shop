<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddExtractAccount.aspx.cs" Inherits="V5APP.Store.UI.member.AddExtractAccount" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>添加账号</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>
<body class="body-gray">
   
        <!--submit errow tip begin-->
        <div data-alert class="alert-box alert" style="display: none;" id="errerMsg">请输入正确的手机！<a href="#" class="close">&times;</a></div>
        <!--submit errow tip end-->
        <!--submit success tip end-->
        <div data-alert class="alert-box success" style="display: none;">注册成功！</div>
        <!--submit success tip end-->
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="ExtractAccount.aspx" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">添加账号</h1>
            </section>
            <section class="right-small right-small-text2">
                <a href="javascript:void(0)" id="btnSave" class="button [radius round] top-button">保存</a>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--content begin-->
    <form class="mt-55 mlr-15">
        <!--logo begin-->
        <div class="row accountLogo">
            <div class="large-12 columns">
                <input type="radio" name="Type" value="<%:(int)V5.MetaData.Util.AppEnum.CashAccountType.Alipay %>" id="Type" checked>
                <label for="type" class="label-pic">
                    <img src="../../member/images/alipay.png"></label>
            </div>
        </div>
        <!--logo end-->
        <div class="panel callout radius formstyle">
            <!--01 begin-->
            <div class="row collapse">
                <div class="small-12 large-12 columns">
                    <input type="text" placeholder="真实姓名" id="CashRealName" name="CashRealName">
                      <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--01 end-->
            <!--02 begin-->
            <div class="row collapse">
                <div class="small-12 large-12 columns">
                    <input type="text" placeholder="账号" id="CashAccount" name="CashAccount">
                      <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--02 end-->
            <!--03 begin-->
            <div class="row collapse">
                <div class="small-12 large-12 columns">
                    <input type="text" placeholder="手机号码" id="CashPhone" name="CashPhone">
                      <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--03 end-->
        </div>
    </form>
    <!--content end-->
</body>
<script type="text/javascript">
    $(function () {
        $("#btnSave").click(function () {
            $("#errerMsg").hide(300, "linear");
            var CashRealName = $("#CashRealName").val().trim();
            if (CashRealName == "") {
                $("#CashRealName").focus();
                ShowMsg("真实姓名不能为空");
                return false;
            }
            var CashAccount = $("#CashAccount").val().trim();
            if (CashAccount == "") {
                $("#CashAccount").focus();
                ShowMsg("账号不能为空");
                return false;
            }
            var CashPhone = $("#CashPhone").val().trim();
            //手机11位
            reg = /^\d{11}$/;
            if (!reg.test(CashPhone)) {
                $("#Phone").focus();
                ShowMsg("手机号码格式不正确");
                return false;
            }
            var Type=$("#Type").val();
            $.ajax({
                url: "../member/ajax/LoginHandle.aspx",
                data: { "action": "AddExtractAccount", "CashRealName": CashRealName, "CashAccount": CashAccount, "CashPhone": CashPhone, "Type": Type },
                async: false,
                cache: false,
                success: function (res) {
                    if (res == "true") {
                        var pageurl = request("url");
                        if (pageurl == "") {
                            window.location.href = "ExtractAccount.aspx"
                        } else {
                            window.location.href = pageurl;
                        }
                        //window.location.href = "ExtractAccount.aspx";
                    } else {
                        ShowMsg("添加失败,请稍候再试");
                    }
                }
            })
        })
    })
</script>
</html>
