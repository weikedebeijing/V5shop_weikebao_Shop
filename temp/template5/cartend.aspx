<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.cartend" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/9/22 16:00:49.
		本页面代码由V5Shop模板引擎生成于 2014/9/22 16:00:49. 
	*/

	base.OnInit(e);
	templateBuilder.Append("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTmL 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
	templateBuilder.Append("<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n");
	templateBuilder.Append("<head>\r\n");
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
	templateBuilder.Append("        var path = 'http://mall.chu-ying.com/';\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/common.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/cartend.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("</head> \r\n");
	templateBuilder.Append("<body topmargin=\"0\" leftmargin=\"0\" bottommargin=\"0\" rightmargin=\"0\">\r\n");
	templateBuilder.Append(" \r\n");
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
