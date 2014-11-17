<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.cartstep" %>
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
	
	int addressdefaultbyuid__loop__id=0;
	int cart__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head><base href=\"http://192.168.1.105:8082/template/version_9/\" />\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\" />\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\" />\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/base.css\" />\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/common.css\" />\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/order.css\" />\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/order.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body topmargin=\"0\" leftmargin=\"0\" bottommargin=\"0\" rightmargin=\"0\">\r\n");
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
	templateBuilder.Append("    <!--main begin-->\r\n");
	templateBuilder.Append("    \r\n");
	templateBuilder.Append("<div class=\"mainwidth mauto mt10 mb10\">\r\n");
	templateBuilder.Append("    <div id=\"content pt20\">\r\n");
	templateBuilder.Append("        <div class=\"wrapper\">\r\n");
	templateBuilder.Append("            <div class=\"shouhuo DivTitle\">\r\n");
	templateBuilder.Append("                <div>\r\n");
	templateBuilder.Append("                    <div>\r\n");
	templateBuilder.Append("                        <section class=\"cart-consignee\">\r\n");
	                          
	addressdefaultbyuid__loop__id=0;
	foreach(DataRow addressdefaultbyuid_member in getTable("addressdefaultbyuid","["+user_id+"]").Rows)
	{
	if(addressdefaultbyuid__loop__id == 999 && addressdefaultbyuid__loop__id != 0) break;
		addressdefaultbyuid__loop__id++;
	templateBuilder.Append("                            <a href=\"/addresslist.aspx\" class=\"a-address\">\r\n");
	templateBuilder.Append("                              <input type=\"hidden\" id=\"addressid\" value=\"" + addressdefaultbyuid_member["id"].ToString() + "\">\r\n");
	templateBuilder.Append("                              <span class=\"name\">收货人:" + addressdefaultbyuid_member["Name"].ToString() + "&nbsp;&nbsp;" + addressdefaultbyuid_member["Moblie"].ToString() + "&nbsp;&nbsp;<br />" + addressdefaultbyuid_member["AddressInfo"].ToString() + "\r\n");
	templateBuilder.Append("                              " + addressdefaultbyuid_member["PostCode"].ToString() + "\r\n");
	templateBuilder.Append("                              </span>\r\n");
	templateBuilder.Append("                              <span class=\"address\"><b class=\"arrow\">&gt;</b></span>\r\n");
	templateBuilder.Append("                            </a>\r\n");
	templateBuilder.Append("                            <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("                                //alert(1);\r\n");
	templateBuilder.Append("                                $(function () {\r\n");
	templateBuilder.Append("                                    $(\"#noaddress\").hide();\r\n");
	templateBuilder.Append("                                })\r\n");
	templateBuilder.Append("                              </"+"script>\r\n");
	                           
	}	//end loop
	templateBuilder.Append("                              <div id=\"noaddress\"><a href=\"/editaddress.aspx?url=cartstep.aspx\" class=\"a-address\"><span class=\"address\"><b class=\"arrow\">新增收货地址&gt;</b></span>\r\n");
	templateBuilder.Append("                            </a></div>\r\n");
	templateBuilder.Append("                        </section>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("                <div id=\"MainPayType\">\r\n");
	templateBuilder.Append("                    <div id=\"ShowPaymnetType\">\r\n");
	templateBuilder.Append("                        <section class=\"cart-info\">\r\n");
	templateBuilder.Append("                            <ul class=\"cart-info-ul\">\r\n");
	templateBuilder.Append("                                <li class=\"cart-info-li line\">\r\n");
	templateBuilder.Append("                                    <div class=\"label\">\r\n");
	templateBuilder.Append("                                        <label>\r\n");
	templateBuilder.Append("                                            支付方式</label></div>\r\n");
	templateBuilder.Append("                                    <div class=\"value\" id=\"payType\">\r\n");
	templateBuilder.Append("                                        <!--<label class=\"value-pay current\">货到付款</label><label class=\"value-pay\">财付通</label>-->\r\n");
	templateBuilder.Append("                                        <label class=\"value-pay current\" id=\"Alipay_Wap\">\r\n");
	templateBuilder.Append("                                            支付宝</label>\r\n");
	templateBuilder.Append("                                    </div>\r\n");
	templateBuilder.Append("                                </li>\r\n");
	templateBuilder.Append("                               <!-- <li class=\"cart-info-li line\">\r\n");
	templateBuilder.Append("                                    <div class=\"label\">\r\n");
	templateBuilder.Append("                                        <label>\r\n");
	templateBuilder.Append("                                            优惠券</label></div>\r\n");
	templateBuilder.Append("                                    <div class=\"value\">\r\n");
	templateBuilder.Append("                                        <label class=\"value-pay current\">\r\n");
	templateBuilder.Append("                                            1223515412</label><label class=\"value-pay\">13564613</label></div>\r\n");
	templateBuilder.Append("                                </li>-->\r\n");
	templateBuilder.Append("                            </ul>\r\n");
	templateBuilder.Append("                        </section>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <div class=\"clear\">\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <section class=\"cart-prolist\">\r\n");
	templateBuilder.Append("                <h2 class=\"title\">\r\n");
	templateBuilder.Append("                    商品列表</h2>\r\n");
	templateBuilder.Append("                <ul class=\"cart-prolist-ul\">\r\n");
	templateBuilder.Append("\r\n");
	                  
	cart__loop__id=0;
	foreach(DataRow cart_member in getTable("cart","["+username+"],["+guid+"]").Rows)
	{
	if(cart__loop__id == 999 && cart__loop__id != 0) break;
		cart__loop__id++;
	templateBuilder.Append("     \r\n");
	templateBuilder.Append("                    <li class=\"cart-prolist-li\">\r\n");
	templateBuilder.Append("                        <div class=\"pic\">\r\n");
	templateBuilder.Append("                            <a href=\"../../product.aspx?id=" + cart_member["ProductID"].ToString() + "\">\r\n");
	templateBuilder.Append("                                <img src=\"" + cart_member["Src"].ToString() + "\" width=\"120\" height=\"120\" alt=\"产品\"></a>\r\n");
	templateBuilder.Append("                        </div>\r\n");
	templateBuilder.Append("                        <div class=\"info\">\r\n");
	templateBuilder.Append("                            <p class=\"info-name\">\r\n");
	templateBuilder.Append("                                " + cart_member["Name"].ToString() + "<br/>" + cart_member["PropertysText"].ToString() + "\r\n");
	templateBuilder.Append("                            </p>\r\n");
	templateBuilder.Append("                            <p class=\"info-price\">\r\n");
	templateBuilder.Append("                                <span class=\"count\">共 " + cart_member["count"].ToString() + " 件</span><span class=\"price\"> ￥" + cart_member["OrderPrice"].ToString() + "</span></p>\r\n");
	templateBuilder.Append("                        </div>\r\n");
	templateBuilder.Append("                    </li>\r\n");
	     
	}	//end loop
	templateBuilder.Append("\r\n");
	templateBuilder.Append("                </ul>\r\n");
	templateBuilder.Append("                  <ul class=\"cart-prolist-ul\" id=\"newCartItemTotal\">\r\n");
	templateBuilder.Append("                  </ul>\r\n");
	templateBuilder.Append("                <div class=\"total\">\r\n");
	templateBuilder.Append("                    您共需要为订单支付：<span class=\"total-price\">" + orderprice.ToString() + "</span></div>\r\n");
	templateBuilder.Append("            </section>\r\n");
	templateBuilder.Append("            <div class=\"submit\">\r\n");
	templateBuilder.Append("                <div class=\"clear\">\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("                <section class=\"s-btn\">\r\n");
	templateBuilder.Append("                    <button class=\"settle-account\" onclick=\"Submit_Order()\" id=\"butSubmit\">\r\n");
	templateBuilder.Append("                        去结算</button>\r\n");
	templateBuilder.Append("                </section>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("</div> \r\n");
	templateBuilder.Append("    <!--main end-->\r\n");
	templateBuilder.Append("    <div id=\"pay\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</body>\r\n");
	templateBuilder.Append("</html>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\">\r\n");
	templateBuilder.Append("    function Submit_Order() {\r\n");
	templateBuilder.Append("        if ($(\"#addressid\").val() != undefined) {\r\n");
	templateBuilder.Append("            $(\"#butSubmit\").attr(\"disabled\", \"true\");\r\n");
	templateBuilder.Append("            $(\"#butSubmit\").removeClass().addClass(\"settle-disable\");\r\n");
	templateBuilder.Append("            $.ajax({\r\n");
	templateBuilder.Append("                type: \"POST\",\r\n");
	templateBuilder.Append("                url: \"../../cartend.aspx\",\r\n");
	templateBuilder.Append("                data: \"login=yes&addressID=\" + $(\"#addressid\").val(),\r\n");
	templateBuilder.Append("                success: function (msg) {\r\n");
	templateBuilder.Append("                    $(\"#aftersubmittext\").hide();\r\n");
	templateBuilder.Append("                    if (msg.indexOf(\"errMessage:\") != -1) {\r\n");
	templateBuilder.Append("                        alert(msg.substr(11));\r\n");
	templateBuilder.Append("                    }\r\n");
	templateBuilder.Append("                    else {\r\n");
	templateBuilder.Append("                        // alert(msg);\r\n");
	templateBuilder.Append("                        gotoPay(\"<input type='hidden' ordernumber='\" + msg + \"'>\");\r\n");
	templateBuilder.Append("                    }\r\n");
	templateBuilder.Append("                }\r\n");
	templateBuilder.Append("            });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("        } else {\r\n");
	templateBuilder.Append("            alert(\"请先选择收货地址\");\r\n");
	templateBuilder.Append("        }\r\n");
	templateBuilder.Append("    }\r\n");
	templateBuilder.Append("    //    $(\"div[name='orderdetail']\").click(function () {\r\n");
	templateBuilder.Append("    //        var oid = $(this).attr(\"oid\");\r\n");
	templateBuilder.Append("    //        window.location.href = \"../../orderdetail.aspx?oid=\" + oid;\r\n");
	templateBuilder.Append("    //    }\r\n");
	templateBuilder.Append("    //    )\r\n");
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
