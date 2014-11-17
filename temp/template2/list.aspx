<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.list" %>
<%@ Import namespace="System.Data" %>
<%@ Import namespace="V5Shop.Common" %>
<%@ Import namespace="Microsoft.Practices.EnterpriseLibrary.Caching" %>
<script runat="server">
override protected void OnInit(EventArgs e)
{

	/* 
		This page was created by V5Shop Template Engine at 2014/9/22 17:29:54.
		本页面代码由V5Shop模板引擎生成于 2014/9/22 17:29:54. 
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
	templateBuilder.Append("    <title>测试微信支付-" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <script src=\"http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/public/js/wxaddress.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../Template/public/js/wxpay.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("    <a href=\"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxa50207519cc317a4&redirect_uri=http://10001shop.ming-bo.net/" + shopID.ToString() + "/list.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect\">获取收货地址</a>\r\n");
	templateBuilder.Append("    <input type=\"hidden\" id=\"ordernumber\" value=\"140630163810200001\" />\r\n");
	templateBuilder.Append("    <a id=\"getBrandWCPayRequest\" href=\"javascript:void(0)\">点击测试</a>\r\n");
	templateBuilder.Append("    <input type=\"hidden\" id=\"accessToken\" value=\"" + accessToken.ToString() + "\" />\r\n");
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
