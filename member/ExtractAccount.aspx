<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExtractAccount.aspx.cs" Inherits="V5APP.Store.UI.member.ExtractAccount" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>我的账号</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>
<body class="body-gray">

    <!--submit errow tip begin-->
    <div data-alert class="alert-box alert" id="errerMsg" style="display: none;"><a href="#" class="close">&times;</a></div>
    <!--submit errow tip end-->


    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="javascript:void(0)" onclick="backpage();" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">我的账号</h1>
            </section>
            <%--  <section class="right-small">
                <a class="menu-add" href="AddExtractAccount.aspx<%=jumpstr %>"><span></span></a>
            </section>--%>
        </nav>
    </div>
    <!--topbar end-->
    <!--button add begin-->
    <div class="listAdd-btn">
        <a href="AddExtractAccount.aspx<%=jumpstr %>" class="button [radius round]"><i>+</i>添加账号</a>
    </div>
    <!--button add begin-->
    <!--content begin-->
    <ul class="side-nav account" id="ul">
        <%foreach (var cashAccount in li)
          { %>
        <%if (cashAccount.IsDefault)
          { %>
        <li class="current" id="0">
            <%}
          else
          { %>
        <li id="<%=cashAccount.ID %>">
            <%} %>
            <a href="javascript:void(0)" class="classnone">
                <span class="payLogo">
                    <img src="../../member/images/alipay.png"></span>
                <span class="payInfo"><%=cashAccount.CashRealName %><br>
                    <%=cashAccount.CashAccount %></span>
                <span class="payStatus">默认</span>
            </a>
            <div class="opera">
                <a href="EditExtractAccount.aspx?ID=<%=cashAccount.ID %>" class="a-edit"><i class="icon-edit-gray"></i></a>
                <%if (cashAccount.IsDefault)
                  { %>
                <a href="javascript:void(0)" onclick="DelCashAccount(0)" class="a-del"><i class="icon-del-gray"></i></a>
                <%}
                  else
                  { %>
                <a href="javascript:void(0)" onclick="DelCashAccount(<%=cashAccount.ID %>)" class="a-del"><i class="icon-del-gray"></i></a>
                <%} %>
            </div>
        </li>

        <%} %>
    </ul>
    <!--content end-->
    <script type="text/javascript">
        function DelCashAccount(cashAccountID) {
            if (cashAccountID == 0) {
                ShowMsg("默认帐号不可删除");
                return false;
            } else {
                $.ajax({
                    url: "../member/ajax/LoginHandle.aspx",
                    data: { "action": "DelExtractAccount", "CashAccountID": cashAccountID },
                    async: false,
                    cache: false,
                    success: function (res) {
                        if (res == "true") {
                            window.location.href = "ExtractAccount.aspx";
                        } else {
                            ShowMsg("删除失败,请稍候再试");
                        }
                    }
                })
            }

        }
        $(function () {
            $("#ul li").click(function (event) {
                var obj = this;
                if (getEventTarget(event, 1).tagName != "A" || getEventTarget(event, 1).className == "classnone") {
                    ///alert(1);
                    var cashAccountID = $(this).attr("id");
                    if (cashAccountID != "0") {
                        $.ajax({
                            url: "../member/ajax/LoginHandle.aspx",
                            data: { "action": "DefaultExtractAccount", "CashAccountID": cashAccountID },
                            async: false,
                            cache: false,
                            success: function (res) {
                                if (res == "true") {
                                    $("#list li").removeClass("current");
                                    $(obj).addClass("current");
                                    var pageurl = request("url");
                                    if (pageurl == "") {
                                        window.location.href = "Extract.aspx"
                                    } else {
                                        window.location.href = pageurl;
                                    }
                                    //window.location.href = "Extract.aspx";
                                } else {
                                    ShowMsg("修改失败,请稍候再试");
                                }
                            }
                        })
                    }
                }
            })
            function getEventTarget(event, targetType) {
                event = event || window.event;
                if (targetType == 1) {// 获得触发的对象
                    return event.target || event.srcElement;
                } else if (targetType == 2) {// 获得处理事件的对象
                    return event.currentTarget;
                }
            }
        })

        function backpage() {
            var pageurl = request("url");
            if (pageurl == "") {
                window.location.href = "member.aspx"
            } else {
                window.location.href = pageurl;
            }
        }
    </script>
</body>
</html>
