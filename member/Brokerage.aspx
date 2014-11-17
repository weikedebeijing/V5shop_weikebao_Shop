<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Brokerage.aspx.cs" Inherits="V5APP.Store.UI.member.Brokerage" %>


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
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.tab.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.accordion.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>
<body>
    <!--mask begin-->
    <div class="mask"></div>
    <!--mask end-->
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="Member.aspx" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">我的佣金</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--yesterday begin-->
    <div class="panel bro-yesterday">
        <p><i class="icon-date"></i>昨日佣金</p>
        <span>￥<%:YesterdayBrokerage()%></span>
        <%if (levelID == 1)
          { %>
        <div class="bro-yesterday-detail">
            <div class="fl-l">
                <p>昨日个人佣金</p>
                <span>￥<%:YesterdayBrokerage() %></span>
            </div>
            <div class="fl-l">
                <p>昨日子店佣金提成</p>
                <span>￥<%:YesterdayNextBrokerage()%></span>
            </div>
        </div>
        <%} %>
    </div>
    <!--yesterday end-->
    <!--total begin-->
    <% var commissionRateAmount = customerShopStatistics.Amount; %>
    <div class="panel bro-total">
        <span>佣金总额</span>￥<%=commissionRateAmount.ToString("0.00") %>
    </div>
    <!--total end-->
    <!--table begin-->
    <% //var personCommission =  customerShopStatistics.;%>
    <%if (ParentID!=0)
      { %>
    <dl class="tabs tab-title4" data-tab>
        <dd class="active"><a href="#panel2-1">个人佣金总额<span>￥<%=personCommissionAmount.ToString("0.00") %></span><i class="icon-arrow-b"></i></a></dd>
        <dd><a href="#panel2-2">子店佣金提成<span>￥<%=nextRateAmount.ToString("0.00") %></span><i class="icon-arrow-b"></i></a></dd>
    </dl>
    <%} %>
    <!--content begin-->
    <div class="tabs-content tabcontent04">
        <!--self begin-->
        <div class="content active" id="panel2-1">
            <!--table begin-->
            <%  %>
            <table class="bro-block">
                <tr>
                    <td>
                        <span>近一周佣金</span>￥<%:NearlyWeekBrokerage() %>
                    </td>
                    <td>
                        <span>近一个月佣金</span>￥<%:NearMonthBrokerage() %>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>已提取佣金</span>￥<%=customerShopStatistics.CashAmount.ToString("0.00") %>
                    </td>
                    <td>
                        <span>累计佣金</span>￥<%=personCommissionAmount.ToString("0.00") %>
                    </td>
                </tr>
            </table>
            <!--table end-->
            <!--view detail begin-->
            <a href="BrokerageLog.aspx" class="bro-viewa">查看佣金明细</a>
            <!--view detail end-->
        </div>
        <!--self end-->
        <!--other begin-->
        <%if (ParentID != 0)
          { %>
        <div class="content" id="panel2-2">
            <!--table begin-->
            <table class="bro-block">
                <tr>
                    <td>
                        <span>近一周佣金</span>￥<%:NearlyWeekNextBrokerage() %>
                    </td>
                    <td>
                        <span>近一个月佣金</span>￥<%:NearMonthNextBrokerage() %>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>已提取佣金</span>￥<%=nextCashAmount.ToString("0.00") %>
                    </td>
                    <td>
                        <span>累计佣金</span>￥<%=nextRateAmount.ToString("0.00") %>
                    </td>
                </tr>
            </table>
            <!--table end-->
            <!--view detail begin-->
            <a href="BrokerageLog.aspx?Next=true" class="bro-viewa">查看佣金明细</a>
            <!--view detail end-->
        </div>
        <%} %>
    </div>

    <div class="bro-extract-btn">
        <a href="Extract.aspx" class="button [radius round] red">立即提取</a>
    </div>
    <div class="h50"></div>

    <div class="fixed bottom">
        <div class="shareList">
            <ul class="small-block-grid-4" id="sharelist">
                <li shareid="tsina"><i class="icon-sina"></i><span class="name">新浪微博</span></li>
                <li shareid="qzone"><i class="icon-qqzone"></i><span class="name">QQ空间</span></li>
                <li shareid="tqq"><i class="icon-txwb"></i><span class="name">腾讯微博</span></li>
                <li class="no-line" shareid="xiaoyou"><i class="icon-friend"></i><span class="name">朋友网</span></li>
                <li shareid="ydnote"><i class="icon-youdao"></i><span class="name">有道云笔记</span></li>
            </ul>
        </div>
        <dl class="sub-nav nav-b4">
            <dd class="share"><a href="javascript:void(0);" id="share-a"><i class="icon-share"></i>分享店铺<span></span></a></dd>
            <dd><a href="../../<%=shopID %>/index.aspx"><i class="icon-store"></i>逛店铺</a></dd>
            <dd class="active"><a href="javascript:void(0)"><i class="icon-commision"></i>我的佣金</a></dd>
            <dd><a href="member.aspx"><i class="icon-member"></i>个人中心<span></span></a></dd>
        </dl>
    </div>
    <script>
        $(document).foundation().foundation('joyride', 'start');

        $(document).ready(function () {
            $("#share-a").click(function () {
                $(".shareList").slideToggle("slow");
                $(".mask").toggle();
            })

            $(".share").click(function () {//分享加载icon三角形
                $(this).parent().find(".arrow").removeClass("arrow");
                $(this).parent().find("dd").removeClass("active");

                $(this).find("a").find("span").addClass("arrow");
                $(this).addClass("active");
            });

            $(".sub-nav dd").click(function () {
                if ($(this).attr("class").indexOf("share")) {
                    $(this).parent().find("dd").removeClass("active");
                    $(this).parent().find(".arrow").removeClass("arrow");
                    $(this).addClass("active");
                }
            });
        })
    </script>
    <!-- JiaThis Button BEGIN -->

    <script type="text/javascript">
        $("#sharelist li").click(function () {
            var shareurl = "<%=shopUrl%>index.aspx";
            var title = "我的微店:<%=currShopTitle%>";
            var shareid = $(this).attr("shareid");
            window.location.href = "http://www.jiathis.com/send/?webid=" + shareid + "&url=" + shareurl + "&title=" + title + "&shortUrl=false&hideMore=false";
        })

    </script>
</body>
</html>
