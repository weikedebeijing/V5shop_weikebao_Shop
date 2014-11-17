/*快速购买*/
$(document).ready(function () {

    $("div[name='specvals']").each(function () {
        if (this.children.length === 1) {
            change(this.children[0]);
        }
    })

    $('#btnCart').bind("click", function () {
        var trueId = "";
        var count = "";
        var $uiskuprop = $(".s-buy-ul .right span");
        var $uiskupropCount = $(".s-buy-ul .s-buy-li").length - 1;
        var flag = 0;
        $($uiskuprop).each(function () {
            flag = $(this).attr("checked") == "checked" ? flag + 1 : flag; //判断所有规格是否都选完整了
        });

        if ($uiskupropCount === flag) {
            var num = $("#num").val() * 1;
            var nummax = $("#num").attr('max') * 1;
            if (num >= 1) {
                if (num <= nummax) {
                    trueId = $("#hiddPDetailID").val();
                    count = $("#num").val();
                    $.ajax({
                        url: "cart.aspx?act=fastbuy&TureProductId=" + trueId + "&BuyNumber=" + count,
                        async: true,
                        type: "post",
                        cache: false,
                        success: function (data) {
                            if (!CheckInt(data)) {
                                $.ajax({
                                    url: "cart.aspx?act=fastbuy&TureProductId=" + trueId + "&BuyNumber=" + count,
                                    async: true,
                                    type: "post",
                                    cache: false,
                                    success: function (data2) {
                                        data = data2;
                                    }
                                })
                            }
                            if (data == 1) {
                                $("#countcart").show();
                            }
                            $("#countcart").html(data);
                            $('body,html').animate({ scrollTop: 0 }, 800);

                        }
                    });
                } else {
                    showBox("库存不足");
                }
            } else {
                showBox("商品的数量至少为1");
            }
        } else {
            showBox("请选择完整的商品规格");
        }
    });

    function CheckInt(obj) {
        var pattern = /^[1-9]\d*|0$/; //匹配非负整数
        if (!pattern.test(obj)) {
            return false;
        } else {
            return true;
        }
    }

    $('#btnFastBuy').bind("click", function () {
        var trueId = "";
        var count = "";
        var $uiskuprop = $(".s-buy-ul .right span");
        //$uiskuprop = $("#propertyDiv div[name='specvals'] span");
        var $uiskupropCount = $(".s-buy-ul .s-buy-li").length - 1;
        //$uiskupropCount = $("#propertyDiv ")
        var flag = 0;
        $($uiskuprop).each(function () {
            flag = $(this).attr("checked") == "checked" ? flag + 1 : flag; //判断所有规格是否都选完整了
        });
        if ($uiskupropCount === flag) {
            var num = $("#num").val() * 1;
            var nummax = $("#num").attr('max') * 1;
            if (num >= 1) {
                if (num <= nummax) {
                    trueId = $("#hiddPDetailID").val();
                    count = $("#num").val();
                    $.ajax({
                        url: "cart.aspx?act=fastbuy&TureProductId=" + trueId + "&BuyNumber=" + count,
                        async: true,
                        type: "post",
                        cache: false,
                        success: function (data) {
                            if (!CheckInt(data)) {
                                $.ajax({
                                    url: "cart.aspx?act=fastbuy&TureProductId=" + trueId + "&BuyNumber=" + count,
                                    async: true,
                                    type: "post",
                                    cache: false,
                                    success: function (data2) {
                                        window.location.href = "cart.aspx";
                                    }
                                })
                                //window.location.href = "cart.aspx?act=fastbuy&TureProductId=" + trueId + "&BuyNumber=" + count;
                            } else {
                                window.location.href = 'cart.aspx';
                            }
                        }
                    });

                } else {
                    showBox("库存不足");
                }
            } else {
                showBox("商品的数量至少为1");
            }
        } else {
            showBox("请选择完整的商品规格");
        }
    });

    function preventNo(e) {
        e.preventDefault();
    }

    $('#btnShare').bind("click", function () {
        var topheight = document.body.scrollTop;
        var scrollHeight = document.body.scrollHeight;
        $("#mask-bg").attr("style", "height:" + (scrollHeight + topheight) + "px");
        $("#mask-content").attr("style", "padding-top:" + topheight + "px");
        $("#mask-bg").show();
        $("#mask-content").show();
        document.addEventListener('touchmove', preventNo, false);

    });
    $('#mask-bg').bind("click", function () {
        $("#mask-bg").hide();
        $("#mask-content").hide();
        document.removeEventListener('touchmove', preventNo, false);
    });
    $('#mask-content').bind("click", function () {
        $("#mask-bg").hide();
        $("#mask-content").hide();
        document.removeEventListener('touchmove', preventNo, false);
    });

});

var specificationValueDatas = {};
var productDatas = {};
var obj = {
    Span1: "",
    Span2: "",
    Span3: "",
    Span4: ""
};

function change(span) {
    $('span[name=' + $(span).attr('name') + ']').each(function () {
        //        if (this.checked && this != span) {
        $(this).removeClass("current");
        $(this).attr("checked", "");
        //        } else {
        //            $(span).removeClass("current");
        //            this.checked = false;
        //        }
    });
    obj[$(span).attr('name')] = span.innerHTML;
    $(span).addClass("current");
    $(span).attr("checked", "checked");

    var specificationValueSelecteds = new Array();
    var $specificationValueSelected = $(".s-buy-ul .right span");
    $specificationValueSelected.each(function (i) {
        var $this = $(this);
        if ($this.attr("checked") === "checked") {
            specificationValueSelecteds.push($this.attr("id"));
        }
    });

    $.each(specificationValueDatas, function (i) {
        if (specificationValueDatas[i].toString() == specificationValueSelecteds.sort().toString() || specificationValueDatas[i].toString() == specificationValueSelecteds.reverse().toString()) {
            //                       $productSn = $productSn.text(productDatas[i].productSn);
            $("#price").text(productDatas[i].SalesPrice);
            $("#num").attr("max", productDatas[i].Stock);
            $("#hiddPDetailID").val(productDatas[i].productDetailID);
            $("#Stock").html("剩余" + productDatas[i].Stock + "件");
        }
    });


    select();
}

function select() {
    var html = '';
    for (var i in obj) {
        if (obj[i] != '') {
            html += '<font color=orange>"' + obj[i] + '"</font> 、';
        }
    }
    //    html = '<b> 已选择:</b> ' + html.slice(0, html.length - 1);
    //    $('#resultSpan').html(html);

}

function imgview(obj) {

    var arr = "";
    $(obj.parentNode.children).each(function () {
        arr += $(this).attr('data-src') + ",";
    });
    var c = arr.substring(0, arr.length - 1).split(',');
    if (typeof window.WeixinJSBridge != 'undefined') {
        WeixinJSBridge.invoke("imagePreview", {
            current: c[0],
            urls: c
        });
    }
}
function showPic() {
    $("#content").html(hdata);
    $("#p-detailoff").hide();
    $("#p-detail").show();

};
window.onload = function () {
    if (typeof window.WeixinJSBridge != 'undefined') {
        document.addEventListener("WeixinJSBridgeReady", onWeixinReady, false);
    } else {
        $("#p-detailoff").show();
    }
}
function onWeixinReady() {
    WeixinJSBridge.invoke('getNetworkType', {}, function (e) {
        WeixinJSBridge.log(e.err_msg);
        var state = e.err_msg.split(':')[1];
        if (state == "wifi") {
            $("#content").html(hdata);
            $("#p-detail").show();
        } else {
            $("#p-detailoff").show();
        }
    });
}


