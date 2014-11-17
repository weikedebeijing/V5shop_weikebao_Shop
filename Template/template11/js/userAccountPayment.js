
$(document).ready(function () {
    //异步提交支付
    $("#userAccountPay").bind("click", function () {
        var password = $("#loginPassWord").val();
        var paymentPrice = parseFloat($("#paymentPrice").val());
        var useMoney = parseFloat($("#useMoney").val());
        var orderNumber = $("#orderNumber").val();
        if (password == "") {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '请输入登录密码！'
            });
        } else if (useMoney < paymentPrice) {
            art.dialog({
                time: 3000,
                lock: true,
                title: '提示消息',
                content: '账户余额不足！'
            });
        } else {
            $.ajax({
                type: "POST",
                data: "act=subm&orderNumber=" + orderNumber + "&&password=" + password,
                url: path + "userAccountPayment.aspx",
                cache: false,
                success: function (msg) {
                    if (msg == "-1") {
                        art.dialog({
                            time: 3000,
                            lock: true,
                            title: '提示消息',
                            content: '用户不存在！'
                        });
                    } else if (msg == "0") {
                        art.dialog({
                            time: 3000,
                            lock: true,
                            title: '提示消息',
                            content: '账户余额不足！'
                        });
                    } else if (msg == "1") {
                        art.dialog({
                            time: 3000,
                            lock: true,
                            title: '提示消息',
                            content: '支付成功！'
                        });
                        window.location.href = path + "membership/useradmin/OrderDetail.aspx?number=" + orderNumber;
                    } else if (msg == "3") {
                        art.dialog({
                            time: 3000,
                            lock: true,
                            title: '提示消息',
                            content: '请勿重复支付！'
                        });
                    }
                    else {
                        art.dialog({
                            time: 3000,
                            lock: true,
                            title: '提示消息',
                            content: '支付失败！'
                        });
                    }

                }
            });
        }
    });

});