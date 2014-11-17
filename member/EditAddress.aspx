<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditAddress.aspx.cs" Inherits="V5APP.Store.UI.member.EditAddress" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <%if (address != null)
      { %>
    <title>编辑地址</title>
    <%}
      else
      { %>
    <title>新增地址</title>
    <%} %>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="../../member/js/address.select.area.js"></script>
    <script src="../../member/js/address.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>

<body class="body-gray">

 
        <!--submit errow tip begin-->
        <div data-alert class="alert-box alert" style="display: none;" id="errerMsg">请选择省！<a href="#" class="close">&times;</a></div>
        <!--submit errow tip end-->


    <%if (address != null)
      { %>
    <input type="hidden" value="<%=address.ID %>" id="AddressID" />
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="javascript:window.history.go(-1)" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">修改地址</h1>
            </section>
            <section class="right-small right-small-text2">
                <a href="javascript:void(0)" onclick="saveAddress()" class="button [radius round] top-button">保存</a>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--form begin-->
    <form class="mt-55 mlr-15">
        <div class="panel callout radius formstyle addressnm">
            <!--01 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix">姓名</span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="输入收件人姓名" class="pl0" value="<%=address.Name %>" id="Name">
                      <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--01 end-->
            <!--02 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix last">手机</span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="手机号" class="pl0 last" value="<%=address.Moblie %>" id="Moblie">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--02 end-->
        </div>
        <input type="hidden" id="AreaCode" value="<%=address.AreaCode %>" />
        <input type="hidden" id="SeletctAreaId" value="" />
        <label class="address-label">收货地址</label>
        <div class="panel callout radius formstyle">
            <!--01 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix">省</span>
                </div>
                <div class="small-9 large-10 columns">
                    <select class="pl0" id="seleAreaNext">
                        <option value="">选择省</option>
                    </select>
                </div>
            </div>
            <!--01 end-->
            <!--02 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix">市</span>
                </div>
                <div class="small-9 large-10 columns">
                    <select class="pl0" id="seleAreaThird">
                        <option value="">选择市</option>
                    </select>
                </div>
            </div>

            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix">区/县</span>
                </div>
                <div class="small-9 large-10 columns">
                    <select class="pl0" id="seleAreaFouth">
                        <option value="">选择区/县</option>
                    </select>
                </div>
            </div>
            <!--02 end-->
            <!--03 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix last">详细</span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="输入详细地址" class="pl0 last" id="AddressInfo" value="<%=address.Remark %>">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--03 end-->
        </div>
    </form>
    <!--form end-->
    <%}
      else
      { %>
    <input type="hidden" value="-1" id="AddressID" />
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="javascript:window.history.go(-1)" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">添加地址</h1>
            </section>
            <section class="right-small right-small-text2">
                <a href="javascript:void(0)" onclick="saveAddress()" class="button [radius round] top-button">保存</a>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--form begin-->
    <form class="mt-55 mlr-15">
        <div class="panel callout radius formstyle addressnm">
            <!--01 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix">姓名</span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="输入收件人姓名" class="pl0" id="Name">
                      <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--01 end-->
            <!--02 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix last">手机</span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="手机号" class="pl0 last" id="Moblie">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--02 end-->
        </div>
        <label class="address-label">收货地址</label>
        <div class="panel callout radius formstyle">
            <!--01 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix">省</span>
                </div>
                <div class="small-9 large-10 columns">
                    <select class="pl0" id="seleAreaNext">
                        <option value="">选择省</option>
                    </select>
                </div>
            </div>
            <!--01 end-->
            <!--02 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix">市</span>
                </div>
                <div class="small-9 large-10 columns">
                    <select class="pl0" id="seleAreaThird">
                        <option value="">选择市</option>
                    </select>
                </div>
            </div>

            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix">区/县</span>
                </div>
                <div class="small-9 large-10 columns">
                    <select class="pl0" id="seleAreaFouth">
                        <option value="">选择区/县</option>
                    </select>
                </div>
            </div>
            <!--02 end-->
            <!--03 begin-->
            <div class="row collapse">
                <div class="small-3 large-2 columns">
                    <span class="prefix last">详细</span>
                </div>
                <div class="small-9 large-10 columns">
                    <input type="text" placeholder="输入详细地址" class="pl0 last" id="AddressInfo">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--03 end-->
        </div>
    </form>
    <!--form end-->


    <%} %>
</body>
</html>
