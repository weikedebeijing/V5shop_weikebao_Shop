<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyPartialOrderList.aspx.cs" Inherits="V5APP.Store.UI.member.MyPartialOrderList" %>

<% foreach (var orderview in OrderViews)
   {%>
      @@Split@@
<!-- 01 begin-->
<div class="list-myorder">
    <div class="ordernumber"><span class="order-num"><%=orderview.Order.OrderNumber %></span><%--<span class="order-date"><%=orderview.Order.rowCreatedDate %></span>--%></div>
    <ul class="ul-product">
        <% foreach (var productitem in orderview.OrderProduct)
           {%>
        <li>
            <a href="./MyOrderDetail.aspx?orderid=<%=orderview.Order.ID%>">
                <span class="pic">
                    <img src="<%=productitem.ProductURL %>"></span>
                <div class="text">
                    <span class="pro-name"><%=productitem.ProductName %></span>
                    <div class="pro-pric"><span>价格:</span>￥<%=productitem.Amount.ToString("0.00") %></div>
                    <div class="pro-pec"><span class="color"><%=productitem.PropertyText %></span></div>
                </div>
            </a>
        </li>
        <%} %>
    </ul>
    <div class="totle"><span class="status"><%=V5.MetaData.Util.AppEnum.GetOrderStatusName(orderview.Order.OrderStatusID, orderview.Order.PaymentStatusID, orderview.Order.DeliveryStatusID) %></span><span class="price">￥<%=orderview.Order.Amount.ToString("0.00") %></span><span class="pric-lable">总价</span><span class="prc-num">共<%=orderview.OrderProduct.Select(o => o.Count).Sum() %>件</span></div>
    <%if (orderview.Order.OrderStatusID == (int)V5.MetaData.Util.AppEnum.OrderStatusType.NoProcess &&
              orderview.Order.PaymentStatusID == (int)V5.MetaData.Util.AppEnum.OrderPaidType.NoPaied)
      { %>
    <div class="div-button">
        <%if (orderview.Order.Payment == "WxPay")
          { %>
        <a href="../../member/WxPay.aspx?showwxpaytitle=1&shopCode=<%=shopID %>&ordernumber=<%=orderview.Order.OrderNumber %>" class="button [radius round] red">立即付款</a>
        <%}
          else
          { %>
        <a href="javascript:void(0)" onclick="gotoPay(this)" ordernumber="<%=orderview.Order.OrderNumber %>" class="button [radius round] red">立即付款</a>
        <%} %>
    </div>
    <%}
      else if (orderview.Order.PaymentStatusID == (int)V5.MetaData.Util.AppEnum.OrderPaidType.Paid &&
      orderview.Order.DeliveryStatusID == (int)V5.MetaData.Util.AppEnum.OrderDeliveredType.Delivered &&
      orderview.Order.OrderStatusID != (int)V5.MetaData.Util.AppEnum.OrderStatusType.Completed)
      {%>
    <div class="div-button">
        <a href="javascript:void(0)" onclick="okDelivery(this)" ordernumber="<%=orderview.Order.OrderNumber %>" class="button [radius round] red">确认收货</a>
    </div>
    <%} %>
</div>
<!--01 end-->
<% }%>