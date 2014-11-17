<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.orderlist" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/9/22 16:36:54.
		本页面代码由V5Shop模板引擎生成于 2014/9/22 16:36:54. 
	*/

	base.OnInit(e);
	
	int orderlist__loop__id=0;
	int productimgbyoid__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>订单列表-" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/order.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/CssLoad.js?Item=base|common|order\"></"+"script>\r\n");
	templateBuilder.Append("        <script type=\"text/javascript\" src=\"../public/js/weixincommon.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("       <!--head begin-->\r\n");
	templateBuilder.Append("    <header class=\"topbar\">\r\n");
	templateBuilder.Append("    <div class=\"topbar-left\">\r\n");
	templateBuilder.Append("    <a href=\"javascript:window.history.go(-1)\" class=\"i-back\">asd</a>\r\n");
	templateBuilder.Append("    <a href=\"index.aspx\" class=\"logo\">\r\n");
	templateBuilder.Append("    <img src=\"" + logo.ToString() + "\" alt=\"logo\">\r\n");
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"topbar-right\">\r\n");
	templateBuilder.Append("    <a class=\"i-member\" href=\"member/member.aspx\">会员</a>\r\n");
	templateBuilder.Append("    <a href=\"cart.aspx\" class=\"i-cart\">&nbsp;\r\n");
	    
	if(Convert.ToInt32(totalnum)>0){
	templateBuilder.Append("    <span class=\"tips\" id=\"countcart\">" + totalnum.ToString() + "</span>\r\n");
	    
	}else{
	templateBuilder.Append("    <span class=\"tips\" id=\"countcart\" style=\" display:none\">0</span>\r\n");
	    
	}	//end if
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</header>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <!--head end-->\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <section class=\"order-advertise\">\r\n");
	templateBuilder.Append("    <a href=\"../../addresslist.aspx\"><img src=\"images/advertise.jpg\" alt=\"收货地址管理\"></a></section>\r\n");
	templateBuilder.Append("    <section class=\"order\">\r\n");
	templateBuilder.Append("    <h3 class=\"order-title\">订单管理</h3>\r\n");
	templateBuilder.Append("    <ul class=\"order-list-ul\">\r\n");
	    
	orderlist__loop__id=0;
	foreach(var orderlist in getTable("orderlist","["+user_id+"]"))
	{
	if(orderlist__loop__id == 999 && orderlist__loop__id != 0) break;
		orderlist__loop__id++;
	templateBuilder.Append("      <li class=\"order-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"number\"><span class=\"label01\">订单编号：</span><span class=\"value01\">" + orderlist.OrderNumber.ToString() + "</span></div>\r\n");
	templateBuilder.Append("        <div class=\"number\"><span class=\"label01\">订单状态：</span><span class=\"value01\">" + orderlist.OrderStateStr.ToString() + "</span></div>\r\n");
	templateBuilder.Append("        <div class=\"pic\" name=\"orderdetail\" oid=\"" + orderlist.OrderNumber.ToString() + "\">\r\n");
	         
	productimgbyoid__loop__id=0;
	foreach(var productimgbyoid in getTable("productimgbyoid","["+orderlist_member["OrderNumber"].ToString()+"]"))
	{
	if(productimgbyoid__loop__id == 999 && productimgbyoid__loop__id != 0) break;
		productimgbyoid__loop__id++;
	templateBuilder.Append("          <span class=\"s-pic\"><img src=\"" + productimgbyoid.ProductURL.ToString() + "\" width=\"100%\"  title=\"" + productimgbyoid.ProductName.ToString() + "\"/></span>\r\n");
	           
	}	//end loop
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"amount-price\">\r\n");
	templateBuilder.Append("          <span class=\"label01\">总额：</span><span class=\"amount-price\">¥" + orderlist.Amount.ToString() + "</span><span class=\"pay-style\">\r\n");
	templateBuilder.Append("          （" + orderlist.Payment.ToString() + "）\r\n");
	templateBuilder.Append("          </span>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"btn\">\r\n");
	templateBuilder.Append("        " + orderlist.Button.ToString() + "\r\n");
	templateBuilder.Append("          \r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	      
	}	//end loop
	templateBuilder.Append("    </ul>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("  <div id=\"pay\"></div>\r\n");
	templateBuilder.Append("    <div class=\"clear\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append(" \r\n");
	templateBuilder.Append("</body>\r\n");
	templateBuilder.Append("</html>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\">\r\n");
	templateBuilder.Append("    $(\"div[name='orderdetail']\").click(function () {\r\n");
	templateBuilder.Append("        var oid = $(this).attr(\"oid\");\r\n");
	templateBuilder.Append("        window.location.href = \"../../orderdetail.aspx?oid=\" + oid;\r\n");
	templateBuilder.Append("    }\r\n");
	templateBuilder.Append("    )\r\n");
	templateBuilder.Append("</"+"script>\r\n");
	templateBuilder.Append("\r\n");
	
	Response.Write(templateBuilder.ToString());
//init cache
	CacheManager testcaching = CacheFactory.GetCacheManager();
	if(!testcaching.Contains(Request.Url.ToString()))
	{
		testcaching.Add(Request.Url.ToString(), templateBuilder.ToString());
	}
}
</script>
