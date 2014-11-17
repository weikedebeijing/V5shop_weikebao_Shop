<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditStore.aspx.cs" Inherits="V5APP.Store.UI.member.EditStore" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>编辑微店</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation.min.js"></script>
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
                <a class="menu-icon" href="Member.aspx"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">编辑微店</h1>
            </section>
            <section class="right-small right-small-text2" id="saveBtn">
                <a href="javascript:void(0)" onclick="btnSave()" class="button [radius round] top-button">保存</a>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <%if (opened == null)
      { %>
    <script type="text/javascript">
        $("#saveBtn").hide();
    </script>
    <!--none begin-->
    <div class="mt-55 mlr-15">
        <h6 class="alignt-c mt-80 mb-30">您当前还没有微店！！</h6>
        <a href="AddStore.aspx" class="button [radius red round]">立即创建</a>
    </div>
    <!--none end-->
    <%}
      else
      { %>
    <!--have begin-->
    <div class="storeedit mlr-15">
<%--        <div class="store-logo">
            <span class="com-p">
                <img src="<%=BMCURL %><%=logoUrl %>" /></span>
            <span class="text">有品质而且更便宜</span>
        </div>--%>
        <form>
            <!--01 begin-->
            <div class="form-title-name">
                <label>微店名称</label>
            </div>
            <div class="panel callout radius formstyle">
                <div class="row">
                    <div class="large-12 columns">
                        <input type="text" id="title" placeholder="" class="last" old="<%=opened.Title %>" value="<%=opened.Title %>">
                    </div>
                </div>
            </div>
            <!--01 end-->
            <!--01 begin-->
            <div class="form-title-class">
                <label>选择商品分类</label>
            </div>
            <div class="row">
                <div class="large-12 columns pl0">
                    <input id="checkbox1" type="checkbox" onclick="checkAll(this)"><label for="checkbox1">全选</label>
                </div>
            </div>
            <!--row01 begin-->
            <div id="device" class="category">
                <%for (int i = 0; i < li.Count; i++)
                  {
                      var commissionRate = openLevel == 1 || openLevel == 0 ? li[i].CommissionRate + li[i].NextCommissionRate : li[i].NextCommissionRate;
                      %>
                <div class="item" name="columns" style="margin-bottom: 10px; zoom: 1; opacity: 1;" cid="<%=li[i].ID %>">
                    <div>
                        <h5><%=li[i].Name %></h5>
                        <p>佣金<%=commissionRate.ToString("0.00")%>%</p>
                    </div>
                </div>
                <%} %>
            </div>


            <!--row02 end-->
            <!--01 end-->
        </form>
    </div>

    <!--have end-->
    <%} %>

    <script src="../../member/js/jquery.grid-a-licious.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#device").gridalicious({
                gutter: 10,
                width: 150,

                animationOptions: {
                    speed: 150,
                    duration: 400,
                    complete: null
                },
            });

        });
    </script>


    <script type="text/javascript">
        var oldcids = '<%=oldcids%>'.split(',');
        for (var i = 0; i < oldcids.length; i++) {
            $("div [name=columns][cid=" + oldcids[i] + "]").addClass("current");
        }
        var cids = oldcids;
        var cidcount = $("div [name=columns]").length;
        if (oldcids.length == cidcount) {
            document.getElementById("checkbox1").checked = true;
        }
        var title = "";
        function checkAll(obj) {
            if (obj.checked) {
                //$("#cidAll").attr("checked", "checked");
                cids = new Array();
                $("div [name=columns]").each(function () {
                    $(this).addClass("current");
                    cids.push($(this).attr("cid"));
                })
            } else {
                // $("#cidAll").attr("checked", "");
                $("div [name=columns]").each(function () {
                    $(this).removeClass("current");
                })
                cids = new Array();
            }
        }
        $(function () {
            //$("div[name=columns]").click(function () {
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

        })

        function btnSave() {
            title = $("#title").val().trim();
            //alert(title);
            //alert(cids.length)

            if (title == "") {
                ShowMsg("店铺名称不可为空");
                return;
            } else {
                if (title == $("#title").attr("old").trim()) {
                    tempbl = "true";
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
            }
            if (tempbl != "true") {
                ShowMsg("店铺名称已存在");
                return;
            } else if (cids.length == 0) {
                ShowMsg("请选择商品分类");
                return;
            } else {
                $.ajax({
                    url: "../member/ajax/LoginHandle.aspx",
                    data: { "action": "modifyshop", "ShopTitle": title, "cids": cids },
                    async: false,
                    cache: false,
                    success: function (res) {
                        if (res == "true") {
                            window.location.href = "Member.aspx";
                        } else {
                            ShowMsg("店铺修改失败");
                        }
                    }
                })
            }

        }
    </script>
</body>

</html>

