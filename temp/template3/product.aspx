<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.product" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/9/22 17:09:08.
		本页面代码由V5Shop模板引擎生成于 2014/9/22 17:09:08. 
	*/

	base.OnInit(e);
	
	int productdetail__loop__id=0;
	int productimage__loop__id=0;
	int ProductDetailPrice__loop__id=0;
	int productspec__loop__id=0;
	int productspecval__loop__id=0;
	int productproperty__loop__id=0;
	int trueproduct__loop__id=0;templateBuilder.Append("  <!DOCTYPE html>\r\n");
	templateBuilder.Append("<html lang=\"zh-CN\" class=\"detail_standard\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
	templateBuilder.Append("    <meta charset=\"utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\">\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <meta http-equiv=\"x-dns-prefetch-control\" content=\"on\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/yixun-black/css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/yixun-black/font/css/font-awesome.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/yixun-black/css/pro-detail.css\">     \r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/distribution/css/PreFoot.css\">\r\n");
	templateBuilder.Append("<style>@-moz-keyframes nodeInserted{from{opacity:0.99;}to{opacity:1;}}@-webkit-keyframes nodeInserted{from{opacity:0.99;}to{opacity:1;}}@-o-keyframes nodeInserted{from{opacity:0.99;}to{opacity:1;}}@keyframes nodeInserted{from{opacity:0.99;}to{opacity:1;}}embed,object{animation-duration:.001s;-ms-animation-duration:.001s;-moz-animation-duration:.001s;-webkit-animation-duration:.001s;-o-animation-duration:.001s;animation-name:nodeInserted;-ms-animation-name:nodeInserted;-moz-animation-name:nodeInserted;-webkit-animation-name:nodeInserted;-o-animation-name:nodeInserted;}</style>\r\n");
	templateBuilder.Append("<script language=\"javascript\" src=\"../Template/" + path.ToString() + "/js/jquery-1.4.2.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/public/js/product.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/public/js/Common.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/" + path.ToString() + "/js/common.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("   <script src=\"../../../member/js/WeiXinShare.js\"></"+"script>\r\n");
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
	templateBuilder.Append("    </"+"script></head>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("      <div class=\"popup\" id=\"popup\" style=\"display: none\">\r\n");
	templateBuilder.Append("    </div>    <section class=\"head\">\r\n");
	templateBuilder.Append("			<a href=\"javascript:void(0)\" onclick=\"window.history.go(-1)\" class=\"head_back\">上一页</a>\r\n");
	templateBuilder.Append("			<h2>商品详情</h2>\r\n");
	templateBuilder.Append("            <a href=\"cart.aspx\" class=\"detail-cart\"><i class=\"fa fa-shopping-cart\"></i>\r\n");
	templateBuilder.Append("                (<span class=\"tips\" id=\"countcart\">\r\n");
	                   
	if(Convert.ToInt32(totalnum)>0){
	templateBuilder.Append("      " + totalnum.ToString() + " \r\n");
	                    
	}else{
	templateBuilder.Append("                    0\r\n");
	                    
	}	//end if
	templateBuilder.Append("                    </span>)   \r\n");
	templateBuilder.Append("            </a>\r\n");
	templateBuilder.Append("	</section>\r\n");
	templateBuilder.Append("   <div class=\"mod_slider\" id=\"loopImgDiv\">\r\n");
	templateBuilder.Append("    <div class=\"inner\">\r\n");
	templateBuilder.Append("            \r\n");
	
	productdetail__loop__id=0;
	foreach(var productdetail in getTable("productdetail","["+cid+"],[id]"))
	{
	if(productdetail__loop__id == 1 && productdetail__loop__id != 0) break;
		productdetail__loop__id++;
	templateBuilder.Append("<img src=\"" + gettmpimg2(productdetail.DefaultImageData.ToString()) + "\" width=\"290\" height=\"174\" data-src=\"" + gettmpimg2(productdetail.DefaultImageData.ToString()) + "\" onclick=\"javascript:imgview(this)\" alt=\"商品\">\r\n");
	 
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
	templateBuilder.Append("        \r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("        \r\n");
	
	productdetail__loop__id=0;
	foreach(var productdetail in getTable("productdetail","["+cid+"],[id]"))
	{
	if(productdetail__loop__id == 1 && productdetail__loop__id != 0) break;
		productdetail__loop__id++;
	templateBuilder.Append("<div class=\"buy_area\">\r\n");
	templateBuilder.Append("    <div id=\"testtt\" style=\"display: none\"></div>\r\n");
	templateBuilder.Append("    <div class=\"fn_wrap\">\r\n");
	templateBuilder.Append("        <h1 class=\"fn\" id=\"itemName\">" + left(productdetail.Name.ToString(),0) + "</h1>\r\n");
	templateBuilder.Append("    </div>\r\n");
	    
	ProductDetailPrice__loop__id=0;
	foreach(var ProductDetailPrice in getTable("ProductDetailPrice","["+productdetail.ID.ToString()+"]"))
	{
	if(ProductDetailPrice__loop__id == 999 && ProductDetailPrice__loop__id != 0) break;
		ProductDetailPrice__loop__id++;
	templateBuilder.Append("    <div class=\"price_wrap\">\r\n");
	templateBuilder.Append("        <span class=\"tit\" id=\"priceTitle\">惊爆价：</span>\r\n");
	templateBuilder.Append("          <span class=\"price\" id=\"price\" price=\"¥311.00\">¥" + GetCustomerPrice( ProductDetailPrice.SalesPrice.ToString() ,productdetail.ID.ToString()).ToString() + "</span>\r\n");
	templateBuilder.Append("        <del class=\"old_price\"><em id=\"priceMarket\" style=\"\">¥" + ProductDetailPrice.OldPrice.ToString() + "</em></del>\r\n");
	templateBuilder.Append("        <span class=\"flag\" id=\"priceDis\" style=\"display: none\"></span>\r\n");
	templateBuilder.Append("    </div>\r\n");
	    
	}	//end loop
	templateBuilder.Append("    <div class=\"buy_tip\" id=\"statusNotice\" style=\"display: none;\">\r\n");
	templateBuilder.Append("        <i class=\"icon_warn\"></i>\r\n");
	templateBuilder.Append("        <span id=\"statusNote\"></span>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"s-buy\" id=\"skuCont\">\r\n");
	templateBuilder.Append("        <ul class=\"s-buy-ul\">\r\n");
	            
	productspec__loop__id=0;
	foreach(var productspec in getTable("productspec","["+productdetail.ID.ToString()+"]"))
	{
	if(productspec__loop__id == 999 && productspec__loop__id != 0) break;
		productspec__loop__id++;
		templateBuilder.Append("    <li class=\"s-buy-li\">\r\n");
	templateBuilder.Append("        <div class=\"left\">\r\n");
	templateBuilder.Append("            " + left(productspec.Name.ToString(),0) + "：\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"right\" name=\"specvals\">\r\n");
	            
	productspecval__loop__id=0;
	foreach(var productspecval in getTable("productspecval","["+productdetail.ID.ToString()+"], ["+productspec.SpecID.ToString()+"]"))
	{
	if(productspecval__loop__id == 999 && productspecval__loop__id != 0) break;
		productspecval__loop__id++;
		templateBuilder.Append("        <span class='select' name=\"Span" + productspec__loop__id.ToString() + "\" id=\"" + productspecval.SpecValID.ToString() + "\" checked='false' onclick='change(this);'>" + productspecval.Alias.ToString() + "</span>\r\n");
	            
	}	//end loop
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </li>\r\n");
	            
	}	//end loop
	templateBuilder.Append("            <!--    <b>提示:</b>  <span id='resultSpan'></span>  -->\r\n");
	templateBuilder.Append("            <li class=\"s-buy-li\">\r\n");
	templateBuilder.Append("                <div class=\"left\">数量：</div>\r\n");
	templateBuilder.Append("                <div class=\"right\">\r\n");
	templateBuilder.Append("                    <span class=\"reduce\">-</span>\r\n");
	templateBuilder.Append("                    <input class=\"number\" name=\"quantity\" autocomplete=\"off\" value=\"1\" min=\"1\" max=\"" + productdetail.Stock.ToString() + "\" id=\"num\" readonly=\"true\">\r\n");
	templateBuilder.Append("                    <span class=\"add\">+</span>\r\n");
	templateBuilder.Append("                    <span class=\"annotation\" id=\"Stock\">剩余" + productdetail.Stock.ToString() + "件</span>\r\n");
	templateBuilder.Append("                    <input id=\"hiddPDetailID\" type=\"hidden\" name=\"name\" value=\"\" />\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </li>\r\n");
	templateBuilder.Append("        </ul>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <div class=\"btn_wrap btn_wrap_static btn_wrap_nocart\">\r\n");
	templateBuilder.Append("        <a class=\"btn btn_cart\" id=\"btnCart\" href=\"javascript:void(0);\"><i></i></a>\r\n");
	templateBuilder.Append("        <a class=\"btn btn_buy\" id=\"btnFastBuy\" href=\"javascript:void(0);\">立即购买</a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("<div class=\"mod_tab_wrap\">\r\n");
	templateBuilder.Append("    <div class=\"mod_tab\" id=\"detailTab\">\r\n");
	templateBuilder.Append("        <span onclick=\"showProperty(this)\" class=\"cur\">商品介绍</span>\r\n");
	templateBuilder.Append("        <span onclick=\"showProperty(this)\">商品参数</span>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("<section class=\"p-a-c-list\">\r\n");
	templateBuilder.Append("    <ul class=\"list-attribute\" id=\"productproperty\" style=\"display: none;\">\r\n");
	        
	productproperty__loop__id=0;
	foreach(var productproperty in getTable("productproperty","["+productdetail.ID.ToString()+"]"))
	{
	if(productproperty__loop__id == 999 && productproperty__loop__id != 0) break;
		productproperty__loop__id++;
		templateBuilder.Append("      <li>\r\n");
	templateBuilder.Append("          <label>" + left(productproperty.Name.ToString(),0) + "</label><span>" + productproperty.Value.ToString() + "</span></li>\r\n");
	        
	}	//end loop
	templateBuilder.Append("    </ul>\r\n");
	templateBuilder.Append("</section>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("<section class=\"p-detail\" id=\"p-detail\">\r\n");
	templateBuilder.Append("    <h1 class=\"d-title\">图文详情</h1>\r\n");
	templateBuilder.Append("    <div class=\"d-content\" id=\"content\">" + productdetail.DetailMemo.ToString() + "</div>\r\n");
	templateBuilder.Append("</section>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\">  \r\n");
	templateBuilder.Append("    var hdata='';\r\n");
	templateBuilder.Append("    $(function () {\r\n");
	templateBuilder.Append("        var trueid = 0;\r\n");
	        
	trueproduct__loop__id=0;
	foreach(var trueproduct in getTable("trueproduct","["+cid+"]"))
	{
	if(trueproduct__loop__id == 999 && trueproduct__loop__id != 0) break;
		trueproduct__loop__id++;
	templateBuilder.Append("        productDatas['" + trueproduct.ProductDetailID.ToString() + "'] = {\r\n");
	templateBuilder.Append("            productDetailID: '" + trueproduct.ProductDetailID.ToString() + "',\r\n");
	templateBuilder.Append("            SalesPrice:' " + GetCustomerPrice( trueproduct.SalesPrice.ToString() ,cid).ToString() + "',\r\n");
	templateBuilder.Append("            Stock:'" + trueproduct.Stock.ToString() + "',\r\n");
	templateBuilder.Append("        };\r\n");
	templateBuilder.Append("        trueid = " + trueproduct.ProductDetailID.ToString() + ";\r\n");
	templateBuilder.Append("        $(\"#hiddPDetailID\").val(trueid);\r\n");
	        
	}	//end loop
	templateBuilder.Append("        " + specificationValueData.ToString() + " \r\n");
	templateBuilder.Append("    });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    function showProperty(sobj){\r\n");
	templateBuilder.Append("        $(\"#detailTab span\").removeClass(\"cur\");\r\n");
	templateBuilder.Append("        $(sobj).addClass(\"cur\");\r\n");
	templateBuilder.Append("        $(\"#productproperty\").toggle();\r\n");
	templateBuilder.Append("        $(\"#p-detail\").toggle();\r\n");
	templateBuilder.Append("    }\r\n");
	templateBuilder.Append("</"+"script>\r\n");
	templateBuilder.Append("\r\n");
	
	}	//end loop
	templateBuilder.Append(" \r\n");
	templateBuilder.Append("    \r\n");
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
