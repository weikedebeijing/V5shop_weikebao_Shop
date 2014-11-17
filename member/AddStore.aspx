<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddStore.aspx.cs" Inherits="V5APP.Store.UI.member.AddStore" %>

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
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.alert.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>

<body class="body-gray">


    <!--submit errow tip begin-->
    <div data-alert class="alert-box alert" style="display: none;" id="errerMsg">请输入微店名！<a href="#" class="close">&times;</a></div>
    <!--submit errow tip end-->

    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="Member.aspx" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">设置店铺</h1>
            </section>
            <section class="right-small right-small-text3">
                <a href="javascript:void(0)" class="button [radius round] top-button" id="nextBtn">下一步</a>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--step01 begin-->
    <ul class="breadcrumbs step-store" id="ul">
        <li class="first current" id="settitle"><a href="javascript:void(0)"><i class="step-number">1</i>设置微店名称</a></li>
        <li class="second" id="setcategory"><a href="javascript:void(0)"><i class="step-number">2</i>选择商品分类</a></li>
        <li class="third"><a href="javascript:void(0)"><i class="step-number">3</i>完成</a></li>
    </ul>
    <!--step01 end-->
    <!--form begin-->
    <form class="mlr-15" id="form1">
        <div class="panel callout radius formstyle">
            <!--01 begin-->
            <div class="row">
                <div class="large-12 columns">
                    <input type="text" placeholder="请输入微店名" class="last" id="title">
                </div>
            </div>
            <!--01 end-->
        </div>
    </form>
    <!--form end-->
    <!--form begin-->
    <div class="mlr-15" id="form2">
        <h6>选择商品分类</h6>
        <div class="row catselect">
            <div class="large-12 columns pl0">
                <input id="checkbox1" type="checkbox" onclick="checkAll(this)"><label for="checkbox1">全选</label>
            </div>
        </div>
        <!--row01 begin-->

        <div id="device" class="category">

            <%
               
              for (int i = 0; i < li.Count; i++)
              {
                  var commissionRate = shopID == "C001" ? li[i].CommissionRate + li[i].NextCommissionRate : li[i].NextCommissionRate;
                  %>
            <div class="item current" name="columns" style="margin-bottom: 10px; zoom: 1; opacity: 1;" cid="<%=li[i].ID %>">
                <div>
                    <h5><%=li[i].Name %></h5>
                    <p>佣金<%=commissionRate.ToString("0.00")%>%</p>
                    <span style="display:none"><%=li[i].CommissionRate + li[i].NextCommissionRate  %></span>
                </div>
            </div>
            <%} %>
        </div>




        <!--row01 end-->
    </div>

    <script src="../../member/js/jquery.grid-a-licious.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#form2").hide();
            //$("#form2").css('opacity', '0');;

        });
    </script>

</body>
</html>
<script type="text/javascript">
    var title = "";
    var cids = new Array();
    var cidcount = $("div [name='columns']").length;

    $("#nextBtn").click(function () {
        var tempbl = "false";
        var tempid = $(".current").attr("id");
        if (tempid == "settitle") {
            title = $("#title").val().trim();
            if (title == "") {
                ShowMsg("店铺名称不可为空");
                return;
            } else {
                $.ajax({
                    url: "../member/ajax/LoginHandle.aspx",
                    data: { "action": "clickshoptitle", "ShopTitle": title },
                    async: false,
                    cache: false,
                    success: function (res) {
                        tempbl = res;
                    }
                })
            }
            if (tempbl != "true") {
                ShowMsg("店铺名称已存在");
                return;
            }
            $("#ul  li").removeClass("current");
            $("#setcategory").addClass("current");
            $("#form1").hide();
            //$("#form2").css('opacity', '1');;
            $("#form2").show();
            $("#device").gridalicious({
                gutter: 10,
                width: 150,
                animationOptions: {
                    speed: 150,
                    duration: 400,
                    complete: null
                },
            });
            $("#checkbox1").click();
            $("#nextBtn").text("保存");
            $("#nextBtn").parent().removeClass("right-small-text3").addClass("right-small-text2")
        } else if (tempid == "setcategory") {
            if (cids.length == 0) {
                ShowMsg("请选择商品分类");
                return;
            } else {
                $.ajax({
                    url: "../member/ajax/LoginHandle.aspx",
                    data: { "action": "createshop", "ShopTitle": title, "cids": cids, "OpenCode": "<%=shopID%>" },
                    async: false,
                    cache: false,
                    success: function (res) {
                        if (res == "true") {
                            var commissions = showCommission()
                            window.location.href = "StoreSuccess.aspx?commissions="+commissions;
                        } else { }
                    }
                })
            }
        }
    })
function checkAll(obj) {
    if (obj.checked) {
        //$("#cidAll").attr("checked", "checked");
        cids = new Array();
        $("div[name=columns]").each(function () {
            $(this).addClass("current");
            cids.push($(this).attr("cid"));
        })
        //alert(cids.length);
        //  cidcount = cids.length;
    } else {
        // $("#cidAll").attr("checked", "");
        $("div[name=columns]").each(function () {
            $(this).removeClass("current");
        })
        cids = new Array();
    }
}
//$(function () {
//$("div [name='columns']").click(function () {
//    if (!$(this).hasClass('current')) {
//        cids.push($(this).attr('cid'));
//        $(this).addClass("current");
//    } else {
//        cids.splice(cids.indexOf($(this).attr('cid')), 1);
//        $(this).removeClass("current");
//    }
//    if (cids.length < cidcount) {
//        document.getElementById("checkbox1").checked = false;
//    } else {
//        document.getElementById("checkbox1").checked = true;
//    }
//})

$(document).on('click', "div[name=columns]", function () {
    if (!$(this).hasClass('current')) {
        cids.push($(this).attr('cid'));
        $(this).addClass("current");
    } else {
        cids.splice(cids.indexOf($(this).attr('cid')), 1);
        $(this).removeClass("current");
    }
    if (cids.length < cidcount) {
        document.getElementById("checkbox1").checked = false;
    } else {
        document.getElementById("checkbox1").checked = true;
    }
});

//})

function showCommission()
{
    var minCommission = 100;
    var maxCommission = 0;
    $("#device .current").each(function () {
        var commission = parseFloat($(this).find("span").text());
        if (minCommission > commission)
        {
            minCommission = commission
        }
        if (maxCommission < commission)
        {
            maxCommission = commission;
        }
    });
    var commissions = "";
    if (minCommission == maxCommission) {
        commissions = maxCommission + "%";
    }
    else {
        commissions = minCommission + "%~" + maxCommission + "%";
    }
    return commissions;
   
}
</script>
