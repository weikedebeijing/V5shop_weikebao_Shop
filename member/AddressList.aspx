<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddressList.aspx.cs" Inherits="V5APP.Store.UI.member.AddressList" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>地址</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>
<body class="body-gray">

    <!--submit errow tip begin-->
    <div data-alert class="alert-box alert" id="errerMsg" style="display: none;"><a href="#" class="close">&times;</a></div>
    <!--submit errow tip end-->


    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="javascript:void(0)" onclick="backPage()" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">地址</h1>
            </section>
            <%--  <section class="right-small">
                <a class="menu-add" href="EditAddress.aspx"><span></span></a>
            </section>--%>
        </nav>
    </div>
    <!--topbar end-->
    <!--button add begin-->
    <div class="listAdd-btn">
        <a id="editaddressurl" href="EditAddress.aspx" class="button [radius round]"><i>+</i>添加地址</a>
    </div>
    <!--button add begin-->
    <!--content begin-->
    <ul class="side-nav address" id="ul">

        <%foreach (var address in li)
          { %>
        <%if (address.IsDefault)
          { %>
        <li class="current" id="0">
            <%}
          else
          { %>
        <li id="<%=address.ID %>">
            <%} %>
            <a href="javascript:void(0)" class="classnone">
                <span class="payInfo"><%=address.Name %><span class="mobile"><%=address.Moblie %></span><br>
                    <%=address.AddressInfo %></span>
                <span class="payStatus">默认</span>
            </a>
            <div class="opera">
                <a href="EditAddress.aspx?ID=<%=address.ID %>" class="a-edit"><i class="icon-edit-gray"></i></a>
                <%if (address.IsDefault)
                  { %>
                <a href="javascript:void(0)" onclick="DelAddress(0)" class="a-del"><i class="icon-del-gray"></i></a>
                <%}
                  else
                  { %>
                <a href="javascript:void(0)" onclick="DelAddress(<%=address.ID %>)" class="a-del"><i class="icon-del-gray"></i></a>
                <%} %>
            </div>
        </li>
        <%} %>
    </ul>
    <!--content end-->
</body>
<script type="text/javascript">
    function DelAddress(addressID) {
        if (addressID == 0) {
            ShowMsg("默认地址不可删除");
            return false;
        } else {
            $.ajax({
                url: "../member/ajax/LoginHandle.aspx",
                data: { "action": "DelAddress", "AddressID": addressID },
                async: false,
                cache: false,
                success: function (res) {
                    if (res == "true") {
                        window.location.href = "AddressList.aspx";
                    } else {
                        ShowMsg("删除失败,请稍候再试");
                    }
                }
            })
        }

    }
    $(function () {
        var pageurl = request("url");
        if (pageurl != "") {
            $("#editaddressurl").attr("href", "EditAddress.aspx?url=" + pageurl);
        }


        $("#ul li").click(function (event) {
            var obj = this;
            if (getEventTarget(event, 1).tagName != "A" || getEventTarget(event, 1).className == "classnone") {

                ///alert(1);
                var addressID = $(this).attr("id");
                if (addressID != "0") {
                    $.ajax({
                        url: "../member/ajax/LoginHandle.aspx",
                        data: { "action": "DefaultAddress", "AddressID": addressID },
                        async: false,
                        cache: false,
                        success: function (res) {
                            if (res == "true") {
                                $("#list li").removeClass("current");
                                $(obj).addClass("current");
                                var pageurl = request("url");
                                if (pageurl == "") {
                                    window.location.href = "AddressList.aspx"
                                } else {
                                    window.location.href = "../" + pageurl;
                                }
                            } else {
                                ShowMsg("修改失败,请稍候再试");
                            }
                        }
                    })
                }
            }
        })
        function getEventTarget(event, targetType) {
            event = event || window.event;
            if (targetType == 1) {// 获得触发的对象
                return event.target || event.srcElement;
            } else if (targetType == 2) {// 获得处理事件的对象
                return event.currentTarget;
            }
        }
    })

    function backPage() {
        var pageurl = request("url");
        if (pageurl == "") {
            window.location.href = "member.aspx"
        } else {
            window.location.href = "../" + pageurl;
        }

    }
</script>
</html>
