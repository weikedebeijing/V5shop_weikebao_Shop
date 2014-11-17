<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Card.aspx.cs" Inherits="V5APP.Store.UI.member.Card" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>
        <%if (bl)
          { %>
        <%=card.Name %>-
    <%} %>
         名片</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="../../member/js/WeiXinShare.js"></script>
    <script>
        $(function () {
            var url = $(this).attr("URL");
            var title = $(".title").text();
            var desc = "<%=card.Name %>" + "  " + "<%=card.Position %><br />" + "<%=card.Company %><br />" + "<%=card.MPhoneNo %>";
            var img_url = "http://" + window.location.host + "/UploadFile/UserImage/<%=card.HeadUrl %>";
            GetData(url, title, desc, img_url);
        });
    </script>
</head>

<body>
    <!--guide begin-->
    <div class="guide" id="guide" style="display: none">
        <img src="http://html.v5portal.com/distribution/images/MgnnofmleF.png" id="Cardfav" style="display: none;">
        <img src="http://html.v5portal.com/distribution/images/MgnnofmleM.png" id="Cardshare" style="display: none;">
    </div>
    <!--guide end-->

    <%if (bl)
      { %>
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="Member.aspx" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">名片</h1>
            </section>
            <section class="right-small right-small-text2">
                <a href="EditCard.aspx" class="button [radius round] top-button">编辑</a>
            </section>
        </nav>
    </div>
    <%} %>
    <!--bg begin-->
    <div class="card-cont">
        <!--head begin-->
        <div class="row">
            <div class="small-12 large-12 columns card-infor-cont">
                <div class="person-info">
                    <span class="header">
                        <img src="../../UploadFile/UserImage/<%=card.HeadUrl %>"></span>
                    <span class="text-v">v</span>
                    <span class="name" id="Name"><%=card.Name %></span>
                    <span class="job" id="PositionAndCompany"><%=card.Position %><br />
                        <%=card.Company %></span>
                </div>
                <div class="code-pic">
                    <img src="../../UploadFile/QRCode/<%=open.QRCodeUrl %>">
                </div>
            </div>
        </div>
        <!--head end-->
        <!--company begin-->
        <div class="row card-infor">
            <div class="separate-line"></div>
            <ul class="disc infor-ul">
                <li><i class="icon-mobile"></i><span>手机：<%=card.MPhoneNo %></span></li>
                <%--                <li><i class="icon-tel"></i><span>电话：021－50896072</span></li>--%>
                <li><i class="icon-address"></i><span>地址：<%=card.AddressInfo %></span></li>
            </ul>
        </div>
        <!--company end-->
    </div>
    <!--bg begin-->
    <%if (!string.IsNullOrEmpty(card.Business))
      { %>
    <!--maindo begin-->
    <div class="card-maindo">
        主营业务:<%=card.Business %>
    </div>
    <!--maindo end-->
    <%} %>
    <!--pic begin-->
    <div class="uppic">
        <ul class="uppic-ul">
            <li><span>
                <img src="../../UploadFile/UserImage/<%=card.Image1 %>" onerror="imgerror(this)"></span></li>
            <li class="middle"><span>
                <img src="../../UploadFile/UserImage/<%=card.Image2 %>" onerror="imgerror(this)"></span></li>
            <li><span>
                <img src="../../UploadFile/UserImage/<%=card.Image3 %>" onerror="imgerror(this)"></span></li>
        </ul>
    </div>
    <!--pic end-->
    <!--button begin-->
    <div class="row card-share">
        <a href="javascript:void(0)" onclick="cardfav()" class="card-fav"><i class="icon-fav-card"></i><span>收藏</span></a>
        <a href="javascript:void(0)" onclick="cardshare()" class="card-share"><i class="icon-share-card"></i><span>分享</span></a>
    </div>
    <!--button end-->
    <!--button begin-->
    <div class="card-button">
        <a href="../../<%=open.Code %>/index.aspx" class="button view-store">访问我的微店</a>
    </div>
    <!--botton end-->
    <script type="text/javascript">
        function imgerror(obj) {
            $(obj).attr("src", "../../member/images/none-pic.png");

        }

        function preventNo(e) {
            e.preventDefault();
        }

        function cardfav() {
            $("#Cardshare").hide();

            var topheight = document.body.scrollTop;
            var scrollHeight = document.body.scrollHeight;
            $("#guide").attr("style", "height:" + (scrollHeight + topheight) + "px");
            $("#Cardfav").attr("style", "padding-top:" + topheight + "px");
            $("#guide").show();
            $("#Cardfav").show();
            document.addEventListener('touchmove', preventNo, false);
        }
        function cardshare() {
            $("#Cardfav").hide();

            var topheight = document.body.scrollTop;
            var scrollHeight = document.body.scrollHeight;
            $("#guide").attr("style", "height:" + (scrollHeight + topheight) + "px");
            $("#Cardshare").attr("style", "padding-top:" + topheight + "px");
            $("#guide").show();
            $("#Cardshare").show();
            document.addEventListener('touchmove', preventNo, false);
        }

        function ToNormal() {
            $("#Cardfav").hide();
            $("#Cardshare").hide();
            $("#guide").hide();
            document.removeEventListener('touchmove', preventNo, false);
        }

        $("#guide").click(function () {
            ToNormal();
        })

    </script>
</body>
</html>
