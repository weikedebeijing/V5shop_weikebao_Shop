<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExtractSuccess.aspx.cs" Inherits="V5APP.Store.UI.member.ExtractSuccess" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>我的佣金</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
</head>
<body class="body-gray">
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="Extract.aspx" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">提取佣金</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--content begin-->
    <%if (statue)
      { %>
    <!--success begin-->
    <div class="panel tippage">
        <span class="icon-success"></span>
        <p class="text-success">提现成功！</p>
        <p class="text-gray">
            提现金额￥<%=cashAccount %><br>
            预计到账时间<%=date %>
        </p>
        <a href="BrokerageLog.aspx?type=1">查看提现记录</a>
    </div>
    <!--success end-->
    <%}
      else
      { %>
    <!--fail begin-->
    <div class="panel tippage">
        <span class="icon-fail"></span>
        <p class="text-fail">提现失败！</p>
        <a href="javascipt:void(0)" class="text-blue">请与店铺管理员联系</a>
        <a href="Extract.aspx">再试一次</a>
    </div>
    <!--fail end-->
    <%} %>
    <!--content end-->
</body>
</html>
