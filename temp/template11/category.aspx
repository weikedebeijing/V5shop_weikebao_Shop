<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.category" %>
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
	templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>商品列表-" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/CssLoad.js?Item=base|common|v5\"></"+"script>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/jquery.mobile-1.3.2.min.css\" />\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/list.css\" />\r\n");
	templateBuilder.Append("    <script src=\"js/jquery-2.0.3.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"js/iscroll.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script src=\"js/iscrollAssist.js\" type=\"text/javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../public/js/weixincommon.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/common.js\" language=\"javascript\" charset=\"gb2312\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\">\r\n");
	templateBuilder.Append("        $(document).ready(function () {\r\n");
	templateBuilder.Append("            $.ajax({\r\n");
	templateBuilder.Append("                url: \"../../member/Ajax/GateWay.aspx\",\r\n");
	templateBuilder.Append("                type: \"post\",\r\n");
	templateBuilder.Append("                dataType: \"json\",\r\n");
	templateBuilder.Append("                async: false,\r\n");
	templateBuilder.Append("                data: { action: \"CATEGORYPAGE\", page: 1, pagesize: 40 },\r\n");
	templateBuilder.Append("                success: function (response) {\r\n");
	templateBuilder.Append("                    if (response.list.length < PAGESIZE) {\r\n");
	templateBuilder.Append("                        hasMoreData = false;\r\n");
	templateBuilder.Append("                        $(\"#pullUp\").hide();\r\n");
	templateBuilder.Append("                    } else {\r\n");
	templateBuilder.Append("                        hasMoreData = true;\r\n");
	templateBuilder.Append("                        $(\"#pullUp\").show();\r\n");
	templateBuilder.Append("                    }\r\n");
	templateBuilder.Append("                    $.each(response.list, function (key, value) {\r\n");
	templateBuilder.Append("                        $(\"#dataArea\").append('<div class=\"pro-inner\"><div class=\"pro-style\" ><div class=\"margin10\"><div class=\"divimg\"><a class=\"img\" href=\"javascript:void(0)\" onclick=\"javascript:jumpproduct(' + value.ID + ')\" ><img onclick=\"javascript:jumpproduct(' + value.ID + ')\" src=\"' + value.DefaultImageData + '\" ></a></div><div class=\"pro-summary\"><a  class=\"name\" title=\"' + value.ProductName + '\" href=\"javascript:void(0)\" onclick=\"javascript:jumpproduct(' + value.ID + ')\">' + value.ProductName + '</a><span class=\"price\">￥' + value.SalesPrice + '</span></div></div></div>');\r\n");
	templateBuilder.Append("                    });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("                }\r\n");
	templateBuilder.Append("            })\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("        });\r\n");
	templateBuilder.Append("        var page = 2;\r\n");
	templateBuilder.Append("        var PAGESIZE = 10;\r\n");
	templateBuilder.Append("        (function ($) {\r\n");
	templateBuilder.Append("            $(function () {\r\n");
	templateBuilder.Append("                var pulldownAction = function () {\r\n");
	templateBuilder.Append("                    $(\"#dataArea\").html(\"\");\r\n");
	templateBuilder.Append("                    page = 2;\r\n");
	templateBuilder.Append("                    $.ajax({\r\n");
	templateBuilder.Append("                        url: \"../../member/Ajax/GateWay.aspx\",\r\n");
	templateBuilder.Append("                        type: \"post\",\r\n");
	templateBuilder.Append("                        dataType: \"json\",\r\n");
	templateBuilder.Append("                        async: false,\r\n");
	templateBuilder.Append("                        data: { action: \"CATEGORYPAGE\", page: 1, pagesize: 40 },\r\n");
	templateBuilder.Append("                        success: function (response) {\r\n");
	templateBuilder.Append("                            if (response.list.length < PAGESIZE) {\r\n");
	templateBuilder.Append("                                hasMoreData = false;\r\n");
	templateBuilder.Append("                                $(\"#pullUp\").hide();\r\n");
	templateBuilder.Append("                            } else {\r\n");
	templateBuilder.Append("                                hasMoreData = true;\r\n");
	templateBuilder.Append("                                $(\"#pullUp\").show();\r\n");
	templateBuilder.Append("                            }\r\n");
	templateBuilder.Append("                            $.each(response.list, function (key, value) {\r\n");
	templateBuilder.Append("                                $(\"#dataArea\").append('<div class=\"pro-inner\"><div class=\"pro-style\" ><div class=\"margin10\"><div class=\"divimg\"><a class=\"img\" href=\"javascript:void(0)\" onclick=\"javascript:jumpproduct(' + value.ID + ')\" ><img onclick=\"javascript:jumpproduct(' + value.ID + ')\" src=\"' + value.DefaultImageData + '\" ></a></div><div class=\"pro-summary\"><a  class=\"name\" title=\"' + value.ProductName + '\" href=\"javascript:void(0)\" onclick=\"javascript:jumpproduct(' + value.ID + ')\">' + value.ProductName + '</a><span class=\"price\">￥' + value.SalesPrice + '</span></div></div></div>');\r\n");
	templateBuilder.Append("                            });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("                        }\r\n");
	templateBuilder.Append("                    })\r\n");
	templateBuilder.Append("                    this.refresh();\r\n");
	templateBuilder.Append("                    console.log(\"下拉执行逻辑\");\r\n");
	templateBuilder.Append("                };\r\n");
	templateBuilder.Append("                var pullupAction = function () {\r\n");
	templateBuilder.Append("                    page++;\r\n");
	templateBuilder.Append("                    $.ajax({\r\n");
	templateBuilder.Append("                        url: \"../../member/Ajax/GateWay.aspx\",\r\n");
	templateBuilder.Append("                        type: \"post\",\r\n");
	templateBuilder.Append("                        dataType: \"json\",\r\n");
	templateBuilder.Append("                        async: false,\r\n");
	templateBuilder.Append("                        data: { action: \"CATEGORYPAGE\", page: page, pagesize: PAGESIZE },\r\n");
	templateBuilder.Append("                        success: function (response) {\r\n");
	templateBuilder.Append("                            if (response.list.length < PAGESIZE) {\r\n");
	templateBuilder.Append("                                hasMoreData = false;\r\n");
	templateBuilder.Append("                                $(\"#pullUp\").hide();\r\n");
	templateBuilder.Append("                            } else {\r\n");
	templateBuilder.Append("                                hasMoreData = true;\r\n");
	templateBuilder.Append("                                $(\"#pullUp\").show();\r\n");
	templateBuilder.Append("                            }\r\n");
	templateBuilder.Append("                            $.each(response.list, function (key, value) {\r\n");
	templateBuilder.Append("                                $(\"#dataArea\").append('<div class=\"pro-inner\"><div class=\"pro-style\"><div class=\"margin10\"><div class=\"divimg\"><a class=\"img\" href=\"javascript:void(0)\" onclick=\"javascript:jumpproduct(' + value.ID + ')\"><img src=\"' + value.DefaultImageData + '\" ></a></div><div class=\"pro-summary\"><a  class=\"name\" title=\"' + value.ProductName + '\" href=\"javascript:jumpproduct(' + value.ID + ')\">' + value.ProductName + '</a><span class=\"price\">￥' + value.SalesPrice + '</span></div></div></div>');\r\n");
	templateBuilder.Append("                            });\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("                        }\r\n");
	templateBuilder.Append("                    })\r\n");
	templateBuilder.Append("                    this.refresh();\r\n");
	templateBuilder.Append("                    console.log(\"上拉执行逻辑\");\r\n");
	templateBuilder.Append("                };\r\n");
	templateBuilder.Append("                var iscrollObj = iscrollAssist.newVerScrollForPull($('#wrapper'), pulldownAction, pullupAction);\r\n");
	templateBuilder.Append("                iscrollObj.refresh();\r\n");
	templateBuilder.Append("            });\r\n");
	templateBuilder.Append("        })(jQuery);\r\n");
	templateBuilder.Append("    </"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body topmargin=\"0\" leftmargin=\"0\" bottommargin=\"0\" rightmargin=\"0\">\r\n");
	templateBuilder.Append("    <!--head begin-->\r\n");
	templateBuilder.Append("    <header class=\"topbar\">\r\n");
	templateBuilder.Append("    <div class=\"topbar-left\">\r\n");
	templateBuilder.Append("    <a href=\"javascript:void(0)\" onclick=\"javascript:jumpaspx('../../index.aspx')\" class=\"i-back\">asd</a>\r\n");
	templateBuilder.Append("    <a href=\"javascript:void(0)\" onclick=\"javascript:jumpaspx('../../index.aspx')\" class=\"logo\">\r\n");
	templateBuilder.Append("    <img src=\"" + logo.ToString() + "\" alt=\"logo\">\r\n");
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"topbar-right\">\r\n");
	templateBuilder.Append("    <a class=\"i-member\" href=\"javascript:void(0)\" onclick=\"javascript:jumpaspx('../../orderlist.aspx')\">会员</a>\r\n");
	templateBuilder.Append("    <a  href=\"javascript:void(0)\" onclick=\"javascript:jumpaspx('../../cart.aspx')\" class=\"i-cart\">&nbsp;  \r\n");
	    
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
	templateBuilder.Append("            <div id=\"pulldown\" class=\"idle\">\r\n");
	templateBuilder.Append("                <span class=\"pullDownIcon\"></span><span class=\"pullDownLabel\" id=\"pulldown-label\">\r\n");
	templateBuilder.Append("                </span>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <div class=\"product\" id=\"dataArea\">\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("            <div id=\"pullup\" class=\"idle\">\r\n");
	templateBuilder.Append("                <span class=\"pullUpIcon\"></span><span class=\"pullUpLabel\" id=\"pullup-label\"></span>\r\n");
	templateBuilder.Append("            </div>\r\n");
	templateBuilder.Append("             \r\n");
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
