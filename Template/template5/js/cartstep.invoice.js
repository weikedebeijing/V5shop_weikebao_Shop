//加载购物车列表
$(document).ready(function () {
    var InvoiceItemHTML = "";
    var InvoiceHTML = "";
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=getInvoice",
        success: function (data) {
            if (data != null) {
                if (data.OrderInfo.length > 0) {
                    var InvoiceItem = data.OrderInfo[0];
                    if (InvoiceItem.IsInvoice != "0") {
                        InvoiceItemHTML = $("#ShowInvoiceType").html();
                        $("#InvoiceTypeShow").show();
                        $("#InvoiceTypeEdit").hide();
                        InvoiceItemHTML = InvoiceItemHTML.replace("$InvoiceDetail", "<p>发票抬头：" + InvoiceItem.InvoiceHead + "</p><p>发票金额:￥" + InvoiceItem.InvoicePrice + "元</p>");
                        $("#InvoiceTypeShow").html(InvoiceItemHTML);

                        $("#PartInvoice_Hidden_Type").val("0"); //设置编辑发票为关闭
                    }
                    else {
                        InvoiceItemHTML = $("#ShowInvoiceType").html();
                        $("#InvoiceTypeShow").show();
                        $("#InvoiceTypeEdit").hide();
                        InvoiceItemHTML = InvoiceItemHTML.replace("$InvoiceDetail", "<p>是否需要发票：否</p>");
                        $("#InvoiceTypeShow").html(InvoiceItemHTML);

                        $("#PartInvoice_Hidden_Type").val("0"); //设置编辑发票为关闭
                    }
                }
                else {
                    InvoiceItemHTML = $("#EditInvoiceType").html();
                    $("#InvoiceTypeShow").hide();
                    $("#InvoiceTypeEdit").show();
                    InvoiceHTML = " <p>是否需要发票：<input type='checkbox' id='IsInvoice' name='IsInvoice' value='1' /></p>";
                    InvoiceHTML += "<p>发票抬头：<input id=\"InvoiceHead\" class=\"Fpassword\" type=\"text\" name=\"InvoiceHead\" value='' /></p>";
                    InvoiceHTML += "<input name='InvoicePrice' type='hidden' id='InvoicePrice' value='" + $("#invoiceprice").val() + "' />";

                    InvoiceHTML += "<p>发票金额：￥" + $("#invoiceprice").html() + "元</p>";

                    InvoiceItemHTML = InvoiceItemHTML.replace("$InvoiceList", InvoiceHTML);
                    $("#InvoiceTypeEdit").html(InvoiceItemHTML);
                    $("#PartInvoice_Hidden_Type").val("1"); //设置编辑发票为打开
                }
            }
        }
    });

});

var OldInvoiceType = "";
//编辑修改发票信息
function showForm_Invoice() {
    $("#InvoiceTypeEdit").show();
    $("#InvoiceTypeShow").hide();
    OldInvoiceType = g("InvoiceTypeShow").innerHTML;

    var InvoiceItemHTML = $("#EditInvoiceType").html();
    var InvoiceHTML = "";
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=getInvoice",
        success: function (data) {
            var chk = "checked";
            if (data.OrderInfo.length > 0) {
                var InvoiceItem = data.OrderInfo[0];
                InvoiceItemHTML = $("#EditInvoiceType").html();
                $("#InvoiceTypeShow").hide();
                $("#InvoiceTypeEdit").show();
                InvoiceHTML = " <p>是否需要发票：<input type='checkbox' id='IsInvoice' name='IsInvoice' value='1' " + (InvoiceItem.IsInvoice == "1" ? "checked" : "") + "/></p>";
                InvoiceHTML += "<p>发票抬头：<input id=\"InvoiceHead\" class=\"Fpassword\" type=\"text\" name=\"InvoiceHead\" value='" + InvoiceItem.InvoiceHead + "' /></p>";
                InvoiceHTML += "<input name='InvoicePrice' type='hidden' id='InvoicePrice' value='" + InvoiceItem.invprice + "' />";
                InvoiceHTML += "<p>发票金额：￥" + InvoiceItem.invprice + "元</p>";

                InvoiceItemHTML = InvoiceItemHTML.replace("$InvoiceList", InvoiceHTML);
                $("#InvoiceTypeEdit").html(InvoiceItemHTML);

                $("#PartInvoice_Hidden_Type").val("1"); //设置编辑发票为打开
            }
            else {
                InvoiceItemHTML = $("#EditInvoiceType").html();
                $("#InvoiceTypeShow").hide();
                $("#InvoiceTypeEdit").show();
                InvoiceHTML = " <p>是否需要发票：<input type='checkbox' id='IsInvoice' name='IsInvoice' value='1' /></p>";
                InvoiceHTML += "<p>发票抬头：<input id=\"InvoiceHead\" class=\"Fpassword\" type=\"text\" name=\"InvoiceHead\" value='' /></p>";
                InvoiceHTML += "<input name='InvoicePrice' type='hidden' id='InvoicePrice' value='" + $("#invoiceprice").val() + "' />";

                InvoiceHTML += "<p>发票金额：￥" + $("#invoiceprice").html() + "元</p>";

                InvoiceItemHTML = InvoiceItemHTML.replace("$InvoiceList", InvoiceHTML);
                $("#InvoiceTypeEdit").html(InvoiceItemHTML);

                $("#PartInvoice_Hidden_Type").val("1"); //设置编辑发票为打开
            }
        }
    });
}

//关闭发票信息
function closeForm_Invoice() {
    if (OldInvoiceType != "") {
        $("#InvoiceTypeShow").show();
        $("#InvoiceTypeEdit").hide();
        g('PartInvoice_Hidden_Type').value = 0; //设置编辑支付方式为关闭
        g("InvoiceTypeShow").innerHTML = OldInvoiceType;
    }
    else {
        var InvoiceItemHTML = $("#ShowInvoiceType").html();
        $("#InvoiceTypeShow").show();
        $("#InvoiceTypeEdit").hide();
        InvoiceItemHTML = InvoiceItemHTML.replace("$InvoiceDetail", "<p>是否需要发票：否</p>");
        $("#InvoiceTypeShow").html(InvoiceItemHTML);

        $("#PartInvoice_Hidden_Type").val("0"); //设置编辑发票为关闭
    }
}

//保存发票信息
function savePart_Invoice() {
    if ($("#IsInvoice").attr("checked")) {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: path + "cartstep.aspx",
            data: "act=saveInvoice&IsInvoice=" + $("#IsInvoice").attr("checked") + "&InvoiceHead=" + encodeURIComponent(encodeURIComponent($("#InvoiceHead").val())) + "&InvoicePrice=" + $("#InvoicePrice").val() + "",
            success: function (result) {
                if (result != null) {
                    var InvoiceItem = result.Invoice[0];
                    InvoiceItemHTML = $("#ShowInvoiceType").html();
                    $("#InvoiceTypeShow").show();
                    $("#InvoiceTypeEdit").hide();
                    InvoiceItemHTML = InvoiceItemHTML.replace("$InvoiceDetail", "<p>发票抬头：" + InvoiceItem.InvoiceHead + "</p><p>发票金额:￥" + InvoiceItem.InvoicePrice + "元</p>");
                    $("#InvoiceTypeShow").html(InvoiceItemHTML);

                    g('PartInvoice_Hidden_Type').value = 0; //设置编辑支付方式为关闭

                    $("#invoiceprice").html(InvoiceItem.InvoicePrice);
                    reloadPriceInfo();
                }
            }
        });
    }
    else {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: path + "cartstep.aspx",
            data: "act=saveInvoice&IsInvoice=" + $("#IsInvoice").attr("checked") + "&InvoiceHead=" + encodeURIComponent(encodeURIComponent($("#InvoiceHead").val())) + "&InvoicePrice=" + $("#InvoicePrice").val() + "",
            success: function (result) {
                if (result != null) {
                    var InvoiceItem = result.Invoice[0];
                    InvoiceItemHTML = $("#ShowInvoiceType").html();
                    $("#InvoiceTypeShow").show();
                    $("#InvoiceTypeEdit").hide();
                    InvoiceItemHTML = InvoiceItemHTML.replace("$InvoiceDetail", "<p>是否需要发票：否</p>");
                    $("#InvoiceTypeShow").html(InvoiceItemHTML);

                    g('PartInvoice_Hidden_Type').value = 0; //设置编辑支付方式为关闭

                    $("#invoiceprice").html("0");
                    reloadPriceInfo();
                }
            }
        });
    }

}