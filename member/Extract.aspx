<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Extract.aspx.cs" Inherits="V5APP.Store.UI.member.Extract" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>我的佣金</title>
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
                <a href="Brokerage.aspx" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">提取佣金</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--content begin-->
    <div class="panel extract">
        <div class="commision-total"><span class="span-title">佣金总额</span><span class="number">￥<%=customerShopStatistics.Amount.ToString("0.00") %></span></div>
        <div class="extract-number"><span class="span-title">可提现金额</span><span class="number" id="MaxCashAmount">￥<%=MaxCashAmount.ToString("0.00") %></span><i class="icon-horn"></i></div>
        <div class="horn-text" style="display: ;">提现金额为交易成功超过<%=days %>天的佣金金额</div>
        <div class="panel extract-account">
            <ul class="side-nav">
                <%if (cashAccount != null)
                  { %>

                <li><a href="ExtractAccount.aspx?url=Extract.aspx"><span><%=cashAccount.CashRealName %><br>
                    <%=cashAccount.CashAccount %></span><i class="arrow"></i></a></li>

                <%}
                  else
                  {%>

                <li class="account-none"><a href="AddExtractAccount.aspx?url=Extract.aspx"><span>添加账号</span><i class="arrow"></i></a></li>
                <%} %>
            </ul>
        </div>
        <div class="row extract-monynumber">
            <div class="large-12 columns">
                <input type="text" class="" id="CashAmount" placeholder="输入提取金额">
                <span class="close-input" style="display: ;"></span>
            </div>
        </div>
        <div class="tip-text">最低提现金额为<b id="MinaAmountCash"><%=MinaAmountCash %></b>元，必须为<b id="IntTimes"><%=IntTimes %></b>的整数倍</div>
        <a href="javascript:void(0)" onclick="btnSave()" class="button [radius round] red">立即提取</a>
    </div>
    <!--content end-->
    <script type="text/javascript">
        function btnSave() {
            var CashAmount = $("#CashAmount").val().trim();
            var MaxCashAmount = $("#MaxCashAmount").text().trim();
            var MinaAmountCash = $("#MinaAmountCash").text().trim();
            var IntTimes = $("#IntTimes").html().trim();
            MaxCashAmount = MaxCashAmount.substr(1);
            var reg = /^[0-9]*(\.[0-9]{1,2})?$/;
            if (reg.test(CashAmount)) {
                CashAmount = Number(CashAmount);
                MaxCashAmount = Number(MaxCashAmount);
                MinaAmountCash = Number(MinaAmountCash);
                if (CashAmount > 0) {
                    if (CashAmount <= MaxCashAmount) {
                        if (CashAmount >= MinaAmountCash) {
                            if (CashAmount % parseInt(IntTimes) == 0) {
                                $.ajax({
                                    url: "../member/ajax/LoginHandle.aspx",
                                    data: { "action": "CreateCashFlows", "CashAmount": CashAmount },
                                    async: false,
                                    cache: false,
                                    success: function (res) {
                                        if (res != "false") {
                                            res = res.split(',');
                                            window.location.href = "ExtractSuccess.aspx?statue=true&CashAccount=" + res[1] + "&date=" + res[2];

                                        } else {
                                            window.location.href = "ExtractSuccess.aspx?statue=false"
                                            return false;
                                        }
                                    }
                                })
                            } else {
                                $("#CashAmount").focus();
                                ShowMsg("提现金额必须是" + IntTimes + "的整数倍");
                                return false;
                            }
                        } else {
                            $("#CashAmount").focus();
                            ShowMsg("提现金额必须大于" + MinaAmountCash);
                            return false;
                        }


                    } else {
                        $("#CashAmount").focus();
                        ShowMsg("可提现金额为:" + MaxCashAmount);
                        return false;
                    }
                } else {
                    $("#CashAmount").focus();
                    ShowMsg("当前不可提现");
                    return false;
                }
            } else {
                $("#CashAmount").focus();
                ShowMsg("输入金额不合法");
                return false;
            }
        }

    </script>
</body>
</html>
