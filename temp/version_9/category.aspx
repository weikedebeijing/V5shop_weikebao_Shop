<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.category" %>
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
	templateBuilder.Append("    <title>" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/base.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/v5.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/jquery.mobile-1.3.2.min.css\" />\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/list.css\" />\r\n");
	templateBuilder.Append("    <script src=\"js/jquery-1.9.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"js/jquery.mobile-1.3.2.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"js/iscroll.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"js/list.js\" type=\"text/javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/common.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body topmargin=\"0\" leftmargin=\"0\" bottommargin=\"0\" rightmargin=\"0\">\r\n");
	templateBuilder.Append("    <!--head begin-->\r\n");
	templateBuilder.Append("    <header class=\"topbar\">\r\n");
	templateBuilder.Append("    <div class=\"topbar-left\">\r\n");
	templateBuilder.Append("    <a href=\"javascript:jumpaspx('../../index.aspx')\" class=\"i-back\">asd</a>\r\n");
	templateBuilder.Append("    <a href=\"javascript:jumpaspx('../../index.aspx')\" class=\"logo\">\r\n");
	templateBuilder.Append("    <img src=\"../../images/logo.png\" alt=\"logo\">\r\n");
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"topbar-right\">\r\n");
	templateBuilder.Append("    <a class=\"i-member\" href=\"javascript:jumpaspx('../../orderlist.aspx')\">会员</a>\r\n");
	templateBuilder.Append("    <a href=\"javascript:jumpaspx('../../cart.aspx')\" class=\"i-cart\">&nbsp;  \r\n");
	    
	if(Convert.ToInt32(totalnum)>0){
	templateBuilder.Append("    <span class=\"tips\" id=\"countcart\">" + totalnum.ToString() + "</span>\r\n");
	    
	}else{
	templateBuilder.Append("    <span class=\"tips\" id=\"countcart\" style=\" display:none\">0</span>\r\n");
	    
	}	//end if
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</header>\r\n");
	templateBuilder.Append("    <!--head end-->\r\n");
	templateBuilder.Append("    <div id=\"wrapper\">\r\n");
	templateBuilder.Append("        <div id=\"scroller\">\r\n");
	templateBuilder.Append("            <div id=\"pullDown\" class=\"idle\">\r\n");
	templateBuilder.Append("                <span class=\"pullDownIcon\"></span><span class=\"pullDownLabel\">Pull down to refresh...</span>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <div class=\"product\" id=\"thelist\">\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <div id=\"pullUp\" class=\"idle\">\r\n");
	templateBuilder.Append("                <span class=\"pullUpIcon\"></span><span class=\"pullUpLabel\">Pull up to refresh...</span>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <footer>\r\n");
	templateBuilder.Append("         Copyright 2005-2007 web08.net. All rights reserved.\r\n");
	templateBuilder.Append("        </footer>\r\n");
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
