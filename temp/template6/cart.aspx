<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.cart" %>
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
	
	int cart__loop__id=0;
	int addressdefaultbyuid__loop__id=0;
	int payment__loop__id=0;
	int soldoutcart__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>购物车-" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/yixun-blue/css/common.css\">\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <script src=\"../Template/" + path.ToString() + "/js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"../Template/" + path.ToString() + "/js/cart.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/" + path.ToString() + "/js/CssLoad.js?Item=common|order\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"../Template/" + path.ToString() + "/js/common.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"../Template/" + path.ToString() + "/js/order.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/public/js/weixincommon.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("        var path = 'http://mall.chu-ying.com/';\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("   <!--goback begin-->\r\n");
	templateBuilder.Append("<section class=\"head\">\r\n");
	templateBuilder.Append("  <a href=\"javascript:void(0)\" onclick=\"window.history.go(-1)\" class=\"head_back\">上一页</a>\r\n");
	templateBuilder.Append("  <h2>购物车</h2>\r\n");
	templateBuilder.Append("</section>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <div class=\"popup\" id=\"popup\" style=\"display: none\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	    
	if(Convert.ToInt32(totalnum)>0){
	templateBuilder.Append("    <section class=\"cart-list\" id=\"cart-list\">\r\n");
	templateBuilder.Append("        <ul class=\"cart-list-ul\">\r\n");
	templateBuilder.Append("            <!--修改样式\"del”-->\r\n");
	            
	cart__loop__id=0;
	foreach(var cart in getTable("cart","["+username+"],["+guid+"],["+shopID+"]"))
	{
	if(cart__loop__id == 999 && cart__loop__id != 0) break;
		cart__loop__id++;
	templateBuilder.Append("            <li class=\"cart-list-li\">\r\n");
	templateBuilder.Append("                <div class=\"product\">\r\n");
	templateBuilder.Append("                    <div class=\"pic\">\r\n");
	templateBuilder.Append("                        <a href=\"product.aspx?id=" + cart.ProductID.ToString() + "\">\r\n");
	templateBuilder.Append("                            <img src=\"" + cart.Src.ToString() + "\" alt=\"" + cart.Name.ToString() + "\"></a>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                    <div class=\"info\">\r\n");
	templateBuilder.Append("                        <p class=\"info-name\">" + cart.Name.ToString() + "" + cart.PropertysText.ToString() + "</p>\r\n");
	templateBuilder.Append("                        <p class=\"info-price\">¥" + cart.MemberPrice.ToString() + "</p>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("                <div class=\"opera\">\r\n");
	templateBuilder.Append("                    <div class=\"number\">\r\n");
	templateBuilder.Append("                        <span class=\"ui-number\">\r\n");
	templateBuilder.Append("                            <button type=\"button\" class=\"decrease\" onclick=\"Cart.changeBar('-','" + cart.ID.ToString() + "',this)\" title=\"加\">-</button>\r\n");
	templateBuilder.Append("                            <input class=\"num\" name=\"quantity\" autocomplete=\"off\" value=\"" + cart.Count.ToString() + "\" min=\"1\" max=\"19684\" readonly=\"true\">\r\n");
	templateBuilder.Append("                            <button type=\"button\" class=\"increase\" onclick=\"Cart.changeBar('+','" + cart.ID.ToString() + "',this)\" title=\"加\">+</button>\r\n");
	templateBuilder.Append("                        </span>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </li>\r\n");
	            
	}	//end loop
	templateBuilder.Append("                   <li class=\"cart-info-li\">\r\n");
	                       
	addressdefaultbyuid__loop__id=0;
	foreach(var addressdefaultbyuid in getTable("addressdefaultbyuid","["+user_id+"]"))
	{
	if(addressdefaultbyuid__loop__id == 999 && addressdefaultbyuid__loop__id != 0) break;
		addressdefaultbyuid__loop__id++;
	templateBuilder.Append("                            <a href=\"member/addresslist.aspx?url=cart.aspx\" class=\"address-a\">\r\n");
	templateBuilder.Append("                                <input type=\"hidden\" id=\"addressid\" value=\"" + addressdefaultbyuid.ID.ToString() + " \">\r\n");
	templateBuilder.Append("                                <div class=\"address-info\">收件人：" + addressdefaultbyuid.Name.ToString() + "<span class=\"mobile\">" + addressdefaultbyuid.Moblie.ToString() + "</span><br>\r\n");
	templateBuilder.Append("                                    " + addressdefaultbyuid.AddressInfo.ToString() + "</div>\r\n");
	templateBuilder.Append("                            </a>\r\n");
	templateBuilder.Append("                       <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("                           //alert(1);\r\n");
	templateBuilder.Append("                           $(function () {\r\n");
	templateBuilder.Append("                               $(\"#noaddress\").hide();\r\n");
	templateBuilder.Append("                           })\r\n");
	templateBuilder.Append("                       </"+"script>\r\n");
	                       
	}	//end loop
	templateBuilder.Append("                       <div id=\"noaddress\" class=\"address-none\">\r\n");
	templateBuilder.Append("                           <a href=\"member/EditAddress.aspx?url=cart.aspx\" class=\"address-a\">请添加收货地址</a>\r\n");
	templateBuilder.Append("                       </div>\r\n");
	templateBuilder.Append("                       <div class=\"address-arrow\"><i class=\"address-arrow-i\"></i></div>\r\n");
	templateBuilder.Append("                   </li>\r\n");
	templateBuilder.Append("        </ul>\r\n");
	templateBuilder.Append("    </section>\r\n");
	templateBuilder.Append("    <div class=\"clear\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <section class=\"cart-info\">\r\n");
	templateBuilder.Append("        <ul class=\"cart-info-ul\">\r\n");
	templateBuilder.Append("            <li class=\"cart-info-li line\">\r\n");
	templateBuilder.Append("                <div class=\"label\">\r\n");
	templateBuilder.Append("                    <label>\r\n");
	templateBuilder.Append("                        支付方式</label>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("                 <div class=\"value\" id=\"payType\">\r\n");
	templateBuilder.Append("                    <!--<label class=\"value-pay current\">货到付款</label><label class=\"value-pay\">财付通</label>-->\r\n");
	                    
	payment__loop__id=0;
	foreach(var payment in getTable("payment","["+IsWxPay+"]"))
	{
	if(payment__loop__id == 999 && payment__loop__id != 0) break;
		payment__loop__id++;
	templateBuilder.Append("                    <label class=\"value-pay\" id=\"" + payment.DllName.ToString() + "\">\r\n");
	templateBuilder.Append("                        " + payment.Name.ToString() + "</label>\r\n");
	                    
	}	//end loop
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </li>\r\n");
	templateBuilder.Append("              <li class=\"cart-info-li line\">\r\n");
	templateBuilder.Append("                <span class=\"numb\">运费</span>\r\n");
	templateBuilder.Append("                <span id=\"feepric\" style=\"float: right\">¥" + feepricestr.ToString() + "</span>\r\n");
	templateBuilder.Append("            </li>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("            <li class=\"cart-info-li line\">\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("                <span class=\"numb\" id=\"count\">共" + CartCount.ToString() + "件商品</span>\r\n");
	templateBuilder.Append("                <span id=\"orderprice\" style=\"float: right\">商品总价:¥" + orderPrice.ToString() + "</span>\r\n");
	templateBuilder.Append("            </li>\r\n");
	templateBuilder.Append("            <!-- <li class=\"cart-info-li line\">\r\n");
	templateBuilder.Append("                     <div class=\"label\">\r\n");
	templateBuilder.Append("                         <label>\r\n");
	templateBuilder.Append("                             优惠券</label></div>\r\n");
	templateBuilder.Append("                     <div class=\"value\">\r\n");
	templateBuilder.Append("                         <label class=\"value-pay current\">\r\n");
	templateBuilder.Append("                             1223515412</label><label class=\"value-pay\">13564613</label></div>\r\n");
	templateBuilder.Append("                 </li>-->\r\n");
	templateBuilder.Append("        </ul>\r\n");
	templateBuilder.Append("    </section>\r\n");
	templateBuilder.Append("    <div class=\"clear\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <section class=\"s-btn\" id=\"s-btn\">\r\n");
	templateBuilder.Append("        <button class=\"settle-account\" onclick=\"Submit_Order()\" id=\"butSubmit\">去结算</button>\r\n");
	templateBuilder.Append("        <div id=\"pay\">\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </section>\r\n");
	    
	if(Convert.ToInt32(soldoutTotalNum)>0){
	templateBuilder.Append("    <h2 class=\"undercarriage-title\" style=\"display: none\">已下架商品</h2>\r\n");
	templateBuilder.Append("    <section class=\"cart-list\" style=\"display: none\">\r\n");
	templateBuilder.Append("        <!--undercarriage begin-->\r\n");
	templateBuilder.Append("        <div class=\"undercarriage-mask\" style=\"display: ;\"></div>\r\n");
	templateBuilder.Append("        <!--undercarriage end-->\r\n");
	templateBuilder.Append("        <ul class=\"cart-list-ul\">\r\n");
	            
	soldoutcart__loop__id=0;
	foreach(var soldoutcart in getTable("soldoutcart","["+username+"],["+guid+"]"))
	{
	if(soldoutcart__loop__id == 999 && soldoutcart__loop__id != 0) break;
		soldoutcart__loop__id++;
	templateBuilder.Append("            <li class=\"cart-list-li\">\r\n");
	templateBuilder.Append("                <div class=\"pic\">\r\n");
	templateBuilder.Append("                    <a href=\"\">\r\n");
	templateBuilder.Append("                        <img src=\"" + soldoutcart.Src.ToString() + "\" width=\"120\" height=\"120\" alt=\"" + soldoutcart.Name.ToString() + "\"></a>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("                <div class=\"info\">\r\n");
	templateBuilder.Append("                    <p class=\"info-name\">" + soldoutcart.Name.ToString() + "</p>\r\n");
	templateBuilder.Append("                    <p class=\"info-price\">¥" + soldoutcart.MemberPrice.ToString() + "</p>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </li>\r\n");
	            
	}	//end loop
	templateBuilder.Append("        </ul>\r\n");
	templateBuilder.Append("    </section>\r\n");
	    
	}	//end if
	templateBuilder.Append("    <section class=\"cart-none\" id=\"cart-none\" style=\"display: none\">\r\n");
	templateBuilder.Append("        <i class=\"cart-big\"></i>\r\n");
	templateBuilder.Append("        <p class=\"text\">您的购物车还没有商品！</p>\r\n");
	templateBuilder.Append("        <a href=\"index.aspx\" class=\"btn\">去逛逛</a>\r\n");
	templateBuilder.Append("    </section>\r\n");
	    
	}else{
	templateBuilder.Append("    <section class=\"cart-none\" id=\"cart-none\">\r\n");
	templateBuilder.Append("        <i class=\"cart-big\"></i>\r\n");
	templateBuilder.Append("        <p class=\"text\">您的购物车还没有商品！</p>\r\n");
	templateBuilder.Append("        <a href=\"index.aspx\" class=\"btn\">去逛逛</a>\r\n");
	templateBuilder.Append("    </section>\r\n");
	    
	}	//end if
	 templateBuilder.Append("    \r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("</body>\r\n");
	templateBuilder.Append("</html>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\">\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    $(function () {\r\n");
	templateBuilder.Append("        if ($(\"#payType label\").length > 1) {\r\n");
	templateBuilder.Append("            $(\"#WxPay\").addClass(\"current\");\r\n");
	templateBuilder.Append("        } else {\r\n");
	templateBuilder.Append("            $(\"#Alipay_Wap\").addClass(\"current\");\r\n");
	templateBuilder.Append("        }\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("        $(\"#payType label\").on(\"click\", function () {\r\n");
	templateBuilder.Append("            $(\"#payType label\").removeClass(\"current\");\r\n");
	templateBuilder.Append("            $(this).addClass(\"current\");\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("        })\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    })\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    function Submit_Order() {\r\n");
	templateBuilder.Append("        if ($(\"#addressid\").val() != undefined) {\r\n");
	templateBuilder.Append("            var dllName = \"\";\r\n");
	templateBuilder.Append("            $(\"#payType label\").each(function () {\r\n");
	templateBuilder.Append("                if ($(this).hasClass(\"current\")) {\r\n");
	templateBuilder.Append("                    dllName = $(this).attr(\"id\");\r\n");
	templateBuilder.Append("                }\r\n");
	templateBuilder.Append("            });\r\n");
	templateBuilder.Append("            if (dllName != \"\") {\r\n");
	templateBuilder.Append("                $(\"#butSubmit\").attr(\"disabled\", \"true\");\r\n");
	templateBuilder.Append("                $(\"#butSubmit\").removeClass().addClass(\"settle-disable\");\r\n");
	templateBuilder.Append("                $.ajax({\r\n");
	templateBuilder.Append("                    type: \"POST\",\r\n");
	templateBuilder.Append("                    url: \"cartend.aspx\",\r\n");
	templateBuilder.Append("                    data: \"login=yes&addressID=\" + $(\"#addressid\").val() + \"&payname=\" + dllName,\r\n");
	templateBuilder.Append("                    success: function (msg) {\r\n");
	templateBuilder.Append("                        $(\"#aftersubmittext\").hide();\r\n");
	templateBuilder.Append("                        if (msg.indexOf(\"errMessage:\") != -1) {\r\n");
	templateBuilder.Append("                            alert(msg.substr(11));\r\n");
	templateBuilder.Append("                        }\r\n");
	templateBuilder.Append("                        else {\r\n");
	templateBuilder.Append("                            if (dllName == \"WxPay\") {\r\n");
	templateBuilder.Append("                                // alert(msg);\r\n");
	templateBuilder.Append("                                window.location.href = \"../member/WxPay.aspx?showwxpaytitle=1&shopCode=" + shopID.ToString() + "&ordernumber=\" + msg;\r\n");
	templateBuilder.Append("                            } else {\r\n");
	templateBuilder.Append("                                gotoPay(\"<input type='hidden' ordernumber='\" + msg + \"'>\");\r\n");
	templateBuilder.Append("                            }\r\n");
	templateBuilder.Append("                        }\r\n");
	templateBuilder.Append("                    }\r\n");
	templateBuilder.Append("                });\r\n");
	templateBuilder.Append("            } else {\r\n");
	templateBuilder.Append("                showBox(\"请先选择支付方式\");\r\n");
	templateBuilder.Append("            }\r\n");
	templateBuilder.Append("        } else {\r\n");
	templateBuilder.Append("            showBox(\"请先选择收货地址\");\r\n");
	templateBuilder.Append("        }\r\n");
	templateBuilder.Append("    }\r\n");
	templateBuilder.Append("</"+"script>\r\n");
	
	Response.Write(templateBuilder.ToString());
//init cache
	CacheManager testcaching = CacheFactory.GetCacheManager();
	if(!testcaching.Contains(Request.Url.ToString()))
	{
		testcaching.Add(Request.Url.ToString(), templateBuilder.ToString());
	}
}
</script>
