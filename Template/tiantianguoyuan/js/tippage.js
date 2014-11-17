$(function () {
    // 没有商品时控制 复制商品的显隐性
    showOrHide();
});


// 没有商品时控制 复制商品的显隐性
function showOrHide() {
    var productName = $("#copyProductNumber").text().trim();
    if (productName.length <= 0) {
        $("#copyproductname").css("display", "none");
    }
};


// 去除前后空格
if (!String.prototype.trim) {
    String.prototype.trim = function () {
        var str = this.replace(/^\s+/, ""),
                      end = this.length - 1,
                      ws = /\s/;
        while (ws.test(this.charAt(end))) {
            end--;
        }
        return this.slice(0, end + 1);
    }
}