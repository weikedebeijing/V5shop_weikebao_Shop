<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QrCode.aspx.cs" Inherits="V5APP.Store.UI.member.QrCode" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>申请分销</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
</head>

<body class="body-gray">

    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="Member.aspx" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">店铺二维码</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--content begin-->
    <div class="qrcode">
        <img src="../../UploadFile/QRCode/<%=open.QRCodeUrl %>">
        <a href="../../<%=open.Code %>/index.aspx" class="qrcode-a">访问我的微店</a>

    </div>
    <!--content end-->
</body>
</html>
