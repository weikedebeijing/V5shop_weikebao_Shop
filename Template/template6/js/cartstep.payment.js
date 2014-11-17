//加载购物车列表
$(document).ready(function () {
    var paymentItemHTML = $("#ShowPaymnetType").html();
    var paymentHTML = "";
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=getPay",
        success: function (data) {
            if (data != null) {

                if (data.Payment != null) {
                    paymentItemHTML = $("#EditPayType").html();
                    $("#PaymentTypeShow").hide();
                    $("#PayTypeEdit").show();
                    $(data.Payment).each(function (index) {
                        var PaymentItem = data.Payment[index];
                        paymentHTML += "<p><input id='p_" + PaymentItem.id + "' name='paymethod' type='radio' payname='" + PaymentItem.Name + "' value='" + PaymentItem.DllName + "' />" + PaymentItem.Name + "</p>";
                    });
                    paymentItemHTML = paymentItemHTML.replace("$PaymentList", paymentHTML);
                    $("#PayTypeEdit").html(paymentItemHTML);
                    $("#PayType_Hidden_Type").val("1"); //设置编辑支付方式为打开

                }
                else {
                    paymentItemHTML = $("#ShowPaymnetType").html();
                    $("#PaymentTypeShow").show();
                    $("#PayTypeEdit").hide();
                    paymentItemHTML = paymentItemHTML.replace("$PaymentDetail", "<p>" + data.OrderInfo[0].PayName + "</p>");
                    $("#PaymentTypeShow").html(paymentItemHTML);
                    $("#PayType_Hidden_Type").val("0"); //设置编辑支付方式为关闭
                }
            }
        }
    });

});

var OldPaymentType = "";
//编辑修改支付方式
function showForm_Pay() {
    $("#PayTypeEdit").show();
    $("#PaymentTypeShow").hide();
    OldPaymentType = g("PaymentTypeShow").innerHTML;

    var paymentItemHTML = $("#EditPayType").html();
    var paymentHTML = "";
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=getPayAndDly",
        success: function (data) {
            var chk = "checked";
            if (data.Payment != "{}") {
                $(data.Payment).each(function (index) {
                    var PaymentItem = data.Payment[index];
                    paymentHTML += "<p><input id='p_" + PaymentItem.id + "' name='paymethod' type='radio'  payname='" + PaymentItem.Name + "' value='" + PaymentItem.DllName + "' " + (PaymentItem.DllName == PaymentItem.spay ? chk : "") + " />" + PaymentItem.Name + "</p>";
                });
                paymentItemHTML = paymentItemHTML.replace("$PaymentList", paymentHTML);
            }
            $("#PayTypeEdit").html(paymentItemHTML);
            $("#PayType_Hidden_Type").val("1"); //设置编辑支付方式为打开
        }
    });
}

//关闭支付方式
function closeForm_Pay() {
    if (OldPaymentType != "") {
        $("#PaymentTypeShow").show();
        $("#PayTypeEdit").hide();
        g('PayType_Hidden_Type').value = 0; //设置编辑支付方式为关闭
        g("PaymentTypeShow").innerHTML = OldPaymentType;
    }
}

//保存支付方式
function savePaymentType(obj) {
    var payTypeRadio = gn("input", "paymethod");
    var pid = 0;
    var payname="";
    for (i = 0; i < payTypeRadio.length; i++) {
        if (payTypeRadio[i].checked) {
            pid = payTypeRadio[i].value;
            payname = payTypeRadio[i].attributes["payname"].value;
	
            break;
        }
    }

    if (pid == 0) {//未选支付方式
        art.dialog({
            time: 3000,
            lock: true,
            title: '提示消息',
            content: '请选择支付方式'
        });
        return;
    }
    
//    $.ajax({
//        type: "POST",
//        dataType: "json",
//        url: path + "cartstep.aspx",
//        data: "act=savePay&paymethod=" + pid + "",
//        success: function (data) {
//            var OrderInfoItem = data.OrderInfo[0];
            $("#PaymentTypeShow").show();
            $("#PayTypeEdit").hide();
            var paymentItemHTML = $("#ShowPaymnetType").html();
            paymentItemHTML = paymentItemHTML.replace("$PaymentDetail", "<p>" + payname + "</p>");

            $("#PayType_Hidden_Type").val("0"); //设置编辑支付方式为关闭
            $("#PaymentTypeShow").html(paymentItemHTML);
//        }
//    });
}