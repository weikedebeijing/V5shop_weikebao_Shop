<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.tippage" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/9/22 17:09:08.
		本页面代码由V5Shop模板引擎生成于 2014/9/22 17:09:08. 
	*/

	base.OnInit(e);
	templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>请关注-" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/CssLoad.js?Item=base|common|v5\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/common.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/jquery.zclip.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/tippage.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../public/js/weixincommon.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("    <div class=\"copy-corname\">\r\n");
	templateBuilder.Append("        <p class=\"text\">\r\n");
	templateBuilder.Append("            购买该商品请点击复制微信公众账号：</p>\r\n");
	templateBuilder.Append("        <div class=\"btn\" id=\"copyWeiXinNumber\">\r\n");
	templateBuilder.Append("            " + weiXinPublicNumber.ToString() + "</div>\r\n");
	templateBuilder.Append("        <p class=\"tips\">\r\n");
	templateBuilder.Append("            通过“添加朋友”找到“查找微信公众账号”或“搜号码”一栏，并在搜索栏粘贴复制内容“<span>" + weiXinPublicNumber.ToString() + "</span>”，单击“查找”，关注“<span>" + weiXinPublicNumber.ToString() + "</span>”即可。</p>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"copy-proname\" id=\"copyproductname\">\r\n");
	templateBuilder.Append("        <p class=\"text\">\r\n");
	templateBuilder.Append("            已关注请点击复制商品名称：</p>\r\n");
	templateBuilder.Append("        <div class=\"btn\" id=\"copyProductNumber\">\r\n");
	templateBuilder.Append("            " + productName.ToString() + "</div>\r\n");
	templateBuilder.Append("        <p class=\"tips\">\r\n");
	templateBuilder.Append("            进入V5SHOP分销商城微信公众号，粘贴复制内容发送即可</p>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    \r\n");
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
