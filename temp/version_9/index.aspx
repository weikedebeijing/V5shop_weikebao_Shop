<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.index" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/5/6 19:28:44.
		本页面代码由V5Shop模板引擎生成于 2014/5/6 19:28:44. 
	*/

	base.OnInit(e);
	
	int rollImages__loop__id=0;
	int hotSaleProduct__loop__id=0;
	int channelPrice__loop__id=0;
	int newProduct__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/" + path.ToString() + "/js/CssLoad.js?Item=base|common|v5\"></"+"script>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"../Template/" + path.ToString() + "/css/slider.css\">\r\n");
	templateBuilder.Append("    <script src=\"../Template/" + path.ToString() + "/js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/" + path.ToString() + "/js/common.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("        <script type=\"text/javascript\" src=\"../Template/public/js/weixincommon.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"../Template/" + path.ToString() + "/js/imageCommon.js\" type='text/javascript'></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"../Template/" + path.ToString() + "/js/slider.js\" type='text/javascript'></"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("    <!--head begin-->\r\n");
	templateBuilder.Append("    <header class=\"topbar\">\r\n");
	templateBuilder.Append("    <div class=\"topbar-left\">\r\n");
	templateBuilder.Append("    <a href=\"index.aspx\" class=\"i-back\">asd</a>\r\n");
	templateBuilder.Append("    <a href=\"index.aspx\" class=\"logo\">\r\n");
	templateBuilder.Append("    <img src=\"" + logo.ToString() + "\" alt=\"logo\">\r\n");
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"topbar-right\">\r\n");
	templateBuilder.Append("    <a class=\"i-member\" href=\"orderlist.aspx\">会员</a>\r\n");
	templateBuilder.Append("    <a href=\"cart.aspx\" class=\"i-cart\">&nbsp;  \r\n");
	    
	if(Convert.ToInt32(totalnum)>0){
	templateBuilder.Append("    <span class=\"tips\" id=\"countcart\">" + totalnum.ToString() + "</span>\r\n");
	    
	}else{
	templateBuilder.Append("    <span class=\"tips\" id=\"countcart\" style=\" display:none\">0</span>\r\n");
	    
	}	//end if
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</header>\r\n");
	templateBuilder.Append("    <!--head end-->\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("        <!--main begin-->\r\n");
	templateBuilder.Append("        <section>\r\n");
	templateBuilder.Append("        <ul id=\"slider\">\r\n");
	             
	rollImages__loop__id=0;
	foreach(var rollImages in getTable("rollImages"))
	{
		rollImages__loop__id++;
	 templateBuilder.Append("                <li>\r\n");
	                
	if(rollImages.Hyperlink.ToString()==""){
	 templateBuilder.Append("                <a href=\"javascript:void(0)\">\r\n");
	                
	}else{
	templateBuilder.Append("                 <a href=\"" + rollImages.Hyperlink.ToString() + "\">\r\n");
	                
	}	//end if
	 templateBuilder.Append("                <img lazyload=\"" + v5ImageGroupUrl2.ToString() + "" + rollImages.ImageUrl.ToString() + "\" class=\"slider-img\"/>\r\n");
	templateBuilder.Append("                 </a>\r\n");
	templateBuilder.Append("                 </li>\r\n");
	            
	}	//end loop
	templateBuilder.Append("          </ul>\r\n");
	templateBuilder.Append("    </section>\r\n");
	templateBuilder.Append("        <section class=\"hot\">\r\n");
	templateBuilder.Append("  <div class=\"title\">\r\n");
	templateBuilder.Append("      <h2 class=\"hot-title\">热销商品</h2>\r\n");
	templateBuilder.Append("      <a href=\"category.aspx\" class=\"btn-allpro\"><span class=\"name\">全部商品</span><span class=\"icon\">&gt;&gt;</span></a></div>\r\n");
	templateBuilder.Append("   \r\n");
	templateBuilder.Append("<div class=\"product\">\r\n");
	
	hotSaleProduct__loop__id=0;
	foreach(var hotSaleProduct in getTable("hotSaleProduct","8,2"))
	{
	if(hotSaleProduct__loop__id == 999 && hotSaleProduct__loop__id != 0) break;
		hotSaleProduct__loop__id++;
	templateBuilder.Append("<div class=\"pro-inner\" >\r\n");
	templateBuilder.Append("<div class=\"pro-style\">\r\n");
	templateBuilder.Append("<div class=\"margin10\">\r\n");
	templateBuilder.Append("<div class=\"divimg\">\r\n");
	templateBuilder.Append("<a class=\"img\" href=\"product.aspx?id=" + hotSaleProduct.ID.ToString() + "\"><img src=\"" + v5ProductUrl.ToString() + "" + hotSaleProduct.DefaultImageData.ToString() + "\"  alt=\"" + hotSaleProduct.Name.ToString() + "\"></a>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("<div class=\"pro-summary\">\r\n");
	
	if(hotSaleProduct.Name.ToString().Length<18 ){
	templateBuilder.Append("<a class=\"name\" href=\"product.aspx?id=" + hotSaleProduct.ID.ToString() + "\" title=\"" + hotSaleProduct.Name.ToString() + "\">" + hotSaleProduct.Name.ToString() + "</a>\r\n");
	
	}else{
	templateBuilder.Append("<a class=\"name\" href=\"product.aspx?id=" + hotSaleProduct.ID.ToString() + "\" title=\"" + hotSaleProduct.Name.ToString() + "\">" + hotSaleProduct.Name.ToString().Substring(0,18).ToString() + "...</a>\r\n");
	
	}	//end if
	templateBuilder.Append("<span class=\"price\">\r\n");
	
	channelPrice__loop__id=0;
	foreach(var channelPrice in getTable("channelPrice","" + hotSaleProduct.ID.ToString() + ",3"))
	{
	if(channelPrice__loop__id == 999 && channelPrice__loop__id != 0) break;
		channelPrice__loop__id++;
	templateBuilder.Append("￥" + GetCustomerPrice( channelPrice.SalesPrice.ToString() ,hotSaleProduct.ID.ToString()).ToString() + "\r\n");
	
	}	//end loop
	templateBuilder.Append("</span>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("\r\n");
	
	}	//end loop
	templateBuilder.Append("\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</section>\r\n");
	templateBuilder.Append("        <div class=\"clear\">\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <section class=\"hot\">\r\n");
	templateBuilder.Append(" <div class=\"title\">\r\n");
	templateBuilder.Append("    <h2 class=\"hot-title\">推荐商品</h2>\r\n");
	templateBuilder.Append("   </div>\r\n");
	templateBuilder.Append("    <div class=\"product\">\r\n");
	
	newProduct__loop__id=0;
	foreach(var newProduct in getTable("newProduct","8,2"))
	{
	if(newProduct__loop__id == 999 && newProduct__loop__id != 0) break;
		newProduct__loop__id++;
	templateBuilder.Append("<div class=\"pro-inner\">\r\n");
	templateBuilder.Append("<div class=\"pro-style\">\r\n");
	templateBuilder.Append("<div class=\"margin10\">\r\n");
	templateBuilder.Append("<div class=\"divimg\">\r\n");
	templateBuilder.Append("        <a class=\"img\" href=\"product.aspx?id=" + newProduct.ID.ToString() + "\"><img src=\"" + v5ProductUrl.ToString() + "" + newProduct.DefaultImageData.ToString() + "\"  alt=\"" + newProduct.Name.ToString() + "\"></a>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("<div class=\"pro-summary\">\r\n");
	
	if(newProduct.Name.ToString().Length<18 ){
	templateBuilder.Append("<a class=\"name\" href=\"product.aspx?id=" + newProduct.ID.ToString() + "\" title=\"" + newProduct.Name.ToString() + "\">" + newProduct.Name.ToString() + "</a>\r\n");
	
	}else{
	templateBuilder.Append("<a class=\"name\" href=\"product.aspx?id=" + newProduct.ID.ToString() + "\" title=\"" + newProduct.Name.ToString() + "\">" + newProduct.Name.ToString().Substring(0,18).ToString() + "...</a>\r\n");
	
	}	//end if
	templateBuilder.Append("<span class=\"price\">\r\n");
	
	channelPrice__loop__id=0;
	foreach(var channelPrice in getTable("channelPrice","" + newProduct.ID.ToString() + ",3"))
	{
	if(channelPrice__loop__id == 999 && channelPrice__loop__id != 0) break;
		channelPrice__loop__id++;
	templateBuilder.Append("￥" + GetCustomerPrice( channelPrice.SalesPrice.ToString() ,newProduct.ID.ToString()).ToString() + "\r\n");
	
	}	//end loop
	templateBuilder.Append("</span>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</div>\r\n");
	
	}	//end loop
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</section>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <div class=\"clear\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("     <footer>\r\n");
	templateBuilder.Append("<span class=\"explain\">技术支持：</span><img src=\"../../images/logo-cop.png\" class=\"logo-cop\" alt=\"v5shop\">\r\n");
	templateBuilder.Append("  </footer>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("</body>\r\n");
	templateBuilder.Append("</html>\r\n");
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
