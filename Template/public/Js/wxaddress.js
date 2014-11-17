document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
    WeixinJSBridge.invoke('editAddress', {
        "appId": getAppId(),
        "scope": "jsapi_address",
        "signType": getSignType(),
        "timeStamp": getTimeStamp(),
        "nonceStr": getNonceStr(),
        "addrSign": getaddrSign(),
    }, function (res) {
        alert(res.err_msg);
        if (res.err_msg == "edit_address:ok") {
            //若 res 中所带的返回值不为空，则表示用户选择该返回值作为收货地址。否则若返回空，则表示用户取消了这一次编辑收货地址。
            $("#address1").val(res.proviceFirstStageName);
            $("#address2").val(res.addressCitySecondStageName);
            $("#address3").val(res.addressCountiesThirdStageName);
            $("#detail").val(res.addressDetailInfo);
            $("#phone").val(res.telNumber);
        }
    });
})
var oldTimeStamp;
var oldNonceStr;
function getAppId() {
    return "wxa50207519cc317a4";
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
    //oldAppId = appid;
    return appid;
    //return document.form1.appId.value;
}
function getSignType() {
    return "SHA1";
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

function getaddrSign() {
    alert(oldNonceStr + "|" + oldTimeStamp + "|" + $("#starturl").val() + "|" + $("#accessToken").val());
    var wxaddrSign = "";
    $.ajax({
        url: "../../member/ajax/LoginHandle.aspx",
        data: { "action": "getwxaddrSign", "NonceStr": oldNonceStr, "TimeStamp": oldTimeStamp, "addressurl": $("#starturl").val(), "accessToken": $("#accessToken").val() },
        async: false,
        cache: false,
        success: function (res) {
            wxaddrSign = res;
        }
    })
    return wxaddrSign;
}