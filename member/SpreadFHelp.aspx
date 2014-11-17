<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpreadFHelp.aspx.cs" Inherits="V5APP.Store.UI.member.SpreadFHelp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<title>会员中心</title>
<link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css" />
<link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css" />
<link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/dis.css" />
<script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
<script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
</head>

<body>
  <!--topbar begin-->
  <div class="fixed">
    <nav class="tab-bar">
      <section class="left-small">
        <a class="menu-icon" onclick="window.history.go(-1)" ><span></span></a>
      </section>
      <section class="middle tab-bar-section">
        <h1 class="title">如何转发</h1>
      </section>
    </nav>
  </div>
  <!--topbar end-->
  <!--content begin-->
  <div class="spreadFHelp">
    <h3>操作步骤</h3>
    <ul class="ul-spreadFHelp">
      <li><i class="icon-number">1</i><div class="text">将图片保存到手机；</div></li>
      <li><i class="icon-number">2</i><div class="text">复制图片上方文字；</div></li>
      <li><i class="icon-number">3</i><div class="text">在微信里点击“发现”→“朋友圈”→点击右上角“拍摄图标”选择已保存的图片→点击“完成”按钮；</div></li>
      <li><i class="icon-number">4</i><div class="text">把文本粘贴到文本框里；</div></li>
      <li><i class="icon-number">5</i><div class="text">点击“发送”按钮，即可完成转发。</div></li>
    </ul>
  </div>
  <!--content begin-->
  <script>
      $(document).foundation().foundation('joyride', 'start');
  </script>
</body>
</html>
