<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DRPPartialOrderList.aspx.cs" Inherits="V5APP.Store.UI.member.DRPPartialOrderList" %>

<% foreach( var orderview in OrderViews) {%>
      @@Split@@<!--01 begin-->
      <div class="list-disorder">
        <div class="ordernumber">
           <span class="order-num"><%=orderview.Order.OrderNumber %></span><%--<span class="order-date"><%=orderview.Order.rowCreatedDate %></span> --%>         
        </div>
        <% var Commirssion = orderview.ShopLevelID == 1 ? orderview.OrderProduct.Select(o => o.CommissionAmount).Sum() :
                 orderview.ShopLevelID == 2 ? orderview.OrderProduct.Select(o => o.NextCommissionAmount).Sum() : 0;%>
        <div class="commision">佣金总额<span>￥<%=Commirssion.ToString("0.00") %></span></div>
        <ul class="ul-product">
           <% foreach (var productitem in orderview.OrderProduct) {%>
          <li>
          <a href="./DRPOrderDetail.aspx?orderid=<%=orderview.Order.ID%>">
            <span class="pic"><img src="<%=productitem.ProductURL %>"></span>
            <div class="text">
              <span class="pro-name"><%=productitem.ProductName %></span>
              <div class="pro-pric"><span>价格:</span>￥<%=productitem.Amount.ToString("0.00") %></div>
               <%var commissionRate = orderview.ShopLevelID == 1 ? productitem.CommissionRate : orderview.ShopLevelID == 2 ? productitem.NextCommissionRate : 0;
                 var commissionRateAmount = orderview.ShopLevelID == 1 ? productitem.CommissionAmount : orderview.ShopLevelID == 2 ? productitem.NextCommissionAmount : 0;
                 %>
              <div class="pro-commision">佣金比率<span class="scale"><%=commissionRate.ToString("0.00") %>%</span>佣金金额<span>￥<%=commissionRateAmount.ToString("0.00") %></span></div>
            </div>
            </a>
          </li>
          <%} %>
        </ul>
        <div class="totle">
        <span class="buyAccount">买家账号：<%=orderview.Order.Customer %></span>
        <span class="status"><%=V5.MetaData.Util.AppEnum.GetOrderStatusName(orderview.Order.OrderStatusID, orderview.Order.PaymentStatusID, orderview.Order.DeliveryStatusID) %></span><span class="prc-num">共<%=orderview.OrderProduct.Select(o => o.Count).Sum() %>件</span>
        </div>
      </div>
      <!--01 end--><% }%>