//支付按钮绑定蒙板层事件
$(".t_c").click(function () {
    $(".t_c").hide();
    $(".Online_payment").show();
    $("#newSpanDes").hide();
});

function HideOnlinepaymentDiv() {
    $(".Online_payment").hide();
    $("#newSpanDes").show();
    $(".t_c").show();
}

function payClick() {
    var orderid = request("orderid");
//    alert(orderid);
    window.location.href = "../../cartend.aspx?orderid=" + orderid + "&payState=true";

}
function request(paras) {
    var url = location.href;
    var paraString = url.substring(url.indexOf("?") + 1, url.length).split("&");
    var paraObj = {}
    for (i = 0; j = paraString[i]; i++) {
        paraObj[j.substring(0, j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=") + 1, j.length);
    }
    var returnValue = paraObj[paras.toLowerCase()];
    if (typeof (returnValue) == "undefined") {
        return "";
    } else {
        return returnValue;
    }
}