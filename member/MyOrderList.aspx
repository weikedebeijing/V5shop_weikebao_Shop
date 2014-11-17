<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyOrderList.aspx.cs" Inherits="V5APP.Store.UI.member.MyOrderList" %>

<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
    <title></title>
    <%--<link rel="stylesheet" type="text/css" href="../../member/css/jquery.mobile-1.3.2.min.css" />--%>
      <title>申请分销</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/controlJS.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.alert.js"></script>
<%--    <link rel="stylesheet" type="text/css" href="../../member/css/list.css" />--%>
    <script src="../../member/js/iscroll.js" type="text/javascript"></script>
    <script src="../../member/js/iscrollAssist.js" type="text/javascript" charset="gb2312"></script>
    <script src="../../member/js/order.js" type="text/javascript"></script>
    <script type="text/javascript">
        var localordercmd = "X1";
        var page = 1;
        var PAGESIZE = 5;
        var MaxPage = 1;

        var NoPaidOrderCount = <%=NoPaidOrderCount%>;
        var NoDeliveryOrderCount = <%=NoDeliveryOrderCount%>;

        $(function () {

            if (localordercmd == "X1" && NoPaidOrderCount == 0 ||
                localordercmd == "X2" && NoDeliveryOrderCount == 0)
            {
                $("#myorder-none").show();
            }

            $("#tabs_dl dd").click(function () {
                $("#tabs_dl dd").removeClass("active");
                $(this).addClass("active");
                localordercmd = $(this).attr("localordercmd");
                $("#dataArea").html("");

                $("#myorder-none").hide();

                if (localordercmd == "X1" && NoPaidOrderCount == 0 ||
                    localordercmd == "X2" && NoDeliveryOrderCount == 0)
                {
                    $("#myorder-none").show();
                    return;
                }

                page = 1;
                MaxPage = 1;

                FillData(localordercmd, 1, PAGESIZE);
            })
        })

        function FillData(_cmd, _pagenum, _pagesize) {
            $.ajax({
                url: "./MyPartialOrderList.aspx",
                type: "post",
                dataType: "html",
                async: false,
                data: { ordercmd: _cmd, pagenum: _pagenum, pagesize: _pagesize },
                success: function (response) {
                    data = response.split("@@Split@@");
                    data.splice(0, 1);

                    if (data.length == 0)
                    {
                        MaxPage--;
                    }

                    if (data.length < PAGESIZE || page > MaxPage) {
                        //page--;
                        //hasMoreData = false;
                        //$("#pullUp").hide();
                    } else {
                        //hasMoreData = true;
                        MaxPage++;
                        //$("#pullUp").show();
                    }
                    $.each(data, function (key, value) {
                        $("#dataArea").append(value);
                    });
                }
            })
        }

        $(document).ready(function () {
            FillData(localordercmd, 1, PAGESIZE);
        });

        (function ($) {
            $(function () {
                var pulldownAction = function () {
                    $("#dataArea").html("");
                    FillData(localordercmd, 1, PAGESIZE);
                    this.refresh();
                    console.log("下拉执行逻辑");
                };
                var pullupAction = function () {
                    page++;
                    if (page <= MaxPage)
                    {
                        FillData(localordercmd, page, PAGESIZE);
                    }
                    else
                    {
                        page--;
                    }
                    this.refresh();
                    console.log("上拉执行逻辑");
                };
                var iscrollObj = iscrollAssist.newVerScrollForPull($('#wrapper'), pulldownAction, pullupAction);
                iscrollObj.refresh();
            });
        })(jQuery);
    </script>
</head>
<body>
  <!--topbar begin-->
  <div class="fixed">
    <nav class="tab-bar">
      <section class="left-small">
        <a class="menu-icon" href="./Member.aspx"><span></span></a>
      </section>
      <section class="middle tab-bar-section">
        <h1 class="title">我的订单</h1>
      </section>
    </nav>
  </div>
  <!--topbar end-->
    <!--table begin-->
    <dl id="tabs_dl" class="tabs tab-title3" data-tab>
        <dd class="active" localordercmd="X1"><a href="javascript:void(0)">待付款(<%=NoPaidOrderCount %>)</a></dd>
        <dd localordercmd="X2"><a href="javascript:void(0)">已付款(<%=NoDeliveryOrderCount %>)</a></dd>
        <dd localordercmd="X3"><a href="javascript:void(0)">已结束</a></dd>
    </dl>
    <!--table end-->
    <div id="pay" style="display:none"></div>
  <!--content begin-->
    <div class="tabs-content" id="wrapper">
      <div id="scroller" class="content active">

          
            <div id="pulldown" class="idle">
                <span class="pullDownIcon"></span><span class="pullDownLabel" id="pulldown-label">
                </span>
            </div>
            <!--none begin-->
            <div id="myorder-none" class="myorder-none" style="display:none;"><i class="icon-none"></i><span class="nonetext">你还没有订单！</span><a href="../" class="nonelink">去逛逛</a></div>
            <!--none end-->

            <div class="" id="dataArea">
            </div>
            <div id="pullup" class="idle">
                <span class="pullUpIcon"></span><span class="pullUpLabel" id="pullup-label"></span>
            </div>
      </div>
    </div>
  <!--content begin-->
<%--  <script>
      $(document).foundation().foundation('joyride', 'start');
  </script>--%>
</body>
</html>
