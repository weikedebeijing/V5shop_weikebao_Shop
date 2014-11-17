<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.product" %>
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
	
	int productdetail__loop__id=0;
	int ProductDetailPrice__loop__id=0;
	int productproperty__loop__id=0;
	int productspec__loop__id=0;
	int productspecval__loop__id=0;
	int trueproduct__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head><base href=\"http://192.168.1.105:8082/template/version_9/\" />\r\n");
	templateBuilder.Append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/>\r\n");
	templateBuilder.Append("<meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\"/>\r\n");
	templateBuilder.Append("<meta name=\"apple-mobile-web-app-capable\" content=\"yes\"/>\r\n");
	templateBuilder.Append("<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\"/>\r\n");
	templateBuilder.Append("<meta name=\"format-detection\" content=\"telephone=no\"/>\r\n");
	templateBuilder.Append("<title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/base.css\"/>\r\n");
	templateBuilder.Append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/common.css\"/>\r\n");
	templateBuilder.Append("<link rel=\"stylesheet\" type=\"text/css\" href=\"css/v5.css\"/>\r\n");
	templateBuilder.Append("<script language=\"javascript\" src=\"js/jquery-1.4.2.min.js\" type=\"text/javascript\"></"+"script>  \r\n");
	templateBuilder.Append("<script type=\"text/javascript\" src=\"../public/js/product.js\" language=\"javascript\" ></"+"script>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\" src=\"../public/js/Common.js\" language=\"javascript\" ></"+"script>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\" src=\"js/common.js\" language=\"javascript\" charset=\"gb2312\" ></"+"script>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append(" <style>  \r\n");
	templateBuilder.Append(" .unchecked{  \r\n");
	templateBuilder.Append("   border: 1px solid gray;  \r\n");
	templateBuilder.Append("   padding: 6px 6px 6px 6px;  \r\n");
	templateBuilder.Append(" }  \r\n");
	templateBuilder.Append(" .checked{  \r\n");
	templateBuilder.Append("   border: 2px solid #c00;  \r\n");
	templateBuilder.Append("   padding: 6px 6px 6px 6px;  \r\n");
	templateBuilder.Append(" }  \r\n");
	templateBuilder.Append("</style>  \r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body topmargin=\"0\" leftmargin=\"0\" bottommargin=\"0\" rightmargin=\"0\" id=\"top\" name=\"top\">\r\n");
	templateBuilder.Append("     <!--head begin-->\r\n");
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
	templateBuilder.Append(" <section class=\"img\">\r\n");
	templateBuilder.Append("            \r\n");
	
	productdetail__loop__id=0;
	foreach(DataRow productdetail_member in getTable("productdetail","["+cid+"],[id]").Rows)
	{
	if(productdetail__loop__id == 1 && productdetail__loop__id != 0) break;
		productdetail__loop__id++;
	templateBuilder.Append(" <img src=\"" + gettmpimg(productdetail_member["DefaultImageData"].ToString(),305,305) + "\" alt=\"商品\">   \r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	
	}	//end loop
	templateBuilder.Append("\r\n");
	templateBuilder.Append("			\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("      \r\n");
	templateBuilder.Append("     </section>     \r\n");
	templateBuilder.Append("   \r\n");
	templateBuilder.Append("                        \r\n");
	
	productdetail__loop__id=0;
	foreach(DataRow productdetail_member in getTable("productdetail","["+cid+"],[id]").Rows)
	{
	if(productdetail__loop__id == 1 && productdetail__loop__id != 0) break;
		productdetail__loop__id++;
	templateBuilder.Append("<section class=\"summary\">\r\n");
	templateBuilder.Append("    <h1 class=\"summary-name\">" + left(productdetail_member["name"].ToString(),0) + "</h1>\r\n");
	templateBuilder.Append("    \r\n");
	    
	ProductDetailPrice__loop__id=0;
	foreach(DataRow ProductDetailPrice_member in getTable("ProductDetailPrice","["+productdetail_member["id"].ToString()+"]").Rows)
	{
	if(ProductDetailPrice__loop__id == 999 && ProductDetailPrice__loop__id != 0) break;
		ProductDetailPrice__loop__id++;
	templateBuilder.Append("    <ul class=\"summary-prices-ul\">\r\n");
	templateBuilder.Append("      <li class=\"p-price\">\r\n");
	templateBuilder.Append("        <span class=\"key\">促销：</span>\r\n");
	templateBuilder.Append("        <div class=\"value\"><span class=\"price\">¥<b class=\"p-price-v\" id=\"price\">" + GetCustomerPrice( ProductDetailPrice_member["SalesPrice"].ToString() ,productdetail_member["id"].ToString()).ToString() + "</b></span></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"o-price line\">\r\n");
	templateBuilder.Append("        <span class=\"key\">原价：</span>\r\n");
	templateBuilder.Append("        <div class=\"value\"><del>¥<span class=\"o-price-v\">" + ProductDetailPrice_member["SalesPrice"].ToString().ToString() + "</span></del></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	      
	}	//end loop
	templateBuilder.Append("      <li class=\"s-volume line\">\r\n");
	templateBuilder.Append("        <span class=\"key\">库存：</span>\r\n");
	templateBuilder.Append("        <div class=\"value\"><b class=\"numb\">" + productdetail_member["Stock"].ToString() + "件</b></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"post line\">\r\n");
	templateBuilder.Append("        <span class=\"key\">配送：</span>\r\n");
	templateBuilder.Append("        <div class=\"value\"><b class=\"from\">浙江杭州</b>至<b class=\"to\">上海</b><b class=\"cost\">快递: 0.00</b></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("    </ul>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("<!--    <div class=\"product-det-shuxing\">\r\n");
	templateBuilder.Append("      <h2 class=\"head4\">商品属性</h2>\r\n");
		   
	productproperty__loop__id=0;
	foreach(DataRow productproperty_member in getTable("productproperty","["+productdetail_member["ID"].ToString()+"]").Rows)
	{
	if(productproperty__loop__id == 999 && productproperty__loop__id != 0) break;
		productproperty__loop__id++;
		templateBuilder.Append("      <p class=\"widthhalf1\"><strong>" + left(productproperty_member["name"].ToString(),0) + ":</strong><span>" + productproperty_member["value"].ToString() + "</span></p>\r\n");
		   
	}	//end loop
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("   \r\n");
	      
	productspec__loop__id=0;
	foreach(DataRow productspec_member in getTable("productspec","["+productdetail_member["ID"].ToString()+"]").Rows)
	{
	if(productspec__loop__id == 999 && productspec__loop__id != 0) break;
		productspec__loop__id++;
		templateBuilder.Append("      <tr bgcolor=\"f0f0f0\" height=\"40px\" align=\"center\" >\r\n");
	templateBuilder.Append("       \r\n");
	templateBuilder.Append("        <th width=\"149px\">" + left(productspec_member["Name"].ToString(),0) + "</th>\r\n");
		   
	productspecval__loop__id=0;
	foreach(DataRow productspecval_member in getTable("productspecval","["+productdetail_member["ID"].ToString()+"], ["+productspec_member["SpecID"].ToString()+"]").Rows)
	{
	if(productspecval__loop__id == 999 && productspecval__loop__id != 0) break;
		productspecval__loop__id++;
		templateBuilder.Append("        <td>" + productspecval_member["Alias"].ToString() + "</td>\r\n");
			
	}	//end loop
	templateBuilder.Append("          </tr>\r\n");
	           
	}	//end loop
	templateBuilder.Append("   \r\n");
	templateBuilder.Append("    <!--<div class=\"product-det-but\">\r\n");
	templateBuilder.Append("      <div class=\"table-but mt10\" style=\"width:auto\">\r\n");
	templateBuilder.Append("        <input type=\"button\" value=\"加入采购单\" class=\"btn-fastbuy\" id=\"btn-fastbuy\"/>\r\n");
	templateBuilder.Append("      </div>\r\n");
	templateBuilder.Append("     <div class=\"table-but mt10\">\r\n");
	templateBuilder.Append("        <input type=\"button\" value=\"立即采购\"/>\r\n");
	templateBuilder.Append("      </div>\r\n");
	templateBuilder.Append("    </div>-->\r\n");
	templateBuilder.Append("<section class=\"s-buy ui-section-box open\"> \r\n");
	templateBuilder.Append("    <label class=\"info ui-more\" for=\"s-buy-open\">\r\n");
	templateBuilder.Append("    <div class=\"notice\">请选择<span class=\"property\">\r\n");
	     
	productspec__loop__id=0;
	foreach(DataRow productspec_member in getTable("productspec","["+productdetail_member["ID"].ToString()+"]").Rows)
	{
	if(productspec__loop__id == 999 && productspec__loop__id != 0) break;
		productspec__loop__id++;
		     
	if(productspec__loop__id<productspec_member.Table.Rows.Count ){
	templateBuilder.Append("       " + left(productspec_member["Name"].ToString(),0) + "/\r\n");
	       
	}else{
	templateBuilder.Append("       " + left(productspec_member["Name"].ToString(),0) + "\r\n");
	       
	}	//end if
		   
	}	//end loop
	templateBuilder.Append("     </span></div>\r\n");
	templateBuilder.Append("    </label>\r\n");
	templateBuilder.Append("   <form action=\"\">\r\n");
	templateBuilder.Append("     <div class=\"fields\">\r\n");
	templateBuilder.Append("     <!-- <div class=\"summary\" style=\"height: 37px;\">\r\n");
	templateBuilder.Append("        <ul class=\"summary-c\" style=\"position: static;\">\r\n");
	templateBuilder.Append("          <li class=\"price\"><span class=\"key\">促销：</span><b class=\"price-v\">¥658.00</b></li>\r\n");
	templateBuilder.Append("          <li class=\"stock\"> <span class=\"key\">库存：</span><span class=\"stock-v\">19684</span>件</li>\r\n");
	templateBuilder.Append("        </ul>\r\n");
	templateBuilder.Append("      </div>-->\r\n");
	templateBuilder.Append("      <div class=\"ui-sku\">\r\n");
	       
	productspec__loop__id=0;
	foreach(DataRow productspec_member in getTable("productspec","["+productdetail_member["ID"].ToString()+"]").Rows)
	{
	if(productspec__loop__id == 999 && productspec__loop__id != 0) break;
		productspec__loop__id++;
		templateBuilder.Append("      <div class=\"ui-sku-prop\">\r\n");
	templateBuilder.Append("         <h2>" + left(productspec_member["Name"].ToString(),0) + "</h2>\r\n");
	templateBuilder.Append("         <div class=\"items\">\r\n");
		   
	productspecval__loop__id=0;
	foreach(DataRow productspecval_member in getTable("productspecval","["+productdetail_member["ID"].ToString()+"], ["+productspec_member["SpecID"].ToString()+"]").Rows)
	{
	if(productspecval__loop__id == 999 && productspecval__loop__id != 0) break;
		productspecval__loop__id++;
		templateBuilder.Append("       <span class='unchecked' name=\"Span" + productspec__loop__id.ToString() + "\"  id=\"" + productspecval_member["SpecValID"].ToString() + "\"  checked='false' onclick='change(this);'>" + productspecval_member["Alias"].ToString() + "</span>\r\n");
			
	}	//end loop
	templateBuilder.Append("           </div>\r\n");
	           
	}	//end loop
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </div>\r\n");
	templateBuilder.Append("      <b>提示:</b>  <span id='resultSpan'></span>  \r\n");
	templateBuilder.Append("      <div class=\"quantity\">\r\n");
	templateBuilder.Append("        <h2>数量：</h2>\r\n");
	templateBuilder.Append("        <div class=\"items\">\r\n");
	templateBuilder.Append("          <span class=\"ui-number\">\r\n");
	templateBuilder.Append("            <button type=\"button\" class=\"decrease\">-</button>\r\n");
	templateBuilder.Append("            <input type=\"number\" class=\"num\" name=\"quantity\" autocomplete=\"off\" value=\"1\" min=\"1\" max=\"19684\" id=\"num\" readonly=\"true\">\r\n");
	templateBuilder.Append("            <button type=\"button\" class=\"increase\">+</button>\r\n");
	templateBuilder.Append("              <input id=\"hiddPDetailID\" type=\"hidden\" name=\"name\" value=\"\" />\r\n");
	templateBuilder.Append("          </span>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"option\">\r\n");
	templateBuilder.Append("      <a class=\"btn buy\" id=\"btnFastBuy\" href=\"javascript:void(0);\">立即购买</a>\r\n");
	templateBuilder.Append("      <a class=\"btn cart\" id=\"btnCart\" href=\"javascript:void(0);\">加入购物车</a> \r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("   </form>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("<section class=\"p-detail\">\r\n");
	templateBuilder.Append("    <h1 class=\"d-title\">详情</h1>\r\n");
	templateBuilder.Append("    <div class=\"d-content\">" + productdetail_member["DetailMemo"].ToString() + "</div>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\">  \r\n");
	templateBuilder.Append("   $(function () {\r\n");
	templateBuilder.Append("   var trueid = 0;\r\n");
	templateBuilder.Append("    \r\n");
	    
	trueproduct__loop__id=0;
	foreach(DataRow trueproduct_member in getTable("trueproduct","["+cid+"]").Rows)
	{
	if(trueproduct__loop__id == 999 && trueproduct__loop__id != 0) break;
		trueproduct__loop__id++;
	templateBuilder.Append("    productDatas['" + trueproduct_member["productdetailid"].ToString() + "'] = {\r\n");
	templateBuilder.Append("			    productDetailID: '" + trueproduct_member["ProductDetailID"].ToString() + "',\r\n");
	templateBuilder.Append("			    SalesPrice:'" + trueproduct_member["SalesPrice"].ToString() + "',\r\n");
	templateBuilder.Append("                Stock:'" + trueproduct_member["Stock"].ToString() + "',\r\n");
	templateBuilder.Append("		    };\r\n");
	templateBuilder.Append("    trueid = " + trueproduct_member["productdetailid"].ToString() + ";\r\n");
	templateBuilder.Append("    $(\"#hiddPDetailID\").val(trueid);\r\n");
	    
	}	//end loop
	templateBuilder.Append("    " + specificationValueData.ToString() + " \r\n");
	templateBuilder.Append("   \r\n");
	templateBuilder.Append("       });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("</"+"script>\r\n");
	templateBuilder.Append("\r\n");
	
	}	//end loop
	templateBuilder.Append("\r\n");
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
