<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyOrderDetail.aspx.cs" Inherits="V5APP.Store.UI.member.MyOrderDetail" %>

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
                <a class="menu-icon" href="./MyOrderList.aspx"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">订单详情</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <div id="pay" style="display: none"></div>
    <!--content begin-->
    <!--summary begin-->
    <ul class="side-nav ordersummary">
        <li>
            <label>商品总价</label><span class="red">￥<%=OrderDetail.Order.ProductAmount.ToString("0.00") %></span></li>
        <li>
            <label>运费&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><span class="red">￥<%=OrderDetail.Order.Freight.ToString("0.00") %></span></li>
        <li>
            <label>在线支付</label><span class="red">￥<%=OrderDetail.Order.Amount.ToString("0.00") %></span></li>
        <li>
            <label>订单编号</label><span><%=OrderDetail.Order.OrderNumber %></span></li>
        <li>
            <label>下单时间</label><span><%=OrderDetail.Order.rowCreatedDate %></span></li>
        <%if(OrderDetail.Order.DeliveryStatusID==(int)V5.MetaData.Util.AppEnum.OrderDeliveredType.Delivered){ %>
        <li><label>物流公司</label><span><%=OrderDetail.Order.ExpressName %></span></li>
        <li><label>物流单号</label><span><%=OrderDetail.Order.ParcelNo %></span></li>
        <%} %>
        <li>
            <label>订单状态</label>
            <% if(OrderDetail.Order.PaymentStatusID == (int)V5.MetaData.Util.AppEnum.OrderPaidType.Paid &&
         OrderDetail.Order.DeliveryStatusID == (int)V5.MetaData.Util.AppEnum.OrderDeliveredType.Delivered &&
         OrderDetail.Order.OrderStatusID != (int)V5.MetaData.Util.AppEnum.OrderStatusType.Completed){ %>
            <span>已发货</span>
            <%}else{ %>
            <span><%=V5.MetaData.Util.AppEnum.GetOrderStatusName(OrderDetail.Order.OrderStatusID, OrderDetail.Order.PaymentStatusID, OrderDetail.Order.DeliveryStatusID) %></span></li>
        <%} %>
    </ul>
    <!--summary end-->
    <!--product begin-->
    <div class="list-myorder">
        <ul class="ul-product">
            <% foreach (var productitem in OrderDetail.OrderProduct)
               {%>
            <li>
                <span class="pic">
                    <img src="<%=productitem.ProductURL %>"></span>
                <div class="text">
                    <span class="pro-name"><%=productitem.ProductName %></span>
                    <div class="pro-pric"><span>价格:</span>￥<%=productitem.Amount.ToString("0.00") %></div>
                    <div class="pro-pec"><span class="color"><%=productitem.PropertyText %></span><span>数量:<%=productitem.Count %></span></div>
                </div>
            </li>
            <%} %>
        </ul>
        <div class="totle"><span class="price">￥<%=OrderDetail.Order.Amount.ToString("0.00") %></span><span class="pric-lable">总价</span><span class="prc-num">共<%=OrderDetail.OrderProduct.Select(o => o.Count).Sum() %>件</span></div>
    </div>
    <!--product end-->
    <!--address begin-->
    <div class="address-myorder">
        <label class="col-label">地址</label><p class="address">
            <%=OrderDetail.Invoice.ReceivingAddress %><br />
            <span class="name"><%=OrderDetail.Invoice.ReceivingName %></span><span class="mobile"><%=string.IsNullOrEmpty(OrderDetail.Invoice.ReceivingMobilePhone) ? OrderDetail.Invoice.ReceivingTelePhone : OrderDetail.Invoice.ReceivingMobilePhone %></span>
        </p>
    </div>
    <!--address end-->
    <div class="myorderd-button">
        <%if (OrderDetail.Order.OrderStatusID == (int)V5.MetaData.Util.AppEnum.OrderStatusType.NoProcess &&
              OrderDetail.Order.PaymentStatusID == (int)V5.MetaData.Util.AppEnum.OrderPaidType.NoPaied)
         { %>
        <%if (OrderDetail.Order.Payment == "WxPay"){ %>
        <a href="../../member/WxPay.aspx?showwxpaytitle=1&shopCode=<%=shopID %>&ordernumber=<%=OrderDetail.Order.OrderNumber %>" class="button [radius round] red">立即付款</a>
        <%}else{ %>
        <a href="javascript:void(0)" onclick="gotoPay(this)" ordernumber="<%=OrderDetail.Order.OrderNumber %>" class="button [radius round] red">立即付款</a>
        <%} %>
        <a href="javascript:void(0)" onclick="orderCancel(this)" ordernumber="<%=OrderDetail.Order.OrderNumber %>" class="button [radius round] gray">取消订单</a>
        <%}
         else if (OrderDetail.Order.PaymentStatusID == (int)V5.MetaData.Util.AppEnum.OrderPaidType.Paid &&
         OrderDetail.Order.DeliveryStatusID == (int)V5.MetaData.Util.AppEnum.OrderDeliveredType.Delivered &&
         OrderDetail.Order.OrderStatusID != (int)V5.MetaData.Util.AppEnum.OrderStatusType.Completed)
         {%>
        <a href="javascript:void(0)" onclick="okDelivery(this)" ordernumber="<%=OrderDetail.Order.OrderNumber %>" class="button [radius round] red">确认收货</a>
        <%} %>
    </div>
    <!--content end-->
    <%} %>
</body>
</html>

