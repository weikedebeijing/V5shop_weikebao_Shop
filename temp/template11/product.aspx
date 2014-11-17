<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.product" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/9/22 15:33:42.
		本页面代码由V5Shop模板引擎生成于 2014/9/22 15:33:42. 
	*/

	base.OnInit(e);
	
	int productdetail__loop__id=0;
	int productimage__loop__id=0;
	int ProductDetailPrice__loop__id=0;
	int productspec__loop__id=0;
	int productspecval__loop__id=0;
	int productproperty__loop__id=0;
	int trueproduct__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\" />\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\" />\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/" + path.ToString() + "/js/CssLoad.js?Item=base|common|v5\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"../Template/" + path.ToString() + "/js/jquery-1.4.2.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/public/js/product.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/public/js/Common.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/" + path.ToString() + "/js/common.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"../../../member/js/WeiXinShare.js\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("        //document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {\r\n");
	templateBuilder.Append("        //    WeixinJSBridge.call('showOptionMenu');\r\n");
	templateBuilder.Append("        //});\r\n");
	templateBuilder.Append("        $(function () {\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("            var title = $(\"#itemName\").text();//商品名称\r\n");
	templateBuilder.Append("            var desc = (\"" + ProductPriceDesc.ToString() + "\")  + $(\"#price\").text() + (\"<br />" + ProductDesc.ToString() + "\");//商品描述\r\n");
	templateBuilder.Append("            var url = $(this).attr(\"URL\");\r\n");
	templateBuilder.Append("            var img_url = $(\".inner img\").attr(\"src\");\r\n");
	templateBuilder.Append("            GetData(url, title, desc, img_url);\r\n");
	templateBuilder.Append("        });\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("  \r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("    <!--mask begin-->\r\n");
	templateBuilder.Append("    <div class=\"mask-bg\" id=\"mask-bg\" style=\"display: none\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"mask-content\" id=\"mask-content\" style=\"display: none\">\r\n");
	templateBuilder.Append("        <img src=\"../Template/" + path.ToString() + "/images/MgnnofmleM.png\" class=\"guide\"></div>\r\n");
	templateBuilder.Append("    <!--mask end-->\r\n");
	templateBuilder.Append("    <div class=\"popup\" id=\"popup\" style=\"display: none\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <!--head begin-->\r\n");
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
	templateBuilder.Append("    <section class=\"img\">\r\n");
	templateBuilder.Append("            \r\n");
	
	productdetail__loop__id=0;
	foreach(var productdetail in getTable("productdetail","["+cid+"],[id]"))
	{
	if(productdetail__loop__id == 1 && productdetail__loop__id != 0) break;
		productdetail__loop__id++;
	templateBuilder.Append("<img src=\"" + gettmpimg2(productdetail.DefaultImageData.ToString()) + "\" data-src=\"" + gettmpimg2(productdetail.DefaultImageData.ToString()) + "\" onclick=\"javascript:imgview(this)\" alt=\"商品\">\r\n");
	 
	productimage__loop__id=0;
	foreach(var productimage in getTable("productimage","["+productdetail.ID+"]"))
	{
	if(productimage__loop__id == 999 && productimage__loop__id != 0) break;
		productimage__loop__id++;
	templateBuilder.Append("<img data-src=\"" + gettmpimg2(productimage.SourceImageData.ToString()) + "\" style=\"display:none\" />\r\n");
	
	}	//end loop
	
	}	//end loop
	templateBuilder.Append("\r\n");
	templateBuilder.Append("			\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("      \r\n");
	templateBuilder.Append("     </section>\r\n");
	templateBuilder.Append("        \r\n");
	
	productdetail__loop__id=0;
	foreach(var productdetail in getTable("productdetail","["+cid+"],[id]"))
	{
	if(productdetail__loop__id == 1 && productdetail__loop__id != 0) break;
		productdetail__loop__id++;
	templateBuilder.Append("<section class=\"summary\">\r\n");
	templateBuilder.Append("    <h1 class=\"summary-name\">" + left(productdetail.Name.ToString(),0) + "</h1>\r\n");
	    
	ProductDetailPrice__loop__id=0;
	foreach(var ProductDetailPrice in getTable("ProductDetailPrice","["+productdetail.ID.ToString()+"]"))
	{
	if(ProductDetailPrice__loop__id == 999 && ProductDetailPrice__loop__id != 0) break;
		ProductDetailPrice__loop__id++;
	templateBuilder.Append("    <ul class=\"summary-prices-ul\">\r\n");
	templateBuilder.Append("      <li class=\"p-price\">\r\n");
	templateBuilder.Append("        <span class=\"key\">惊爆价：</span>\r\n");
	templateBuilder.Append("        <div class=\"value\"><span class=\"price\">¥<b class=\"p-price-v\" id=\"price\"> " + GetCustomerPrice( ProductDetailPrice.SalesPrice.ToString() ,productdetail.ID.ToString()).ToString() + "</b></span></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	      
	}	//end loop
	templateBuilder.Append("        <li class=\"post\">\r\n");
	templateBuilder.Append("            <span class=\"key\"><span class=\"c99\">运费：</span></span>\r\n");
	templateBuilder.Append("        <div class=\"value\"><b class=\"cost\">快递￥0.00</b></div>\r\n");
	templateBuilder.Append("        </li>\r\n");
	templateBuilder.Append("    </ul>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("<section class=\"s-buy\"> \r\n");
	templateBuilder.Append("     <ul class=\"s-buy-ul\">\r\n");
	       
	productspec__loop__id=0;
	foreach(var productspec in getTable("productspec","["+productdetail.ID.ToString()+"]"))
	{
	if(productspec__loop__id == 999 && productspec__loop__id != 0) break;
		productspec__loop__id++;
		templateBuilder.Append("    <li class=\"s-buy-li\">\r\n");
	templateBuilder.Append("    <div class=\"left\">\r\n");
	templateBuilder.Append("         " + left(productspec.Name.ToString(),0) + "：</div>\r\n");
	templateBuilder.Append("    <div class=\"right\" name=\"specvals\">\r\n");
	        
	productspecval__loop__id=0;
	foreach(var productspecval in getTable("productspecval","["+productdetail.ID.ToString()+"], ["+productspec.SpecID.ToString()+"]"))
	{
	if(productspecval__loop__id == 999 && productspecval__loop__id != 0) break;
		productspecval__loop__id++;
		templateBuilder.Append("        <span class='select' name=\"Span" + productspec__loop__id.ToString() + "\"  id=\"" + productspecval.SpecValID.ToString() + "\"  checked='false' onclick='change(this);'>" + productspecval.Alias.ToString() + "</span>\r\n");
	        
	}	//end loop
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("     </li>\r\n");
	           
	}	//end loop
	templateBuilder.Append("<!--    <b>提示:</b>  <span id='resultSpan'></span>  -->\r\n");
	templateBuilder.Append("       <li class=\"s-buy-li\">\r\n");
	templateBuilder.Append("     <div class=\"left\">数量：</div>\r\n");
	templateBuilder.Append("         <div class=\"right\">\r\n");
	templateBuilder.Append("         <span class=\"reduce\">-</span>\r\n");
	templateBuilder.Append("            <input  class=\"number\" name=\"quantity\" autocomplete=\"off\" value=\"1\" min=\"1\" max=\"" + productdetail.Stock.ToString() + "\" id=\"num\" readonly=\"true\">\r\n");
	templateBuilder.Append("             <span class=\"add\">+</span>\r\n");
	templateBuilder.Append("             <span class=\"annotation\" id=\"Stock\">剩余" + productdetail.Stock.ToString() + "件</span>\r\n");
	templateBuilder.Append("              <input id=\"hiddPDetailID\" type=\"hidden\" name=\"name\" value=\"\" />\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("    </ul>\r\n");
	templateBuilder.Append("</section>\r\n");
	templateBuilder.Append("<section class=\"option\">\r\n");
	templateBuilder.Append("          <a class=\"btn cart\" id=\"btnCart\" href=\"javascript:void(0);\">加入购物车</a> \r\n");
	templateBuilder.Append("    <a class=\"btn buy\" id=\"btnFastBuy\" href=\"javascript:void(0);\">立即购买</a>\r\n");
	templateBuilder.Append("    <a class=\"btn share\" id=\"btnShare\" href=\"javascript:void(0);\">发送给朋友</a>\r\n");
	templateBuilder.Append("</section>\r\n");
	templateBuilder.Append("  <section class=\"p-attributeoff\">\r\n");
	templateBuilder.Append("      <a href=\"javascript:showProperty();\" class=\"p-attributeoff-a\"><span class=\"text\">产品参数</span><span class=\"arrow\">></span><span class=\"wifi\"></span></a>       \r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("  <section class=\"p-a-c-list\">\r\n");
	templateBuilder.Append("  <ul class=\"list-attribute\" id=\"productproperty\" style=\"display:none;\">\r\n");
	  	   
	productproperty__loop__id=0;
	foreach(var productproperty in getTable("productproperty","["+productdetail.ID.ToString()+"]"))
	{
	if(productproperty__loop__id == 999 && productproperty__loop__id != 0) break;
		productproperty__loop__id++;
		templateBuilder.Append("      <li><label> " + left(productproperty.Name.ToString(),0) + "</label><span>" + productproperty.Value.ToString() + "</span></li>\r\n");
		   
	}	//end loop
	templateBuilder.Append("      </ul>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("<section class=\"p-detail\" id=\"p-detail\" >\r\n");
	templateBuilder.Append("    <h1 class=\"d-title\">图文详情</h1>\r\n");
	templateBuilder.Append("    <div class=\"d-content\" id=\"content\">" + productdetail.DetailMemo.ToString() + "</div>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\">  \r\n");
	templateBuilder.Append("  var hdata='';\r\n");
	templateBuilder.Append("   $(function () {\r\n");
	templateBuilder.Append("   var trueid = 0;\r\n");
	    
	trueproduct__loop__id=0;
	foreach(var trueproduct in getTable("trueproduct","["+cid+"]"))
	{
	if(trueproduct__loop__id == 999 && trueproduct__loop__id != 0) break;
		trueproduct__loop__id++;
	templateBuilder.Append("    productDatas['" + trueproduct.ProductDetailID.ToString() + "'] = {\r\n");
	templateBuilder.Append("   \r\n");
	templateBuilder.Append("			    productDetailID: '" + trueproduct.ProductDetailID.ToString() + "',\r\n");
	templateBuilder.Append("			    SalesPrice:' " + GetCustomerPrice( trueproduct.SalesPrice.ToString() ,cid).ToString() + "',\r\n");
	templateBuilder.Append("                Stock:'" + trueproduct.Stock.ToString() + "',\r\n");
	templateBuilder.Append("		    };\r\n");
	templateBuilder.Append("    trueid = " + trueproduct.ProductDetailID.ToString() + ";\r\n");
	templateBuilder.Append("    $(\"#hiddPDetailID\").val(trueid);\r\n");
	    
	}	//end loop
	templateBuilder.Append("    " + specificationValueData.ToString() + " \r\n");
	templateBuilder.Append("   });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("   function showProperty(){\r\n");
	templateBuilder.Append("       $(\"#productproperty\").toggle();\r\n");
	templateBuilder.Append("   }\r\n");
	templateBuilder.Append("</"+"script>\r\n");
	templateBuilder.Append("\r\n");
	
	}	//end loop
	templateBuilder.Append("  \r\n");
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
