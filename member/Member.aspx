<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Member.aspx.cs" Inherits="V5APP.Store.UI.member.Member" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>会员中心</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.reveal.js"></script>
    <script src="../../member/js/Common.js"></script>
    <script type="text/javascript">
        $(function () {
            var isshow = request("isshow");
            if (isshow == "1") {
                $("#personStatus").addClass("status-info");
            }
            else {
                $("#personStatus").removeClass("status-info");
            }

            $(".share,.active").click(function () {//分享加载icon三角形
                $(this).parent().find(".arrow").removeClass("arrow");
                $(this).find("a").find("span").addClass("arrow");
            });

            //点击我的店铺，分销订单记录时间
            $("#subShop,#drpOrder").click(function () {
                var type;
                if ($(this).attr("id") == "subShop") {
                    type = 0;
                }
                else {
                    type = 1;
                }
                var userid = $("#hiddenCustomerID").val();
                $.ajax({
                    url: "Ajax/GateWay.aspx",
                    data: { "action": "saveRecord", "user_id": userid, "type": type },
                    success: function (res) {
                        if (res == "ok") {
                            if (type == 0) {
                                window.location.href = "LowLevel.aspx";
                            }
                            else {
                                window.location.href = "DRPOrderList.aspx";
                            }
                        }
                        else {
                            alert("跳转失败");
                        }
                    },
                    error: function () {
                        alert("跳转失败");
                    }
                });
            });
        })

        function closepic() {
            $("#showpic").hide();
        }

    </script>
</head>

<body class="body-gray">
    <!--mask begin-->
    <div class="mask"></div>
    <!--mask end-->
    <!--topbar begin-->
    <!--fillout tip begin-->
    <div class="fillouttip-p" id="showpic" style="display: none">
        <input type="hidden" id="hiddenCustomerID" value="<%=CustomerID %>" />
        <div class="close-div"><span class="close" onclick="closepic()"></span></div>
        <a href="PersonalCenter.aspx">
            <img src="http://html.v5portal.com/distribution/images/tip-p.png"></a>
    </div>
    <!--fillout tip end-->
    <!--alert begin-->
    <div id="myStore" class="reveal-modal alert-header radius" data-reveal>
        <ul class="side-nav">
            <li class="first"><a href="EditStore.aspx"><i class="icon-edit-w"></i>编辑店铺</a></li>
            <li class="last"><a href="../../<%=channelCode %>/"><i class="icon-eye-w"></i>预览店铺</a></li>
        </ul>
    </div>
    <div id="myCard" class="reveal-modal alert-header radius" data-reveal>
        <ul class="side-nav">
            <li class="first"><a href="EditCard.aspx"><i class="icon-edit-w"></i>编辑名片</a></li>
            <li class="last"><a href="card.aspx?id=<%=customer.ID %>"><i class="icon-eye-w"></i>预览名片</a></li>
        </ul>
    </div>
    <!--alert end-->
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">会员中心</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--head begin-->

    <%if (channelCode == "C001")
      { %>
    <div class="panel memberhead">
        <div class="header-l"><i class="icon-level-p"></i></div>
        <div class="name-p">
            <% if (customer.Status == (int)V5.MetaData.Util.AppEnum.CustomerStatusType.Unbound)
               { %>
            <span class="round alert label"><a href="CustomerBind.aspx">绑定</a>个人账号，获取更多优惠</span>
            <%}
               else
               { %>
            <%=customer.LoginName %>
            <%} %>
        </div>
    </div>

    <div class="addvistion" id="addvistion">
    <%--    <a href="AddStore.aspx">
            <img src="http://html.v5portal.com/distribution/images/ad_02.png"></a><a href="javascript:void(0)" onclick="addclose()" class="close"></a>--%>
    </div>


    <%}
      else
      { %>
    <div class="panel memberhead">
        <div class="header-l"><i class="icon-level-dis"></i></div>
        <div class="header-r">
            <% if (customer.Status == (int)V5.MetaData.Util.AppEnum.CustomerStatusType.Unbound)
               { %>
            <span class="round alert label"><a href="CustomerBind.aspx">绑定</a>个人账号，获取更多优惠</span>
            <span class="store-title">我的微店：</span><a href="<%=marketUrl %>" class="store-address"><%=marketUrl %></a>

            <%}
               else
               { %>
            <span class="name"><%=customer.LoginName %></span>
            <span class="store-title">我的微店：</span><a href="<%=marketUrl %>" class="store-address"><%=marketUrl %></a>
            <%} %>
        </div>

        <%} %>



        <%--<a href="PersonalCenter.aspx" class="content">
            <span class="pic-header">
                <img src="<%=logurl %>" style="display: ;"></span>

            <% if (customer.Status == (int)V5.MetaData.Util.AppEnum.CustomerStatusType.Unbound)
               { %>
            <span class="name">未设置会员名称</span>
            <%}
               else
               { %>

            <%} %>
            <span class="personaldata">个人资料<i class="arrow-r"></i></span>
        </a>--%>
    </div>
    <!--head end-->
    <!--count begin-->
    <%if (isDrp)
      { %>
    <div class="row count">
        <div class="small-3 large-3 columns first"><a href="DRPOrderList.aspx" class="count-a">
            <p class="count-dis-mony"><%=OrderCount %></p>
            <span class="count-title">分销订单</span></a></div>
        <div class="small-3 large-3 columns mid"><a href="Total.aspx" class="count-a">
            <p class="count-dis-mony"><small>￥</small><%=ProductAmount.ToString("0.00") %></p>
            <span class="count-title">成交总额</span></a></div>
        <div class="small-3 large-3 columns mid"><a href="dis-brokerage.aspx" class="count-a">
            <p class="count-dis-mony"><small>￥</small><%=DrpCommission.ToString("0.00") %></p>
            <span class="count-title">分销提成</span></a></div>
        <div class="small-3 large-3 columns last"><a href="SubStoreBrokerage.aspx" class="count-a">
            <p class="count-dis-mony"><small>￥</small><%=NextDrpCommission.ToString("0.00") %></p>
            <span class="count-title">子店提成</span></a></div>
    </div>
    <%} %>
    <!--count end-->
    <!--side nav begin-->
    <div class="panel member-nav">
        <ul class="side-nav">

            <li class="last"><a href="PersonalCenter.aspx"><i class="icon-personal"></i><span class="text">个人资料</span><span id="personStatus" class="status-info"></span><i class="arrow"></i></a></li>
        </ul>
    </div>
    <%if (channelCode == "C001")
      { %>
    <div class="panel member-nav">
        <ul class="side-nav">
            <%-- <li><a href="AddStore.aspx"><i class="icon-dis"></i><span class="text">我要分销</span><i class="arrow"></i></a></li>--%>
        </ul>
    </div>
    <!--nav02 end-->
    <!--nav 03 begin-->
    <div class="panel member-nav">
        <ul class="side-nav">
            <li><a href="MyOrderList.aspx"><i class="icon-myorder"></i><span class="text">我的购买</span><i class="arrow"></i></a></li>
        </ul>
    </div>
    <%}
      else
      { %>
    <div class="panel member-nav">
        <ul class="side-nav">
            <li><a href="#" data-reveal-id="myStore"><i class="icon-shop"></i><span class="text">我的微店</span><i class="arrow"></i></a></li>
            <li><a href="javascript:void(0)" data-reveal-id="myCard"><i class="icon-card"></i><span class="text">我的名片</span><i class="arrow"></i></a></li>
            <%if (level == 1)
              { %>
            <li class="last" id="subShop"><a href="javascript:void(0);"><i class="icon-lowLevel"></i><span class="text">我的子店</span>
                <%if (SubShop != 0)
                  { %><span class="tip-number"><%=SubShop %></span><%} %><i class="arrow"></i></a></li>
            <%} %>
        </ul>
    </div>
    <div class="panel member-nav">
        <ul class="side-nav">
            <li><a href="brokerage.aspx"><i class="icon-commission"></i><span class="text">我的佣金</span><i class="arrow"></i></a></li>
            <li class="last"><a href="ExtractAccount.aspx"><i class="icon-account"></i><span class="text">提现账户</span><i class="arrow"></i></a></li>
        </ul>
    </div>
    <div class="panel member-nav">
        <ul class="side-nav">
            <li><a href="MyOrderList.aspx"><i class="icon-myorder"></i><span class="text">我的购买</span><i class="arrow"></i></a></li>
            <li class="last" id="drpOrder"><a href="javascript:void(0);"><i class="icon-disorder"></i><span class="text">分销订单</span>
                <%if (DrpOrder != 0)
                  { %>
                <span class="tip-number"><%=DrpOrder %></span><%} %><i class="arrow"></i></a></li>
        </ul>
    </div>
    <div class="panel member-nav">
        <ul class="side-nav">
            <li><a href="SpreadFriend-list.aspx"><i class="icon-friends"></i><span class="text">朋友圈推广</span>
                <%if (unReadCount != 0)
                  { %>
                <span class="tip-number"><%=unReadCount %></span><%} %><i class="arrow"></i></a></li>

            <li class="last"><a href="QrCode.aspx"><i class="icon-qrcode"></i><span class="text">店铺二维码</span><i class="arrow"></i></a></li>
        </ul>
    </div>
    <%} %>
    <!--side nav end-->
    <!--bottom begin-->
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
        <%if (isDrp)
          { %>
        <dl class="sub-nav nav-b4">
            <dd class="share"><a href="javascript:void(0);" id="share-a"><i class="icon-share"></i>分享店铺<span></span></a></dd>
            <dd><a href="../../<%=shopID %>/index.aspx"><i class="icon-store"></i>逛店铺</a></dd>
            <dd><a href="Brokerage.aspx"><i class="icon-commision"></i>我的佣金</a></dd>
            <dd class="active"><a href="javascript:void(0)"><i class="icon-member"></i>个人中心<span class="arrow"></span></a></dd>
        </dl>
        <%}
          else
          { %>
        <%if (shopID == "C001")
          { %>
        <dl class="sub-nav nav-b4">
            <dd style="width:33.33%"  class="share"><a href="javascript:void(0);" id="share-a"><i class="icon-share"></i>分享店铺<span></span></a></dd>
            <dd style="width:33.33%"><a href="../../<%=shopID %>/index.aspx"><i class="icon-store"></i>逛店铺</a></dd>
            <%--           <dd><a href="AddStore.aspx"><i class="icon-distribusion"></i>我要分销</a></dd>--%>
            <dd  style="width:33.33%" class="active"><a href="javascript:void(0)"><i class="icon-member"></i>个人中心<span class="arrow"></span></a></dd>
        </dl>
        <%}
          else
          { %>
        <dl class="sub-nav nav-b4">
            <dd class="share"><a href="javascript:void(0);" id="share-a"><i class="icon-share"></i>分享店铺<span></span></a></dd>
            <dd><a href="../../<%=shopID %>/index.aspx"><i class="icon-store"></i>逛店铺</a></dd>
            <dd><a href="../../<%=shopID %>/cart.aspx"><i class="icon-distribusion"></i>购物车</a></dd>
            <dd class="active"><a href="javascript:void(0)"><i class="icon-member"></i>个人中心<span class="arrow"></span></a></dd>
        </dl>
        <%} %>
        <%} %>
    </div>
    <!--bottom end-->
    <script>
        $(document).foundation().foundation('joyride', 'start');
        function addclose() {
            $("#addvistion").hide();

        }

        $(document).ready(function () {
            $("#share-a").click(function () {
                $(".shareList").slideToggle("slow");
                $(".mask").toggle();
            })
        })
    </script>

    <!-- JiaThis Button BEGIN -->

    <script type="text/javascript">
        $("#sharelist li").click(function () {
            var shareurl = "<%=marketUrl%>index.aspx";
            var title = "我的微店:<%=currShopTitle%>";
            var shareid = $(this).attr("shareid");
            window.location.href = "http://www.jiathis.com/send/?webid=" + shareid + "&url=" + shareurl + "&title=" + title + "&shortUrl=false&hideMore=false";
        })
    </script>
    <!-- JiaThis Button END -->

</body>
</html>
