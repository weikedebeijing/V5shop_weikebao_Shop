<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.index" %>
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
	
	int category__loop__id=0;
	int categoryproduct__loop__id=0;templateBuilder.Append("<!DOCTYPE html>\r\n");
	templateBuilder.Append("<html lang=\"zh-CN\">\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\">\r\n");
	templateBuilder.Append("    <meta charset=\"utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <meta http-equiv=\"x-dns-prefetch-control\" content=\"on\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/distribution/foundation/css/normalize.css\">\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"../Template/" + path.ToString() + "/js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/" + path.ToString() + "/js/jscommon.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"../Template/" + path.ToString() + "/css/mall.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/distribution/css/PreFoot.css\">\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <script src=\"../../../member/js/WeiXinShare.js\"></"+"script>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <script>\r\n");
	templateBuilder.Append("        $(function () {\r\n");
	templateBuilder.Append("            var title = \"" + OpenTitle.ToString() + "\" + \"" + shoptitle.ToString() + "\";\r\n");
	templateBuilder.Append("            var desc = \"" + OpenDesc1.ToString() + "<br />" + OpenDesc2.ToString() + "\";\r\n");
	templateBuilder.Append("            var url = $(this).attr(\"URL\");\r\n");
	templateBuilder.Append("           var img_url = \"" + logo.ToString() + "\";\r\n");
	templateBuilder.Append("            GetData(url, title, desc, img_url);\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("            $(\".share\").click(function () {//分享加载icon三角形\r\n");
	templateBuilder.Append("                $(this).parent().find(\".arrow\").removeClass(\"arrow\");\r\n");
	templateBuilder.Append("                $(this).parent().find(\"dd\").removeClass(\"active\");\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("                $(this).find(\"a\").find(\"span\").addClass(\"arrow\");\r\n");
	templateBuilder.Append("                $(this).addClass(\"active\");\r\n");
	templateBuilder.Append("            });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("            $(\".sub-nav dd\").click(function () {\r\n");
	templateBuilder.Append("                if ($(this).attr(\"class\").indexOf(\"share\") < 0) {\r\n");
	templateBuilder.Append("                    $(this).parent().find(\"dd\").removeClass(\"active\");\r\n");
	templateBuilder.Append("                    $(this).parent().find(\".arrow\").removeClass(\"arrow\");\r\n");
	templateBuilder.Append("                    $(this).addClass(\"active\");\r\n");
	templateBuilder.Append("                }\r\n");
	templateBuilder.Append("            });\r\n");
	templateBuilder.Append("        });\r\n");
	templateBuilder.Append("        </"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("     <!--mask begin-->\r\n");
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
	templateBuilder.Append("    <!--mask begin-->\r\n");
	templateBuilder.Append("    <div class=\"WX_mask\" style=\"display: none;\" id=\"mask\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <!--mask end-->\r\n");
	templateBuilder.Append("    <div class=\"WX_bar J_topbar\" id=\"top1\">\r\n");
	templateBuilder.Append("        <div class=\"WX_cat J_smenu\">\r\n");
	templateBuilder.Append("            <div class=\"WX_cat_btn J_smenu_btn J_ytag\" id=\"menu\">\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <div class=\"WX_cat_pop WX_cat_list J_smenu_list\" id=\"menulist\" style=\"display: none\" id=\"top2\">\r\n");
	templateBuilder.Append("                <i class=\"WX_cat_btn-arrow\"></i>\r\n");
	                
	category__loop__id=0;
	foreach(var category in getTable("category","["+shopID+"]"))
	{
	if(category__loop__id == 999 && category__loop__id != 0) break;
		category__loop__id++;
	 templateBuilder.Append("                <a href=\"index.aspx?cid=" + category.ID.ToString() + "&name=" + category.Name.ToString() + "\"\r\n");
	templateBuilder.Append("                    class=\"J_ytag WX_cat_sp\">" + category.Name.ToString() + "</a><!--00101-00199 -->\r\n");
	                
	}	//end loop
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"WX_nav\">\r\n");
	templateBuilder.Append("            <a class=\"on\" href=\"index.aspx?cid=A\" id=\"xpTab\">新品</a> <a href=\"index.aspx?cid=B\"\r\n");
	templateBuilder.Append("                id=\"jxTab\" class=\"J_ytag\">精选</a> <a href=\"index.aspx?cid=C\" id=\"thTab\" class=\"J_ytag\">特惠</a>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"WX_me J_me\">\r\n");
	templateBuilder.Append("            <div class=\"WX_me_btn J_meTrigger J_ytag\" onclick=\"javascript:window.location.href='member/Member.aspx'\">\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"WX_bar\" style=\"display: none\" id=\"top2\">\r\n");
	templateBuilder.Append("        <div class=\"WX_bar_back\">\r\n");
	templateBuilder.Append("            <a ytag=\"19999\" class=\"J_ytag\" href=\"index.aspx\"></a>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("        <div class=\"WX_bar_tit\">\r\n");
	templateBuilder.Append("            <div class=\"WX_sx\">\r\n");
	templateBuilder.Append("                <h1 class=\"WX_bar_tit\">" + name.ToString() + "</h1>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("        var cid = '" + cid.ToString() + "';\r\n");
	templateBuilder.Append("        switch (cid) {\r\n");
	templateBuilder.Append("            case \"A\":\r\n");
	templateBuilder.Append("                $(\"#xpTab\").removeClass(\"J_ytag\").addClass(\"on\");\r\n");
	templateBuilder.Append("                $(\"#jxTab\").removeClass(\"on\").addClass(\"J_ytag\");\r\n");
	templateBuilder.Append("                $(\"#thTab\").removeClass(\"on\").addClass(\"J_ytag\");\r\n");
	templateBuilder.Append("                break;\r\n");
	templateBuilder.Append("            case \"B\":\r\n");
	templateBuilder.Append("                $(\"#xpTab\").removeClass(\"on\").addClass(\"J_ytag\");\r\n");
	templateBuilder.Append("                $(\"#jxTab\").removeClass(\"J_ytag\").addClass(\"on\");\r\n");
	templateBuilder.Append("                $(\"#thTab\").removeClass(\"on\").addClass(\"J_ytag\");\r\n");
	templateBuilder.Append("                break;\r\n");
	templateBuilder.Append("            case \"C\":\r\n");
	templateBuilder.Append("                $(\"#xpTab\").removeClass(\"on\").addClass(\"J_ytag\");\r\n");
	templateBuilder.Append("                $(\"#jxTab\").removeClass(\"on\").addClass(\"J_ytag\");\r\n");
	templateBuilder.Append("                $(\"#thTab\").removeClass(\"J_ytag\").addClass(\"on\");\r\n");
	templateBuilder.Append("                break;\r\n");
	templateBuilder.Append("            case \"0\":\r\n");
	templateBuilder.Append("                break;\r\n");
	templateBuilder.Append("            default:\r\n");
	templateBuilder.Append("                $(\"#top1\").hide();\r\n");
	templateBuilder.Append("                $(\"#top2\").show();\r\n");
	templateBuilder.Append("                break;\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("        }\r\n");
	templateBuilder.Append("        //        if (id != \"\") {\r\n");
	templateBuilder.Append("        //           \r\n");
	templateBuilder.Append("        //        }\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("    <div class=\"WX_con\" id=\"J_main\">\r\n");
	templateBuilder.Append("        <div class=\"jx\">\r\n");
	templateBuilder.Append("            <div class=\"jx_list\">\r\n");
	                
	categoryproduct__loop__id=0;
	foreach(var categoryproduct in getTable("categoryproduct","["+shopID+"],["+cid+"]"))
	{
	if(categoryproduct__loop__id == 999 && categoryproduct__loop__id != 0) break;
		categoryproduct__loop__id++;
	templateBuilder.Append("                <div class=\"jx_g\">\r\n");
	templateBuilder.Append("                    <div class=\"jx_g_img\">\r\n");
	templateBuilder.Append("                        <a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\" class=\"J_bi_product_item J_ytag\"\r\n");
	templateBuilder.Append("                            data-dap=\"\" data-pid=\"561592\">\r\n");
	templateBuilder.Append("                            <img class=\"\" src=\"" + categoryproduct.DefaultImageData.ToString() + "\">\r\n");
	templateBuilder.Append("                        </a>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                    <div class=\"jx_g_info\">\r\n");
	templateBuilder.Append("                        <p class=\"jx_g_title\">\r\n");
	templateBuilder.Append("                            <a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\" class=\"J_bi_product_item J_ytag\"\r\n");
	templateBuilder.Append("                                data-dap=\"\" data-pid=\"561592\">" + categoryproduct.ProductName.ToString() + "</a>\r\n");
	templateBuilder.Append("                        </p>\r\n");
	templateBuilder.Append("                        <p class=\"jx_g_price\">\r\n");
	templateBuilder.Append("                            <span class=\"jx_g_price_wx\">惊爆价<span><i>￥</i>" + GetCustomerPrice(categoryproduct.SalesPrice.ToString(),categoryproduct.ID.ToString()).ToString() + "</span>\r\n");
	templateBuilder.Append("                            </span><del class=\"jx_g_price_market\">市场价￥" + categoryproduct.OldPrice.ToString() + "</del>\r\n");
	templateBuilder.Append("                        </p>\r\n");
	templateBuilder.Append("                        <a href=\"product.aspx?id=" + categoryproduct.ID.ToString() + "\" class=\"WX_btn jx_g_btn J_bi_product_item J_ytag\"\r\n");
	templateBuilder.Append("                            data-dap=\"\" data-pid=\"561592\">立即购买</a>\r\n");
	templateBuilder.Append("                    </div>\r\n");
	templateBuilder.Append("                </div>\r\n");
	                
	}	//end loop
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <div class=\"jx_map\">\r\n");
	templateBuilder.Append("                <div class=\"jx_map_hd\">\r\n");
	templateBuilder.Append("                    主题卖场\r\n");
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("                <div class=\"jx_map_bd WX_cat_list\">\r\n");
	                    
	category__loop__id=0;
	foreach(var category in getTable("category","["+shopID+"]"))
	{
	if(category__loop__id == 999 && category__loop__id != 0) break;
		category__loop__id++;
	 templateBuilder.Append("                    <a href=\"index.aspx?cid=" + category.ID.ToString() + "&name=" + category.Name.ToString() + "\"\r\n");
	templateBuilder.Append("                        class=\"J_ytag WX_cat_sp\">" + category.Name.ToString() + "</a><!--00101-00199 -->\r\n");
	                    
	}	//end loop
	templateBuilder.Append("                </div>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("          \r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("     \r\n");
	templateBuilder.Append("    \r\n");
	templateBuilder.Append("    <a href=\"javascript:void(0);\" class=\"WX_backtop J_backTop J_ytag \"\r\n");
	templateBuilder.Append("        ytag=\"09999\" id=\"gotopbtn\">返回顶部</a>\r\n");
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
	templateBuilder.Append("            $('#mask').toggle();\r\n");
	templateBuilder.Append("        });\r\n");
	templateBuilder.Append("        //点击空白层，关闭菜单\r\n");
	templateBuilder.Append("        document.querySelector('#mask').addEventListener('touchstart', function (e) {\r\n");
	templateBuilder.Append("            $('#menulist').toggle();\r\n");
	templateBuilder.Append("            $('#mask').toggle();\r\n");
	templateBuilder.Append("        })\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("     <div class=\"h50\"></div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <div class=\"fixed bottom\">\r\n");
	templateBuilder.Append("        <div class=\"shareList\" style=\"display: none;\">\r\n");
	templateBuilder.Append("    <ul class=\"small-block-grid-4\" id=\"sharelist\">\r\n");
	templateBuilder.Append("        <li shareid=\"tsina\"><i class=\"icon-sina\"></i><span class=\"name\">新浪微博</span></li>\r\n");
	templateBuilder.Append("        <li shareid=\"qzone\"><i class=\"icon-qqzone\"></i><span class=\"name\">QQ空间</span></li>\r\n");
	templateBuilder.Append("        <li shareid=\"tqq\"><i class=\"icon-txwb\"></i><span class=\"name\">腾讯微博</span></li>\r\n");
	templateBuilder.Append("        <li class=\"no-line\" shareid=\"xiaoyou\"><i class=\"icon-renren\"></i><span class=\"name\">朋友网</span></li>\r\n");
	templateBuilder.Append("        <li shareid=\"ydnote\"><i class=\"icon-renren\"></i><span class=\"name\">有道云笔记</span></li>\r\n");
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
	  templateBuilder.Append("            <dd class=\"share\"><a href=\"javascript:void(0)\" id=\"share-a\"><i class=\"icon-share\"></i>分享店铺<span></span></a></dd>\r\n");
	templateBuilder.Append("            <dd class=\"active\"><a href=\"javascript:void(0)\"><i class=\"icon-store\"></i>逛店铺</a></dd>\r\n");
	templateBuilder.Append("            <dd><a href=\"member/brokerage.aspx\"><i class=\"icon-commision\"></i>我的佣金</a></dd>\r\n");
	templateBuilder.Append("            <dd><a href=\"member/member.aspx\"><i class=\"icon-member\"></i>会员中心</a></dd>\r\n");
	            
	}else{
	              
	if(shopID=="C001" ){
	templateBuilder.Append("            <dd class=\"share\"><a href=\"javascript:void(0)\" id=\"share-a\"><i class=\"icon-share\"></i>分享店铺<span></span></a></dd>\r\n");
	templateBuilder.Append("       <dd class=\"active\"><a href=\"javascript:void(0)\"><i class=\"icon-store\"></i>逛店铺</a></dd>\r\n");
	templateBuilder.Append("            <dd><a href=\"member/AddStore.aspx\"><i class=\"icon-distribusion\"></i>我要分销</a></dd>\r\n");
	templateBuilder.Append("            <dd><a href=\"member/member.aspx\"><i class=\"icon-member\"></i>会员中心</a></dd>\r\n");
	templateBuilder.Append("\r\n");
	            
	}else{
	templateBuilder.Append("            <dd class=\"share\"><a href=\"javascript:void(0)\" id=\"share-a\"><i class=\"icon-share\"></i>分享店铺</a></dd>\r\n");
	templateBuilder.Append("             <dd class=\"active\"><a href=\"javascript:void(0)\"><i class=\"icon-store\"></i>逛店铺</a></dd>\r\n");
	templateBuilder.Append("            <dd><a href=\"cart.aspx\"><i class=\"icon-distribusion\"></i>购物车</a></dd>\r\n");
	templateBuilder.Append("            <dd><a href=\"member/member.aspx\"><i class=\"icon-member\"></i>会员中心</a></dd>\r\n");
	            
	}	//end if
	             
	}	//end if
	templateBuilder.Append("        </dl>\r\n");
	templateBuilder.Append("    </div>\r\n");
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
