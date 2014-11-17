<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BrokerageLog.aspx.cs" Inherits="V5APP.Store.UI.member.BrokerageLog" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>会员中心</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
</head>

<body>
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="Brokerage.aspx" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">佣金</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--table begin-->
    <dl class="tabs tab-title2">
        <dd class="active" id="brokeragetab"><a href="javascript:void(0)" onclick="brokeragelistshow(this)"><i class="icon-comdetail"></i>佣金明细</a></dd>
        <dd id="extracttab"><a href="javascript:void(0)" onclick="extractlistshow(this)"><i class="icon-extract"></i>提现记录</a></dd>
    </dl>
    <!--table end-->
    <!--content begin-->
    <div class="tabs-content">
        <!--commission begin-->
        <div class="content active" id="brokeragelist">
            <%if (newbrokeragelist.Count == 0 && thelastbrokeragelist.Count == 0 && lastlastbrokeragelist.Count == 0)
              { %>
            <!--none begin-->
            <div class="disorder-none"><i class="icon-none"></i><span class="nonetext">您还没有佣金！</span></div>
            <!--none end-->
            <%}
              else
              { %>
            <div>
                <dl class="accordion bAccordion">
                    <!--01 begin-->
                    <dd class="current">
                        <a href="javascript:void(0)" name="list"><i class="icon-arrow"></i><span class="text-l"><%=nowMonth %>月</span><span class="text-r text-green">+￥<%=newbrokeragelist.Sum(x=>x.OrderProduct.Sum(p=>p.CommissionAmount)).ToString("0.00") %></span></a>
                        <div class="content active">
                            <%foreach (var orderview in newbrokeragelist)
                              { %>
                            <!--order01 begin-->
                            <div class="list-brokerage">
                                <div class="commision">
                                    <p class="ordernumber"><span class="order-num">订单号&nbsp;<%=orderview.Order.OrderNumber %></span><span class="order-date"><%=orderview.Order.MCreateDate %></span></p>
                                    <% var commissionAmount = orderview.ShopLevelID == 1 ? orderview.OrderProduct.Sum(x => x.CommissionAmount).ToString("0.00")
                                           : orderview.ShopLevelID == 2 ? orderview.OrderProduct.Sum(x => x.NextCommissionAmount).ToString("0.00") : "0.00"; %>
                                    <p>佣金<span class="mony">￥<%=commissionAmount %></span></p>
                                </div>
                                <ul class="ul-product">
                                    <%foreach (var orderproduct in orderview.OrderProduct)
                                      { %>
                                    <li>
                                        <span class="pic">
                                            <img src="<%=BMCURL+orderproduct.ProductURL %>" /></span>
                                        <div class="text">
                                            <span class="pro-name"><%=orderproduct.ProductName %></span>
                                            <div class="pro-pric"><span>交易金额：</span>￥<%=orderproduct.Amount %></div>
                                            <%  var commission = orderview.ShopLevelID == 1 ? orderproduct.CommissionAmount.ToString("0.00")
                                           : orderview.ShopLevelID == 2 ? orderproduct.NextCommissionAmount.ToString("0.00") : "0.00"; %>
                                            <div class="pro-commision">佣金<span>￥<%=commission %></span></div>
                                        </div>
                                    </li>
                                    <%} %>
                                </ul>
                            </div>
                            <!--order01 end-->
                            <%} %>
                        </div>
                    </dd>
                    <!--01 end-->
                    <!--01 begin-->
                    <dd>
                        <a href="javascript:void(0)" name="list"><i class="icon-arrow"></i><span class="text-l"><%=thelastMonth %>月</span><span class="text-r text-green">+￥<%=thelastbrokeragelist.Sum(x=>x.OrderProduct.Sum(p=>p.CommissionAmount)).ToString("0.00") %></span></a>
                        <div class="content active" style="display: none">
                            <%foreach (var orderview in thelastbrokeragelist)
                              { %>
                            <!--order01 begin-->
                            <div class="list-brokerage">
                                <div class="commision">
                                    <p class="ordernumber"><span class="order-num">订单号&nbsp;<%=orderview.Order.OrderNumber %></span><span class="order-date"><%=orderview.Order.MCreateDate %></span></p>
                                       <%  var commissionAmount2 = orderview.ShopLevelID == 1 ? orderview.OrderProduct.Sum(x => x.CommissionAmount).ToString("0.00")
                                           : orderview.ShopLevelID == 2 ? orderview.OrderProduct.Sum(x => x.NextCommissionAmount).ToString("0.00") : "0.00"; %>
                                    <p>佣金<span class="mony">￥<%=commissionAmount2 %></span></p>
                                </div>
                                <ul class="ul-product">
                                    <%foreach (var orderproduct in orderview.OrderProduct)
                                      { %>
                                    <li>
                                        <span class="pic">
                                            <img src="<%=BMCURL+orderproduct.ProductURL %>"></span>
                                        <div class="text">
                                            <span class="pro-name"><%=orderproduct.ProductName %></span>
                                            <div class="pro-pric"><span>交易金额：</span>￥<%=orderproduct.Amount %></div>
                                             <%  var commission2 = orderview.ShopLevelID == 1 ? orderproduct.CommissionAmount.ToString("0.00")
                                           : orderview.ShopLevelID == 2 ? orderproduct.NextCommissionAmount.ToString("0.00") : "0.00"; %>
                                            <div class="pro-commision">佣金<span>￥<%=commission2 %></span></div>
                                        </div>
                                    </li>
                                    <%} %>
                                </ul>
                            </div>
                            <!--order01 end-->
                            <%} %>
                        </div>
                    </dd>
                    <!--01 end-->
                    <!--01 begin-->
                    <dd>
                        <a href="javascript:void(0)" name="list"><i class="icon-arrow"></i><span class="text-l"><%=lastlastMonth %>月</span><span class="text-r text-green">+￥<%=lastlastbrokeragelist.Sum(x=>x.OrderProduct.Sum(p=>p.CommissionAmount)).ToString("0.00") %></span></a>
                        <div class="content active" style="display: none">
                            <%foreach (var orderview in lastlastbrokeragelist)
                              { %>
                            <!--order01 begin-->
                            <div class="list-brokerage">
                                <div class="commision">
                                    <p class="ordernumber"><span class="order-num">订单号&nbsp;<%=orderview.Order.OrderNumber %></span><span class="order-date"><%=orderview.Order.MCreateDate %></span></p>
                                    <%  var commissionAmount3 = orderview.ShopLevelID == 1 ? orderview.OrderProduct.Sum(x => x.CommissionAmount).ToString("0.00")
                                           : orderview.ShopLevelID == 2 ? orderview.OrderProduct.Sum(x => x.NextCommissionAmount).ToString("0.00") : "0.00"; %>
                                    <p>佣金<span class="mony">￥<%=commissionAmount3 %></span></p>
                                </div>
                                <ul class="ul-product">
                                    <%foreach (var orderproduct in orderview.OrderProduct)
                                      { %>
                                    <li>
                                        <span class="pic">
                                            <img src="<%=BMCURL+orderproduct.ProductURL %>"></span>
                                        <div class="text">
                                            <span class="pro-name"><%=orderproduct.ProductName %></span>
                                            <div class="pro-pric"><span>交易金额：</span>￥<%=orderproduct.Amount %></div>
                                                <%  var commission3 = orderview.ShopLevelID == 1 ? orderproduct.CommissionAmount.ToString("0.00")
                                           : orderview.ShopLevelID == 2 ? orderproduct.NextCommissionAmount.ToString("0.00") : "0.00"; %>
                                            <div class="pro-commision">佣金<span>￥<%=commission3 %></span></div>
                                        </div>
                                    </li>
                                    <%} %>
                                </ul>
                            </div>
                            <!--order01 end-->
                            <%} %>
                        </div>
                    </dd>
                    <!--01 end-->
                </dl>
            </div>
            <%} %>
        </div>
        <!--commission end-->
        <!--wait recevie begin-->
        <div class="content" id="extractlist">
            <%if (newCashFlowList.Count == 0 && thelastCashFlowList.Count == 0 && lastlastCashFlowList.Count == 0)
              { %>
            <!--none begin-->
            <div class="disorder-none"><i class="icon-none"></i><span class="nonetext">您还没有提现记录！</span></div>
            <!--none end-->
            <%}
              else
              { %>
            <div>
                <dl class="accordion bAccordion">
                    <!--01 begin-->
                    <dd class="current">
                        <a href="javascript:void(0)" name="list"><i class="icon-arrow"></i><span class="text-l"><%=nowMonth %>月</span><span class="text-r text-blue">-￥<%=newCashFlowList.Sum(x=>x.Amount).ToString("0.00") %></span></a>
                        <div class="content active">
                            <%foreach (var cashflow in newCashFlowList)
                              { %>
                            <!--order01 begin-->
                            <div name="listext" class="list-ext">
                                <div class="row">
                                    <div class="small-6 large-4 columns ext-title">提现<span>-￥<%=cashflow.Amount %></span></div>
                                    <div class="small-6 large-4 columns ext-icon"><i class="icon-arrow"></i></div>
                                </div>
                                <div class="row">
                                    <div class="small-6 large-4 columns ext-date"><%=cashflow.rowModifiedDate %></div>
                                    <div class="small-6 large-4 columns ext-status"><%=V5.MetaData.Util.AppEnum.CashFlowStatusTypeForCustomerName(cashflow.Status) %></div>
                                </div>
                                <div class="row detail">
                                    <div class="small-12 large-4 columns ext-account"><%=cashflow.CashAccount %><span class="name"><%=cashflow.CashRealName %></span></div>
                                </div>
                            </div>
                            <!--order01 end-->
                            <%} %>
                        </div>
                    </dd>
                    <!--01 begin-->
                    <dd>
                        <a href="javascript:void(0)" name="list"><i class="icon-arrow"></i><span class="text-l"><%=thelastMonth %>月</span><span class="text-r text-blue">-￥<%= thelastCashFlowList.Sum(x=>x.Amount).ToString("0.00") %></span></a>
                        <div style="display: none" class="content active">
                            <%foreach (var cashflow in thelastCashFlowList)
                              { %>
                            <!--order01 begin-->
                            <div name="listext" class="list-ext">
                                <div class="row">
                                    <div class="small-6 large-4 columns ext-title">提现<span>-￥<%=cashflow.Amount %></span></div>
                                    <div class="small-6 large-4 columns ext-icon"><i class="icon-arrow"></i></div>
                                </div>
                                <div class="row">
                                    <div class="small-6 large-4 columns ext-date"><%=cashflow.rowModifiedDate %></div>
                                    <div class="small-6 large-4 columns ext-status"><%=V5.MetaData.Util.AppEnum.CashFlowStatusTypeForCustomerName(cashflow.Status) %></div>
                                </div>
                                <div class="row detail">
                                    <div class="small-12 large-4 columns ext-account"><%=cashflow.CashAccount %><span class="name"><%=cashflow.CashRealName %></span></div>
                                </div>
                            </div>
                            <!--order01 end-->
                            <%} %>
                        </div>
                    </dd>
                    <!--01 begin-->
                    <dd>
                        <a href="javascript:void(0)" name="list"><i class="icon-arrow"></i><span class="text-l"><%=lastlastMonth %>月</span><span class="text-r text-blue">-￥<%=lastlastCashFlowList.Sum(x=>x.Amount).ToString("0.00") %></span></a>
                        <div style="display: none" class="content active">
                            <%foreach (var cashflow in lastlastCashFlowList)
                              { %>
                            <!--order01 begin-->
                            <div name="listext" class="list-ext">
                                <div class="row">
                                    <div class="small-6 large-4 columns ext-title">提现<span>-￥<%=cashflow.Amount %></span></div>
                                    <div class="small-6 large-4 columns ext-icon"><i class="icon-arrow"></i></div>
                                </div>
                                <div class="row">
                                    <div class="small-6 large-4 columns ext-date"><%=cashflow.rowModifiedDate %></div>
                                    <div class="small-6 large-4 columns ext-status"><%=V5.MetaData.Util.AppEnum.CashFlowStatusTypeForCustomerName(cashflow.Status) %></div>
                                </div>
                                <div class="row detail">
                                    <div class="small-12 large-4 columns ext-account"><%=cashflow.CashAccount %><span class="name"><%=cashflow.CashRealName %></span></div>
                                </div>
                            </div>
                            <!--order01 end-->
                            <%} %>
                        </div>
                    </dd>
                </dl>
            </div>
            <%} %>
        </div>
        <!--wait recevie end-->
    </div>
    <!--content begin-->
    <script type="text/javascript">
        $('a[name="list"]').click(function () {
            //  alert(1)
            $(this).parent().children("div").toggle();
            $(this).parent().toggleClass("current");
        })

        $('div[name="listext"]').click(function () {
            $(this).toggleClass("current");
        })
        function brokeragelistshow() {
            $("#brokeragelist").show();
            $("#extractlist").hide();
            $("#brokeragetab").addClass("active");
            $("#extracttab").removeClass("active");
        }
        function extractlistshow() {
            $("#brokeragelist").hide();
            $("#extractlist").show();
            $("#extracttab").addClass("active");
            $("#brokeragetab").removeClass("active");
        }
    </script>
</body>
</html>
