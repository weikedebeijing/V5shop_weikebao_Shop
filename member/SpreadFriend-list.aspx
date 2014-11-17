<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpreadFriend-list.aspx.cs" Inherits="V5APP.Store.UI.member.SpreadFriend_list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection" content="telephone=no" />
    <title>会员中心</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution//foundation/css/foundation.css" />
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution//foundation/css/normalize.css" />
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution//css/common.css" />
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution//css/dis.css" />
    <script src="http://html.v5portal.com/distribution//foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution//foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution//foundation/js/foundation/foundation.tab.js"></script>
    <script>
        $(document).ready(function () {


            $("#figure-search").click(function () {
                $("#search").fadeIn();
                $("#search-mask").fadeIn();
            })
            $("#search-cancel").click(function () {
                $("#search").fadeOut();
                $("#search-mask").fadeOut();

            })
            $("#search-mask").click(function () {
                $("#search").fadeOut();
                $("#search-mask").fadeOut();
            })


            //showPreview();

            $(".li-spreadFList").click(function () {
                var datakey = $(this).attr("datakey");
                var customerID = $("#hiddenCustomerID").val();
                $.ajax({
                    url: "Ajax/GateWay.aspx",
                    data: { "action": "ADDCUSTOMERFRIEND", "friendsID": datakey, "customerID": customerID },
                    success: function (res) {
                        if (res == "ok") {
                            window.location.href = "spreadFDetail.aspx?ID=" + datakey;
                        }
                        else {
                            alert("操作失败！");
                        }
                    },
                    error: function () {
                        alert("操作失败！");
                    }
                })

            });
        })

        document.onkeydown = function (event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) { // enter 键
                btnSearch();
                return false;

            }
        }
    </script>
</head>

<body>
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a class="menu-icon" href="Member.aspx"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">朋友圈推广</h1>
            </section>
            <section class="right-small right-small-product">
                <a href="javascript:void(0);" id="figure-search"><i class="icon-search-white"></i></a>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--search begin-->
    <div class="search" id="search">
        <%--<form>--%>
        <div class="row">
            <div class="small-10 large-4 columns">
                <i class="icon-search-gray" onclick="btnSearch()"></i>
                <input type="hidden" id="hiddenCustomerID" value="<%=CustomerID%>" />
                <input type="text" id="txtQuery" placeholder="请输入信息关键字" />
                <span class="close-input" style="display: none;"></span>
            </div>
            <div class="small-2 large-4 columns">
                <a href="#" class="cancel" id="search-cancel">取消</a>
            </div>
        </div>
        <%-- </form>--%>
    </div>
    <div class="search-mask" id="search-mask"></div>
    <!--search end-->
    <!--table begin-->
    <dl class="tabs tab-title3-2" data-tab id="lookstatus">
        <dd class="active"><a href="javascript:void(0)" onclick="showtype(0)">未查看(<%=unreadfriendsCircleList.Count %>)</a></dd>
        <dd><a href="javascript:void(0)" onclick="showtype(1)">已查看(<%=readfriendsCircleList.Count %>)</a></dd>
    </dl>
    <!--table end-->
    <!--content begin-->
    <div class="tabs-content">
        <!--have begin-->
        <div class="content active padding0" id="panel2-1">
            <!--tips begin-->
            <div class="spreadFList-tip"><i class="icon-tip"></i><span class="text-tip">每日一新发送商品至朋友圈，让你的订单时刻保持不断！</span></div>
            <!--tips begin-->
            <%if (unreadfriendsCircleList.Count == 0)
              { %>
            <!--none begin-->
            <div class="disorder-none"><i class="icon-none"></i><span class="nonetext">你还没未查看信息！</span></div>
            <!--none end-->
            <% }
              else
              {%>
            <div style="display: ;" class="spreadFList">
                <ul class="ul-spreadFList" id="ul-friends">
                    <%foreach (var friendCircle in unreadfriendsCircleList)
                      { %>
                    <li class="li-spreadFList" datakey="<%=friendCircle.ID %>">
                        <a class="a-spreadFList">
                            <span class="logo">
                                <img src="<%=logo %>"></span>
                            <div class="r-content">
                                <span class="logo-name"><%=OpendTitle %></span>
                                <div class="text" style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"><%=friendCircle.Description %></div>
                                <%--<img id="BigImg" src="" style="display:none;" />--%>
                                <ul class="small-block-grid-3 medium-block-grid-3 large-block-grid-3 pic9" id="imgList">
                                    <% var imgs = friendCircle.CircleImg.Split(';');
                                       for (var i = 0; i < imgs.Length; i++)
                                       {
                                    %>
                                    <li style="background-image: url(<%=PlantFormPath+imgs[i] %>)"><%--<img src="<%=PlantFormPath+imgs[i] %>"  style="width:120px;height:120px;" />--%></li>
                                    <%} %>
                                </ul>
                                <% TimeSpan unreadDate = DateTime.Now.Subtract(DateTime.Parse(friendCircle.ModifyDate.ToString("yyyy-MM-dd")));
                                   if (unreadDate.Days == 0)
                                   {
                                %>
                                <div class="date">今天</div>
                                <%}
                                   else if (unreadDate.Days == 1)
                                   { %>
                                <div class="date">昨天</div>
                                <%}
                                   else
                                   { %>
                                <div class="date"><%=unreadDate.Days %>天前</div>
                                <%} %>
                            </div>
                        </a>
                    </li>
                    <%} %>
                </ul>
            </div>
            <% }%>
        </div>
        <!--have end-->
        <!--wait begin-->
        <div class="content padding0" id="panel2-2" style="display: none">
            <%if (readfriendsCircleList.Count == 0)
              { %>
            <!--none begin-->
            <div class="disorder-none"><i class="icon-none"></i><span class="nonetext">你还没有已查看信息！</span></div>
            <!--none end-->
            <% }
              else
              {%>
            <div style="display: ;" class="spreadFList">
                <ul class="ul-spreadFList" id="ul1">
                    <%foreach (var friendCircle in readfriendsCircleList)
                      { %>
                    <li datakey="<%=friendCircle.ID %>" class="li-spreadFList">
                        <a class="a-spreadFList">
                            <span class="logo">
                                <img src="<%=logo %>"></span>
                            <div class="r-content">
                                <span class="logo-name"><%=OpendTitle %></span>
                                <div class="text" style="text-overflow: ellipsis; overflow: hidden; white-space: nowrap;"><%=friendCircle.Description %></div>
                                <%--<img id="BigImg" src="" style="display:none;" />--%>
                                <ul class="small-block-grid-3 medium-block-grid-3 large-block-grid-3 pic9" id="Ul2">
                                    <% var imgs = friendCircle.CircleImg.Split(';');
                                       for (var i = 0; i < imgs.Length; i++)
                                       {
                                    %>
                                    <li style="background-image: url(<%=PlantFormPath+imgs[i] %>)"><%--<img src="<%=PlantFormPath+imgs[i] %>"  style="width:120px;height:120px;" />--%></li>
                                    <%} %>
                                </ul>
                                <% TimeSpan readDate = DateTime.Now.Subtract(DateTime.Parse(friendCircle.ModifyDate.ToString("yyyy-MM-dd")));
                                   if (readDate.Days == 0)
                                   {
                                %>
                                <div class="date">今天</div>
                                <%}
                                   else if (readDate.Days == 1)
                                   { %>
                                <div class="date">昨天</div>
                                <%}
                                   else
                                   { %>
                                <div class="date"><%=readDate.Days %>天前</div>
                                <%} %>
                            </div>
                        </a>
                    </li>
                    <%} %>
                </ul>
            </div>
            <% }%>
        </div>
        <!--wait end-->
    </div>
    <!--content begin-->
    <script>
        function showtype(islook) {
            if (islook == 0) {
                $("#panel2-2").hide();
                $("#panel2-1").show();
            } else {
                $("#panel2-1").hide();
                $("#panel2-2").show();

            }
            $("#lookstatus").attr("panel", islook)

        }

        $(document).foundation().foundation('joyride', 'start');

        function btnSearch() {
            var query = $("#txtQuery").val();
            var logo = "<%=logo%>";
            var status = $("#lookstatus").attr("panel") == undefined ? 0 : $("#lookstatus").attr("panel");
            $.ajax({
                url: "Ajax/GateWay.aspx",
                data: { "action": "getfriend", "query": query, "logo": logo, "panelStatus": status, "CustomerID": $("#hiddenCustomerID").val() },
                async: false,
                success: function (res) {
                    if (status == "0") {
                        $("#panel2-1 ul li").remove();
                        if (res != null) {
                            $("#panel2-1 ul").html(res);
                        }
                    }
                    else {
                        $("#panel2-2 ul li").remove();
                        if (res != null) {
                            $("#panel2-2 ul").html(res);
                        }
                    }
                    $("#search-mask").click();
                },
                error: function (res) {
                    alert("加载失败" + res);
                }
            });
        }

    </script>
</body>
</html>
