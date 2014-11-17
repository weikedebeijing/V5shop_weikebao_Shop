<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.addresslist" %>
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
	
	int addresslist__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head><base href=\"http://192.168.1.105:8082/template/version_9/\" />\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>我的地址</title>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/base.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/order.css\">\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("    <!--head begin-->\r\n");
	templateBuilder.Append("    <header class=\"topbar\">\r\n");
	templateBuilder.Append("    <div class=\"topbar-left\">\r\n");
	templateBuilder.Append("    <a href=\"javascript:window.history.go(-1)\" class=\"i-back\">asd</a>\r\n");
	templateBuilder.Append("    <a href=\"../../index.aspx\" class=\"logo\">\r\n");
	templateBuilder.Append("    <img src=\"../../images/logo.png\" alt=\"logo\">\r\n");
	templateBuilder.Append("    </a>\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <div class=\"topbar-right\">\r\n");
	templateBuilder.Append("    <a class=\"i-member\" href=\"../../orderlist.aspx\">会员</a>\r\n");
	templateBuilder.Append("    <a href=\"../../cart.aspx\" class=\"i-cart\">&nbsp;\r\n");
	    
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
	templateBuilder.Append("    <div class=\"btn-addaddress\">\r\n");
	templateBuilder.Append("        <a href=\"../../editaddress.aspx?url=addresslist.aspx\"><b class=\"icon-add\">+</b>添加收获地址</a></div>\r\n");
	templateBuilder.Append("    <section class=\"address-list\">\r\n");
	templateBuilder.Append("    <ul class=\"address-list-ul\" id=\"list\">\r\n");
	    
	addresslist__loop__id=0;
	foreach(DataRow addresslist_member in getTable("addresslist","["+user_id+"]").Rows)
	{
	if(addresslist__loop__id == 999 && addresslist__loop__id != 0) break;
		addresslist__loop__id++;
	     
	if(addresslist_member["IsDefault"].ToString()=="True" ){
	templateBuilder.Append("      <li class=\"address-list-li current\" id=\"" + addresslist_member["ID"].ToString() + "\">\r\n");
	      
	}else{
	templateBuilder.Append("        <li class=\"address-list-li \" id=\"" + addresslist_member["ID"].ToString() + "\">\r\n");
	      
	}	//end if
	templateBuilder.Append("        <p class=\"person\"><span class=\"name\">" + addresslist_member["Name"].ToString() + "</span></p>\r\n");
	templateBuilder.Append("        <p class=\"detail-address\">" + addresslist_member["AddressInfo"].ToString() + "</p>\r\n");
	templateBuilder.Append("        <a href=\"../../editaddress.aspx?addressid=" + addresslist_member["ID"].ToString() + "&url=addresslist.aspx\" class=\"edit\">编辑</a>\r\n");
	templateBuilder.Append("        <a href=\"javascript:void(0)\"  onclick=\"deladdress(this)\" class=\"del\" addressid=\"" + addresslist_member["ID"].ToString() + "\">删除</a>\r\n");
	templateBuilder.Append("      </li>\r\n");
	      
	}	//end loop
	templateBuilder.Append("    </ul>    \r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("    <div class=\"clear\">\r\n");
	templateBuilder.Append("    </div>\r\n");
	templateBuilder.Append("    <footer>\r\n");
	templateBuilder.Append("    Copyright 2005-2007 web08.net. All rights reserved.\r\n");
	templateBuilder.Append("  </footer>\r\n");
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
	templateBuilder.Append("                    location.href = \"../../cartstep.aspx\";\r\n");
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
