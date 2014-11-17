<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.list" %>
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
	
	int categoryproduct__loop__id=0;templateBuilder.Append("<!DOCTYPE html>\r\n");
	templateBuilder.Append("<html class=\"page_index\" lang=\"zh-CN\">\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=GBK\">\r\n");
	templateBuilder.Append("    <meta charset=\"gbk\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <meta name=\"language\" content=\"zh-CN\" data-author=\"julying\">\r\n");
	templateBuilder.Append("    <meta http-equiv=\"x-dns-prefetch-control\" content=\"on\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/tiantianguoyuan/css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/tiantianguoyuan/css/index.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/tiantianguoyuan/css/scroll.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/distribution/css/PreFoot.css\">\r\n");
	templateBuilder.Append("    <script src=\"js/scroll.js\"></"+"script>\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body data-page-type=\"shop-home\">\r\n");
	templateBuilder.Append("    <header class=\"wx_hd\">\r\n");
	templateBuilder.Append("        <nav>\r\n");
	templateBuilder.Append("            <h2 id=\"searchKeyWord\">" + name.ToString() + "</h2>\r\n");
	templateBuilder.Append("            <a id=\"backBtn\" class=\"btn_back\" href=\"javascript:void(0)\" onclick=\"window.history.go(-1)\">返回</a>\r\n");
	templateBuilder.Append("            <a id=\"categoryBtn\" class=\"btn_category\" href=\"category.aspx\">分类</a>\r\n");
	templateBuilder.Append("        </nav>\r\n");
	templateBuilder.Append("    </header>\r\n");
	templateBuilder.Append("    <div class=\"bd pfhlkd_bd_10\">\r\n");
	templateBuilder.Append("        <div class=\"wx_itemlist\" data-lazyload=\"true\">\r\n");
	templateBuilder.Append("            <div class=\"mod_pic_1\">\r\n");
	                
	categoryproduct__loop__id=0;
	foreach(var categoryproduct in getTable("categoryproduct","["+shopID+"],["+cid+"]"))
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
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <!--common-->\r\n");
	templateBuilder.Append("    <footer>\r\n");
	templateBuilder.Append("        <span class=\"explain\">技术支持：</span><img src=\"images/logo-cop.png\" class=\"logo-cop\" alt=\"v5shop\">\r\n");
	templateBuilder.Append("    </footer>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <a href=\"javascript:void(0);\" class=\"WX_backtop J_backTop J_ytag WX_backtop_active\" ytag=\"09999\">返回顶部</a>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <!--common-->\r\n");
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
