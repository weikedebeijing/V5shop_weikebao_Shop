////加载购物车列表
//$(document).ready(function () {
//    $.ajax({
//        type: "POST",
//        dataType: "json",
//        url: path + "cart.aspx",
//        cache: false,
//        data: "act=showcartlist",
//        success: function (data) {

//            if (data != "" && data.Count != 0) {
//                $("#ShowCart").hide();
//                $("#HidCart").show();
//                $("#productList").show();////加载购物车列表
//$(document).ready(function () {
//    $.ajax({
//        type: "POST",
//        dataType: "json",
//        url: path + "cart.aspx",
//        cache: false,
//        data: "act=showcartlist",
//        success: function (data) {

//            if (data != "" && data.Count != 0) {
//                $("#ShowCart").hide();
//                $("#HidCart").show();
//                $("#productList").show();
//                var cartItemHTMLOrigin = $("#cartItemTotal").html();
//                var currentItem = "";
//                var total = "";
//                $(data.cartItem).each(function (index) {
//                    alert(1);
//                    currentItem = data.cartItem[index]; //json 购物项
//                    var cartItemHTML = cartItemHTMLOrigin;
//                    cartItemHTML = cartItemHTML.replace("$Image", currentItem.Src);

//                    cartItemHTML = cartItemHTML.replace("$Title", currentItem.Name);

//                    cartItemHTML = cartItemHTML.replace("$ProductPrice", currentItem.ProductPrice);

//                    cartItemHTML = cartItemHTML.replace("$OperateNum", currentItem.Count);

//                    $("#newCartItemTotal").append(cartItemHTML);
//                });

//            } else {
//                $("#ShowCart").show();
//                $("#HidCart").hide();
//                $("#productList").hide();
//            }
//        },
//        error: function (txt) {
//            $("#ShowCart").show();
//            $("#HidCart").hide();
//            $("#productList").hide();
//        }
//    });
//});

//extend the jquery
(function ($) {
    $.extend($.fn, {
        enable: function () {
            if (this[0]) this[0].disabled = false;
        },
        disable: function () {
            if (this[0]) this[0].disabled = true;
        }
    });
})(jQuery);

//$.ajaxSetup({
//    dataType: "html",
//    error: function () { alert("系统产生异常"); }
//})

//define the global variable that cart required
var delSku = null;
var reAddSku = null;

//difine the cart class
var Cart = {
    //add the product to the cart
    AddProduct: function (productId, trueProductId, obj, type, num, isRestore) {
        var urlStr, count;
        var fittings;
        var fitproducts = "0";
        fittings = $("input[name^='fitting_']");
        for (var fit = 0; fit < fittings.length; fit++) {
            if (fittings[fit].checked) {
                fitproducts += "," + fittings[fit].value;
            }
        }
        if (num && num != "0") count = num;
        else count = "1";

        $.ajax({
            url: "cart.aspx?act=" + type + "&id=" + productId + "&trueId=" + trueProductId + "&count=" + count + "&fit=" + fitproducts,
            success: function (data) {
                Utils.showProductListHtml(data);
                if (!isRestore) {
                    Utils.showAddWaitTip(obj);
                }
            }
        });
    },
    ShowShoppingCart: function () {
        $("#productList").load("cart.aspx?act=ShowShoppingCart")
    },
    changeBar: function (type, skuId, obj) {
        var txtC = null;
        var change = 0;
        if (type == '+') {
            txtC = $(obj).prev();
            change = 1;
        }
        if (type == '-') {
            txtC = $(obj).next();
            change = -1;
        }
        var num = parseInt(txtC.val());
        if (num + change < 0) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '您输入的数字已经超出的最小值！'
            });
            return;
        }
        txtC.val(num + change);
        this.changeProductCount(skuId, txtC[0], change);
    },
    changeProductCount: function (skuId, tmpObj, change) {
        var obj = $(tmpObj);
        if (obj.val().length <= 0) { obj.val(obj.next().val()); return; }
        if (parseInt(obj.val()) == 0) {
            this.removeProductOnShoppingCart(skuId, tmpObj);
            return;
        }
        $.ajax({
            type: "POST",
            cache: false,
            dataType: "json",
            data: "act=modify&cartId=" + skuId + "&count=" + obj.val() + "&pType=" + change,
            url: "cart.aspx",
            success: function (data) {
                $("#count").html("共" + data.cartItem[0].count + "件商品");
                $("#orderprice").html("商品总价:¥" + data.cartItem[0].orderprice);
                $("#feepric").html("¥" + data.cartItem[0].feeprice);
                $("#countcart").html(data.cartItem[0].count);
            }
        });
    },
    removeProductOnShoppingCart: function (skuId, obj) {
        if (confirm('确定不购买该商品？')) {
            $.ajax({
                dataType: "json",
                type: "POST",
                cache: false,
                data: "act=del&cartId=" + skuId,
                url: "cart.aspx",
                success: function (data) {
                    if (data.cartItem[0].count != "") {
                        $("#count").html("共" + data.cartItem[0].count + "件商品");
                        $("#orderprice").html("商品总价:¥" + data.cartItem[0].orderprice);
                        $("#feepric").html("¥" + data.cartItem[0].feeprice);
                        $("#countcart").html(data.cartItem[0].count);
                    } else {
                        $("#count").html("共0件商品");
                        $("#orderprice").html("商品总价:¥0.00");
                        $("#feepric").html("¥0.00");
                        $("#countcart").attr("style", "display:none");
                        $("#cart_count").hide();
                        $("#cart-list").hide();
                        $("#s-btn").hide();
                        $(".cart-info").hide();
                        $("#cart-none").show();
                    }
                    obj.parentNode.parentNode.parentNode.parentNode.remove();
                }
            });
        } else {
            $(obj).val("1");
        }
    },
    _setDelSku: function (skuId, obj) {

        delSku = new DeledSku();
        var trObj = $(obj).parent().parent().children();
        delSku.Id = trObj.eq(0).attr("id");
        delSku.TrueId = trObj.eq(0).attr("trueId");
        delSku.Name = trObj.eq(1).attr("productName");
        delSku.Price = trObj.eq(3).text();
        delSku.Num = $('#hidChange' + skuId).val();

    },
    _setDelSkuShow: function () {

        if (!$('#divDeledSku')) return;
        if (delSku != null && delSku.Id != '') {
            var dHtml = "<table class='delItem'><tr>";
            dHtml += "<td style='width:70px'>" + delSku.Id + "</td>";
            dHtml += "<td style='text-align:left'>" + delSku.Name + "</td>";
            dHtml += "<td style='width:150px'>" + delSku.Price + "</td>";
            dHtml += "<td style='width:125px'>" + delSku.Num + "</td>";
            dHtml += "<td style='width:100px'><a href='javascript:void(0)' onclick=\"Cart.AddProduct('" + delSku.Id + "','" + delSku.TrueId + "','','buyAjax','" + delSku.Num + "',true);Cart.reAddedSku('delSku" + delSku.Id + "');\">重新购买</a> | <a href='javascript:void(0)' onclick=\"Cart.saveFavorite('" + delSku.Id + "')\">收藏</a></td>";
            dHtml += "</tr></table>";

            if ($('#divDeledSku').children().length > 0) {
                dHtml = "<div class='delSplit'></div>" + dHtml;
            }
            $('#divDeledSku')[0].innerHTML += "<div class='delItem' id='delSku" + delSku.Id + "'>" + dHtml + "</div>";

        }
        if ($('#divDeledSku').children().length > 0) {
            $('#DeledSkuInfo').show();
        }
        delSku = null;

    },
    clearCart: function () {
        if (confirm('确定清空购物车吗？')) {
            $.ajax({
                type: "POST",
                url: "cart.aspx",
                cache: false,
                data: "act=delall",
                success: function (data) {
                    if (data == "True") {
                        window.location.href = path + "cart.aspx";
                    } else {
                        showBox(data);
                    }
                }
            });
        }
    },
    runOrderInfo: function () {
        //20212-09-27 增加判断购买数量是否达到起购数量的方法 by songcf
        if (Utils.checkAjaxStatus()) {
            $('#submit_info').show();
            $('#submit_info').html("正在转向订单信息填写页面，请稍候！");
            $('#submit_btn').hide();

            $.ajax({
                beforeSend: Utils.showOverLay(),
                type: "POST",
                url: path + "cart.aspx",
                data: "act=okAll",
                success: function (data) {
                    Cart._setCartSubmitRes(data);
                }
            });
        }
    },
    _setCartSubmitRes: function (bakValue) {

        if (bakValue.indexOf("errMessage:") != -1) {
            showBox(bakValue.substr(11));
            Utils.removeOverLay();
            $('#submit_info').hide();
            $('#submit_btn').show();
            return;
        } else if (bakValue.indexOf('errLogin:') != -1) {
            var errStr = bakValue.substr(9);
            $('#submit_info').html(errStr);
            window.setTimeout(function () { window.location.href = "login.aspx?url=cart.aspx"; }, 1000);
        } else {
            window.location.href = "cartstep.aspx";
        }
    },
    reAddedSku: function (reAddDivId) {
        try {
            $("#" + reAddDivId).remove();
            if ($('#divDeledSku').children().length == 0) {
                $('#DeledSkuInfo').hide();
            }
        } catch (e) { }
    },
    saveFavorite: function (productId) {
        var retMsg = "";

        $.get(path + "cart.aspx?act=saveFavorite&id=" + productId, function (data) {
            retMsg = data;
            if (retMsg.indexOf("errMessage:") == -1)
                getFavInfo(retMsg);
            else
                showBox(retMsg.substr(11));
        });

        function getFavInfo(retMsg) {
            $.ajax({
                beforeSend: function () { $("#favSkuInfo").html("正在读取您收藏夹中的商品信息，请稍等。。。") },
                url: "cart.aspx?act=getFavorite",
                success: function (data) {
                    $("#favSkuInfo").html(data);
                    bindBuyEvent();
                    art.dialog({
                        time: 3000,
                        lock: true,
                        title: '提示消息',
                        content: '商品收藏成功！'
                    });
                }
            });
            /*
            $("#favSkuInfo").html("正在读取您收藏夹中的商品信息，请稍等。。。");
            $("#favSkuInfo").load();
            alert("商品收藏成功");
            */
        }
    },
    delFav: function (skuId, obj) {
        $.ajax({
            beforeSend: function () { $("#favSkuInfo").html("正在读取您收藏夹中的商品信息，请稍等。。。"); },
            url: "cart.aspx?act=delFav&favId=" + skuId,
            success: function (data) {
                $("#favSkuInfo").html(data);
                bindBuyEvent();
            }
        });
    }
}

//define the global variable that cartorder required
var isAddrOpen = false;
var isDlyOpen = false;
var isPackOpen = false;
var isInvoiceOpen = false;

//difine the global variable that saved the closed html string
var label_Address = "";
var label_Delivery = "";
var label_Package = "";
var label_Invoice = "";

//difine the global variable that saved the already selected area string
var nStr = "", pStr = "", cStr = "", cyStr = "";
var nTmp = "", pTmp = "", cTmp = "", cyTmp = "";

//define the cardorder class
var CartOrder = {
    showForm_Address: function () {
        label_Address = $("#part_consignee").html();
        Utils.showWaitInfo('正在读取收货人信息，请等待！', $("#linkConsignee"));
        $("#part_consignee").load("cartstep.aspx?act=getCurrentAddr", function () {
            isAddrOpen = true;
            Utils.loadScript("orderValidatorAddr", "cart.validator.addr.js");

            nTmp = $("#area_nation option:selected").text().replace("请选择", "");
            pTmp = $("#area_province option:selected").text().replace("请选择", "");
            cTmp = $("#area_city option:selected").text().replace("请选择", "");
            cyTmp = $("#area_county option:selected").text().replace("请选择", "");
        });
    },
    changeForm_Address: function (obj) {
        $("#addrList li").removeClass("xz");
        $(obj).parent().parent().addClass("xz");
        $("#consignee_addr").load("cartstep.aspx?act=changeCurrentAddr&id=" + $(obj).val());
    },
    closeForm_Address: function () {
        $("#part_consignee").html(label_Address);
        isAddrOpen = false;
    },
    savePart_Address: function () {
        Utils.showWaitInfo('正在提交收货人信息，请等待。。。', $("#btnSaveAddress"));
        $("#addrForm").ajaxSubmit({
            target: "#part_consignee",
            success: function (data) {
                isAddrOpen = false;
                CartOrder.showForm_PayAndDly(true);
            }
        });
        return false;
    },
    showForm_PayAndDly: function (isRefresh) {
        label_Delivery = $("#part_payanddly").html();
        if (isRefresh) {
            var s = "<div class=\"o_show\">";
            s += "<h1><b>支付及配送方式</b>&nbsp;<a id=\"linkPayAndDly\" onClick=\"CartOrder.showForm_PayAndDly();\" href=\"javascript:void(0)\">[修改]</a></h1>";
            s += "<div class=\"middle\">对不起，您还没有维护支付及配送方式！</div>";
            label_Delivery = s;
        }
        Utils.showWaitInfo('正在读取支付及配送方式，请等待！', $("#linkPayAndDly"));
        var reqUrl = path + "cartstep.aspx?act=getPayAndDly";
        if (isRefresh)
            reqUrl = path + "cartstep.aspx?act=getPayAndDly&isRefresh=true";

        $.ajax({
            url: reqUrl,
            complete: Utils.clearWaitInfo,
            success: function (data) {
                isDlyOpen = true;
                $("#part_payanddly").html(data);
                Utils.loadScript("orderValidatorDly", "cart.validator.dly.js");
            }
        });
    },
    closeForm_PayAndDly: function () {
        $("#part_payanddly").html(label_Delivery);
        isDlyOpen = false;
    },
    savePart_PayAndDly: function () {
        if (Utils.checkAjaxStatus()) {
            Utils.showWaitInfo('正在提交支付及配送方式，请等待。。。', $("#btnSavePayAndDly"));
            $("#pdForm").ajaxSubmit({
                target: "#part_payanddly",
                success: function () {
                    isDlyOpen = false;
                    CartOrder.reloadPriceInfo();
                }
            });
        }
        return false;
    },
    ChangeDly: function (obj) {
        if ($(obj).attr("iscod") == "0" && $("input[name='paymethod']:checked").val() == "COD") {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '该配送方式不支持货到付款！'
            });
            obj.checked = false; return;
        }

        $.get("cartstep.aspx?act=calcFee&query=" + $(obj).attr("query") + "&dllname=" + $(obj).val(), function (data) {
            $("#showFee").html(data);

            //process the no login form
            if ($("#isLogin").val() == "0") {
                var price = data.substring(data.indexOf(">") + 1)
                $("#feeDiv").html(price);

                CartOrder._mathNoAjaxTotalPrice(price);
            }
        });
    },
    checkCod: function () {
        var obj = $("input[name='delivery']:checked");
        if ($(this).val() == "COD" && !(obj.size())) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '请先选择配送方式！'
            });
            return false;
        }

        if ($(this).val() == "COD" && obj.attr("iscod") == "0") {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '该配送方式不支持货到付款！'
            });
            return false;
        } else {
            return true;
        }
    },
    showForm_Invoice: function (isAjax) {
        label_Invoice = $("#part_Invoice").html();
        Utils.showWaitInfo('正在读取发票信息，请等待！', $("#linkInvoice"));
        $("#part_Invoice").load(path + "cartstep.aspx?act=getInvoice", function () {
            isInvoiceOpen = true;
        });
    },
    closeForm_Invoice: function () {
        $("#part_Invoice").html(label_Invoice);
        isInvoiceOpen = false;
    },
    showForm_Inv_NoAjax: function () {
        $("#writeInvDiv").show();
        $("#defaultInvDiv").hide();
    },
    closeForm_Inv_NoAjax: function () {
        if ($("input[name='IsInvoice']").is(":checked")) {
            var invPrice = $("input[name='InvoicePrice']").val();
            $("#show_IsNeedInvoice").html("是");
            $("#show_InvoiceHead").html($("input[name='InvoiceHead']").val());
            $("#show_InvoicePricw").html("￥" + invPrice + "元");
            $("#invDiv").html(invPrice);
            $("#writeInvDiv").hide();
            $("#showInvDiv").show();
        } else {
            $("#invDiv").html("0");
            $("#writeInvDiv,#showInvDiv").hide();
            $("#defaultInvDiv").show();
        }
        this._mathNoAjaxTotalPrice();
    },
    savePart_Invoice: function () {
        Utils.showWaitInfo('正在提交发票信息，请等待。。。', $("#btnSaveInvoice"));
        $("#invoiceForm").ajaxForm({
            target: "#part_Invoice",
            success: function () {
                isInvoiceOpen = false;
                CartOrder.reloadPriceInfo();
            }
        });
    },
    showForm_Remark: function () {
        $("#writeBzDiv").show();
        $("#defaultBzDiv").hide();
    },
    closeForm_Remark: function () {
        if ($("textarea[name='txtRemark']").val().length > 0) {
            $("#show_Bzinfo").html($("textarea[name='txtRemark']").val());
            $("#writeBzDiv").hide();
            $("#showBzDiv").show();
        } else {
            $("#writeBzDiv,#showBzDiv").hide();
            $("#defaultBzDiv").show();
        }
    },
    ShowScoreOper: function (obj) {
        if ($(obj).html().indexOf("+") != -1) {
            $("#scoreContent").show();
            $(obj).html($(obj).html().replace("+", "-"));

        } else {
            $("#scoreContent").hide();
            $(obj).html($(obj).html().replace("-", "+"));
        }
    },
    ShowCouponOper: function (obj) {
        if ($(obj).html().indexOf("+") != -1) {
            $("#couponContent").show();
            $(obj).html($(obj).html().replace("+", "-"));
        } else {
            $("#couponContent").hide();
            $(obj).html($(obj).html().replace("-", "+"));
        }
    },
    changeMoney: function () {
        if (!this._checkScore()) return;
        if ($("#changebutton").val() == "取消积分抵扣") {
            $("#usedscore").val(0);
            $("input[name^='usedmoney']").val(0);
            $("#changebutton").val("积分抵扣");
        } else {
            var score = $("#usedscore").val();
            var money = score / scorepercent;
            $("input[name^='usedmoney']").val(money);
        }

        this._mathPrice();
        this.useCoupon();
    },
    _checkScore: function () {
        var obj = $("#usedscore")[0];
        var score = $("#userscore").val();
        var maxscore = $("#maxscore").val();
        var cscore = obj.value;

        if (isNaN(cscore) || cscore.indexOf('.') != -1 || cscore.indexOf('-') != -1) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '您的积分输入不合法！'
            });
            obj.select(); obj.value = "0";
            return false;
        }
        if (parseInt(score) < parseInt(cscore)) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: "您最多能使用" + score + "积分"
            });
            obj.select(); obj.value = "0";
            return false;
        }
        if (parseInt(cscore) > parseInt(maxscore)) {
            if (maxscore == "0") {
                art.dialog({
                    time: 3000,
                    lock: true,
                    title: '提示消息',
                    content: '该订单不可使用积分！'
                });
                obj.select(); obj.value = "0";
                return false;
            } else {
                art.dialog({
                    time: 3000,
                    lock: true,
                    title: '提示消息',
                    content: "该订单您最多可以使用" + maxscore + "积分!"
                });
                obj.select(); obj.value = "0";
                return false;
            }
        }
        return true;
    },
    _mathNoAjaxTotalPrice: function (ajaxPrice) {
        var pSelect = $("input[name='productpackage']:checked");
        var gSelect = $("input[name='greetingcard']:checked");

        var price = parseFloat($("#price").val());
        var feePrice = ajaxPrice || $("input[name='feeValue']").val();
        if (!feePrice) feePrice = "0";
        var pkPrice = parseFloat(pSelect.attr("compare"));
        var gtPrice = parseFloat(gSelect.attr("compare"));
        var invPrice = 0;

        if (price >= pkPrice) pkPrice = 0;
        else pkPrice = parseFloat(pSelect.attr("price"));

        if (price >= gtPrice) gtPrice = 0;
        else gtPrice = parseFloat(gSelect.attr("price"));
        //计算发票费用
        if ($("input[name='IsInvoice']").is(":checked")) {
            var OrderTax = parseFloat($("input[name='ordertax']").val()); //发票税点
            invPrice = parseFloat((price + parseFloat(feePrice) + pkPrice + gtPrice) * OrderTax / 100); //根据税点计算发票金额
            $("input[name='InvoicePrice']").val(invPrice);
            $("#invDiv").html(invPrice);
        }
        $("#show_InvoicePricw").html("￥" + invPrice + "元");

        var totalPrice = Utils.round(price + parseFloat(feePrice) + pkPrice + gtPrice + invPrice, 2);
        $("#totalprice").val(totalPrice);
        $("#newtotalprice").html(totalPrice);
    },
    _mathPrice: function () {
        var newprice = parseFloat(($("#totalprice").val() / 10) * 1000) / 100 - parseFloat(($("input[name='usedmoney']").val() / 10) * 1000) / 100;
        newprice = Utils.round(parseFloat((newprice / 10) * 1000) / 100, 2);
        $("#newtotalprice").html(newprice);
    },
    ShowCouponList: function (obj) {
        if (obj.checked)
            $("#couponlist").show();
        else
            $("#couponlist").hide();
    },
    initCoupon: function (obj) {
        var ary = obj.value.split("-");
        try {
            $("#coupon1").val(ary[0]);
            $("#coupon2").val(ary[1]);
            $("#coupon3").val(ary[2]);
            $("#coupon4").val(ary[3]);

            this.verifyCoupon();
        } catch (e) { }
    },
    moveNext: function (obj, index) {
        obj.value = obj.value.toUpperCase();
        if (obj.value.length == 4 && index != 4) {
            $("#coupon" + (index + 1))[0].select();
            $("#coupon" + (index + 1))[0].focus();
        }
    },
    verifyCoupon: function () {
        var coupon = $("#coupon1").val() + "-" + $("#coupon2").val() + "-" + $("#coupon3").val() + "-" + $("#coupon4").val();
        var url = path + "cartstep.aspx?act=coupon&coupon=" + coupon;

        $("#load").show();
        $("#ok").hide();
        $("#error").hide();

        //Ajax请求
        $("#ispasstxt").load(url, function () {
            var ispass = $("#ispasstxt").html();
            $("#load").hide();
            if (isNaN(ispass)) {
                if (ispass == "none") {
                    $("#ok").hide();
                    $("#error").show();
                    $("#errmsg").html("× 验证错误，使用该券不存在或已被使用");
                } else {
                    $("#ok").hide();
                    $("#error").show();
                    $("#errmsg").html("× 验证错误，" + ispass);
                }
            } else {
                $("#ok").show();
                $("#error").hide();
                $("#couponmoney").html(ispass);
                $("#verify").enable();
            }
        });

        $("#verify")[0].checked = false;
        $("#verify").disable();
        $("#couponprice").val("0");
    },
    useCoupon: function () {
        if ($("#verify")[0].checked == true) {
            var newprice = parseFloat(($("#totalprice").val() / 10) * 1000) / 100 - parseFloat(($("#couponmoney")[0].innerHTML / 10) * 1000) / 100 - parseFloat(($("input[name='usedmoney']").val() / 10) * 1000) / 100;
            newprice = parseFloat((newprice / 10) * 1000) / 100;
            if (newprice < 0) newprice = 0;
            $("#newtotalprice").html(Utils.round(newprice, 2));
            $("#couponprice").val($("#couponmoney").html());
        } else {
            this._mathPrice();
            $("#couponprice").val("0");
        }
    },
    reloadPriceInfo: function () {
        $.get(path + "cartstep.aspx?act=getPriceInfo", function (data) {
            var dataArr = data.split("||");
            $("#priceSummary").html(dataArr[0]);
            $("#totalprice").val(dataArr[1]);
            $("#newtotalprice").html(dataArr[1]);
            $("#loginInvoiceprice").html("￥" + dataArr[2] + "元");
        });

        $("#usedscore").val(0);
        $("#usedmoneyTemp,#usedmoney").val(0);
        $("#couponprice").val(0);
        $("#verify")[0].checked = false;
    },
    submitNoAjaxOrder: function () {
        if (Utils.checkAjaxStatus()) {
            if ($("input[name='delivery']:checked").size() && $("input[name='paymethod']:checked").size()) {
                $("#submit_tip").show();
                Utils.showWaitInfo("正在提交订单，请稍候！", $("#submitWaitInfo"), true);
                $('#submit_btn').hide();
                $("#orderNoForm").ajaxSubmit({
                    beforeSubmit: Utils.showOverLay(),
                    success: function (data) {
                        if (data.indexOf("errMessage:") != -1) {
                            showBox(data.substr(11));
                            Utils.removeOverLay();
                            $("#submit_tip").hide();
                            $('#submit_btn').show();
                        }
                        else
                            window.location.href = data;
                    }
                });
            } else {
                art.dialog({
                    time: 3000,
                    lock: true,
                    title: '提示消息',
                    content: '对不起，支付方式或配送方式为空。\n您可能没有安装配送及支付方式或选择的地区没有配送方式！'
                });
                return false;
            }
        }
    },
    submitOrder: function () {
        if (Utils.checkAjaxStatus()) {
            if (CartOrder._check_submit_isClose()) {
                if ($("#isPayAndDly").val()) {
                    $("#submit_error").html('');
                    $("#submit_error").hide();
                    $("#submit_tip").show();
                    Utils.showWaitInfo("正在提交订单，请稍候！", $("#submitWaitInfo"), true);

                    $('#submit_btn').hide();
                    $("#orderRemark").val($("#txtRemark").val());
                    $("#orderForm").ajaxSubmit({
                        beforeSubmit: Utils.showOverLay(),
                        success: function (data) {
                            if (data.indexOf("errMessage:") != -1) {
                                showBox(data.substr(11));
                                Utils.removeOverLay();
                                $("#submit_tip").hide();
                                $('#submit_btn').show();
                            }
                            else
                                window.location.href = data;
                        }
                    });
                } else {
                    art.dialog({
                        time: 3000,
                        lock: true,
                        title: '提示消息',
                        content: '对不起，支付方式或配送方式为空。\n您可能没有安装配送及支付方式或选择的地区没有配送方式！'
                    });
                }
            }
        }
    },
    _check_submit_isClose: function () {
        var errInfo = "";
        //check all form is saved
        if (isAddrOpen) { errInfo += "“收货人信息”"; }
        if (isDlyOpen) { if (errInfo != '') { errInfo += ","; } errInfo += "“支付方式及配送方式”"; }
        if (isPackOpen) { if (errInfo != '') { errInfo += ","; } errInfo += "“商品包装及贺卡”"; }
        if (isInvoiceOpen) { if (errInfo != '') { errInfo += ","; } errInfo += "“发票信息”"; }
        if (errInfo != "") {
            $("#submit_error").html("请先保存" + errInfo);
            $("#submit_error").show();
            return false;
        }
        return true;
    },
    changeNation: function (isAjaxArea) {
        var obj = $("#area_nation option:selected");
        $.getJSON(path + "cartstep.aspx?areaId=" + obj.val() + "&level=2&act=getArea", function (data) {
            Utils.initAreaList($("#area_province"), data);
            Utils.initAreaList($("#area_city"));
            Utils.initAreaList($("#area_county"));
        });

        this.__getSelectArea();
        if ($("#tempAddr").val().length == 0)
            $("#txtAddress").val(nStr + $("#tempAddr").val());
        else
            $("#txtAddress").val($("#tempAddr").val().replace(nTmp, nStr));

        if (isAjaxArea) {
            $("#deliveryList").load(path + "cartstep.aspx?areaId=" + obj.val() + "&act=getDelivery")
        }
    },
    changeProvince: function (isAjaxArea) {
        var obj = $("#area_province option:selected");
        $.getJSON(path + "cartstep.aspx?areaId=" + obj.val() + "&level=3&act=getArea", function (data) {
            Utils.initAreaList($("#area_city"), data);
            Utils.initAreaList($("#area_county"));
        });
        this.__getSelectArea();
        if ($("#tempAddr").val().length == 0)
            $("#txtAddress").val(nStr + pStr + $("#tempAddr").val());
        else {
            $("#txtAddress").val($("#tempAddr").val().replace(nTmp + pTmp, nStr + pStr));
        }

        if (isAjaxArea) {


            $("#deliveryList").load(path + "cartstep.aspx?areaId=" + (obj.val() == "-1" ? $("#area_nation option:selected").val() : obj.val()) + "&act=getDelivery")
        }
    },
    changeCity: function (isAjaxArea) {
        var obj = $("#area_city option:selected");
        $.getJSON(path + "cartstep.aspx?areaId=" + obj.val() + "&level=4&act=getArea", function (data) {
            Utils.initAreaList($("#area_county"), data);
        });
        this.__getSelectArea();
        if ($("#tempAddr").val().length == 0)
            $("#txtAddress").val(nStr + pStr + cStr + $("#tempAddr").val());
        else {
            $("#txtAddress").val($("#tempAddr").val().replace(nTmp + pTmp + cTmp, nStr + pStr + cStr));
        }

        if (isAjaxArea) {
            $("#deliveryList").load(path + "cartstep.aspx?areaId=" + (obj.val() == "-1" ? $("#area_province option:selected").val() : obj.val()) + "&act=getDelivery")
        }
    },
    changeCounty: function (isAjaxArea) {
        var obj = $("#area_county option:selected");
        this.__getSelectArea();
        if ($("#tempAddr").val().length == 0)
            $("#txtAddress").val(nStr + pStr + cStr + cyStr + $("#tempAddr").val());
        else {
            $("#txtAddress").val($("#tempAddr").val().replace(nTmp + pTmp + cTmp + cyTmp, nStr + pStr + cStr + cyStr));
        }

        if (isAjaxArea) {
            $("#deliveryList").load(path + "cartstep.aspx?areaId=" + (obj.val() == "-1" ? $("#area_city option:selected").val() : obj.val()) + "&act=getDelivery")
        }
    },
    __getSelectArea: function () {
        nStr = $("#area_nation option:selected").text().replace("请选择", "");
        pStr = $("#area_province option:selected").text().replace("请选择", "");
        cStr = $("#area_city option:selected").text().replace("请选择", "");
        cyStr = $("#area_county option:selected").text().replace("请选择", "");
    }
}

//cart utility
var Utils = {
    //check the whole page's ajax is complete
    checkAjaxStatus: function () {
        if (jqueryAjaxStatus != -1 && jqueryAjaxStatus != 4) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '页面正在加载中，请稍候……！'
            });
            return false;
        } else return true;
    },
    showProductListHtml: function (data) {
        if ($('#productList'))
            $('#productList').html(data);
    },
    showWaitInfo: function (info, obj, needOver) {
        try {
            if (obj == null) return;
            this.clearWaitInfo();
            if (!needOver)
                var newd = document.createElement("span");
            else
                var newd = document.createElement("div");

            newd.className = 'waitInfo';
            newd.id = 'waitInfo';
            newd.innerHTML = info;
            obj.parent().append(newd);
            if (needOver)
                $(newd).css({ "width": "135px", "position": "relative", "z-index": "110", "margin-left": "auto" });
        } catch (e) { }
    },
    clearWaitInfo: function () {
        $('#waitInfo').remove();
    },
    showOverLay: function () {
        var obj = document.createElement("div");
        obj.id = "usercart-overlay";
        $(document.body).append(obj);
        var ie6 = navigator.userAgent.indexOf('MSIE 6') >= 0;
        var $body = $(ie6 ? document.body : document);
        $('#usercart-overlay').css({
            width: $body.width(),
            height: $body.height()
        });
        if (ie6) {
            $('#usercart-overlay').css({
                position: 'absolute',
                top: '0px',
                left: '0px'
            });
        }
    },
    removeOverLay: function () {
        $("#usercart-overlay").remove();
    },
    showAddWaitTip: function (obj) {
        var msg = "";
        msg = "商品加入成功！&nbsp;<a href='" + path + "cart.aspx#top'>转到购物车</a>";

        var tipHtml = "<div id='addSucTip'>" + msg + "</div>";
        $("#" + obj).hide();
        $("#" + obj).after(tipHtml);

        //1.5秒后将提示层删除
        window.setTimeout(function () {
            $("#" + obj).next("div").remove();
            $("#" + obj).show();
        }, 1500);
    },
    showChangeSucTip: function (pos) {
        this.closeWindow();
        pos.Top = pos.Top - 84;
        pos.Left = pos.Left - (204 - pos.Width) / 2;
        //定义数量更改提示层
        var tipHtml = "<div id='changeSucTip'><div id='tipContent'><div id='tipTitle'>商品数量修改成功！<br />商品金额为：<span id='priceSpan'>" + $('#cartBottom_price').html() + "</span>元<br /><a href='javascript:Utils.closeWindow()'>关闭</a></div></div></div>";
        this._showMessageBox(tipHtml, pos, 204);

        var mWin = $('#mesWindow');
        setTimeout(function () { mWin.fadeOut(300, this.closeWindow); }, 4000);
    },
    _showMessageBox: function (content, pos, wWidth) {
        this.closeWindow();
        var bWidth = parseInt(document.documentElement.scrollWidth);
        var bHeight = parseInt(document.documentElement.scrollHeight);
        var mesW = document.createElement("div");
        mesW.id = "mesWindow";
        mesW.innerHTML = content;
        if (bWidth - pos.Left < wWidth) {
            styleStr = "left:" + (pos.Left - wWidth) + "px;";
        }
        else {
            styleStr = "left:" + (pos.Left) + "px;";
        }
        styleStr += "top:" + pos.Top + "px;position:absolute;width:" + wWidth + "px;";
        mesW.style.cssText = styleStr;
        document.body.appendChild(mesW);

    },
    closeWindow: function () {
        if ($('#mesWindow'))
            $('#mesWindow').remove();
    },
    initAreaList: function (tmpObj, arr) {
        var obj = tmpObj[0];
        obj.length = 0;
        obj.options.add(new Option("请选择", "-1"));
        if (arr) {
            var has = false;
            $.each(arr, function (i, n) {
                obj.options.add(new Option(i, n));
                has = true;
            })
            if (has) tmpObj.show();
            else tmpObj.hide();
        } else tmpObj.hide();
    },
    loadScript: function (id, name) {
        var oScript = document.getElementById(id);
        var bdy = document.getElementsByTagName("body").item(0);
        if (oScript) {
            bdy.removeChild(oScript);
        }
        oScript = document.createElement("script");
        oScript.setAttribute("src", "js/" + name);
        oScript.setAttribute("id", id);
        oScript.setAttribute("type", "text/javascript");
        oScript.setAttribute("language", "javascript");
        bdy.appendChild(oScript);
    },
    round: function (number, precision) {
        precision = Math.pow(10, precision || 0);
        return Math.round(number * precision) / precision;
    }

}

//-------------------------------------------------------------
//all common class
//-------------------------------------------------------------
function getPos(obj) {
    this.Left = 0;
    this.Top = 0;
    this.Height = obj.offsetHeight;
    this.Width = obj.offsetWidth;
    var tempObj = obj;
    try {
        while (tempObj.tagName.toLowerCase() != "body" && tempObj.tagName.toLowerCase() != "html") {
            this.Left += tempObj.offsetLeft;
            this.Top += tempObj.offsetTop;
            tempObj = tempObj.offsetParent;
        }
    } catch (e) { }
}

function DeledSku() {
    this.Id = '';
    this.TrueID = '';
    this.Name = '';
    this.Price = '';
    this.Num = '';
}

//bind page event
$(document).ready(function () {
    $("input[name='paymethod']").click(CartOrder.checkCod);
    $("#btnSaveOrder").click(CartOrder.submitOrder);

    //换购商品单独绑定事件
    $(".chg-img-btn").click(function () {
        var id = $(this).attr("id");
        Cart.AddProduct(id, "0", 'chg_' + id, 'present')
    });

    //支付按钮绑定蒙板层事件
    $(".payment-btn").click(function () {
        Utils.showOverLay();
        var top = ($(window).height() - 288) / 2;
        var left = ($(window).width() - 340) / 2;
        $(".payment-info-tip").css({
            "z-index": 101,
            "position": "absolute",
            "top": top,
            "left": left
        }).show();
    });
    $(".payment-close-btn").click(function () {
        Utils.removeOverLay();
        $(".payment-info-tip").hide();
        return false;
    });
    $("#noaddress").click(function () {
        window.location.href = "member/editaddress.aspx?url=cart.aspx";


    });

    bindBuyEvent();
});

var bindBuyEvent = function () {
    $(".buy-img-btn").unbind().bind("click", function () {
        var id = $(this).attr("id");
        var num = $(this).attr("buynum");
        Utils.showOverLay();
        $.ajax({
            beforeSend: function () {
                var top = ($(window).height() - 30) / 2 + $(window).scrollTop();
                var left = ($(window).width() - 200) / 2;
                $(document.body).append($("<div style='position: absolute; z-index: 120;top:" + top + "px;left:" + left + "px;' class='submitSuccess' id='addTrue_info'>正在读取规格信息，请稍候……</div>"));
            },
            url: path + "cart.aspx?act=getTrueProduct&id=" + id,
            complete: function () {
                $("#addTrue_info").remove();
            },
            success: function (data) {
                if (data.indexOf("trueProductId:") != -1) {
                    var trueId = data.substring(14);
                    //隐藏遮罩层
                    Utils.removeOverLay();
                    //收藏夹购买
                    Cart.AddProduct(id, trueId, 'fav_' + id, 'buyAjax', num);
                } else {
                    var el = $(data);
                    $(document.body).append(el);
                    var top = ($(window).height() - el.height()) / 2 + $(window).scrollTop();
                    var left = ($(window).width() - el.width()) / 2;
                    el.css({ "top": top, "left": left, "z-index": 130 }).show();

                    $(".chooselist").draggable({ handle: ".chooselist-title" });

                    //bind for buy btn
                    $(".buy-spec-img-btn").unbind().click(function () {
                        var _id = $(this).attr("id");
                        var _trueId = $(this).attr("trueid");
                        Cart.AddProduct(_id, _trueId, 'fav_' + _id, 'buyAjax');
                        el.remove();
                        Utils.removeOverLay();
                    });

                    //bind for close btn
                    $("#specCloseImg").unbind().click(function () {
                        el.remove();
                        Utils.removeOverLay();
                    });
                }

            }
        });
    });
}
function cartDel(skuId, obj) {
    $.ajax({
        dataType: "json",
        type: "POST",
        cache: false,
        data: "act=del&cartId=" + skuId,
        url: "cart.aspx",
        success: function (data) {
            if (data.cartItem[0].count != "") {
                $("#count").html("共" + data.cartItem[0].count + "件商品");
                $("#orderprice").html("总价:¥" + data.cartItem[0].orderprice);
                $("#countcart").html(data.cartItem[0].count);
            } else {
                $("#count").html("共0件商品");
                $("#orderprice").html("总价:¥0.00");
                $("#countcart").attr("style", "display:none");
                $("#cart_count").hide();
                $("#cart-list").hide();
                $("#s-btn").hide();
                $(".cart-info").hide();
                $("#cart-none").show();
            }
            obj.parentNode.parentNode.parentNode.remove();
        }
    });
}
function onKeyup(id, obj) {
    obj.value = obj.value.replace(/\D/g, '');

    $.ajax({
        type: "POST",
        cache: false,
        dataType: "json",
        data: "act=modify&cartId=" + id + "&count=" + obj.value,
        url: "cart.aspx",
        success: function (data) {
            obj.parentNode.parentNode.children[0].children[1].innerHTML = $(obj).attr('price') * obj.value + ".00";
            $("#count").html("共" + data.cartItem[0].count + "件商品");
            $("#orderprice").html("总价:¥" + data.cartItem[0].orderprice);
            $("#countcart").html(data.cartItem[0].count);
        }
    });
}
function onChange(id, obj) {
    obj.value = obj.value.replace(/\D/g, '');
    if (obj.value == '' || obj.value == '0') {
        obj.value = 1;
    }
    $.ajax({
        type: "POST",
        cache: false,
        dataType: "json",
        data: "act=modify&cartId=" + id + "&count=" + obj.value,
        url: "cart.aspx",
        success: function (data) {
            obj.parentNode.parentNode.children[0].children[1].innerHTML = $(obj).attr('price') * obj.value + ".00";
            $("#count").html("共" + data.cartItem[0].count + "件商品");
            $("#orderprice").html("总价:¥" + data.cartItem[0].orderprice);
            $("#countcart").html(data.cartItem[0].count);
        }
    });
}


function onAfterpaste(obj) {
    obj.value = obj.value.replace(/\D/g, '');
    if (obj.value == '' || obj.value == '0') {
        obj.value = 1;
    }
}
//                var cartItemHTMLOrigin = $("#cartItemTotal").html();
//                var currentItem = "";
//                var total = "";
//                $(data.cartItem).each(function (index) {
//                    alert(1);
//                    currentItem = data.cartItem[index]; //json 购物项
//                    var cartItemHTML = cartItemHTMLOrigin;
//                    cartItemHTML = cartItemHTML.replace("$Image", currentItem.Src);

//                    cartItemHTML = cartItemHTML.replace("$Title", currentItem.Name);

//                    cartItemHTML = cartItemHTML.replace("$ProductPrice", currentItem.ProductPrice);

//                    cartItemHTML = cartItemHTML.replace("$OperateNum", currentItem.Count);

//                    $("#newCartItemTotal").append(cartItemHTML);
//                });

//            } else {
//                $("#ShowCart").show();
//                $("#HidCart").hide();
//                $("#productList").hide();
//            }
//        },
//        error: function (txt) {
//            $("#ShowCart").show();
//            $("#HidCart").hide();
//            $("#productList").hide();
//        }
//    });
//});

//extend the jquery
(function ($) {
    $.extend($.fn, {
        enable: function () {
            if (this[0]) this[0].disabled = false;
        },
        disable: function () {
            if (this[0]) this[0].disabled = true;
        }
    });
})(jQuery);

//$.ajaxSetup({
//    dataType: "html",
//    error: function () { alert("系统产生异常"); }
//})

//define the global variable that cart required
var delSku = null;
var reAddSku = null;

//difine the cart class
var Cart = {
    //add the product to the cart
    AddProduct: function (productId, trueProductId, obj, type, num, isRestore) {
        var urlStr, count;
        var fittings;
        var fitproducts = "0";
        fittings = $("input[name^='fitting_']");
        for (var fit = 0; fit < fittings.length; fit++) {
            if (fittings[fit].checked) {
                fitproducts += "," + fittings[fit].value;
            }
        }
        if (num && num != "0") count = num;
        else count = "1";

        $.ajax({
            url: "cart.aspx?act=" + type + "&id=" + productId + "&trueId=" + trueProductId + "&count=" + count + "&fit=" + fitproducts,
            success: function (data) {
                Utils.showProductListHtml(data);
                if (!isRestore) {
                    Utils.showAddWaitTip(obj);
                }
            }
        });
    },
    ShowShoppingCart: function () {
        $("#productList").load("cart.aspx?act=ShowShoppingCart")
    },
    changeBar: function (type, skuId, obj) {
        var txtC = null;
        var change = 0;
        if (type == '+') {
            txtC = $(obj).prev();
            change = 1;
        }
        if (type == '-') {
            txtC = $(obj).next();
            change = -1;
        }
        var num = parseInt(txtC.val());
        if (num + change < 0) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '您输入的数字已经超出的最小值！'
            });
            return;
        }
        txtC.val(num + change);
        this.changeProductCount(skuId, txtC[0], change);
    },
    changeProductCount: function (skuId, tmpObj, change) {
        var obj = $(tmpObj);
        if (obj.val().length <= 0) { obj.val(obj.next().val()); return; }
        if (parseInt(obj.val()) == 0) {
            this.removeProductOnShoppingCart(skuId, tmpObj);
            return;
        }
        $.ajax({
            type: "POST",
            cache: false,
            dataType: "json",
            data: "act=modify&cartId=" + skuId + "&count=" + obj.val() + "&pType=" + change,
            url: "cart.aspx",
            success: function (data) {
                $("#count").html("共" + data.cartItem[0].count + "件商品");
                $("#orderprice").html("总价:¥" + data.cartItem[0].orderprice);
                $("#countcart").html(data.cartItem[0].count);
            }
        });
    },
    removeProductOnShoppingCart: function (skuId, obj) {
        if (confirm('确定不购买该商品？')) {
            $.ajax({
                dataType: "json",
                type: "POST",
                cache: false,
                data: "act=del&cartId=" + skuId,
                url:"cart.aspx",
                success: function (data) {
                    if (data.cartItem[0].count != "") {
                        $("#count").html("共" + data.cartItem[0].count + "件商品");
                        $("#orderprice").html("总价:¥" + data.cartItem[0].orderprice);
                        $("#countcart").html(data.cartItem[0].count);
                    } else {
                        $("#count").html("共0件商品");
                        $("#orderprice").html("总价:¥0.00");
                        $("#countcart").attr("style", "display:none");
                        $("#cart_count").hide();
                        $("#cart-list").hide();
                        $("#s-btn").hide();
                        $(".cart-info").hide();
                        $("#cart-none").show();
                    }
                    obj.parentNode.parentNode.parentNode.parentNode.remove();
                }
            });
        } else {
            $(obj).val("1");
        }
    },
    _setDelSku: function (skuId, obj) {

        delSku = new DeledSku();
        var trObj = $(obj).parent().parent().children();
        delSku.Id = trObj.eq(0).attr("id");
        delSku.TrueId = trObj.eq(0).attr("trueId");
        delSku.Name = trObj.eq(1).attr("productName");
        delSku.Price = trObj.eq(3).text();
        delSku.Num = $('#hidChange' + skuId).val();

    },
    _setDelSkuShow: function () {

        if (!$('#divDeledSku')) return;
        if (delSku != null && delSku.Id != '') {
            var dHtml = "<table class='delItem'><tr>";
            dHtml += "<td style='width:70px'>" + delSku.Id + "</td>";
            dHtml += "<td style='text-align:left'>" + delSku.Name + "</td>";
            dHtml += "<td style='width:150px'>" + delSku.Price + "</td>";
            dHtml += "<td style='width:125px'>" + delSku.Num + "</td>";
            dHtml += "<td style='width:100px'><a href='javascript:void(0)' onclick=\"Cart.AddProduct('" + delSku.Id + "','" + delSku.TrueId + "','','buyAjax','" + delSku.Num + "',true);Cart.reAddedSku('delSku" + delSku.Id + "');\">重新购买</a> | <a href='javascript:void(0)' onclick=\"Cart.saveFavorite('" + delSku.Id + "')\">收藏</a></td>";
            dHtml += "</tr></table>";

            if ($('#divDeledSku').children().length > 0) {
                dHtml = "<div class='delSplit'></div>" + dHtml;
            }
            $('#divDeledSku')[0].innerHTML += "<div class='delItem' id='delSku" + delSku.Id + "'>" + dHtml + "</div>";

        }
        if ($('#divDeledSku').children().length > 0) {
            $('#DeledSkuInfo').show();
        }
        delSku = null;

    },
    clearCart: function () {
        if (confirm('确定清空购物车吗？')) {
            $.ajax({
                type: "POST",
                url: "cart.aspx",
                cache: false,
                data: "act=delall",
                success: function (data) {
                    if (data == "True") {
                        window.location.href = path + "cart.aspx";
                    } else {
                        showBox(data);
                    }
                }
            });
        }
    },
    runOrderInfo: function () {
        //20212-09-27 增加判断购买数量是否达到起购数量的方法 by songcf
        if (Utils.checkAjaxStatus()) {
            $('#submit_info').show();
            $('#submit_info').html("正在转向订单信息填写页面，请稍候！");
            $('#submit_btn').hide();

            $.ajax({
                beforeSend: Utils.showOverLay(),
                type: "POST",
                url: path + "cart.aspx",
                data: "act=okAll",
                success: function (data) {
                    Cart._setCartSubmitRes(data);
                }
            });
        }
    },
    _setCartSubmitRes: function (bakValue) {

        if (bakValue.indexOf("errMessage:") != -1) {
            showBox(bakValue.substr(11));
            Utils.removeOverLay();
            $('#submit_info').hide();
            $('#submit_btn').show();
            return;
        } else if (bakValue.indexOf('errLogin:') != -1) {
            var errStr = bakValue.substr(9);
            $('#submit_info').html(errStr);
            window.setTimeout(function () { window.location.href =  "login.aspx?url=cart.aspx"; }, 1000);
        } else {
            window.location.href = "cartstep.aspx";
        }
    },
    reAddedSku: function (reAddDivId) {
        try {
            $("#" + reAddDivId).remove();
            if ($('#divDeledSku').children().length == 0) {
                $('#DeledSkuInfo').hide();
            }
        } catch (e) { }
    },
    saveFavorite: function (productId) {
        var retMsg = "";

        $.get(path + "cart.aspx?act=saveFavorite&id=" + productId, function (data) {
            retMsg = data;
            if (retMsg.indexOf("errMessage:") == -1)
                getFavInfo(retMsg);
            else
                showBox(retMsg.substr(11));
        });

        function getFavInfo(retMsg) {
            $.ajax({
                beforeSend: function () { $("#favSkuInfo").html("正在读取您收藏夹中的商品信息，请稍等。。。") },
                url: "cart.aspx?act=getFavorite",
                success: function (data) {
                    $("#favSkuInfo").html(data);
                    bindBuyEvent();
                    art.dialog({
                        time: 3000,
                        lock: true,
                        title: '提示消息',
                        content: '商品收藏成功！'
                    });
                }
            });
            /*
            $("#favSkuInfo").html("正在读取您收藏夹中的商品信息，请稍等。。。");
            $("#favSkuInfo").load();
            alert("商品收藏成功");
            */
        }
    },
    delFav: function (skuId, obj) {
        $.ajax({
            beforeSend: function () { $("#favSkuInfo").html("正在读取您收藏夹中的商品信息，请稍等。。。"); },
            url: "cart.aspx?act=delFav&favId=" + skuId,
            success: function (data) {
                $("#favSkuInfo").html(data);
                bindBuyEvent();
            }
        });
    }
}

//define the global variable that cartorder required
var isAddrOpen = false;
var isDlyOpen = false;
var isPackOpen = false;
var isInvoiceOpen = false;

//difine the global variable that saved the closed html string
var label_Address = "";
var label_Delivery = "";
var label_Package = "";
var label_Invoice = "";

//difine the global variable that saved the already selected area string
var nStr = "", pStr = "", cStr = "", cyStr = "";
var nTmp = "", pTmp = "", cTmp = "", cyTmp = "";

//define the cardorder class
var CartOrder = {
    showForm_Address: function () {
        label_Address = $("#part_consignee").html();
        Utils.showWaitInfo('正在读取收货人信息，请等待！', $("#linkConsignee"));
        $("#part_consignee").load("cartstep.aspx?act=getCurrentAddr", function () {
            isAddrOpen = true;
            Utils.loadScript("orderValidatorAddr", "cart.validator.addr.js");

            nTmp = $("#area_nation option:selected").text().replace("请选择", "");
            pTmp = $("#area_province option:selected").text().replace("请选择", "");
            cTmp = $("#area_city option:selected").text().replace("请选择", "");
            cyTmp = $("#area_county option:selected").text().replace("请选择", "");
        });
    },
    changeForm_Address: function (obj) {
        $("#addrList li").removeClass("xz");
        $(obj).parent().parent().addClass("xz");
        $("#consignee_addr").load("cartstep.aspx?act=changeCurrentAddr&id=" + $(obj).val());
    },
    closeForm_Address: function () {
        $("#part_consignee").html(label_Address);
        isAddrOpen = false;
    },
    savePart_Address: function () {
        Utils.showWaitInfo('正在提交收货人信息，请等待。。。', $("#btnSaveAddress"));
        $("#addrForm").ajaxSubmit({
            target: "#part_consignee",
            success: function (data) {
                isAddrOpen = false;
                CartOrder.showForm_PayAndDly(true);
            }
        });
        return false;
    },
    showForm_PayAndDly: function (isRefresh) {
        label_Delivery = $("#part_payanddly").html();
        if (isRefresh) {
            var s = "<div class=\"o_show\">";
            s += "<h1><b>支付及配送方式</b>&nbsp;<a id=\"linkPayAndDly\" onClick=\"CartOrder.showForm_PayAndDly();\" href=\"javascript:void(0)\">[修改]</a></h1>";
            s += "<div class=\"middle\">对不起，您还没有维护支付及配送方式！</div>";
            label_Delivery = s;
        }
        Utils.showWaitInfo('正在读取支付及配送方式，请等待！', $("#linkPayAndDly"));
        var reqUrl = path + "cartstep.aspx?act=getPayAndDly";
        if (isRefresh)
            reqUrl = path + "cartstep.aspx?act=getPayAndDly&isRefresh=true";

        $.ajax({
            url: reqUrl,
            complete: Utils.clearWaitInfo,
            success: function (data) {
                isDlyOpen = true;
                $("#part_payanddly").html(data);
                Utils.loadScript("orderValidatorDly", "cart.validator.dly.js");
            }
        });
    },
    closeForm_PayAndDly: function () {
        $("#part_payanddly").html(label_Delivery);
        isDlyOpen = false;
    },
    savePart_PayAndDly: function () {
        if (Utils.checkAjaxStatus()) {
            Utils.showWaitInfo('正在提交支付及配送方式，请等待。。。', $("#btnSavePayAndDly"));
            $("#pdForm").ajaxSubmit({
                target: "#part_payanddly",
                success: function () {
                    isDlyOpen = false;
                    CartOrder.reloadPriceInfo();
                }
            });
        }
        return false;
    },
    ChangeDly: function (obj) {
        if ($(obj).attr("iscod") == "0" && $("input[name='paymethod']:checked").val() == "COD") {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '该配送方式不支持货到付款！'
            });
            obj.checked = false; return;
        }

        $.get("cartstep.aspx?act=calcFee&query=" + $(obj).attr("query") + "&dllname=" + $(obj).val(), function (data) {
            $("#showFee").html(data);

            //process the no login form
            if ($("#isLogin").val() == "0") {
                var price = data.substring(data.indexOf(">") + 1)
                $("#feeDiv").html(price);

                CartOrder._mathNoAjaxTotalPrice(price);
            }
        });
    },
    checkCod: function () {
        var obj = $("input[name='delivery']:checked");
        if ($(this).val() == "COD" && !(obj.size())) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '请先选择配送方式！'
            });
            return false;
        }

        if ($(this).val() == "COD" && obj.attr("iscod") == "0") {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '该配送方式不支持货到付款！'
            });
            return false;
        } else {
            return true;
        }
    },
    showForm_Invoice: function (isAjax) {
        label_Invoice = $("#part_Invoice").html();
        Utils.showWaitInfo('正在读取发票信息，请等待！', $("#linkInvoice"));
        $("#part_Invoice").load(path + "cartstep.aspx?act=getInvoice", function () {
            isInvoiceOpen = true;
        });
    },
    closeForm_Invoice: function () {
        $("#part_Invoice").html(label_Invoice);
        isInvoiceOpen = false;
    },
    showForm_Inv_NoAjax: function () {
        $("#writeInvDiv").show();
        $("#defaultInvDiv").hide();
    },
    closeForm_Inv_NoAjax: function () {
        if ($("input[name='IsInvoice']").is(":checked")) {
            var invPrice = $("input[name='InvoicePrice']").val();
            $("#show_IsNeedInvoice").html("是");
            $("#show_InvoiceHead").html($("input[name='InvoiceHead']").val());
            $("#show_InvoicePricw").html("￥" + invPrice + "元");
            $("#invDiv").html(invPrice);
            $("#writeInvDiv").hide();
            $("#showInvDiv").show();
        } else {
            $("#invDiv").html("0");
            $("#writeInvDiv,#showInvDiv").hide();
            $("#defaultInvDiv").show();
        }
        this._mathNoAjaxTotalPrice();
    },
    savePart_Invoice: function () {
        Utils.showWaitInfo('正在提交发票信息，请等待。。。', $("#btnSaveInvoice"));
        $("#invoiceForm").ajaxForm({
            target: "#part_Invoice",
            success: function () {
                isInvoiceOpen = false;
                CartOrder.reloadPriceInfo();
            }
        });
    },
    showForm_Remark: function () {
        $("#writeBzDiv").show();
        $("#defaultBzDiv").hide();
    },
    closeForm_Remark: function () {
        if ($("textarea[name='txtRemark']").val().length > 0) {
            $("#show_Bzinfo").html($("textarea[name='txtRemark']").val());
            $("#writeBzDiv").hide();
            $("#showBzDiv").show();
        } else {
            $("#writeBzDiv,#showBzDiv").hide();
            $("#defaultBzDiv").show();
        }
    },
    ShowScoreOper: function (obj) {
        if ($(obj).html().indexOf("+") != -1) {
            $("#scoreContent").show();
            $(obj).html($(obj).html().replace("+", "-"));

        } else {
            $("#scoreContent").hide();
            $(obj).html($(obj).html().replace("-", "+"));
        }
    },
    ShowCouponOper: function (obj) {
        if ($(obj).html().indexOf("+") != -1) {
            $("#couponContent").show();
            $(obj).html($(obj).html().replace("+", "-"));
        } else {
            $("#couponContent").hide();
            $(obj).html($(obj).html().replace("-", "+"));
        }
    },
    changeMoney: function () {
        if (!this._checkScore()) return;
        if ($("#changebutton").val() == "取消积分抵扣") {
            $("#usedscore").val(0);
            $("input[name^='usedmoney']").val(0);
            $("#changebutton").val("积分抵扣");
        } else {
            var score = $("#usedscore").val();
            var money = score / scorepercent;
            $("input[name^='usedmoney']").val(money);
        }

        this._mathPrice();
        this.useCoupon();
    },
    _checkScore: function () {
        var obj = $("#usedscore")[0];
        var score = $("#userscore").val();
        var maxscore = $("#maxscore").val();
        var cscore = obj.value;

        if (isNaN(cscore) || cscore.indexOf('.') != -1 || cscore.indexOf('-') != -1) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '您的积分输入不合法！'
            });
            obj.select(); obj.value = "0";
            return false;
        }
        if (parseInt(score) < parseInt(cscore)) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: "您最多能使用" + score + "积分"
            });
            obj.select(); obj.value = "0";
            return false;
        }
        if (parseInt(cscore) > parseInt(maxscore)) {
            if (maxscore == "0") {
                art.dialog({
                    time: 3000,
                    lock: true,
                    title: '提示消息',
                    content: '该订单不可使用积分！'
                });
                obj.select(); obj.value = "0";
                return false;
            } else {
                art.dialog({
                    time: 3000,
                    lock: true,
                    title: '提示消息',
                    content: "该订单您最多可以使用" + maxscore + "积分!"
                });
                obj.select(); obj.value = "0";
                return false;
            }
        }
        return true;
    },
    _mathNoAjaxTotalPrice: function (ajaxPrice) {
        var pSelect = $("input[name='productpackage']:checked");
        var gSelect = $("input[name='greetingcard']:checked");

        var price = parseFloat($("#price").val());
        var feePrice = ajaxPrice || $("input[name='feeValue']").val();
        if (!feePrice) feePrice = "0";
        var pkPrice = parseFloat(pSelect.attr("compare"));
        var gtPrice = parseFloat(gSelect.attr("compare"));
        var invPrice = 0;

        if (price >= pkPrice) pkPrice = 0;
        else pkPrice = parseFloat(pSelect.attr("price"));

        if (price >= gtPrice) gtPrice = 0;
        else gtPrice = parseFloat(gSelect.attr("price"));
        //计算发票费用
        if ($("input[name='IsInvoice']").is(":checked")) {
            var OrderTax = parseFloat($("input[name='ordertax']").val()); //发票税点
            invPrice = parseFloat((price + parseFloat(feePrice) + pkPrice + gtPrice) * OrderTax / 100); //根据税点计算发票金额
            $("input[name='InvoicePrice']").val(invPrice);
            $("#invDiv").html(invPrice);
        }
        $("#show_InvoicePricw").html("￥" + invPrice + "元");

        var totalPrice = Utils.round(price + parseFloat(feePrice) + pkPrice + gtPrice + invPrice, 2);
        $("#totalprice").val(totalPrice);
        $("#newtotalprice").html(totalPrice);
    },
    _mathPrice: function () {
        var newprice = parseFloat(($("#totalprice").val() / 10) * 1000) / 100 - parseFloat(($("input[name='usedmoney']").val() / 10) * 1000) / 100;
        newprice = Utils.round(parseFloat((newprice / 10) * 1000) / 100, 2);
        $("#newtotalprice").html(newprice);
    },
    ShowCouponList: function (obj) {
        if (obj.checked)
            $("#couponlist").show();
        else
            $("#couponlist").hide();
    },
    initCoupon: function (obj) {
        var ary = obj.value.split("-");
        try {
            $("#coupon1").val(ary[0]);
            $("#coupon2").val(ary[1]);
            $("#coupon3").val(ary[2]);
            $("#coupon4").val(ary[3]);

            this.verifyCoupon();
        } catch (e) { }
    },
    moveNext: function (obj, index) {
        obj.value = obj.value.toUpperCase();
        if (obj.value.length == 4 && index != 4) {
            $("#coupon" + (index + 1))[0].select();
            $("#coupon" + (index + 1))[0].focus();
        }
    },
    verifyCoupon: function () {
        var coupon = $("#coupon1").val() + "-" + $("#coupon2").val() + "-" + $("#coupon3").val() + "-" + $("#coupon4").val();
        var url = path + "cartstep.aspx?act=coupon&coupon=" + coupon;

        $("#load").show();
        $("#ok").hide();
        $("#error").hide();

        //Ajax请求
        $("#ispasstxt").load(url, function () {
            var ispass = $("#ispasstxt").html();
            $("#load").hide();
            if (isNaN(ispass)) {
                if (ispass == "none") {
                    $("#ok").hide();
                    $("#error").show();
                    $("#errmsg").html("× 验证错误，使用该券不存在或已被使用");
                } else {
                    $("#ok").hide();
                    $("#error").show();
                    $("#errmsg").html("× 验证错误，" + ispass);
                }
            } else {
                $("#ok").show();
                $("#error").hide();
                $("#couponmoney").html(ispass);
                $("#verify").enable();
            }
        });

        $("#verify")[0].checked = false;
        $("#verify").disable();
        $("#couponprice").val("0");
    },
    useCoupon: function () {
        if ($("#verify")[0].checked == true) {
            var newprice = parseFloat(($("#totalprice").val() / 10) * 1000) / 100 - parseFloat(($("#couponmoney")[0].innerHTML / 10) * 1000) / 100 - parseFloat(($("input[name='usedmoney']").val() / 10) * 1000) / 100;
            newprice = parseFloat((newprice / 10) * 1000) / 100;
            if (newprice < 0) newprice = 0;
            $("#newtotalprice").html(Utils.round(newprice, 2));
            $("#couponprice").val($("#couponmoney").html());
        } else {
            this._mathPrice();
            $("#couponprice").val("0");
        }
    },
    reloadPriceInfo: function () {
        $.get(path + "cartstep.aspx?act=getPriceInfo", function (data) {
            var dataArr = data.split("||");
            $("#priceSummary").html(dataArr[0]);
            $("#totalprice").val(dataArr[1]);
            $("#newtotalprice").html(dataArr[1]);
            $("#loginInvoiceprice").html("￥" + dataArr[2] + "元");
        });

        $("#usedscore").val(0);
        $("#usedmoneyTemp,#usedmoney").val(0);
        $("#couponprice").val(0);
        $("#verify")[0].checked = false;
    },
    submitNoAjaxOrder: function () {
        if (Utils.checkAjaxStatus()) {
            if ($("input[name='delivery']:checked").size() && $("input[name='paymethod']:checked").size()) {
                $("#submit_tip").show();
                Utils.showWaitInfo("正在提交订单，请稍候！", $("#submitWaitInfo"), true);
                $('#submit_btn').hide();
                $("#orderNoForm").ajaxSubmit({
                    beforeSubmit: Utils.showOverLay(),
                    success: function (data) {
                        if (data.indexOf("errMessage:") != -1) {
                            showBox(data.substr(11));
                            Utils.removeOverLay();
                            $("#submit_tip").hide();
                            $('#submit_btn').show();
                        }
                        else
                            window.location.href = data;
                    }
                });
            } else {
                art.dialog({
                    time: 3000,
                    lock: true,
                    title: '提示消息',
                    content: '对不起，支付方式或配送方式为空。\n您可能没有安装配送及支付方式或选择的地区没有配送方式！'
                });
                return false;
            }
        }
    },
    submitOrder: function () {
        if (Utils.checkAjaxStatus()) {
            if (CartOrder._check_submit_isClose()) {
                if ($("#isPayAndDly").val()) {
                    $("#submit_error").html('');
                    $("#submit_error").hide();
                    $("#submit_tip").show();
                    Utils.showWaitInfo("正在提交订单，请稍候！", $("#submitWaitInfo"), true);

                    $('#submit_btn').hide();
                    $("#orderRemark").val($("#txtRemark").val());
                    $("#orderForm").ajaxSubmit({
                        beforeSubmit: Utils.showOverLay(),
                        success: function (data) {
                            if (data.indexOf("errMessage:") != -1) {
                                showBox(data.substr(11));
                                Utils.removeOverLay();
                                $("#submit_tip").hide();
                                $('#submit_btn').show();
                            }
                            else
                                window.location.href = data;
                        }
                    });
                } else {
                    art.dialog({
                        time: 3000,
                        lock: true,
                        title: '提示消息',
                        content: '对不起，支付方式或配送方式为空。\n您可能没有安装配送及支付方式或选择的地区没有配送方式！'
                    });
                }
            }
        }
    },
    _check_submit_isClose: function () {
        var errInfo = "";
        //check all form is saved
        if (isAddrOpen) { errInfo += "“收货人信息”"; }
        if (isDlyOpen) { if (errInfo != '') { errInfo += ","; } errInfo += "“支付方式及配送方式”"; }
        if (isPackOpen) { if (errInfo != '') { errInfo += ","; } errInfo += "“商品包装及贺卡”"; }
        if (isInvoiceOpen) { if (errInfo != '') { errInfo += ","; } errInfo += "“发票信息”"; }
        if (errInfo != "") {
            $("#submit_error").html("请先保存" + errInfo);
            $("#submit_error").show();
            return false;
        }
        return true;
    },
    changeNation: function (isAjaxArea) {
        var obj = $("#area_nation option:selected");
        $.getJSON(path + "cartstep.aspx?areaId=" + obj.val() + "&level=2&act=getArea", function (data) {
            Utils.initAreaList($("#area_province"), data);
            Utils.initAreaList($("#area_city"));
            Utils.initAreaList($("#area_county"));
        });

        this.__getSelectArea();
        if ($("#tempAddr").val().length == 0)
            $("#txtAddress").val(nStr + $("#tempAddr").val());
        else
            $("#txtAddress").val($("#tempAddr").val().replace(nTmp, nStr));

        if (isAjaxArea) {
            $("#deliveryList").load(path + "cartstep.aspx?areaId=" + obj.val() + "&act=getDelivery")
        }
    },
    changeProvince: function (isAjaxArea) {
        var obj = $("#area_province option:selected");
        $.getJSON(path + "cartstep.aspx?areaId=" + obj.val() + "&level=3&act=getArea", function (data) {
            Utils.initAreaList($("#area_city"), data);
            Utils.initAreaList($("#area_county"));
        });
        this.__getSelectArea();
        if ($("#tempAddr").val().length == 0)
            $("#txtAddress").val(nStr + pStr + $("#tempAddr").val());
        else {
            $("#txtAddress").val($("#tempAddr").val().replace(nTmp + pTmp, nStr + pStr));
        }

        if (isAjaxArea) {


            $("#deliveryList").load(path + "cartstep.aspx?areaId=" + (obj.val() == "-1" ? $("#area_nation option:selected").val() : obj.val()) + "&act=getDelivery")
        }
    },
    changeCity: function (isAjaxArea) {
        var obj = $("#area_city option:selected");
        $.getJSON(path + "cartstep.aspx?areaId=" + obj.val() + "&level=4&act=getArea", function (data) {
            Utils.initAreaList($("#area_county"), data);
        });
        this.__getSelectArea();
        if ($("#tempAddr").val().length == 0)
            $("#txtAddress").val(nStr + pStr + cStr + $("#tempAddr").val());
        else {
            $("#txtAddress").val($("#tempAddr").val().replace(nTmp + pTmp + cTmp, nStr + pStr + cStr));
        }

        if (isAjaxArea) {
            $("#deliveryList").load(path + "cartstep.aspx?areaId=" + (obj.val() == "-1" ? $("#area_province option:selected").val() : obj.val()) + "&act=getDelivery")
        }
    },
    changeCounty: function (isAjaxArea) {
        var obj = $("#area_county option:selected");
        this.__getSelectArea();
        if ($("#tempAddr").val().length == 0)
            $("#txtAddress").val(nStr + pStr + cStr + cyStr + $("#tempAddr").val());
        else {
            $("#txtAddress").val($("#tempAddr").val().replace(nTmp + pTmp + cTmp + cyTmp, nStr + pStr + cStr + cyStr));
        }

        if (isAjaxArea) {
            $("#deliveryList").load(path + "cartstep.aspx?areaId=" + (obj.val() == "-1" ? $("#area_city option:selected").val() : obj.val()) + "&act=getDelivery")
        }
    },
    __getSelectArea: function () {
        nStr = $("#area_nation option:selected").text().replace("请选择", "");
        pStr = $("#area_province option:selected").text().replace("请选择", "");
        cStr = $("#area_city option:selected").text().replace("请选择", "");
        cyStr = $("#area_county option:selected").text().replace("请选择", "");
    }
}

//cart utility
var Utils = {
    //check the whole page's ajax is complete
    checkAjaxStatus: function () {
        if (jqueryAjaxStatus != -1 && jqueryAjaxStatus != 4) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '页面正在加载中，请稍候……！'
            });
            return false;
        } else return true;
    },
    showProductListHtml: function (data) {
        if ($('#productList'))
            $('#productList').html(data);
    },
    showWaitInfo: function (info, obj, needOver) {
        try {
            if (obj == null) return;
            this.clearWaitInfo();
            if (!needOver)
                var newd = document.createElement("span");
            else
                var newd = document.createElement("div");

            newd.className = 'waitInfo';
            newd.id = 'waitInfo';
            newd.innerHTML = info;
            obj.parent().append(newd);
            if (needOver)
                $(newd).css({ "width": "135px", "position": "relative", "z-index": "110", "margin-left": "auto" });
        } catch (e) { }
    },
    clearWaitInfo: function () {
        $('#waitInfo').remove();
    },
    showOverLay: function () {
        var obj = document.createElement("div");
        obj.id = "usercart-overlay";
        $(document.body).append(obj);
        var ie6 = navigator.userAgent.indexOf('MSIE 6') >= 0;
        var $body = $(ie6 ? document.body : document);
        $('#usercart-overlay').css({
            width: $body.width(),
            height: $body.height()
        });
        if (ie6) {
            $('#usercart-overlay').css({
                position: 'absolute',
                top: '0px',
                left: '0px'
            });
        }
    },
    removeOverLay: function () {
        $("#usercart-overlay").remove();
    },
    showAddWaitTip: function (obj) {
        var msg = "";
        msg = "商品加入成功！&nbsp;<a href='" + path + "cart.aspx#top'>转到购物车</a>";

        var tipHtml = "<div id='addSucTip'>" + msg + "</div>";
        $("#" + obj).hide();
        $("#" + obj).after(tipHtml);

        //1.5秒后将提示层删除
        window.setTimeout(function () {
            $("#" + obj).next("div").remove();
            $("#" + obj).show();
        }, 1500);
    },
    showChangeSucTip: function (pos) {
        this.closeWindow();
        pos.Top = pos.Top - 84;
        pos.Left = pos.Left - (204 - pos.Width) / 2;
        //定义数量更改提示层
        var tipHtml = "<div id='changeSucTip'><div id='tipContent'><div id='tipTitle'>商品数量修改成功！<br />商品金额为：<span id='priceSpan'>" + $('#cartBottom_price').html() + "</span>元<br /><a href='javascript:Utils.closeWindow()'>关闭</a></div></div></div>";
        this._showMessageBox(tipHtml, pos, 204);

        var mWin = $('#mesWindow');
        setTimeout(function () { mWin.fadeOut(300, this.closeWindow); }, 4000);
    },
    _showMessageBox: function (content, pos, wWidth) {
        this.closeWindow();
        var bWidth = parseInt(document.documentElement.scrollWidth);
        var bHeight = parseInt(document.documentElement.scrollHeight);
        var mesW = document.createElement("div");
        mesW.id = "mesWindow";
        mesW.innerHTML = content;
        if (bWidth - pos.Left < wWidth) {
            styleStr = "left:" + (pos.Left - wWidth) + "px;";
        }
        else {
            styleStr = "left:" + (pos.Left) + "px;";
        }
        styleStr += "top:" + pos.Top + "px;position:absolute;width:" + wWidth + "px;";
        mesW.style.cssText = styleStr;
        document.body.appendChild(mesW);

    },
    closeWindow: function () {
        if ($('#mesWindow'))
            $('#mesWindow').remove();
    },
    initAreaList: function (tmpObj, arr) {
        var obj = tmpObj[0];
        obj.length = 0;
        obj.options.add(new Option("请选择", "-1"));
        if (arr) {
            var has = false;
            $.each(arr, function (i, n) {
                obj.options.add(new Option(i, n));
                has = true;
            })
            if (has) tmpObj.show();
            else tmpObj.hide();
        } else tmpObj.hide();
    },
    loadScript: function (id, name) {
        var oScript = document.getElementById(id);
        var bdy = document.getElementsByTagName("body").item(0);
        if (oScript) {
            bdy.removeChild(oScript);
        }
        oScript = document.createElement("script");
        oScript.setAttribute("src", "js/" + name);
        oScript.setAttribute("id", id);
        oScript.setAttribute("type", "text/javascript");
        oScript.setAttribute("language", "javascript");
        bdy.appendChild(oScript);
    },
    round: function (number, precision) {
        precision = Math.pow(10, precision || 0);
        return Math.round(number * precision) / precision;
    }

}

//-------------------------------------------------------------
//all common class
//-------------------------------------------------------------
function getPos(obj) {
    this.Left = 0;
    this.Top = 0;
    this.Height = obj.offsetHeight;
    this.Width = obj.offsetWidth;
    var tempObj = obj;
    try {
        while (tempObj.tagName.toLowerCase() != "body" && tempObj.tagName.toLowerCase() != "html") {
            this.Left += tempObj.offsetLeft;
            this.Top += tempObj.offsetTop;
            tempObj = tempObj.offsetParent;
        }
    } catch (e) { }
}

function DeledSku() {
    this.Id = '';
    this.TrueID = '';
    this.Name = '';
    this.Price = '';
    this.Num = '';
}

//bind page event
$(document).ready(function () {
    $("input[name='paymethod']").click(CartOrder.checkCod);
    $("#btnSaveOrder").click(CartOrder.submitOrder);

    //换购商品单独绑定事件
    $(".chg-img-btn").click(function () {
        var id = $(this).attr("id");
        Cart.AddProduct(id, "0", 'chg_' + id, 'present')
    });

    //支付按钮绑定蒙板层事件
    $(".payment-btn").click(function () {
        Utils.showOverLay();
        var top = ($(window).height() - 288) / 2;
        var left = ($(window).width() - 340) / 2;
        $(".payment-info-tip").css({
            "z-index": 101,
            "position": "absolute",
            "top": top,
            "left": left
        }).show();
    });
    $(".payment-close-btn").click(function () {
        Utils.removeOverLay();
        $(".payment-info-tip").hide();
        return false;
    });
    $("#noaddress").click(function () {
        window.location.href = "member/editaddress.aspx?url=cart.aspx";


    });

    bindBuyEvent();
});

var bindBuyEvent = function () {
    $(".buy-img-btn").unbind().bind("click", function () {
        var id = $(this).attr("id");
        var num = $(this).attr("buynum");
        Utils.showOverLay();
        $.ajax({
            beforeSend: function () {
                var top = ($(window).height() - 30) / 2 + $(window).scrollTop();
                var left = ($(window).width() - 200) / 2;
                $(document.body).append($("<div style='position: absolute; z-index: 120;top:" + top + "px;left:" + left + "px;' class='submitSuccess' id='addTrue_info'>正在读取规格信息，请稍候……</div>"));
            },
            url: path + "cart.aspx?act=getTrueProduct&id=" + id,
            complete: function () {
                $("#addTrue_info").remove();
            },
            success: function (data) {
                if (data.indexOf("trueProductId:") != -1) {
                    var trueId = data.substring(14);
                    //隐藏遮罩层
                    Utils.removeOverLay();
                    //收藏夹购买
                    Cart.AddProduct(id, trueId, 'fav_' + id, 'buyAjax', num);
                } else {
                    var el = $(data);
                    $(document.body).append(el);
                    var top = ($(window).height() - el.height()) / 2 + $(window).scrollTop();
                    var left = ($(window).width() - el.width()) / 2;
                    el.css({ "top": top, "left": left, "z-index": 130 }).show();

                    $(".chooselist").draggable({ handle: ".chooselist-title" });

                    //bind for buy btn
                    $(".buy-spec-img-btn").unbind().click(function () {
                        var _id = $(this).attr("id");
                        var _trueId = $(this).attr("trueid");
                        Cart.AddProduct(_id, _trueId, 'fav_' + _id, 'buyAjax');
                        el.remove();
                        Utils.removeOverLay();
                    });

                    //bind for close btn
                    $("#specCloseImg").unbind().click(function () {
                        el.remove();
                        Utils.removeOverLay();
                    });
                }

            }
        });
    });
}
function cartDel(skuId, obj) {
    $.ajax({
        dataType: "json",
        type: "POST",
        cache: false,
        data: "act=del&cartId=" + skuId,
        url: "cart.aspx",
        success: function (data) {
            if (data.cartItem[0].count != "") {
                $("#count").html("共" + data.cartItem[0].count + "件商品");
                $("#orderprice").html("总价:¥" + data.cartItem[0].orderprice);
                $("#countcart").html(data.cartItem[0].count);
            } else {
                $("#count").html("共0件商品");
                $("#orderprice").html("总价:¥0.00");
                $("#countcart").attr("style", "display:none");
                $("#cart_count").hide();
                $("#cart-list").hide();
                $("#s-btn").hide();
                $(".cart-info").hide();
                $("#cart-none").show();
            }
            obj.parentNode.parentNode.parentNode.remove();
        }
    });
}
function onKeyup(id,obj) {
    obj.value = obj.value.replace(/\D/g, '');
   
    $.ajax({
        type: "POST",
        cache: false,
        dataType: "json",
        data: "act=modify&cartId=" + id + "&count=" + obj.value,
        url: "cart.aspx",
        success: function (data) {
            obj.parentNode.parentNode.children[0].children[1].innerHTML = $(obj).attr('price') * obj.value + ".00";
            $("#count").html("共" + data.cartItem[0].count + "件商品");
            $("#orderprice").html("总价:¥" + data.cartItem[0].orderprice);
            $("#countcart").html(data.cartItem[0].count);
        }
    });
}
function onChange(id, obj) {
    obj.value = obj.value.replace(/\D/g, '');
    if (obj.value == '' || obj.value == '0') {
        obj.value = 1;
    }
    $.ajax({
        type: "POST",
        cache: false,
        dataType: "json",
        data: "act=modify&cartId=" + id + "&count=" + obj.value,
        url: "cart.aspx",
        success: function (data) {
            obj.parentNode.parentNode.children[0].children[1].innerHTML = $(obj).attr('price') * obj.value + ".00";
            $("#count").html("共" + data.cartItem[0].count + "件商品");
            $("#orderprice").html("总价:¥" + data.cartItem[0].orderprice);
            $("#countcart").html(data.cartItem[0].count);
        }
    });
}


function onAfterpaste(obj){
    obj.value = obj.value.replace(/\D/g, '');
    if (obj.value == ''||obj.value =='0') {
        obj.value = 1;
    }
} 