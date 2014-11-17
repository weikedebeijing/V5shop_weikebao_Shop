<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.tippage" %>
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
	templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head><base href=\"http://192.168.1.105:8082/template/version_9/\" />\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>微商城</title>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/base.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/v5.css\">\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/common.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/jquery.zclip.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/tippage.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("    <div class=\"copy-corname\">\r\n");
	templateBuilder.Append("        <p class=\"text\">\r\n");
	templateBuilder.Append("            购买该商品请点击复制微信公众账号：</p>\r\n");
	templateBuilder.Append("        <div class=\"btn\" id=\"copyWeiXinNumber\">" + weiXinPublicNumber.ToString() + "</div>\r\n");
	templateBuilder.Append("        <p class=\"tips\">\r\n");
	templateBuilder.Append("            通过“添加朋友”找到“查找微信公众账号”或“搜号码”一栏，并在搜索栏粘贴复制内容“V5SHOP分销商城”，单击“查找”，关注“V5SHOP分销商城”即可。</p>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"copy-proname\" id=\"copyproductname\">\r\n");
	templateBuilder.Append("        <p class=\"text\">\r\n");
	templateBuilder.Append("            已关注请点击复制商品名称：</p>\r\n");
	templateBuilder.Append("        <div class=\"btn\" id=\"copyProductNumber\">" + productName.ToString() + "</div>\r\n");
	templateBuilder.Append("        <p class=\"tips\">\r\n");
	templateBuilder.Append("            进入V5SHOP分销商城微信公众号，粘贴复制内容发送即可</p>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</body>\r\n");
	templateBuilder.Append("</html>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
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
