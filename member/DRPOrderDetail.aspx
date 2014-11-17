<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DRPOrderDetail.aspx.cs" Inherits="V5APP.Store.UI.member.DRPOrderDetail" %>

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
<script src="../../member/js/order.js" type="text/javascript"></script>

</head>

<body>
  <% if (OrderDetail != null) {%>
<!--topbar begin-->
  <div class="fixed">
    <nav class="tab-bar">
      <section class="left-small">
        <a class="menu-icon" href="./DRPOrderList.aspx"><span></span></a>
      </section>
      <section class="middle tab-bar-section">
        <h1 class="title">订单详情</h1>
      </section>
    </nav>
  </div>
  <!--topbar end-->
  <!--content begin-->
       <!--yesterday begin-->
        <div class="panel bro-ordercom">
          <div class="com-top"><p><i class="icon-monyg"></i>佣金</p><span class="status"><%=V5.MetaData.Util.AppEnum.GetOrderStatusName(OrderDetail.Order.OrderStatusID, OrderDetail.Order.PaymentStatusID, OrderDetail.Order.DeliveryStatusID) %></span></div>
          <% var Commirssion = OrderDetail.ShopLevelID == 1 ? OrderDetail.OrderProduct.Select(o => o.CommissionAmount).Sum() :
                 OrderDetail.ShopLevelID == 2 ? OrderDetail.OrderProduct.Select(o => o.NextCommissionAmount).Sum() : 0;%>
            <span class="com-mony">￥<%=Commirssion.ToString("0.00") %></span>
        </div>
      <!--yesterday end-->
      <!--summary begin-->
      <ul class="side-nav disordersummary">
        <li><label>在线支付</label><span class="red">￥<%=OrderDetail.Order.Amount.ToString("0.00") %></span></li>
        <li><label>订单编号</label><span><%=OrderDetail.Order.OrderNumber %></span></li>
        <li><label>下单时间</label><span><%=OrderDetail.Order.rowCreatedDate %></span></li>
      </ul>
      <!--summary end-->
      <!--product begin-->
      <div class="list-disorder">        
        <ul class="ul-product">
          <% foreach (var productitem in OrderDetail.OrderProduct)
               {%>
          <li>
            <span class="pic"><img src="<%=productitem.ProductURL %>"></span>
            <div class="text">
              <span class="pro-name"><%=productitem.ProductName %></span>
              <div class="pro-pric"><span>价格:</span>￥<%=productitem.Amount.ToString("0.00") %></div>
              <div class="pro-pec"><span class="color"><%=productitem.PropertyText %></span><span>数量:<%=productitem.Count %></span></div>
                <%var commissionRate = OrderDetail.ShopLevelID == 1 ? productitem.CommissionRate : OrderDetail.ShopLevelID == 2 ? productitem.NextCommissionRate : 0;
                  var commissionRateAmount = OrderDetail.ShopLevelID == 1 ? productitem.CommissionAmount : OrderDetail.ShopLevelID == 2 ? productitem.NextCommissionAmount : 0; 
                  %>
              <div class="pro-commision">佣金比率<span class="scale"><%=commissionRate.ToString("0.00") %>%</span>佣金金额<span>￥<%=Decimal.Round(commissionRateAmount, 2) %></span></div>
            </div>
          </li>
            <%} %>
        </ul>
        <div class="totle"><span class="price">￥<%=OrderDetail.Order.Amount.ToString("0.00") %></span><span class="pric-lable">总价</span><span class="prc-num">共<%=OrderDetail.OrderProduct.Select(o => o.Count).Sum() %>件</span></div>
      </div>
      <!--product end-->
      <!--address begin-->
      <div class="address-myorder">
        <label class="col-label">地址</label><p class="address"><%=OrderDetail.Invoice.ReceivingAddress %><br/><span class="name"><%=OrderDetail.Invoice.ReceivingName %></span><span class="mobile"><%=string.IsNullOrEmpty(OrderDetail.Invoice.ReceivingMobilePhone) ? OrderDetail.Invoice.ReceivingTelePhone : OrderDetail.Invoice.ReceivingMobilePhone %> </span></p>
      </div>
      <!--address end-->
  <!--content end-->
    <%} %>
</body>
</html>

