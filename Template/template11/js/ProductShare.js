$(document).ready(function () {
    var IsInsert = $("#IsInsert").val();
    var cid = $("#cid").val();
    var pshare = $("#pshare").val();
    var url = "../../product.aspx?id=" + cid + "#pshare=" + pshare;
    if (IsInsert == "true") {
        var state = { //这里可以是你想给浏览器的一个State对象，为后面的StateEvent做准备。
            title: "商品详细",
            url: url
        };
        history.pushState(state, "商品详细", url);

    }

})