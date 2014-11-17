<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.category" %>
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
	
	int category__loop__id=0;templateBuilder.Append("<!DOCTYPE html>\r\n");
	templateBuilder.Append("<html class=\"page_index\" lang=\"zh-CN\">\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"content-type\" content=\"text/html; charset=gbk\">\r\n");
	templateBuilder.Append("    <meta charset=\"gbk\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <meta name=\"language\" content=\"zh-CN\" data-author=\"julying\">\r\n");
	templateBuilder.Append("    <meta http-equiv=\"x-dns-prefetch-control\" content=\"on\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/tiantianguoyuan/css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"http://html.v5portal.com/mobile-template/tiantianguoyuan/css/index.css\">\r\n");
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body data-page-type=\"shop-category\">\r\n");
	templateBuilder.Append("    <div class=\"pfhlkd_frame1\">\r\n");
	templateBuilder.Append("        <div class=\"bd pfhlkd_bd_10\">\r\n");
	templateBuilder.Append("            <header class=\"wx_hd\">\r\n");
	templateBuilder.Append("                <div class=\"wx_hd_back\"><a href=\"index.aspx\">返回</a></div>\r\n");
	templateBuilder.Append("                <div class=\"wx_hd_tit\">全部分类</div>\r\n");
	templateBuilder.Append("            </header>\r\n");
	templateBuilder.Append("            <div class=\"wx_category\">\r\n");
	templateBuilder.Append("                <div class=\"item\">\r\n");
	templateBuilder.Append("                    <h3><a href=\"list.aspx?cid=0&name=所有商品\">所有商品</a></h3>\r\n");
	templateBuilder.Append("                </div>\r\n");
	                
	category__loop__id=0;
	foreach(var category in getTable("category","["+shopID+"]"))
	{
	if(category__loop__id == 999 && category__loop__id != 0) break;
		category__loop__id++;
	 templateBuilder.Append("                         <div class=\"item\">\r\n");
	templateBuilder.Append("                             <h3><a href=\"list.aspx?cid=" + category.ID.ToString() + "&name=" + category.Name.ToString() + "\">" + category.Name.ToString() + "</a></h3>\r\n");
	templateBuilder.Append("                         </div>\r\n");
	                
	}	//end loop
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("    </div>\r\n");
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
