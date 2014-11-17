//初始化验证码
$(document).ready(function () {
    //ChangeVerifyImg();
    $("#email").click(function () {
        $("#email").val("");
    });
});
////切换验证码
//function ChangeVerifyImg() {
//    document.getElementById("verifyimg").src = '[$syspath]member/verifyimg.aspx?d=' + Date();
//}


//邮件订阅格式验证
function InsertSubmit() {
    var email = document.getElementById("email");
    if (!ValidateEmail(email.value)) {
        art.dialog({
            time: 3000,
            lock: true,
            title: '提示消息',
            content: '邮件格式不正确！'
        });
        email.focus();
        return false;
    }
    //邮件订阅
    $.ajax({
        type: "GET",
        url: path + "subscription.aspx",
        cache: false,
        data: "email=" + email.value + "&act=addsub",
        success: function (data) {
            if (data == "1") {
                art.dialog({
                    time: 3000,
                    lock: true,
                    title: '提示消息',
                    content: '订阅成功！'
                });
            } else if (data == "-1") {
                window.location.href = path + "login.aspx?url=" + window.location.href;
            } else {
                art.dialog({
                    time: 3000,
                    lock: true,
                    title: '提示消息',
                    content: '您已经有订阅记录！'
                });
            }
        }
    });
}

function ValidateEmail(j) {
    var emailReg = /^([a-zA-Z0-9_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    return emailReg.test(j);
}