var ffAlertTxt = "含有非法字符！";
//加载购物车列表
$(document).ready(function () {
    var cartItemHTMLOrigin = $("#cartItemTotal").html();
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cart.aspx",
        data: "act=showcartlist",
        success: function (data) {
            if (data != "") {
                var currentItem = "";
                $(data.cartItem).each(function (index) {
                    var cartItemHTML = cartItemHTMLOrigin;
                    currentItem = data.cartItem[index]; //json 购物项
                    cartItemHTML = cartItemHTML.replace("$Image", currentItem.Src);
                    cartItemHTML = cartItemHTML.replace("$Name", currentItem.Name);
                    cartItemHTML = cartItemHTML.replace("$OperateNum", currentItem.Count);
                    cartItemHTML = cartItemHTML.replace("$OrderPrice", currentItem.ProductPrice);

                    $("#newCartItemTotal").append(cartItemHTML);
                });
            }
        }
    });
    $("#couponList li input").bind("click", function () {
        var id = $(this).val();
        var price = parseFloat($("#LabelNewMoney").html()) + parseFloat($("#feeprice").html())
        if (id == "-1") {
            $("#couponprice").html("0.00");
            $("#OrderFormMoney").html((price).toFixed(2));
        } else {
            var feeprice = parseFloat($("#feeprice").html());
            var couponprice = parseFloat($("#coupon" + id).val());
            $("#couponprice").html(couponprice + ".00");
            if (price - couponprice < feeprice) {
                $("#OrderFormMoney").html((feeprice).toFixed(2));
            } else {
                $("#OrderFormMoney").html((price - couponprice).toFixed(2));
            }
        }
    });
});

function rount(number) {
    if (number.toString().indexOf('.') == -1) {
        return number + '.00';
    } else {

    }
    var len = number.toString().length - number.toString().indexOf('.');

    if (len == 2) {
        return number + '0';
    } else {
        return number;
    }
}

function ControlImg(oj, obj) {
    var img = $(oj).eq(0).attr("src");
    if (img == "images/cart/hideTag.gif") {
        $("#" + obj).show();
        g('OrderRemark_Hidden_Type').value = 1;
        $(oj).attr("src", "images/cart/expandTag.gif");
    } else {
        $("#" + obj).hide();
        g('OrderRemark_Hidden_Type').value = 0;
        $(oj).attr("src", "images/cart/hideTag.gif");
    }
}

var clearflag = true;
function clearContent() {
    if (clearflag) {
        document.getElementById("textComment").value = '';
        clearflag = false;
    }
}

//提交订单
function Submit_Order() {
    var addressID = $("#AddressID").val();
    var couponID = $('input:radio[name="coupon_radio"]:checked').val();

        if (couponID == undefined) {
            couponID = -1;
        }


        var payname = "";
        $("#payType label").each(function () {
            if ($(this).hasClass("current")) {
                payname = $(this).attr("id");
            }
        })
        if (payname == "") {
            alert("请选择支付方式！")
        } else {
            if (addressID != "") {
                
                    $.ajax({
                        type: "POST",
                        url: path + "cartend.aspx",
                        data: "login=yes&addressID=" + addressID + "&couponID=" + couponID + "&usepoint=" + "" + "&payname=" + payname,
                        success: function (msg) {

                            if (msg.indexOf("errMessage:") != -1) {
                                //AlertErrMsg(msg.substr(11));
                            }
                            else {
                                window.location.href = msg;
                            }
                        }
                    });
               
            }
        }
}
//验证订单页是否全部关闭
function check_submit_isClose() {
    $("#submitWaitInfo").html("");
    var consigenn = g('Consignee_Hidden_Type').value;
    var delType = g('DelieryType_Hidden_Type').value;
    var payType = g('PayType_Hidden_Type').value;
    var partInvoice = g('PartInvoice_Hidden_Type').value;
    //var orderremark = g('OrderRemark_Hidden_Type').value;

    var errInfo = "";
    //检查是否都关闭
    if (consigenn == 1) {
        errInfo += "“收货人信息”";
    }
    //    if (delType == 1) {
    //        if (errInfo != '') {
    //            errInfo += ",";
    //        }
    //        errInfo += "“配送方式”";
    //    }
    //    if (payType == 1) {
    //        if (errInfo != '') {
    //            errInfo += ",";
    //        }
    //        errInfo += "“支付方式”";
    //    }
    //    if (partInvoice == 1) {
    //        if (errInfo != '') {
    //            errInfo += ",";
    //        }
    //        errInfo += "“发票信息”";
    //    }
    //    if (orderremark == 1) {
    //        if (errInfo != '') {
    //            errInfo += ",";
    //        }
    //        errInfo += "“附加说明”";
    //    }
    if (errInfo != "") {
        $("#aftersubmittext").hide();
        AlertErrMsg("请先保存" + errInfo);
        return false;
    }
    return true;
}

function AlertErrMsg(str) {
    $("#submittext").html(str).show().css("color", "#A10000");
    return false;
}
//预存款抵扣
function changeMoney() {
    var Depositprice = $("#usepointbox_input").val();
    if (Depositprice == "") {
        Depositprice = "0.00";
        $("#usepointbox_input").val(Depositprice);
    }
    if (!check_double(Depositprice)) {
        $("#PointErr").html("您输入的不是数字请重新输入!")
        $("#PointErr").show();

    } else {
        $("#PointErr").hide();
        var DepositMax = parseFloat($("#usepointbox_input").attr("total"));
        if (parseFloat(Depositprice) <= DepositMax) {
            $("#depositprice").html(rount(Depositprice));
            var price = parseFloat($("#LabelNewMoney").html()) + parseFloat($("#feeprice").html()) - parseFloat($("#couponprice").html());
            $("#OrderFormMoney").html((price - parseFloat(Depositprice)).toFixed(2));
        } else {
            $("#PointErr").html("最多使用" + DepositMax + "元预存款!")
            $("#PointErr").show();
        }
    }
}
//验证双精度数字  
function check_double(obj) {
    var reg = /^[0-9]+(\.[0-9]+)?$/;
    if (obj != "" && !reg.test(obj)) {

        return false;
    } else {
        return true;
    }
}  
