<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubStoreBrokerage.aspx.cs" Inherits="V5APP.Store.UI.member.SubStoreBrokerage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
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
<link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/dis.css">
<script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
<script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
<script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.tab.js"></script>
<script src="http://html.v5portal.com/distribution/js/highcharts.js"></script>
<script src="http://html.v5portal.com/distribution/js/exporting.js"></script>
<script src="../../member/js/chartline.js"></script>
    <script>
        function GetToDayPrice() {
            var str = "<%=dayTimeSlot%>";
         return JSON.parse(str);
     }
     function GetYesterDayPrice() {
         var str = "<%=yesterdayTimeSlot%>";
         return JSON.parse(str);
     }
     function GetThisWeekPrice() {
         var str = "<%=weekTimeSlot%>";
         return JSON.parse(str);
     }
     function GetThisMonthPrice() {
         var str = "<%=monthTimeSlot%>";
         return JSON.parse(str);
     }
 </script>
</head>
<body>
  <!--topbar begin-->
  <div class="fixed">
    <nav class="tab-bar">
      <section class="left-small">
        <a class="menu-icon" href="Member.aspx" ><span></span></a>
      </section>
      <section class="middle tab-bar-section">
        <h1 class="title">子店提成</h1>
      </section>
    </nav>
  </div>
  <!--topbar end-->
  <!--yesterday begin-->
  <div class="panel bro-yesterday">
    <p><i class="icon-monyg"></i>子店总提成</p>
    <span>￥<%=nextCommissionAmount.ToString("0.00") %></span>
  </div>
  <!--yesterday end-->
  <!--table begin-->
  <dl class="tabs tab-title4-chart" data-tab>
    <dd class="active"><a href="#panel2-1">今日</a></dd>
    <dd><a href="#panel2-2">昨日</a></dd>
    <dd><a href="#panel2-3">本周</a></dd>
    <dd><a href="#panel2-4">本月</a></dd>    
  </dl>
  <!--table end--> 
  <!--content begin-->
  <div class="tabs-content tabcontent04">
    <!--totaltoday begin-->
    <div class="content active" id="panel2-1">
      <a href="DRPOrderList.aspx?DayOf=today&Next=true" class="view-detail">查看详情</a>
      <div id="totaltoday" style="min-width:100%;height:400px;margin-top:10px;"></div> 
    </div>
    <!--totaltoday end-->
    <!--yestoday begin-->
    <div class="content" id="panel2-2">
      <a href="DRPOrderList.aspx?DayOf=yestoday&Next=true" class="view-detail">查看详情</a>
      <div id="yestoday" style="min-width:100%;height:400px;margin-top:10px;"></div> 
    </div>    
    <!--yestoday end-->
    <!--weekday begin-->
    <div class="content" id="panel2-3">
      <a href="DRPOrderList.aspx?DayOf=weekday&Next=true" class="view-detail">查看详情</a>
      <div id="weekday" style="min-width:100%;height:400px;margin-top:10px;"></div> 
    </div>    
    <!--weekday end-->
    <!--moonth begin-->
    <div class="content" id="panel2-4">
      <a href="DRPOrderList.aspx?DayOf=month&Next=true" class="view-detail">查看详情</a>
      <div id="moonth" style="min-width:100%;height:400px;margin-top:10px;"></div> 
    </div>    
    <!--moonth end-->
    
  </div>
  <!--content end-->
  
    <script>
        $(document).foundation().foundation('joyride', 'start');
  </script>
</body>
</html>
