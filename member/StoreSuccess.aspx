<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StoreSuccess.aspx.cs" Inherits="V5APP.Store.UI.member.StoreSuccess" %>

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
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/dis.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation.min.js"></script>
</head>

<body>
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">设置店铺</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--step02 begin-->
    <ul class="breadcrumbs step-store">
        <li class="first"><a href="javascript:void(0)"><i class="step-number">1</i>设置微店名称</a></li>
        <li class="second"><a href="javascript:void(0)"><i class="step-number">2</i>选择商品分类</a></li>
        <li class="third current"><a href="javascript:void(0)"><i class="step-number">3</i>完成</a></li>
    </ul>
    <!--step02 end-->
    <!--content begin-->
  <div class="panel tippage registerST">
    <div class="row">
      <div class="small-2 large-2 columns"><span class="icon-success"></span></div>
      <div class="small-10 large-10 columns"><h4 class="tiptext">注册成功！请用纸笔保留以下信息：</h4>
      <p class="info">手机版微店：<a href="<%=shopUrl %>"><%=shopUrl %></a></p>
      </div>
    </div>
    <div class="row explan-title">
     <span class="text">新手必读</span><span class="line"></span>
    </div>
    <div class="row explan-text">
      <div class="small-2 large-2 columns"><span class="icon-circle"></span></div>
      <div class="small-10 large-10 columns"><h4 class="text-title">开微店收入来源一</h4>
      <p class="info">您已成功注册微店，已经取得整座商城的商品销售权，只要有人在您的微店购物，即可获得相应佣金。</p>
      </div>
    </div>
      <%if (ShopLevel ==1)
        { %>
     <div class="row explan-text">
      <div class="small-2 large-2 columns"><span class="icon-circle"></span></div>
      <div class="small-10 large-10 columns"><h4 class="text-title">开微店收入来源二</h4>
      <p class="info">邀请朋友注册，Ta就成为您的分销商，Ta店内成交的佣金，您可以获得<%=commissions %>的奖励，分销商越多，您赚得越多！</p>
      </div>
    </div>
      <%} %>
    <a href="../../<%=channelCode %>/index.aspx" class="inStore">马上进入微店</a>
      </div>
  <!--content end-->
</body>
</html>
