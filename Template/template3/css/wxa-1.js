(function(e) {
if (!!e.wxa) return;
var t = "1.0", n = "NONE", r = "https:" == document.location.protocol ? "https://" : "http://", i = {}, s = typeof e._wxao != "undefined" ? e._wxao : {};
s.time = s.time || {}, s.time.begin = s.begin || 0, i.cookies = {
set: function(e, t, n) {
n = n || 30;
var r = new Date;
r.setTime(r.getTime() + n * 24 * 60 * 60 * 1e3), document.cookie = e + "=" + escape(t) + ";expires=" + r.toGMTString();
},
get: function(e) {
var t = new RegExp([ "(^|;|\\s+)", e.replace(/([\^\.\[\$\(\)\|\*\+\?\{\\])/ig, "\\$1"), "=([^;]*);?" ].join(""));
if (t.test(document.cookie)) try {
return decodeURIComponent(RegExp.$2);
} catch (n) {
return RegExp.$2;
}
return "";
}
}, i.parseURL = function() {
var e = {}, t = location.search;
if (t.indexOf("?") != 0) return e;
t = t.substr(1).split("&");
for (var n = 0; n < t.length; ++n) {
var r = t[n], i = r.indexOf("="), s = r.substr(0, i), o = r.substr(i + 1);
e[s] = o;
}
return e;
};
var o = i.parseURL();
o.uin ? i.cookies.set("wxauin", o.uin) : o.uin = i.cookies.get("wxauin"), i.report = function(e) {
var n = new Image(1, 1), i = [];
if (!!e) for (var s in e) i.push(s + "=" + e[s]);
n.src = r + "mp.weixin.qq.com/mp/comm_report?version=" + t + "&" + i.join("&");
};
var u = function() {
s.time.jsbLoaded = +(new Date);
var e = s.time.jsbLoaded - s.time.begin;
WeixinJSBridge.invoke("getNetworkType", {}, function(t) {
n = t.err_msg, i.report({
action: "stat",
dom_begin: s.time.begin,
js_api_end: s.time.jsbLoaded,
page_time: e,
appid: s.appid || "",
openid: s.openid || "",
uin: o.uin || "",
url: encodeURIComponent(location.href),
net_type: n
});
});
};
s.jsbReady ? u() : document.addEventListener ? document.addEventListener("WeixinJSBridgeReady", u, !1) : document.attachEvent && (document.attachEvent("WeixinJSBridgeReady", u), document.attachEvent("onWeixinJSBridgeReady", u)), i.ready = function() {
s.time.allResLoaded = +(new Date);
var e = s.time.allResLoaded - s.time.begin;
i.report({
action: "pvuv",
dom_begin: s.time.begin,
dom_end: s.time.allResLoaded,
page_time: e,
appid: s.appid || "",
openid: s.openid || "",
uin: o.uin || "",
url: encodeURIComponent(location.href)
});
}, document.readyState === "complete" ? setTimeout(i.ready, 1) : document.addEventListener ? e.addEventListener("load", i.ready, !1) : e.attachEvent && e.attachEvent("onload", i.ready);
})(window);