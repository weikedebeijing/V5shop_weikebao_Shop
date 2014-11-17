<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.addresslist" %>
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
	
	int addresslist__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head>\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>我的地址-" + shoptitle.ToString() + "</title>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"js/CssLoad.js?Item=base|common|order\"></"+"script>\r\n");
	templateBuilder.Append("    <script type=\"text/javascript\" src=\"../public/js/weixincommon.js\" language=\"javascript\"></"+"script>\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("    <!--head begin-->\r\n");
	templateBuilder.Append("    <header class=\"topbar\">\r\n");
	templateBuilder.Append("    <div class=\"topbar-left\">\r\n");
	templateBuilder.Append("    <a href=\"javascript:window.history.go(-1)\" class=\"i-back\">asd</a>\r\n");
	templateBuilder.Append("    <a href=\"index.aspx\" class=\"logo\">\r\n");
	templateBuilder.Append("    <img src=\"" + logo.ToString() + "\" alt=\"logo\">\r\n");
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"topbar-right\">\r\n");
	templateBuilder.Append("    <a class=\"i-member\" href=\"member/member.aspx\">会员</a>\r\n");
	templateBuilder.Append("    <a href=\"cart.aspx\" class=\"i-cart\">&nbsp;\r\n");
	    
	if(Convert.ToInt32(totalnum)>0){
	templateBuilder.Append("    <span class=\"tips\" id=\"countcart\">" + totalnum.ToString() + "</span>\r\n");
	    
	}else{
	templateBuilder.Append("    <span class=\"tips\" id=\"countcart\" style=\" display:none\">0</span>\r\n");
	    
	}	//end if
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("</header>\r\n");
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <!--head end-->\r\n");
	templateBuilder.Append("    <section class=\"address-list\">\r\n");
	templateBuilder.Append("               <a href=\"../../editaddress.aspx?url=addresslist.aspx\" class=\"address-add-a\">添加收货地址</a>\r\n");
	templateBuilder.Append("        <ul class=\"address-list-ul\" id=\"list\">\r\n");
	            
	addresslist__loop__id=0;
	foreach(var addresslist in getTable("addresslist","["+user_id+"]"))
	{
	if(addresslist__loop__id == 999 && addresslist__loop__id != 0) break;
		addresslist__loop__id++;
	            
	if(addresslist_member["IsDefault"].ToString()=="True" ){
	templateBuilder.Append("            <li class=\"address-list-li current\" id=\"" + addresslist.ID.ToString() + "\">\r\n");
	            
	}else{
	templateBuilder.Append("            <li class=\"address-list-li \" id=\"" + addresslist.ID.ToString() + "\">\r\n");
	                
	}	//end if
	templateBuilder.Append("                 <div class=\"opera\"><a href=\"../../editaddress.aspx?addressid=" + addresslist.ID.ToString() + "&url=addresslist.aspx\" class=\"icon-edit\"></a><a href=\"javascript:void(0)\"  onclick=\"deladdress(this)\" addressid=\"" + addresslist.ID.ToString() + "\"  class=\"icon-del\"></a></div>\r\n");
	templateBuilder.Append("        <p class=\"person\"><span class=\"name\">" + addresslist.Name.ToString() + "</span><span class=\"mobile\">" + addresslist.Moblie.ToString() + "</span></p>\r\n");
	templateBuilder.Append("        <p class=\"detail-address\">" + addresslist.AddressInfo.ToString() + "</p>\r\n");
	templateBuilder.Append("        <i class=\"icon-hook\"></i>\r\n");
	templateBuilder.Append("                          </li>\r\n");
	            
	}	//end loop
	templateBuilder.Append("        </ul>    \r\n");
	templateBuilder.Append("    </section>\r\n");
	templateBuilder.Append("    <div class=\"clear\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    \r\n");
	templateBuilder.Append("</body>\r\n");
	templateBuilder.Append("</html>\r\n");
	templateBuilder.Append("<script type=\"text/javascript\">\r\n");
	templateBuilder.Append("    function deladdress(obj) {\r\n");
	templateBuilder.Append("        var id = $(obj).attr(\"addressid\");\r\n");
	templateBuilder.Append("        $.ajax({\r\n");
	templateBuilder.Append("            type: \"POST\",\r\n");
	templateBuilder.Append("            dataType: \"text\",\r\n");
	templateBuilder.Append("            url: \"../../member/ajax/GateWay.aspx\",\r\n");
	templateBuilder.Append("            data: \"action=DelAddress&id=\" + id,\r\n");
	templateBuilder.Append("            success: function (txt) {\r\n");
	templateBuilder.Append("                if (txt == \"成功\") {\r\n");
	templateBuilder.Append("                    location.href = \"../../addresslist.aspx\";\r\n");
	templateBuilder.Append("                } else {\r\n");
	templateBuilder.Append("                    alert(txt);\r\n");
	templateBuilder.Append("                }\r\n");
	templateBuilder.Append("            }\r\n");
	templateBuilder.Append("        })\r\n");
	templateBuilder.Append("    }\r\n");
	templateBuilder.Append("    $(\"#list li\").click(function (event) {\r\n");
	templateBuilder.Append("        var obj = this;\r\n");
	templateBuilder.Append("        if (getEventTarget(event, 1).tagName != \"A\") {\r\n");
	templateBuilder.Append("            var id = $(this).attr(\"id\");\r\n");
	templateBuilder.Append("            $.get(\"../../member/ajax/GateWay.aspx?action=DefaultAddress&id=\" + id, function (data) {\r\n");
	templateBuilder.Append("                if (data == \"成功\") {\r\n");
	templateBuilder.Append("                    $(\"#list li\").removeClass(\"current\");\r\n");
	templateBuilder.Append("                    $(obj).addClass(\"current\");\r\n");
	templateBuilder.Append("                    location.href = \"../../cart.aspx\";\r\n");
	templateBuilder.Append("                }\r\n");
	templateBuilder.Append("            });\r\n");
	templateBuilder.Append("        }\r\n");
	templateBuilder.Append("    })\r\n");
	templateBuilder.Append("    function getEventTarget(event, targetType) {\r\n");
	templateBuilder.Append("        event = event || window.event;\r\n");
	templateBuilder.Append("        if (targetType == 1) {// 获得触发的对象\r\n");
	templateBuilder.Append("            return event.target || event.srcElement;\r\n");
	templateBuilder.Append("        } else if (targetType == 2) {// 获得处理事件的对象\r\n");
	templateBuilder.Append("            return event.currentTarget;\r\n");
	templateBuilder.Append("        }\r\n");
	templateBuilder.Append("    }\r\n");
	templateBuilder.Append("</"+"script>\r\n");
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
