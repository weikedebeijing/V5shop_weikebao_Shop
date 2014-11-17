<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestWXPay.aspx.cs" Inherits="V5APP.Store.UI.member.TestWXPay" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>微信支付测试</title>

    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="../../member/js/wxpay.js"></script>
</head>
<body>
    <a href="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxa50207519cc317a4&redirect_uri=http://10001shop.ming-bo.net/c001/oauth/index.aspx&response_type=code&scope=snsapi_base&state=http://10001shop.ming-bo.net/c001/member/testwxaddress.aspx#wechat_redirect" >获取收货地址</a>
    <input type="hidden" id="ordernumber" value="140630163810200001" />
    <a id="getBrandWCPayRequest" href="javascript:void(0)">点击测试</a>
</body>
</html>
