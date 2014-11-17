<%@ Page language="c#" AutoEventWireup="false" EnableViewState="false" Inherits="V5Shop.Web.editaddress" %>
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
	
	int addressbyid__loop__id=0;templateBuilder.Append("<!DOCTYPE HTML>\r\n");
	templateBuilder.Append("<html>\r\n");
	templateBuilder.Append("<head><base href=\"http://192.168.1.105:8082/template/version_9/\" />\r\n");
	templateBuilder.Append("    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n");
	templateBuilder.Append("    <meta name=\"viewport\" content=\"initial-scale=1.0,maximum-scale=1.0,user-scalable=no\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-capable\" content=\"yes\">\r\n");
	templateBuilder.Append("    <meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\">\r\n");
	templateBuilder.Append("    <meta name=\"format-detection\" content=\"telephone=no\">\r\n");
	templateBuilder.Append("    <title>收货地址</title>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/jquery-1.7.1.min.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/address.select.area.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <script language=\"javascript\" src=\"js/address.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("     <script language=\"javascript\" src=\"js/jscommon.js\" type=\"text/javascript\"></"+"script>\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/base.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/common.css\">\r\n");
	templateBuilder.Append("    <link rel=\"stylesheet\" type=\"text/css\" href=\"css/order.css\">\r\n");
	templateBuilder.Append("</head>\r\n");
	templateBuilder.Append("<body>\r\n");
	templateBuilder.Append("       <!--head begin-->\r\n");
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
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <section class=\"adressadd-list\">\r\n");
	templateBuilder.Append("    <input type=\"hidden\" value=\"" + addressid.ToString() + "\" id=\"AddressID\" />\r\n");
	    
	if(addressid!="-1" ){
	    
	addressbyid__loop__id=0;
	foreach(DataRow addressbyid_member in getTable("addressbyid","["+addressid+"]").Rows)
	{
	if(addressbyid__loop__id == 999 && addressbyid__loop__id != 0) break;
		addressbyid__loop__id++;
	templateBuilder.Append("     <ul class=\"adressadd-list-ul\">\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>收货人</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\"><input type=\"text\" id=\"Name\" value=\"" + addressbyid_member["Name"].ToString() + "\"/></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>手机号码</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\"><input type=\"text\" id=\"Moblie\" value=\"" + addressbyid_member["Moblie"].ToString() + "\"/></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>选择省份</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\">\r\n");
	templateBuilder.Append("          <select id=\"seleAreaNext\">               \r\n");
	templateBuilder.Append("            <option value=\"-1\">请选择</option>\r\n");
	templateBuilder.Append("          </select>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>选择城市</label></div>\r\n");
	templateBuilder.Append("        <input type=\"hidden\" id=\"AreaCode\" value=\"" + addressbyid_member["AreaCode"].ToString() + "\" />\r\n");
	templateBuilder.Append("        <input type=\"hidden\" id=\"SeletctAreaId\" value=\"\" />\r\n");
	templateBuilder.Append("        <div class=\"value\">\r\n");
	templateBuilder.Append("          <select id=\"seleAreaThird\"> <option value=\"-1\">请选择</option></select>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>选择区/县</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\">\r\n");
	templateBuilder.Append("          <select id=\"seleAreaFouth\">\r\n");
	templateBuilder.Append("            <option value=\"-1\">请选择</option>\r\n");
	templateBuilder.Append("          </select>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>详细地址</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\">\r\n");
	templateBuilder.Append("          <textarea name=\"address\" class=\"remark\" placeholder=\"请填写详细地址\" onblur=\"infoOnblur(this)\" onclick=\"infoClick(this)\" id=\"AddressInfo\">" + addressbyid_member["Remark"].ToString() + "</textarea>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("    </ul>\r\n");
	    
	}	//end loop
	    
	}else{
	templateBuilder.Append("\r\n");
	templateBuilder.Append("    <ul class=\"adressadd-list-ul\">\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>收货人</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\"><input type=\"text\" id=\"Name\"/></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>手机号码</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\"><input type=\"text\" id=\"Moblie\"/></div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>选择省份</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\">\r\n");
	templateBuilder.Append("          <select id=\"seleAreaNext\">               \r\n");
	templateBuilder.Append("            <option value=\"-1\">请选择</option>\r\n");
	templateBuilder.Append("          </select>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>选择城市</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\">\r\n");
	templateBuilder.Append("          <select id=\"seleAreaThird\"> <option value=\"-1\">请选择</option></select>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>选择区/县</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\">\r\n");
	templateBuilder.Append("          <select id=\"seleAreaFouth\">\r\n");
	templateBuilder.Append("            <option value=\"-1\">请选择</option>\r\n");
	templateBuilder.Append("          </select>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("      <li class=\"adressadd-list-li\">\r\n");
	templateBuilder.Append("        <div class=\"label\"><label>详细地址</label></div>\r\n");
	templateBuilder.Append("        <div class=\"value\">\r\n");
	templateBuilder.Append("          <textarea name=\"address\" class=\"remark\" placeholder=\"请填写详细地址\" onblur=\"infoOnblur(this)\" onclick=\"infoClick(this)\" id=\"AddressInfo\"></textarea>\r\n");
	templateBuilder.Append("        </div>\r\n");
	templateBuilder.Append("      </li>\r\n");
	templateBuilder.Append("    </ul>\r\n");
	    
	}	//end if
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("    <section class=\"s-btn\">\r\n");
	templateBuilder.Append("    <button class=\"settle-account\" onclick=\"saveAddress()\">确定</button>\r\n");
	templateBuilder.Append("    <a href=\"javascript:window.history.go(-1)\" style=\"display:none\" ><span id=\"backpage\"></span></a>\r\n");
	templateBuilder.Append("  </section>\r\n");
	templateBuilder.Append("    <footer>\r\n");
	templateBuilder.Append("    Copyright 2005-2007 web08.net. All rights reserved.\r\n");
	templateBuilder.Append("  </footer>\r\n");
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
