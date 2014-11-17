

var oldTimeStamp;//记住timestamp，避免签名时的timestamp与传入的timestamp时不一致
var oldNonceStr; //记住nonceStr,避免签名时的nonceStr与传入的nonceStr不一致
var oldPackageString;//记住package，方便最后进行整体签名时取用


//下面是app进行签名的操作：
function getPackage() {
    var wxpackage = "";
    var ordernumber = $("#ordernumber").val();
    $.ajax({
        url: "../../member/ajax/LoginHandle.aspx",
        data: { "action": "getwxPackage", "ordernumber": ordernumber },
        async: false,
        cache: false,
        success: function (res) {
            wxpackage = res;
        }
    })
    oldPackageString = wxpackage;
    return wxpackage;
}

function getAppId() {
    var appid = "";
    $.ajax({
        url: "../../member/ajax/LoginHandle.aspx",
        data: { "action": "getwxAppId" },
        async: false,
        cache: false,
        success: function (res) {
            appid = res;
        }
    })
    return appid;
}

function getTimeStamp() {
    var timestamp = new Date().getTime();
    var timestampstring = timestamp.toString();//一定要转换字符串
    oldTimeStamp = timestampstring;
    return timestampstring;
}

function getNonceStr() {
    var $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var maxPos = $chars.length;
    var noceStr = "";
    for (i = 0; i < 32; i++) {
        noceStr += $chars.charAt(Math.floor(Math.random() * maxPos));
    }
    oldNonceStr = noceStr;
    return noceStr;
}

function getSignType() {
    return "SHA1";
}

function getSign() {
     alert(oldNonceStr + "|" + oldTimeStamp + "|" + oldPackageString);
    var wxSign = "";
    $.ajax({
        url: "../../member/ajax/LoginHandle.aspx",
        data: { "action": "getwxSign", "oldNonceStr": oldNonceStr, "oldTimeStamp": oldTimeStamp, "oldPackageString": oldPackageString },
        async: false,
        cache: false,
        success: function (res) {
            wxSign = res;
        }
    })
    return wxSign;
}




// 当微信内置浏览器完成内部初始化后会触发WeixinJSBridgeReady事件。
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
    //公众号支付
    jQuery('a#getBrandWCPayRequest').click(function (e) {
    WeixinJSBridge.invoke('getBrandWCPayRequest', {
        "appId": getAppId(), //公众号名称，由商户传入
        "timeStamp": getTimeStamp(), //时间戳
        "nonceStr": getNonceStr(), //随机串
        "package": getPackage(),//扩展包
        "signType": getSignType(), //微信签名方式:1.sha1
        "paySign": getSign() //微信签名
    }, function (res) {
        //alert(res.err_msg);
        if (res.err_msg == "get_brand_wcpay_request:ok") { }
        // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
        //因此微信团队建议，当收到ok返回时，向商户后台询问是否收到交易成功的通知，若收到通知，前端展示交易成功的界面；若此时未收到通知，商户后台主动调用查询订单接口，查询订单的当前状态，并反馈给前端展示相应的界面。
    });

    }    );





    WeixinJSBridge.log('yo~ ready.');

}, false)