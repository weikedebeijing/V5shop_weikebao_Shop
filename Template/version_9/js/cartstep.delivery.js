//加载购物车列表
$(document).ready(function () {
    var deliveryItemHTML = $("#ShowDeliveryType").html();
    var deliveryHTML = "";
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=getDly",
        success: function (data) {            
            if (data == null) {
                deliveryItemHTML = $("#ShowDeliveryType").html();
                $("#DeliveryTypeShow").show();
                $("#DeliveryTypeEdit").hide();
                //deliveryItemHTML = deliveryItemHTML.replace("$DeliveryDetail", "<p>您所在的地区没有配送方式，请联系商城管理员。</p>");
                $("#DeliveryTypeShow").html("<div id='DeliveryTypeShow'><h1>配送方式： </h1><div class='fangshi DivClosed'><p>您所在的地区没有配送方式，请联系商城管理员。</p></div></div>");
                $("#DelieryType_Hidden_Type").val("1"); //设置编辑配送方式为关闭
            }
            else {
                if (data.OrderInfo.length > 0) {
                    deliveryItemHTML = $("#EditDeliveryType").html();
                    $("#DeliveryTypeShow").hide();
                    $("#DeliveryTypeEdit").show();
                    $(data.Delivery).each(function (index) {
                        var DeliveryItem = data.Delivery[index];
                        deliveryHTML += "<p><input type=\"radio\" iscod='" + DeliveryItem.IsCOD + "' value=\"" + DeliveryItem.DLLName + "\" name=\"delivery\" onclick=\"ChangeDly(this)\"  id=\"d_" + DeliveryItem.ID + "\" query='" + DeliveryItem.QueryArray + "' />" + DeliveryItem.Name + "</p>";
                    });
                    $("#FeePrice").val(data.Fee[0].fee);
                    deliveryItemHTML = deliveryItemHTML.replace("$DeliveryPrice", "￥" + data.Fee[0].fee);
                    deliveryItemHTML = deliveryItemHTML.replace("$DeliveryList", deliveryHTML);
                    $("#DeliveryTypeEdit").html(deliveryItemHTML);
                    OldDelieryType = g("DeliveryTypeShow").innerHTML;
                    $("#DelieryType_Hidden_Type").val("1"); //设置编辑配送方式为打开
                }
                else {
                    deliveryItemHTML = $("#ShowDeliveryType").html();                   
                    deliveryItemHTML = deliveryItemHTML.replace("$DeliveryDetail", "<p>配送方式：" + data.Delivery[0].Name + "</p><p>运费：￥" + data.Fee[0].fee + "元</p>");
                    $("#DeliveryTypeShow").html(deliveryItemHTML);
                    $("#DelieryType_Hidden_Type").val("0"); //设置编辑配送方式为关闭
                }
            }
        }
    });
});

var OldDelieryType = "";
//编辑修改配送方式
function showForm_Dly(areaname) {
    $("#DelieryType_Hidden_Type").val("1");
    $("#DeliveryTypeEdit").show();
    $("#DeliveryTypeShow").hide();
    OldDelieryType = g("DeliveryTypeShow").innerHTML;    
    var deliveryItemHTML = $("#EditDeliveryType").html();
    var deliveryHTML = "";
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=getPayAndDly&areaname=" + areaname,
        success: function (data) {
            var chk = "checked";
            if (data.Delivery != "{}") {
                $(data.Delivery).each(function (index) {
                    var DeliveryItem = data.Delivery[index];
                    deliveryHTML += "  <input type=\"radio\" iscod='" + DeliveryItem.IsCOD + "' value=\"" + DeliveryItem.DLLName + "\" name=\"delivery\" onclick=\"ChangeDly(this)\" " + (DeliveryItem.DLLName == DeliveryItem.sdly ? chk : "") + " id=\"d_" + DeliveryItem.ID + "\" query='" + DeliveryItem.QueryArray + "' />" + DeliveryItem.Name + "";
                });
                $("#FeePriceAll").val(data.Fee[0].fee);
                deliveryItemHTML = deliveryItemHTML.replace("$DeliveryPrice", "￥" + data.Fee[0].fee);
                deliveryItemHTML = deliveryItemHTML.replace("$DeliveryList", deliveryHTML);
            }
            $("#DeliveryTypeEdit").html(deliveryItemHTML);
        }
    });
}

//关闭配送方式
function closeForm_Dly() {
    if (OldDelieryType != "") {
        $("#DeliveryTypeShow").show();
        $("#DeliveryTypeEdit").hide();
        g('DelieryType_Hidden_Type').value = 1; //设置编辑支付方式为关闭
        g("DeliveryTypeShow").innerHTML = OldDelieryType;
    }
}

function ChangeDly(obj) {    
    if ($(obj).attr("iscod") == "0" && $("input[name='paymethod']:checked").val() == "COD") {        
        art.dialog({
            time: 3000,
            lock: true,
            title: '提示消息',
            content: '该配送方式不支持货到付款！'
        });
        obj.checked = false;
        return;
    }
    $.ajax({
        type: "POST",
        url: path + "cartstep.aspx",
        data: "act=calcFee&query=" + $(obj).attr("query") + "&dllname=" + $(obj).val(),
        success: function (data) {
            $(".maincolor").html("￥" + data);
            $("#FeePriceAll").val(data);
        }
    });
}

//保存配送方式
function saveDeliveryType(obj) {   
    var delTypeRadio = gn("input", "delivery");
    var did = 0;
    for (i = 0; i < delTypeRadio.length; i++) {
        if (delTypeRadio[i].checked) {
            did = delTypeRadio[i].value;
            break;
        }
    }
    if (did == 0) {//未选配送方式
        art.dialog({
            time: 3000,
            lock: true,
            title: '提示消息',
            content: '请选择配送方式！'
        });
        return;
    }

    var fee = $("#FeePriceAll").val();
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=saveDly&feeValue=" + fee + "&delivery=" + did + "",
        success: function (data) {
            var OrderInfoItem = data.OrderInfo[0];
            $("#DeliveryTypeShow").show();
            $("#DeliveryTypeEdit").hide();
            var deliveryItemHTML = $("#ShowDeliveryType").html();
            deliveryItemHTML = deliveryItemHTML.replace("$DeliveryDetail", "<p>配送方式：" + OrderInfoItem.DlyName + "</p><p>运费：￥" + OrderInfoItem.Fee + "元</p>");
            $("#DelieryType_Hidden_Type").val("0"); //设置编辑支付方式为关闭
            $("#DeliveryTypeShow").html(deliveryItemHTML);
            reloadPriceInfo();
        }
    });
}

function reloadPriceInfo() {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=getPriceInfo",
        success: function (data) {
            if (data != null) {
                var priceItem = data.PriceItem[0];
                //$("#priceSummary").html("商品金额：" + priceItem.totalprice + "元 + 运费：" + priceItem.feeprice + "元 + 发票：" + priceItem.invoiceprice + "元");
                $("#feeprice").html(priceItem.feeprice);
                $("#totalprice").html(priceItem.totalprice);
                $("#OrderFormMoney").html(priceItem.orderprice);
                $("#submittext").html('请核对以上信息，确认无误后点击"提交订单"').show().css("color", "#A10000");
                //$("#newtotalprice").html(priceItem.orderprice);
                //$("#loginInvoiceprice").html("￥" + priceItem.invoiceprice + "元");
            }
        }
    });
}
