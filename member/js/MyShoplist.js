
$(document).ready(function () {
    Creatmyshop1();
});
    var btnaddmyshop = $("#RegAddShop");
    btnaddmyshop.bind('click', function (e) {
        var account = $("#account").val();
        var shopaddress = $("#shopaddress").val();
        var myshoptype = $("#myshoptype").val();
        var shopId = $("#shopid").val();

        var result = true;
        if (account == "") {
            $("#shopfenhaoMessage").empty();
            $("#shopfenhaoMessage").removeClass();
            $("#shopfenhaoMessage").text("请输入正确的帐号!");
            $("#shopfenhaoMessage").addClass("tips01-err");
            result = false;
        }
        else {
            $("#shopfenhaoMessage").empty();
            $("#shopfenhaoMessage").removeClass();
            $("#shopfenhaoMessage").addClass("tips01-icon");
        }

        if (shopaddress == "") {
            $("#shopfenMessage").empty();
            $("#shopfenMessage").removeClass();
            $("#shopfenMessage").text("请输入正确的店铺地址!");
            $("#shopfenMessage").addClass("tips01-err");
            result = false;
        } else {
            $("#shopfenMessage").empty();
            $("#shopfenMessage").removeClass();
            $("#shopfenMessage").addClass("tips01-icon");
        }

        if (myshoptype == "") {
            $("#myshoptypeMessage").empty();
            $("#myshoptypeMessage").removeClass();
            $("#myshoptypeMessage").text("请选择店铺类型!");
            $("#myshoptypeMessage").addClass("tips01-err");
            result = false;
        } else {
            $("#myshoptypeMessage").empty();
            $("#myshoptypeMessage").removeClass();
            $("#myshoptypeMessage").addClass("tips01-icon");
        }

        if (result) {
            if (shopId == "") {
                RegisterThridStepInsertShop(account, shopaddress, myshoptype);
            }
            else {
                RegisterThridStepUpdateShop(account, shopaddress, myshoptype, shopId);
            }
        }

    });

    $("#account").focus(function () {

        $("#shopfenhaoMessage").empty();
        $("#shopfenhaoMessage").removeClass();
        $("#shopfenhaoMessage").text("请输入正确的帐号!");
        $("#shopfenhaoMessage").addClass("tips01");

    });
    $("#account").focusout(function () {
        if ($("#account").val() == "") {
            $("#shopfenhaoMessage").empty();
            $("#shopfenhaoMessage").removeClass();
            $("#shopfenhaoMessage").text("请输入正确的帐号!");
            $("#shopfenhaoMessage").addClass("tips01-err");
        }
        else {
            $("#shopfenhaoMessage").empty();
            $("#shopfenhaoMessage").removeClass();
            $("#shopfenhaoMessage").addClass("tips01-icon");
        }
    });

    $("#shopaddress").focus(function () {
        $("#shopfenMessage").empty();
        $("#shopfenMessage").removeClass();
        $("#shopfenMessage").text("请输入正确的店铺地址!");
        $("#shopfenMessage").addClass("tips01");

    });
    $("#shopaddress").focusout(function () {
        if ($("#shopaddress").val() == "") {
            $("#shopfenMessage").empty();
            $("#shopfenMessage").removeClass();
            $("#shopfenMessage").text("请输入正确的店铺地址");
            $("#shopfenMessage").addClass("tips01-err");
        }
        else {
            $("#shopfenMessage").empty();
            $("#shopfenMessage").removeClass();
            $("#shopfenMessage").addClass("tips01-icon");
        }
    });

    $("#myshoptype").focus(function () {

        $("#myshoptypeMessage").empty();
        $("#myshoptypeMessage").removeClass();
        $("#myshoptypeMessage").text("请选择店铺类型!");
        $("#myshoptypeMessage").addClass("tips01");

    });
    $("#myshoptype").focusout(function () {
        if ($("#myshoptype").val() == "") {
            $("#myshoptypeMessage").empty();
            $("#myshoptypeMessage").removeClass();
            $("#myshoptypeMessage").text("请选择店铺类型!");
            $("#myshoptypeMessage").addClass("tips01-err");
        }
        else {
            $("#myshoptypeMessage").empty();
            $("#myshoptypeMessage").removeClass();
            $("#myshoptypeMessage").addClass("tips01-icon");
        }
    });
        
//});


    myEmail();
   

////$(function () {
////    myshoplist();

//    $("#RegAddShop").click(function () {
//        var account = $("#account").val();
//        // var startdate = $("#startdate").val();
//        var shopaddress = $("#shopaddress").val();
//        var myshoptype = $("#myshoptype").val();
//        var shopId = $("#shopid").val();
//        if (myshoptype == "") {
//            alert("请选择店铺类型！");
//            return false;
//        }
//        if (account == "") {
//            alert("帐号不能为空！");
//            return false;
//        }
//        if (shopaddress == "") {
//            alert("地址不能为空！");
//            return false;
//        }
//        if (shopId == "") {
//            RegisterThridStepInsertShop(account, shopaddress, myshoptype);
//        }
//        else {
//            RegisterThridStepUpdateShop(account, shopaddress, myshoptype, shopId)
//        }
//    });
////});

        function RegisterThridStepInsertShop(myaccount, shopaddress, myshoptype) {
    $.ajax({
        url: "Ajax/Register.ashx",
        type: "get",当
        data: { action: "RegisterThridStepcharuShop", myaccount: escape(myaccount), shopaddress: escape(shopaddress), myshoptype: escape(myshoptype) },
        success: function (data) {
            data = unescape(data);
            var array = data.split("$");
            if (array[1] == "0") {
                alert("前用户名有误！请重新登录");
                return false;
            }
            else if (array[1] == "1") {
                alert("系统繁忙，稍后重试");
                return false;
            }
            else if (array[1] == "2") {
                clearinput();
                $("#shopcontent").hide();
                myshoplist();
            }
            else {
                alert(array[0]);
                return false;
            }
        }
    });
}

function RegisterThridStepUpdateShop(myaccount, shopaddress, myshoptype, myshopId) {
    $.ajax({
        url: "Ajax/Register.ashx",
        type: "get",
        data: { action: "RegisterThridStepgengxinShop", myaccount: escape(myaccount), shopaddress: escape(shopaddress), myshoptype: escape(myshoptype), myshopId: escape(myshopId) },
        success: function (data) {
            data = unescape(data);
            var array = data.split("$");
            if (array[1] == "0") {
                alert("当前用户名有误！请重新登录");
               
                return false;
            }
            else if (array[1] == "1") {
                alert("系统繁忙，稍后重试");
                return false;
            }
            else if (array[1] == "2") {
                clearinput();
                $("#shopcontent").hide();
                myshoplist();
            }
            else {
                alert(array[1]);
                return false;
            }
        }
    });
}

//新增店铺
function myshoplist() {
    $.ajax({ url: "ajax/MyShopList.ashx",

        success: function (xml) {
            $("#shopcontentlist").empty();
            $(xml).find("node").each(function () {
                var name = $(this).attr("name"); //this->
                var account = $(this).attr("account");
                var shopdate = $(this).attr("shopdate");
                var address = $(this).attr("address");
                var id = $(this).attr("id");
                var strs = "";
                strs = "<ul><li class='li01'><span class='c07 mr3'>*</span>店铺类别：<span class='span01'>" + name + "</span>";
                strs += "<span class='c07 mr3 ml25'>*</span>账号：<span class='span02'>" + account + "</span><span class='c07 mr3 ml25'>*</span>店铺地址：<span class='span03'>" + address + "</span></li>";
                strs += "<li class='li02'><input type='button' onclick=\"editshop('" + id + "','" + name + "','" + account + "','" + address + "')\" value='修改' class='btn-save'/>";
                strs += "<input type='button'  value='删除' class='btn-edit ml5' onclick=\"deleteshop('" + id + "')\" />";
                strs += "</li></ul><div class='clear'></div>";
                $("#shopcontentlist").append(strs);
            });
            if ($("#shopcontentlist").html().indexOf("店铺类别") == -1) {
                $("#shopcontentlisttitle").hide(); $("#shopcontentlist").hide();
                $("#shopcontent").show(); $("#shopcontenarea").show();
            }
            else {
                $("#shopcontent").hide(); $("#shopcontenarea").hide(); $("#shopcontentlisttitle").show(); $("#shopcontentlist").show();
            }

        }
    });
}





function myEmail() {
    $.ajax({
        url: "Ajax/Register.ashx",
        type: "get",
        data: { action: "GetMyEmal" },
        success: function (data) {
            data = unescape(data);
            $("#contectEmail").attr("value", data);
            
            return true;
        }
    });

}


function Creatmyshop1() {
    var strs = "";
    shopid += "1";
    strs = "<div id='shop" + shopid + "'><ul><li class='li01'><span class='c07 mr3'>*</span>店铺类别：<select  name='myshoptype' id='shoptype" + shopid + "'><option value=''>请选择</option></select>";
    strs += "<span class='c07 mr3 ml25'>*</span>账号：<input type='text' class='form-input w150' name='account'/>";
    strs += "<span class='c07 mr3 ml25'>*</span>店铺地址：<input type='text' class='form-input w180' name='shopaddress' />";
    strs += "</li></ul><div class='clear'></div></div>";
    $("#shopcontentlist").append(strs);
    var t = setTimeout("myAtshoptype('shoptype" + shopid + "')", 500);
}

//新增店铺
var shopid = 1;
function Creatmyshop() {

    var shopType = document.getElementsByName("myshoptype");
    var shopAccount = document.getElementsByName("account");
    var shopAddress = document.getElementsByName("shopaddress");
    if (shopType[shopType.length - 1].options[shopType[shopType.length - 1].selectedIndex].text == "请选择" || shopAccount[shopType.length - 1].value == "" || shopAddress[shopType.length - 1].value == "") {
        $("#newShopMessage").show();
        $("#newShopMsg").hide();
        return false;
    } else {
    $("#newShopMessage").hide();
        var strs = "";
        shopid += "1";
        strs = "<div id='shop" + shopid + "'><ul><li class='li01'><span class='c07 mr3'>*</span>店铺类别：<select  name='myshoptype' id='shoptype" + shopid + "'><option value=''>请选择</option></select>";
        strs += "<span class='c07 mr3 ml25'>*</span>账号：<input type='text' class='form-input w150' name='account'/>";
        strs += "<span class='c07 mr3 ml25'>*</span>店铺地址：<input type='text' class='form-input w180' name='shopaddress' />";
        strs += "<input type='button'  value='删除' class='btn-edit ml5' onclick=\"Clearshop('shop" + shopid + "')\" />";
        strs += "</li></ul><div class='clear'></div></div>";
        $("#shopcontentlist").append(strs);
        var t = setTimeout("myAtshoptype('shoptype" + shopid + "')", 500);

    }
}

function editshop(id, name, account, address) {
    $("#shopid").attr("value", id);
    $("#myshoptype").attr("value", name);
    $("#account").attr("value", account);
    //$("#startdate").attr("value", date);
    $("#shopaddress").attr("value", address);
    $("#shopcontent").show();
    $("#shopcontenarea").show();

}

function deleteshop(id) {
    $("#shopid").attr("value", id);
    if (confirm("你确定要删除吗？")) {
        clearinput();
        DeleteShop(id);
    }
    else {
        return false;
    }
      
}

function clearinput() {
    var allText = document.getElementsByName("shopfen");
    for (var i = 0; i < allText.length; i++) {
        allText[i].value = "";
    }
}

function DeleteShop(shopId) {
    $.ajax({
        url: "Ajax/Register.ashx",
        type: "get",
        data: { action: "shanchuShop", shopId: escape(shopId) },
        success: function (data) {
            data = unescape(data);
            var array = data.split("$");
            if (array[1] == "0") {
                alert("当前用户名有误！请重新登录");
                return false;
            }
            else if (array[1] == "1") {
                alert("系统繁忙，稍后重试");
                return false;
            }
            else if (array[1] == "2") {
                myshoplist();
                return false;
            }
            else {
                alert(array[1]);
                return false;
            }
        }
    });
}

var btnaddnewmyshop = $("#addnewshop");
btnaddnewmyshop.bind('click', function (e) {
//    $("#myshoptype").empty();
//    myshoptype();
    $("#myshoptypeMessage").removeClass();
    $("#shopfenhaoMessage").removeClass();
    $("#shopfenMessage").removeClass();

    $("#shopcontent").show();
    $("#shopcontenarea").show();

});

 
var btnaddnewmyshop2 = $("#addnewshop2");
btnaddnewmyshop2.bind('click', function (e) {

    Creatmyshop();

});

function Clearshop(id) {
    $("#" + id).empty();
}
 