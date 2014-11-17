<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.index" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/9/26 13:19:31.
		本页面代码由V5Shop模板引擎生成于 2014/9/26 13:19:31. 
	*/

	base.OnInit(e);
	
	int rollImages__loop__id=0;
	int categoryproduct__loop__id=0;templateBuilder.Append("<!DOCTYPE html>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
	templateBuilder.Append("    <meta charset=\"utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <meta http-equiv=\"x-dns-prefetch-control\" content=\"on\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/tiantianguoyuan/css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/tiantianguoyuan/css/index.css\">\r\n");
	templateBuilder.Append("     <link href=\"../../../member/Css/PreFoot.css\" rel=\"stylesheet\" />\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"../Template/" + path.ToString() + "/js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/" + path.ToString() + "/js/jscommon.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("     <script src=\"../../../member/js/WeiXinShare.js\"></"+"script>\r\n");
	templateBuilder.Append("      <script>\r\n");
	templateBuilder.Append("          $(function () {\r\n");
	templateBuilder.Append("              var title = \"" + OpenTitle.ToString() + "\" + \"" + shoptitle.ToString() + "\";\r\n");
	templateBuilder.Append("              var desc = \"" + OpenDesc1.ToString() + "<br />" + OpenDesc2.ToString() + "\";\r\n");
	templateBuilder.Append("              var url = $(this).attr(\"URL\");\r\n");
	templateBuilder.Append("             var img_url = \"" + logo.ToString() + "\";\r\n");
	templateBuilder.Append("             GetData(url, title, desc, img_url);\r\n");
	templateBuilder.Append("             $(\".share\").click(function () {//分享加载icon三角形\r\n");
	templateBuilder.Append("                 $(this).parent().find(\".arrow\").removeClass(\"arrow\");\r\n");
	templateBuilder.Append("                 $(this).parent().find(\"dd\").removeClass(\"active\");\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("                 $(this).find(\"a\").find(\"span\").addClass(\"arrow\");\r\n");
	templateBuilder.Append("                 $(this).addClass(\"active\");\r\n");
	templateBuilder.Append("             });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("             $(\".sub-nav dd\").click(function () {\r\n");
	templateBuilder.Append("                 if ($(this).attr(\"class\").indexOf(\"share\") < 0) {\r\n");
	templateBuilder.Append("                     $(this).parent().find(\"dd\").removeClass(\"active\");\r\n");
	templateBuilder.Append("                     $(this).parent().find(\".arrow\").removeClass(\"arrow\");\r\n");
	templateBuilder.Append("                     $(this).addClass(\"active\");\r\n");
	templateBuilder.Append("                 }\r\n");
	templateBuilder.Append("             });\r\n");
	templateBuilder.Append("          });\r\n");
	templateBuilder.Append("        </"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("  \r\n");
	templateBuilder.Append("    <header class=\"wx_hd\" id=\"shop-header\">\r\n");
	templateBuilder.Append("        <nav>\r\n");
	templateBuilder.Append("            <h2>" + shoptitle.ToString() + "</h2>\r\n");
	templateBuilder.Append("            <a href=\"index.aspx\" class=\"btn_back\" data-tag=\"go-back\" style=\"display: none;\">返回</a>\r\n");
	templateBuilder.Append("            <a href=\"category.aspx\" class=\"btn_category\" data-tag=\"category\">分类</a>\r\n");
	templateBuilder.Append("        </nav>\r\n");
	templateBuilder.Append("    </header>\r\n");
	templateBuilder.Append("      <!--mask begin-->\r\n");
	templateBuilder.Append("    <div class=\"mask\"></div>\r\n");
	templateBuilder.Append("    <!--mask end-->\r\n");
	    
	if(shopID!="C001" && IsShowMenu){
	templateBuilder.Append("    <div class=\"contFloat\">\r\n");
	templateBuilder.Append("       <i class=\"icon-contHuman\"></i>\r\n");
	templateBuilder.Append("       <a href=\"" + customerUrl.ToString() + "\" target=\"_blank\">联系店主</a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	
	}else{
	    
	if(IsShowMenu){
	templateBuilder.Append("    <div class=\"contFloat\">\r\n");
	templateBuilder.Append("       <a href=\"" + publicImgUrl.ToString() + "\" target=\"_blank\">关注公众号</a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	    
	}	//end if
	
	}	//end if
	templateBuilder.Append("    <section class=\"box\" id=\"banner\">\r\n");
	templateBuilder.Append("        <link rel=\"stylesheet\" type=\"text/css\" href=\"../Template/" + path.ToString() + "/css/scroll.css\">\r\n");
	templateBuilder.Append("<script language=\"javascript\" src=\"../Template/" + path.ToString() + "/js/scroll.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("<div class=\"pfhlkd_frame1\">\r\n");
	templateBuilder.Append("    <div class=\"pfhlkd_mode0  pfhlkd_mf10001000\"></div>\r\n");
	templateBuilder.Append("    <div class=\"pfhlkd_mode0  pfhlkd_mf10001005\"></div>\r\n");
	templateBuilder.Append("    <div class=\"pfhlkd_mode0  pfhlkd_mf10001001\">\r\n");
	templateBuilder.Append("        <div class=\"bd pfhlkd_bd_10\">\r\n");
	templateBuilder.Append("            <div class=\"shop_slider shop_slider_auto mod_pic_mt_1\" data-tag=\"module-slider\" data-height=\"320\">\r\n");
	templateBuilder.Append("                <div class=\"inner\" data-tag=\"slider-warp\" style=\"visibility: visible;\">\r\n");
	templateBuilder.Append("                    <ul class=\"pic_list\" data-tag=\"slider-list\" style=\"width: 2560px;\">\r\n");
	                        
	rollImages__loop__id=0;
	foreach(var rollImages in getTable("rollImages"))
	{
		rollImages__loop__id++;
	 templateBuilder.Append("                            <li data-index=\"0\" style=\"width: 640px; left: 0px; transition: 0ms; -webkit-transition: 0ms; -webkit-transform: translate(640px, 0px) translateZ(0px);\">\r\n");
	templateBuilder.Append("                                 <a href=\"" + rollImages.Hyperlink.ToString() + "\" target=\"_blank\" title=\"图片\">\r\n");
	templateBuilder.Append("                                    <img alt=\"图片\" class=\"pp_init_img\" src=\"" + v5ImageGroupUrl2.ToString() + "" + rollImages.ImageUrl.ToString() + "\"></a></li>\r\n");
	                        
	}	//end loop
	templateBuilder.Append("                    </ul>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("                <div class=\"bar_wrap\">\r\n");
	templateBuilder.Append("                    <ul class=\"bar\" data-tag=\"slider-page\">\r\n");
	templateBuilder.Append("                        <li class=\"\"></li>\r\n");
	templateBuilder.Append("                        <li class=\"cur\"></li>\r\n");
	templateBuilder.Append("                    </ul>\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    </section>\r\n");
	templateBuilder.Append("    <div class=\"logodiv\">\r\n");
	templateBuilder.Append("        <span class=\"logo\">\r\n");
	templateBuilder.Append("            <img src=\"" + logo.ToString() + "\"><i class=\"star\"></i></span>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"pfhlkd_mode0  pfhlkd_mf10001004\">\r\n");
	templateBuilder.Append("        <div class=\"bd pfhlkd_bd_10\">\r\n");
	templateBuilder.Append("            <h2 class=\"mod_tit\">新品推荐</h2>\r\n");
	templateBuilder.Append("            <div class=\"wx_itemlist\" data-lazyload=\"true\">\r\n");
	templateBuilder.Append("                <div class=\"mod_pic_1\">\r\n");
	                    
	categoryproduct__loop__id=0;
	foreach(var categoryproduct in getTable("categoryproduct","["+shopID+"],[A]"))
	{
	if(categoryproduct__loop__id == 999 && categoryproduct__loop__id != 0) break;
		categoryproduct__loop__id++;
	templateBuilder.Append("                    <div class=\"hproduct\">\r\n");
	templateBuilder.Append("                        <p class=\"cover\">\r\n");
	templateBuilder.Append("                            <a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\">\r\n");
	templateBuilder.Append("                                <img class=\"pp_init_img\" src=\"" + categoryproduct.DefaultImageData.ToString() + "\"></a>\r\n");
	templateBuilder.Append("                        </p>\r\n");
	templateBuilder.Append("                        <p class=\"prices\">\r\n");
	templateBuilder.Append("                            <strong><em>￥" + GetCustomerPrice(categoryproduct.SalesPrice.ToString(),categoryproduct.ID.ToString()).ToString() + "</em><del>￥" + categoryproduct.OldPrice.ToString() + "</del></strong>\r\n");
	templateBuilder.Append("                        </p>\r\n");
	templateBuilder.Append("                        <p class=\"fn\"><a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\">" + categoryproduct.ProductName.ToString() + "</a></p>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	                    
	}	//end loop
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <div class=\"pfhlkd_mode0  pfhlkd_mf10001004\">\r\n");
	templateBuilder.Append("        <div class=\"bd pfhlkd_bd_10\">\r\n");
	templateBuilder.Append("            <h2 class=\"mod_tit\">精选推荐</h2>\r\n");
	templateBuilder.Append("            <div class=\"wx_itemlist\" data-lazyload=\"true\">\r\n");
	templateBuilder.Append("                <div class=\"mod_pic_1\">\r\n");
	                    
	categoryproduct__loop__id=0;
	foreach(var categoryproduct in getTable("categoryproduct","["+shopID+"],[B]"))
	{
	if(categoryproduct__loop__id == 999 && categoryproduct__loop__id != 0) break;
		categoryproduct__loop__id++;
	templateBuilder.Append("                    <div class=\"hproduct\">\r\n");
	templateBuilder.Append("                        <p class=\"cover\">\r\n");
	templateBuilder.Append("                            <a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\">\r\n");
	templateBuilder.Append("                                <img class=\"pp_init_img\" src=\"" + categoryproduct.DefaultImageData.ToString() + "\"></a>\r\n");
	templateBuilder.Append("                        </p>\r\n");
	templateBuilder.Append("                        <p class=\"prices\">\r\n");
	templateBuilder.Append("                            <strong><em>￥" + GetCustomerPrice(categoryproduct.SalesPrice.ToString(),categoryproduct.ID.ToString()).ToString() + "</em><del>￥" + categoryproduct.OldPrice.ToString() + "</del></strong>\r\n");
	templateBuilder.Append("                        </p>\r\n");
	templateBuilder.Append("                        <p class=\"fn\"><a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\">" + categoryproduct.ProductName.ToString() + "</a></p>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	                    
	}	//end loop
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <div class=\"pfhlkd_mode0  pfhlkd_mf10001004\">\r\n");
	templateBuilder.Append("        <div class=\"bd pfhlkd_bd_10\">\r\n");
	templateBuilder.Append("            <h2 class=\"mod_tit\">特惠商品</h2>\r\n");
	templateBuilder.Append("            <div class=\"wx_itemlist\" data-lazyload=\"true\">\r\n");
	templateBuilder.Append("                <div class=\"mod_pic_1\">\r\n");
	                    
	categoryproduct__loop__id=0;
	foreach(var categoryproduct in getTable("categoryproduct","["+shopID+"],[C]"))
	{
	if(categoryproduct__loop__id == 999 && categoryproduct__loop__id != 0) break;
		categoryproduct__loop__id++;
	templateBuilder.Append("                    <div class=\"hproduct\">\r\n");
	templateBuilder.Append("                        <p class=\"cover\">\r\n");
	templateBuilder.Append("                            <a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\">\r\n");
	templateBuilder.Append("                                <img class=\"pp_init_img\" src=\"" + categoryproduct.DefaultImageData.ToString() + "\"></a>\r\n");
	templateBuilder.Append("                        </p>\r\n");
	templateBuilder.Append("                        <p class=\"prices\">\r\n");
	templateBuilder.Append("                            <strong><em>￥" + GetCustomerPrice(categoryproduct.SalesPrice.ToString(),categoryproduct.ID.ToString()).ToString() + "</em><del>￥" + categoryproduct.OldPrice.ToString() + "</del></strong>\r\n");
	templateBuilder.Append("                        </p>\r\n");
	templateBuilder.Append("                        <p class=\"fn\"><a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\">" + categoryproduct.ProductName.ToString() + "</a></p>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	                    
	}	//end loop
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    \r\n");
	templateBuilder.Append("    \r\n");
	templateBuilder.Append("    <a href=\"javascript:void(0);\" class=\"WX_backtop J_backTop J_ytag \"\r\n");
	templateBuilder.Append("        id=\"gotopbtn\">返回顶部</a>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("        //注册当点击返回顶部的时候，回到网页顶部  \r\n");
	templateBuilder.Append("        $('#gotopbtn').click(function () {\r\n");
	templateBuilder.Append("            $('body').scrollTop(0);\r\n");
	templateBuilder.Append("            test();\r\n");
	templateBuilder.Append("        });\r\n");
	templateBuilder.Append("        //注册当页面发生滚动事件的时候，判断他有没有滚动条，如果有滚动条就显示“返回”，如果没有就不返回  \r\n");
	templateBuilder.Append("        window.onscroll = test;\r\n");
	templateBuilder.Append("        function test() {\r\n");
	templateBuilder.Append("            if ($('body').scrollTop() == 0) {\r\n");
	templateBuilder.Append("                $('#gotopbtn').removeClass(\"WX_backtop_active\");\r\n");
	templateBuilder.Append("            } else {\r\n");
	templateBuilder.Append("                $('#gotopbtn').addClass(\"WX_backtop_active\");\r\n");
	templateBuilder.Append("            }\r\n");
	templateBuilder.Append("        }\r\n");
	templateBuilder.Append("        $('#menu').click(function () {\r\n");
	templateBuilder.Append("            $('#menulist').toggle();\r\n");
	templateBuilder.Append("        });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("    <div class=\"h50\"></div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("     <div class=\"fixed bottom\">\r\n");
	templateBuilder.Append("     <div class=\"shareList\" style=\"display: none;\">\r\n");
	templateBuilder.Append("    <ul class=\"small-block-grid-4\" id=\"sharelist\">\r\n");
	templateBuilder.Append("        <li shareid=\"tsina\"><i class=\"icon-sina\"></i><span class=\"name\">新浪微博</span></li>\r\n");
	templateBuilder.Append("        <li shareid=\"qzone\"><i class=\"icon-qqzone\"></i><span class=\"name\">QQ空间</span></li>\r\n");
	templateBuilder.Append("        <li shareid=\"tqq\"><i class=\"icon-txwb\"></i><span class=\"name\">腾讯微博</span></li>\r\n");
	templateBuilder.Append("        <li class=\"no-line\" shareid=\"xiaoyou\"><i class=\"icon-friend\"></i><span class=\"name\">朋友网</span></li>\r\n");
	templateBuilder.Append("        <li shareid=\"ydnote\"><i class=\"icon-youdao\"></i><span class=\"name\">有道云笔记</span></li>\r\n");
	templateBuilder.Append("    </ul>\r\n");
	templateBuilder.Append("</div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("<script>\r\n");
	templateBuilder.Append("    $(document).ready(function () {\r\n");
	templateBuilder.Append("        $(\"#share-a\").click(function () {\r\n");
	templateBuilder.Append("            $(\".shareList\").slideToggle(\"slow\");\r\n");
	templateBuilder.Append("            $(\".mask\").toggle();\r\n");
	templateBuilder.Append("        })\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    })\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    $(\"#sharelist li\").click(function () {\r\n");
	templateBuilder.Append("        var shareurl = \"" + shopUrl.ToString() + "index.aspx\";\r\n");
	templateBuilder.Append("        var title = \"我的微店:" + shoptitle.ToString() + "\";\r\n");
	templateBuilder.Append("        var shareid = $(this).attr(\"shareid\");\r\n");
	templateBuilder.Append("        window.location.href = \"http://www.jiathis.com/send/?webid=\" + shareid + \"&url=\" + shareurl + \"&title=\" + title + \"&shortUrl=false&hideMore=false\";\r\n");
	templateBuilder.Append("    })\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("</"+"script>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("        <dl class=\"sub-nav nav-b4\">\r\n");
	    
	if(IsDRP ){
	  templateBuilder.Append("            <dd class=\"share\"><a href=\"javascript:void(0);\" id=\"share-a\"><i class=\"icon-share\"></i>分享店铺<span></span></a></dd>\r\n");
	templateBuilder.Append("    <dd class=\"active\"><a href=\"index.aspx\"><i class=\"icon-store\"></i>逛店铺</a></dd>\r\n");
	    
	if(IsMyShop ){
	  templateBuilder.Append("              <dd><a href=\"member/brokerage.aspx\"><i class=\"icon-commision\"></i>我的佣金</a></dd>\r\n");
	    
	}else{
	templateBuilder.Append("           <dd><a href=\"../" + MyShopID.ToString() + "/index.aspx\"><i class=\"icon-commision\"></i>我的微店</a></dd>\r\n");
	    
	}	//end if
	templateBuilder.Append("           <dd><a href=\"member/member.aspx\"><i class=\"icon-member\"></i>会员中心</a></dd>\r\n");
	    
	}else{
	              
	if(shopID=="C001" ){
	templateBuilder.Append("           <dd class=\"share\"><a href=\"javascript:void(0);\" id=\"share-a\"><i class=\"icon-share\"></i>分享店铺<span></span></a></dd>\r\n");
	templateBuilder.Append("    <dd class=\"active\"><a href=\"index.aspx\"><i class=\"icon-store\"></i>逛店铺</a></dd>\r\n");
	templateBuilder.Append("    <!-- <dd><a href=\"member/AddStore.aspx\"><i class=\"icon-distribusion\"></i>我要分销</a></dd>-->\r\n");
	templateBuilder.Append("    <dd ><a href=\"member/member.aspx\"><i class=\"icon-member\"></i>会员中心</a></dd>\r\n");
	templateBuilder.Append("\r\n");
	    
	}else{
	templateBuilder.Append("            <dd class=\"share\"><a href=\"javascript:void(0);\" id=\"share-a\"><i class=\"icon-share\"></i>分享店铺<span></span></a></dd>\r\n");
	templateBuilder.Append("    <dd class=\"active\"><a href=\"index.aspx\"><i class=\"icon-store\"></i>逛店铺</a></dd>\r\n");
	templateBuilder.Append("    <dd><a href=\"cart.aspx\"><i class=\"icon-distribusion\"></i>购物车</a></dd>\r\n");
	templateBuilder.Append("    <dd><a href=\"member/member.aspx\"><i class=\"icon-member\"></i>会员中心</a></dd>\r\n");
	    
	}	//end if
	             
	}	//end if
	templateBuilder.Append("</dl>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("           </div>\r\n");
	templateBuilder.Append("    <style>\r\n");
	templateBuilder.Append("    /*待删除*/\r\n");
	templateBuilder.Append("    .sub-nav.nav-b4 dd a\r\n");
	templateBuilder.Append("    {\r\n");
	templateBuilder.Append("        color: #999999;\r\n");
	templateBuilder.Append("    }\r\n");
	templateBuilder.Append("</style>\r\n");
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
