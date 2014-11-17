<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.cartend" %>
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
	
	int helpcategorysearch__loop__id=0;
	int helpsearchbyid__loop__id=0;templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTmL 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
	templateBuilder.Append("<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n");
	templateBuilder.Append("<head><base href=\"http://192.168.1.105:8082/template/version_9/\" />\r\n");
	templateBuilder.Append("    <meta content=\"text/html;charset=utf-8\" http-equiv=\"Content-Type\" />\r\n");
	templateBuilder.Append("    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=Edge\" />\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("<meta name=\"keywords\" content=\"" + keywords.ToString() + "\" />\r\n");
	templateBuilder.Append("<meta name=\"description\" content=\"" + description.ToString() + "\" />\r\n");
	templateBuilder.Append("    <link href=\"css/common.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <link href=\"css/color_red.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <link href=\"css/size_960.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <link href=\"css/navigation.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <link href=\"css/floatsort.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <link href=\"css/floatcart.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <link href=\"css/cohelp.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <link href=\"css/copyright.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <link href=\"css/cart.css\" type=\"text/css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/jquery.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("        var path = 'http://192.168.1.105:8082/';\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/common.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/cartend.js\" type=\"text/javascript\"></"+"script>\r\n");
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
	templateBuilder.Append("    <div class=\"mainwidth mauto mt10 mb10\">\r\n");
	templateBuilder.Append("    <div class=\"layout pt10\">\r\n");
	templateBuilder.Append("        <div class=\"order-flow02\">\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div id=\"OrderDiv\" class=\"bxSty dingdan mb10\" align=\"center\">\r\n");
	templateBuilder.Append("        <div class=\"dingdanHead\">\r\n");
	templateBuilder.Append("            <img src=\"images/cart/pic_gongxi.gif\">\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div id=\"OrderList\" class=\"dingdanList\">\r\n");
	templateBuilder.Append("            <div class=\"listHead\">\r\n");
	templateBuilder.Append("                <ul>\r\n");
	templateBuilder.Append("                    <li class=\"liheight\" style=\"border-left: 1px solid rgb(216, 216, 216);\">订单号</li>\r\n");
	templateBuilder.Append("                    <li id=\"dollarHead\" class=\"liheight\">需支付金额（元）</li>\r\n");
	templateBuilder.Append("                    <li class=\"liheight\">配送方式</li>\r\n");
	templateBuilder.Append("                    <li class=\"liheight\" style=\"border-right: 1px solid rgb(216, 216, 216);\">支付方式</li>\r\n");
	templateBuilder.Append("                </ul>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <div class=\"listHead listCon\">\r\n");
	templateBuilder.Append("                <ul>\r\n");
	templateBuilder.Append("                    <li class=\"liheight\" style=\"border-left: 1px solid rgb(216, 216, 216);\">" + orderid.ToString() + "</li>\r\n");
	templateBuilder.Append("                    <li id=\"dollarBody0\" class=\"liheight\"><span>" + orderprice.ToString() + "</span> 元 </li>\r\n");
	templateBuilder.Append("                    <li class=\"liheight\">" + deliname.ToString() + "</li>\r\n");
	templateBuilder.Append("                    <li class=\"liheight\">" + payname.ToString() + "</li>\r\n");
	templateBuilder.Append("                </ul>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <span class=\"blank0\"></span>\r\n");
	templateBuilder.Append("        <div class=\"shopping_word\" style=\"position: relative; z-index: 1;\">\r\n");
	templateBuilder.Append("           <!-- <p id=\"OrderWord\" style=\"text-align: center;\">\r\n");
	templateBuilder.Append("                已选择付款方式：\r\n");
	templateBuilder.Append("            </p>-->\r\n");
	templateBuilder.Append("            <p class=\"t_c\">\r\n");
	templateBuilder.Append("               <a style=\"text-decoration: none; background: url(images/gb_btn_dot.png) repeat-x scroll left -260px transparent; display: inline-block; height: 26px; color: rgb(255, 255, 255); width: 100px;\" href=\"javascript:void(0)\" onclick=\"payClick()\">立即付款</a>\r\n");
	               
	if(payState== "true"){
	templateBuilder.Append("               " + paystr.ToString() + "\r\n");
	               
	}	//end if
	templateBuilder.Append("            </p>\r\n");
	templateBuilder.Append("            <p id=\"newSpanDes\" style=\"float: left; text-align: left;\">\r\n");
	templateBuilder.Append("                <span>(未支付的订单将为您保留24小时，在收到全部订单金额后，我们将尽快安排发货)</span>\r\n");
	templateBuilder.Append("            </p>\r\n");
	templateBuilder.Append("            <div class=\"Online_payment\" style=\"z-index: 2; display: none\">\r\n");
	templateBuilder.Append("                <h2 class=\"msgboxhead\">\r\n");
	templateBuilder.Append("                    <span>您正在进行的在线支付</span>\r\n");
	templateBuilder.Append("                    <p class=\"msgboxhead_close\">\r\n");
	templateBuilder.Append("                        <a class=\"whiteff\" onclick=\"HideOnlinepaymentDiv()\" href=\"javascript:void(0);\">\r\n");
	templateBuilder.Append("                            <img src=\"https://sslimg.vancl.com/shopping/onlinepay/dpbox_06.gif\">\r\n");
	templateBuilder.Append("                            关闭 </a>\r\n");
	templateBuilder.Append("                    </p>\r\n");
	templateBuilder.Append("                </h2>\r\n");
	templateBuilder.Append("                <p class=\"zftitleBg\">\r\n");
	templateBuilder.Append("                    请在新开的网银页面完成支付后选择：</p>\r\n");
	templateBuilder.Append("                <div class=\"payment_PopupInfon\">\r\n");
	templateBuilder.Append("                    <span class=\"blank10\"></span>\r\n");
	templateBuilder.Append("                    <div class=\"zfsb_tipsinfo\">\r\n");
	templateBuilder.Append("                        <b style=\"font-weight: bold;\">支付成功：</b>\r\n");
	templateBuilder.Append("                        <ul>\r\n");
	templateBuilder.Append("                            <li><a href=\"http://192.168.1.105:8082/orderdetail.aspx?id=" + orderid.ToString() + "\" target=\"_blank\" class=\"reda10\">\r\n");
	templateBuilder.Append("                                订单详情</a><span class=\"fredline\">|</span></li>\r\n");
	templateBuilder.Append("                            <li><a href=\"http://192.168.1.105:8082/index.aspx\" target=\"_blank\" class=\"reda10\">继续购物</a></li>\r\n");
	templateBuilder.Append("                        </ul>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                    <span class=\"blank10\"></span>\r\n");
	templateBuilder.Append("                    <div class=\"zfsb_tipsinfo\">\r\n");
	templateBuilder.Append("                        <b style=\"font-weight: bold;\">支付失败：</b>\r\n");
	templateBuilder.Append("                        <ul>\r\n");
	templateBuilder.Append("                            <li><a id=\"repay\" class=\"reda10\" href=\"http://192.168.1.105:8082/orderdetail.aspx?id=" + orderid.ToString() + "\" target=\"_blank\">\r\n");
	templateBuilder.Append("                                重新支付</a></li>\r\n");
	templateBuilder.Append("                            <li></li>\r\n");
	templateBuilder.Append("                        </ul>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                    <span class=\"blank10\"></span>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <span class=\"clear\"></span>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"nowPayArea\">\r\n");
	templateBuilder.Append("            <div style=\"border-bottom: 1px solid rgb(227, 227, 227);\">\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <p style=\"font-size: 10.5pt; font-weight: bold; text-align: right; line-height: 50px;\">\r\n");
	templateBuilder.Append("                <a class=\"track\" name=\"sp_cart_complete_order_details\" target=\"_blank\" href=\"http://192.168.1.105:8082/member/useradmin/OrderDetail.aspx?id=" + orderid.ToString() + "\">\r\n");
	templateBuilder.Append("                    订单详情</a> | <a class=\"track\" name=\"sp_cart_complete_go_on_shopping\" target=\"_blank\"\r\n");
	templateBuilder.Append("                        href=\"http://192.168.1.105:8082/index.aspx\">继续采购</a>\r\n");
	templateBuilder.Append("            </p>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <!--main end-->\r\n");
	templateBuilder.Append("    <!--foot begin-->\r\n");
	templateBuilder.Append("    <div class=\"foot1\">\r\n");
	templateBuilder.Append("        <!--cohelp begin-->\r\n");
	templateBuilder.Append("            <div class=\"cohelp\">\r\n");
	templateBuilder.Append("    <div class=\"mainwidth mauto\">\r\n");
	templateBuilder.Append("        <div class=\"clear\">\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"mt20\">\r\n");
	templateBuilder.Append("            <div style=\"margin: 0 auto; width:600px; height:auto;\">\r\n");
	templateBuilder.Append("                <table class=\"cohelpTable\">\r\n");
	templateBuilder.Append("                    <tr style=\" font-size:14px; font-weight:bold;\">\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            购物流程\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            支付方式\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            帮助中心\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            售后服务\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                    </tr>\r\n");
	templateBuilder.Append("                    <tr>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            购物指南\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            支付方式\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            免费注册\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            品牌授权\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                    </tr>\r\n");
	templateBuilder.Append("                    <tr>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            常见问题\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            代金券\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            支付帮助\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                        <td>\r\n");
	templateBuilder.Append("                            退款政策\r\n");
	templateBuilder.Append("                        </td>\r\n");
	templateBuilder.Append("                    </tr>\r\n");
	templateBuilder.Append("                </table>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"foothelp\">\r\n");
	templateBuilder.Append("            \r\n");
	
	helpcategorysearch__loop__id=0;
	foreach(DataRow helpcategorysearch_member in getTable("helpcategorysearch","[id]$[name]").Rows)
	{
	if(helpcategorysearch__loop__id == 99 && helpcategorysearch__loop__id != 0) break;
		helpcategorysearch__loop__id++;
	templateBuilder.Append(" <dl>\r\n");
	templateBuilder.Append("          <dt>\r\n");
	templateBuilder.Append("             " + left(helpcategorysearch_member["name"].ToString(),12) + "\r\n");
	templateBuilder.Append("          </dt>\r\n");
	templateBuilder.Append("         \r\n");
	
	helpsearchbyid__loop__id=0;
	foreach(DataRow helpsearchbyid_member in getTable("helpsearchbyid","["+helpcategorysearch_member["id"]+"],[id]$[title]").Rows)
	{
	if(helpsearchbyid__loop__id == 99 && helpsearchbyid__loop__id != 0) break;
		helpsearchbyid__loop__id++;
	templateBuilder.Append("<dd><a target=\"_blank\" href=\"http://192.168.1.105:8082/help.aspx?id=" + helpsearchbyid_member["id"].ToString() + "\">" + left(helpsearchbyid_member["title"].ToString(),12) + "</a></dd>\r\n");
	
	}	//end loop
	templateBuilder.Append("\r\n");
	templateBuilder.Append("</dl>\r\n");
	
	}	//end loop
	templateBuilder.Append("\r\n");
	templateBuilder.Append("            <div class=\"clear\">\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("        <!--cohelp end-->\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"foot2\">\r\n");
	templateBuilder.Append("        <!--copyright  begin-->\r\n");
	templateBuilder.Append("        <div class=\"foot2\">\r\n");
	templateBuilder.Append("            <!--copyright  begin-->\r\n");
	templateBuilder.Append("            <div class=\"copyright\">\r\n");
	templateBuilder.Append("                  <div class=\"copyright\">\r\n");
	templateBuilder.Append("<div class=\"mainwidth mauto\">\r\n");
	templateBuilder.Append("      <div>" + copyright.ToString() + "</div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <!--copyright  end-->\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <!--copyright  end-->\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <!--foot end-->\r\n");
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
