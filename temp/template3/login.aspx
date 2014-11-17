<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.login" %>
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
