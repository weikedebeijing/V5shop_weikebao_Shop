<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.cart" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/1/17 17:11:17.
		本页面代码由V5Shop模板引擎生成于 2014/1/17 17:11:17. 
	*/

	base.OnInit(e);
	
	int cartcount__loop__id=0;
	int cart__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head><base href=\"http://192.168.1.105:8082/template/version_9/\" />\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>购物车</title>\r\n");
	templateBuilder.Append("    <script src=\"js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"js/cart.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/base.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/order.css\">\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("        var path = 'http://192.168.1.105:8082/';\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("    <!--head begin-->\r\n");
	templateBuilder.Append("    <header class=\"topbar\">\r\n");
	templateBuilder.Append("    <div class=\"topbar-left\">\r\n");
	templateBuilder.Append("    <a href=\"javascript:window.history.go(-1)\" class=\"i-back\">asd</a>\r\n");
	templateBuilder.Append("    <a href=\"../../index.aspx\" class=\"logo\">\r\n");
	templateBuilder.Append("    <img src=\"../../images/logo.png\" alt=\"logo\">\r\n");
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"topbar-right\">\r\n");
	templateBuilder.Append("    <a class=\"i-member\" href=\"../../orderlist.aspx\">会员</a>\r\n");
	templateBuilder.Append("    <a href=\"../../cart.aspx\" class=\"i-cart\">&nbsp;\r\n");
	    
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
	    
	if(Convert.ToInt32(totalnum)>0){
	templateBuilder.Append("    <section class=\"cart-count\" id=\"cart_count\">\r\n");
	     
	cartcount__loop__id=0;
	foreach(DataRow cartcount_member in getTable("cartcount","["+username+"],["+guid+"]").Rows)
	{
	if(cartcount__loop__id == 999 && cartcount__loop__id != 0) break;
		cartcount__loop__id++;
	templateBuilder.Append("    <span class=\"numb\" id=\"count\">共" + cartcount_member["count"].ToString() + "件商品</span><span class=\"price\" id=\"orderprice\">¥" + cartcount_member["orderprice"].ToString() + "</span>\r\n");
	    
	}	//end loop
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("    <section class=\"cart-list\" id=\"cart-list\">\r\n");
	templateBuilder.Append("    <ul class=\"cart-list-ul\"><!--修改样式\"del”-->\r\n");
	    
	cart__loop__id=0;
	foreach(DataRow cart_member in getTable("cart","["+username+"],["+guid+"]").Rows)
	{
	if(cart__loop__id == 999 && cart__loop__id != 0) break;
		cart__loop__id++;
	templateBuilder.Append("     <li class=\"cart-list-li\">\r\n");
	templateBuilder.Append("       <label class=\"operate\"><input type=\"checkbox\" class=\"icon_cartcheck J_ytag\" data-type=\"2\" ytag=\"31001\" value=\"582733\"></label>\r\n");
	templateBuilder.Append("       <div class=\"pic\">\r\n");
	templateBuilder.Append("         <a href=\"../../product.aspx?id=" + cart_member["ProductID"].ToString() + "\"><img src=\"" + cart_member["Src"].ToString() + "\" width=\"120\" height=\"120\" alt=\"产品\"></a>\r\n");
	templateBuilder.Append("       </div>\r\n");
	templateBuilder.Append("       <div class=\"info\">\r\n");
	templateBuilder.Append("         <p class=\"info-name\">" + cart_member["Name"].ToString() + "<br/>" + cart_member["PropertysText"].ToString() + "</p>\r\n");
	templateBuilder.Append("         <p class=\"info-price\">¥" + cart_member["MemberPrice"].ToString() + "</p>\r\n");
	templateBuilder.Append("         <span class=\"ui-number\">\r\n");
	templateBuilder.Append("            <button type=\"button\" class=\"decrease\" onclick=\"Cart.changeBar('-','" + cart_member["id"].ToString() + "',this)\" title=\"加\" >-</button>\r\n");
	templateBuilder.Append("            <input type=\"number\" class=\"num\" name=\"quantity\" autocomplete=\"off\" value=\"" + cart_member["count"].ToString() + "\" min=\"1\" max=\"19684\" readonly=\"true\">\r\n");
	templateBuilder.Append("            <button type=\"button\" class=\"increase\" onclick=\"Cart.changeBar('+','" + cart_member["id"].ToString() + "',this)\" title=\"加\" >+</button>\r\n");
	templateBuilder.Append("          </span>\r\n");
	templateBuilder.Append("       </div>\r\n");
	templateBuilder.Append("     </li>\r\n");
	     
	}	//end loop
	templateBuilder.Append("    </ul>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("    <div class=\"clear\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <section class=\"s-btn\" id=\"s-btn\">\r\n");
	templateBuilder.Append("        <button class=\"settle-account\" onClick=\"CartStep()\">去结算</button>\r\n");
	templateBuilder.Append("    </section>\r\n");
	templateBuilder.Append("    <section class=\"cart-none\" id=\"cart-none\" style=\"display: none\">\r\n");
	templateBuilder.Append("        <i class=\"cart-big\"></i>\r\n");
	templateBuilder.Append("        <p class=\"text\">您的购物车还没有商品！</p>\r\n");
	templateBuilder.Append("        <a href=\"../../index.aspx\" class=\"btn\">去逛逛</a>\r\n");
	templateBuilder.Append("    </section>\r\n");
	    
	}else{
	templateBuilder.Append("    <section class=\"cart-none\" id=\"cart-none\">\r\n");
	templateBuilder.Append("        <i class=\"cart-big\"></i>\r\n");
	templateBuilder.Append("        <p class=\"text\">您的购物车还没有商品！</p>\r\n");
	templateBuilder.Append("        <a href=\"../../index.aspx\" class=\"btn\">去逛逛</a>\r\n");
	templateBuilder.Append("    </section>\r\n");
	    
	}	//end if
	 templateBuilder.Append("    <footer>\r\n");
	templateBuilder.Append("    Copyright 2005-2007 web08.net. All rights reserved.\r\n");
	templateBuilder.Append("  </footer>\r\n");
	templateBuilder.Append("</body>\r\n");
	templateBuilder.Append("</html>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\">\r\n");
	templateBuilder.Append("    function CartStep() {\r\n");
	templateBuilder.Append("        window.location.href = \"../../cartstep.aspx\";\r\n");
	templateBuilder.Append("    }\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    \r\n");
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
