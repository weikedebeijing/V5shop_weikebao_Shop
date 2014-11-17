<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestWxAddress.aspx.cs" Inherits="V5APP.Store.UI.member.TestWxAddress" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>微信收货地址</title>

    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="../../member/js/wxaddress.js"></script>
</head>
<body>
    <a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxa50207519cc317a4&redirect_uri=http://10001shop.ming-bo.net/member/TestWxAddress.aspx&response_type=code&scope=snsapi_base&state=123#wechat_redirect">获取收货地址</a>
    <input type="text" id="accessToken" value="<%=accessToken %>" />
    <input type="text" id="starturl" style="width: 300px" value="<%=starturl %>" />
    <form name="form1">
        <input type="text" id="address1" />
        <input type="text" id="address2" />
        <input type="text" id="address3" />
        <input type="text" id="detail" />
        <input type="text" id="phone" />
    </form>
</body>
</html>
