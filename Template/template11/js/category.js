//批量采购弹出层操作
$(document).ready(function () {
    //弹出批量采购提示层
    $(".cart").bind("click",
    function () {
        $("#mini-set-product" + $(this).attr("showDiv")).show();
    });
    //关闭弹出层
    $(".close").bind("click",
    function () {
        $(this).parents("#mini-set-product" + $(this).attr("closeDiv")).hide();
    });
    //左侧分类手风琴效果
    $(".category").find(".fold").toggle(function () {
        if ($(this).hasClass("fold")) {
            $(this).addClass("unfold").parents("dl").find("dd").show();
        }
    },
    function () {
        if ($(this).hasClass("unfold")) {
            $(this).removeClass("unfold").parents("dl").find("dd").hide();
        }
    });
    //设为代销
    SetDistribution();
    //初始化商品分类
    showCurrentCate();

});

//设为代销
function SetDistribution() {
    $("a[name='Distribution']").bind("click",
    function () {
        $.ajax({
            type: "POST",
            url: path + "category.aspx",
            cache: false,
            data: "act=setdistribution&productId=" + $(this).attr("productId"),
            success: function (data) {
                alert(data);
                if (data == "1") {
                    art.dialog({
                        time: 3000,
                        lock: true,
                        title: '提示消息',
                        content: '成功设为代销商品xcvc！'
                    });
                } else if (data == "2") {
                    art.dialog({
                        time: 3000,
                        lock: true,
                        title: '提示消息',
                        content: '该商品已经代销过！'
                    });
                } else {
                    art.dialog({
                        time: 3000,
                        lock: true,
                        title: '提示消息',
                        content: '设为代销商品失败！'
                    });
                }
            }
        });
    });
}


function showCurrentCate() {
    var currentId = $.getUrlVar("id");
    if ($("#first" + currentId).length > 0) {

        $("#first" + currentId).addClass("unfold");
        $("#secondAll" + currentId).show();
    } else if ($("#second" + currentId).length > 0) {
        var firstCate = $("#second" + currentId).attr("firstCat");

        $("#first" + firstCate).addClass("unfold");
        $("#secondAll" + firstCate).show();
    }
}

//获取URL参数
$.extend({
    getUrlVars: function () {
        var vars = [], hash;
        var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
        for (var i = 0; i < hashes.length; i++) {
            hash = hashes[i].split('=');
            vars.push(hash[0]);
            vars[hash[0]] = hash[1];
        }
        return vars;
    },
    getUrlVar: function (name) {
        return $.getUrlVars()[name];
    }
});