$(function () {
    $("#loginformbtn2").click(function () {
        var userName = $("#loginusernameoremail").val().trim() ;
        var userPwd = $("#loginpassword").val().trim();
        var url = location.search; //获取url中"?"符后的字串
        var theRequest = new Object();
        var urlReferrer = "";
        if (url.indexOf("?") != -1) {
            var urlReferrer = url.split('=')[1];
        }
        var isremUser = null;
        if (userName == "") {
            $("#userloginnameresult").empty();
            $("#userloginnameresult").removeClass();
            $("#userloginnameresult").text("账号必填!");
            $("#userloginnameresult").addClass("tips01-err");
            return false;
        }
        if (userPwd == "") {
            $("#userloginpwdresult").empty();
            $("#userloginpwdresult").removeClass();
            $("#userloginpwdresult").text("密码必填!");
            $("#userloginpwdresult").addClass("tips01-err");
            return false;
        }
        //        if ($("#remUser").attr("checked")) {
        //            isremUser = "1";
        //        }
        //        else {
        //            isremUser
        //        }

        userLogin(userName, userPwd, "1", urlReferrer);
    });
    $("#loginusernameoremail").focus(function () {
        $("#userloginnameresult").empty();
        $("#userloginnameresult").removeClass();
        $("#userloginnameresult").text("登录账号!");
        $("#userloginnameresult").addClass("tips01");

    });


    $("#loginusernameoremail").focusout(function () {
        var userName = $("#loginusernameoremail").val().trim();
        if (userName == "") {
            $("#userloginnameresult").empty();
            $("#userloginnameresult").removeClass();
            $("#userloginnameresult").text("账号必填!");
            $("#userloginnameresult").addClass("tips01-err");
        }
        else {
            var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
            if (myreg.test(userName) || userName.indexOf("TB")!=-1) {
                // checkUserName(userName); 
                $("#userloginnameresult").empty();
                $("#userloginnameresult").removeClass();
            }
            else {
                $("#userloginnameresult").empty();
                $("#userloginnameresult").removeClass();
                $("#userloginnameresult").text("格式错误!");
                $("#userloginnameresult").addClass("tips01-err");
            }
        }
    });
    $("#loginpassword").focus(function () {
        $("#userloginpwdresult").empty();
        $("#userloginpwdresult").removeClass();
        $("#userloginpwdresult").text("登录密码!");
        $("#userloginpwdresult").addClass("tips01");
    });
    $("#loginpassword").focusout(function () {
        var password = $("#loginpassword").val();
        if (password == "") {
            $("#userloginpwdresult").empty();
            $("#userloginpwdresult").removeClass();
            $("#userloginpwdresult").text("密码必填!");
            $("#userloginpwdresult").addClass("tips01-err");
        }
        else {
            if (password.length > 18 || password.length < 6) {
                $("#userloginpwdresult").empty();
                $("#userloginpwdresult").removeClass();
                $("#userloginpwdresult").text("格式错误");
                $("#userloginpwdresult").addClass("tips01-err");
            }
            else {

                $("#userloginpwdresult").empty();
                $("#userloginpwdresult").removeClass();
            }

        }
    });

});
function checkUserName(userName) {
    $.ajax({
        url: "Ajax/LoginHandle.aspx",
        type: "get",
        data: { action: "checkUserName", userName: escape(userName) },
        success: function (data) {
            data = unescape(data);
            if (data == "true") {
                $("#userloginnameresult").empty();
                $("#userloginnameresult").removeClass();
                $("#useremailresult").addClass("tips01-icon");
            }
            else {
                $("#userloginnameresult").empty();
                $("#userloginnameresult").removeClass();
                $("#userloginnameresult").text("帐号错误!");
                $("#userloginnameresult").addClass("tips01-err");
            }
        }
    });
}
function userLogin(userName, userPwd, isAutoLogin, urlReferrer) {
    $("#submitlogin").attr("style", "display:block;");
    $.ajax({
        url: "Ajax/LoginHandle.aspx",
        type: "get",
        data: { action: "userLoginHandle", userName: escape(userName), userPwd: escape(userPwd), isAutoLogin: escape(isAutoLogin), urlReferrer: escape(urlReferrer) },
        success: function (data) {
            data = unescape(data);
            var array = data.split("$");
            if (array[0] == "true") {
                if (array[1] != "") {
                    window.location.href = array[1];
                }
                else {

                    window.location.href = "/";
                }
            }
            else if (array[0] == "false") {
                if (array[2] == "该帐号已被冻结!") {
                    ShowartDialogMessage('提示', array[2]);
                    return false;
                } else {
                    $("#submitlogin").attr("style", "display:none;");
                    ShowartDialogMessage('提示', '用户名或密码错误');
                    return false;
                }
            }
            else if (array[2] != "Null") {
                alert(array[2]);
                return false;
            }
        }
    });
}
function checkRegUserName(userName) {
    $.ajax({
        url: "Ajax/LoginHandle.aspx",
        type: "get",
        data: { action: "checkUserName", userName: escape(userName) },
        success: function (data) {
            data = unescape(data);
            if (data == "false") {
                $("#useremailresult").empty();
                $("#useremailresult").removeClass();
                $("#useremailresult").addClass("tips01-icon");
            }
            else {
                $("#useremailresult").empty();
                $("#useremailresult").removeClass();
                $("#useremailresult").text("该用户已存在！");
                $("#useremailresult").addClass("tips01-err");
            }
        }
    });
}
$(function () {
    $("#register").click(function () {
        var userName = $("#usernameoremail").val();
        var password = $("#password").val();
        var password2 = $("#password2").val();
        var yzm = $("#yzm").val();
        var result = true;
        //        var chekCode = $("#checkCode").val();
        var RoleID = $("#RoleID").val();
        var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
        if (!myreg.test(userName)) {
            $("#useremailresult").empty();
            $("#useremailresult").removeClass();
            $("#useremailresult").text("请输入正确邮箱地址");
            $("#useremailresult").addClass("tips01-err");
            result = false;
        }
        else {
            $("#useremailresult").empty();
            $("#useremailresult").removeClass();
            $("#useremailresult").addClass("tips01-icon");
        }

        if (password == "" || password.length > 18 || password.length < 6) {
            $("#userpasswordresult1").empty();
            $("#userpasswordresult1").removeClass();
            $("#userpasswordresult1").text("请输入6到18位的密码.");
            $("#userpasswordresult1").addClass("tips01-err");
            result = false;
        }
        if (password2 != password) {
            $("#userpasswordresult1").empty();
            $("#userpasswordresult1").removeClass();
            $("#userpasswordresult1").text("密码确认不一致.");
            $("#userpasswordresult1").addClass("tips01-err");
            result = false;
        }
        if (yzm == "") {
            $("#useryanzhengma").empty();
            $("#useryanzhengma").removeClass();
            $("#useryanzhengma").text("验证码错误.");
            $("#useryanzhengma").addClass("tips01-err");
            result = false;
        }
        if ($("#checkTreaty").attr("checked") == undefined) {
            $("#checkTreatyError").empty();
            $("#checkTreatyError").removeClass();
            $("#checkTreatyError").text("请同意注册协议");
            $("#checkTreatyError").addClass("tips01-err");
            result = false;
        }
        if (result) {
            GetCheckCode(yzm);
        }
    });

    $("#checkTreaty").click(function () {
        if ($("#checkTreaty").attr("checked") == undefined) {
            $("#checkTreatyError").empty();
            $("#checkTreatyError").removeClass();
            $("#checkTreatyError").text("请同意注册协议");
            $("#checkTreatyError").addClass("tips01-err");
        }
        else {
            $("#checkTreatyError").empty();
            $("#checkTreatyError").removeClass();
            $("#checkTreatyError").addClass("tips01-icon");
        }

    });
    $("#usernameoremail").focus(function () {
        $("#useremailresult").empty();
        $("#useremailresult").removeClass();
        $("#useremailresult").text("输入经常使用的邮箱");
        $("#useremailresult").addClass("tips01");
    });
    $("#usernameoremail").focusout(function () {
        var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
        var userName = $("#usernameoremail").val();
        if (myreg.test(userName)) {
            checkRegUserName(userName);
        }
        else {
            $("#useremailresult").empty();
            $("#useremailresult").removeClass();
            $("#useremailresult").text("请输入正确邮箱地址");
            $("#useremailresult").addClass("tips01-err");
        }
    });
    $("#password").focus(function () {
        $("#userpasswordresult1").empty();
        $("#userpasswordresult1").removeClass();
        $("#userpasswordresult1").text("6到18位的密码");
        $("#userpasswordresult1").addClass("tips01");
    });
    $("#password").focusout(function () {
        var password = $("#password").val();
        if (password.length < 6 || password.length > 18) {
            $("#userpasswordresult1").empty();
            $("#userpasswordresult1").removeClass();
            $("#userpasswordresult1").text("请输入6到18位的密码");
            $("#userpasswordresult1").addClass("tips01-err");
        }
        else {

            $("#userpasswordresult1").empty();
            $("#userpasswordresult1").removeClass();
            $("#userpasswordresult1").addClass("tips01-icon");
        }
    });
    $("#password2").focus(function () {
        $("#userpasswordresult2").empty();
        $("#userpasswordresult2").removeClass();
        $("#userpasswordresult2").text("请进行密码确认!");
        $("#userpasswordresult2").addClass("tips01");
    });
    $("#password2").focusout(function () {
        var password = $("#password").val();
        var password2 = $("#password2").val();
        if (password.length >= 6) {
            if (password != password2) {

                $("#userpasswordresult2").empty();
                $("#userpasswordresult2").removeClass();
                $("#userpasswordresult2").text("密码确认不一致，请检查!");
                $("#userpasswordresult2").addClass("tips01-err");
            }
            else {
                $("#userpasswordresult2").empty();
                $("#userpasswordresult2").removeClass();
                $("#userpasswordresult2").addClass("tips01-icon");
            }
        }
    });
    $("#yzm").focus(function () {
        $("#useryanzhengma").empty();
        $("#useryanzhengma").removeClass();
        $("#useryanzhengma").text("请输入验证码!");
        $("#useryanzhengma").addClass("tips01");
    });
    $("#yzm").focusout(function () {
        var yzm = $("#yzm").val();
        if (yzm == "") {
            $("#useryanzhengma").empty();
            $("#useryanzhengma").removeClass();
            $("#useryanzhengma").text("请输入验证码!");
            $("#useryanzhengma").addClass("tips01-err");
        }
        else {

            GetCheckCodeOut(yzm);
        }

    });
});
function GetCheckCode(checkCode) {

    var result;
    $.ajax({
        url: "CheckCode.aspx",
        type: "get",
        data: { actioncode: "GetCheckCode", checkCode: escape(checkCode) },
        success: function (data) {
            data = unescape(data);
            if (data == "0") {
                $("#useryanzhengma").empty();
                $("#useryanzhengma").removeClass();
                $("#useryanzhengma").text("请输入正确的验证码!");
                $("#useryanzhengma").addClass("tips01-err");
                return false;
            }
            else if (data == "1") {
                var userName = $("#usernameoremail").val();
                var password = $("#password").val();
                var RoleID = $("#RoleID").val();
                $("#submitshuju").show();
                RegisterFristStep(userName, password, RoleID);

                return true;
            }
        }
    });


}
function GetCheckCodeOut(checkCode) {
    $.ajax({
        url: "CheckCode.aspx",
        type: "get",
        data: { actioncode: "GetCheckCode", checkCode: escape(checkCode) },
        success: function (data) {
            data = unescape(data);
            if (data == "0") {
                $("#useryanzhengma").empty();
                $("#useryanzhengma").removeClass();
                $("#useryanzhengma").text("请输入正确的验证码!");
                $("#useryanzhengma").addClass("tips01-err");
                return false;
            }
            else if (data == "1") {
                $("#useryanzhengma").empty();
                $("#useryanzhengma").removeClass();
                $("#useryanzhengma").addClass("tips01-icon");
                return true;
            }
        }
    });

}

function RegisterFristStep(userName, userPwd, RoleID) {
    $.ajax({
        url: "Ajax/Register.ashx",
        type: "get",
        data: { action: "RegisterFristStep", userName: escape(userName), userPwd: escape(userPwd), RoleID: escape(RoleID) },
        success: function (data) {
            data = unescape(data);
            var array = data.split("$");
            if (array[1] == "0") {
                $("#useremailresult").empty();
                $("#useremailresult").removeClass();
                $("#useremailresult").text("请输入正确的用户名或密码");
                $("#useremailresult").addClass("tips01-err");
                return false;
            }
            else if (array[1] == "1") {
                $("#useremailresult").empty();
                $("#useremailresult").removeClass();
                $("#useremailresult").text("该账号已被注册,请重新输入");
                $("#useremailresult").addClass("tips01-err");
                return false;
            }
            else if (array[1] == "3") {
                $("#useremailresult").empty();
                $("#useremailresult").removeClass();
                $("#useremailresult").text("系统繁忙,稍后重试");
                $("#useremailresult").addClass("tips01-err");
                return false;
            }
            else if (array[1] == "2") {
                window.location.href = "/Member/UserAdmin/UserInformation.aspx";
                return false;
            }
            else {
                alert(array[1]);
            }
        }
    });
}
$(function () {
    //重新发送邮件
    $("#ReSendEmail").click(function () {
        $.ajax({
            url: "Ajax/Register.ashx",
            type: "get",
            data: { action: "ReSendEmail" },
            success: function (data) {
                data = unescape(data);
                if (data == "true") {

                    ShowartDialogMessage('', '邮箱发送成功！请注意查收您的邮件');
                    return false;
                }
                else {


                    ShowartDialogMessage('', '邮件发送失败！请稍后重试');
                    return false;
                }
            }
        });
    });
});
$(function () {
    //激活邮件
    $("#ActivationEmail").click(function () {
        $.ajax({
            url: "Ajax/Register.ashx",
            type: "get",
            data: { action: "jihuoEmail" },
            success: function (data) {
                data = unescape(data);
                if (data != "false") {
                    mySendMail(data);
                }
                else {

                    ShowartDialogMessage('', '请重新登录.');
                    return false;
                }
            }
        });
    });
});
function mySendMail(domain) {
    $.ajax({ url: "config/webemail.xml",
        success: function (xml) {
            $(xml).find("node").each(function () {
                var domain2 = $(this).attr("domain"); //this->
                var link = $(this).attr("link");
                if (domain == domain2) {
                    window.location.href = link;
                }
            });
        }
    });
}
$(function () {
    $("#openMyEmail").click(function () {
        art.dialog.open('UpdateEmail.aspx', {
            title: '',
            lock: true,
            opacity: .5,
            width: '580px',
            height: '220px'
        });
    });
})

$(function () {
    $("#UpdateEmail").click(function () {
        var upEmail = $("#upemailvalue").val();
        var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
        if (!myreg.test(upEmail)) {
            $("#upemailmessage").empty();
            $("#upemailmessage").removeClass();
            $("#upemailmessage").text("请输入正确的邮箱格式!");
            $("#upemailmessage").addClass("tips01-err");
            return false;
        }
        UpdateEmail(upEmail);
    });
    $("#upemailvalue").focusout(function () {
        var upEmail = $("#upemailvalue").val();
        var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
        if (!myreg.test(upEmail)) {
            $("#upemailmessage").empty();
            $("#upemailmessage").removeClass();
            $("#upemailmessage").text("您输入的邮箱格式错误！");
            $("#upemailmessage").addClass("tips01-err");
        }
        else {
            $("#upemailmessage").empty();
            $("#upemailmessage").removeClass();
            $("#upemailmessage").addClass("tips01-icon");
        }
    });
    $("#upemailvalue").focus(function () {
        $("#upemailmessage").empty();
        $("#upemailmessage").removeClass();
        $("#upemailmessage").text("请输入正确的邮箱格式!");
        $("#upemailmessage").addClass("tips01");
    });

});
function UpdateEmail(userName) {
    $.ajax({
        url: "Ajax/Register.ashx",
        type: "get",
        data: { action: "gengxinEmail", userName: escape(userName) },
        success: function (data) {
            data = unescape(data);
            var array = data.split("$");
            if (array[1] == "0") {
                $("#upemailmessage").empty();
                $("#upemailmessage").removeClass();
                $("#upemailmessage").text("您信息已过期，请重新登录");
                $("#upemailmessage").addClass("tips01-err");
                return false;
            }
            else if (array[1] == "1") {
                $("#upemailmessage").empty();
                $("#upemailmessage").removeClass();
                $("#upemailmessage").text("系统繁忙，稍后重试！");
                $("#upemailmessage").addClass("tips01-err");
                return false;
            }
            else if (array[1] == "2") {
                window.parent.location.href = "Register2.aspx";
                return false;
            }
            else if (array[1] == "3") {
                $("#upemailmessage").empty();
                $("#upemailmessage").removeClass();
                $("#upemailmessage").text("该用户已经存在！");
                $("#upemailmessage").addClass("tips01-err");
                return false;
            }
            else {
                alert(array[0]);
            }
        }
    });
}
$(function () {
    $("#ContionmSlit").click(function () {
        var trueName = $("#trueName").val();
        var phone = $("#phone").val();
        var contectEmail = $("#contectEmail").val();
        var address = $("#address").val();
        var remark = $("#remark").val();
        var seletctAreaId = document.getElementById("SeletctAreaId").value;

        var shopTypeVal = "";
        var shopNumberVal = "";
        var shopUrlVal = "";

        var shopType = document.getElementsByName("myshoptype"); //店铺类型
        var shopNumber = document.getElementsByName("account"); //店铺号
        var shopUrl = document.getElementsByName("shopaddress"); //店铺地址


        var result = true;
        if (trueName == "") {
            $("#trueNameError").empty();
            $("#trueNameError").removeClass();
            $("#trueNameError").text("请输入正确联系人名称!");
            $("#trueNameError").addClass("tips01-err");
            result = false;
        }
        else {
            $("#trueNameError").empty();
            $("#trueNameError").removeClass();
            $("#trueNameError").addClass("tips01-icon");
        }
        if (phone == "") {
            $("#phoneMessage").empty();
            $("#phoneMessage").removeClass();
            $("#phoneMessage").text("请填写正确的手机号码，以便有急事联系。");
            $("#phoneMessage").addClass("tips01-err");
            result = false;
        }
        else {
            $("#phoneMessage").empty();
            $("#phoneMessage").removeClass();
            $("#phoneMessage").addClass("tips01-icon");
        }
        if (contectEmail == "") {
            $("#contectEmailMessage").empty();
            $("#contectEmailMessage").removeClass();
            $("#contectEmailMessage").text("请填写正确的邮箱！");
            $("#contectEmailMessage").addClass("tips01-err");
            result = false;
        }
        else {
            $("#contectEmailMessage").empty();
            $("#contectEmailMessage").removeClass();
            $("#contectEmailMessage").addClass("tips01-icon");
        }

        if (address == "") {
            $("#addressMessage").empty();
            $("#addressMessage").removeClass();
            $("#addressMessage").text("请填写正确的地址，以便有急事联系。");
            $("#addressMessage").addClass("tips01-err");
            result = false;
        }
        else {
            $("#addressMessage").empty();
            $("#addressMessage").removeClass();
            $("#addressMessage").addClass("tips01-icon");
        }


        for (var i = 0; i < shopType.length; i++) {

            if (shopType[i].options[shopType[i].selectedIndex].text == "请选择" || shopNumber[i].value == "" || shopUrl[i].value == "") {

                $("#newShopMsg").show();
                $("#newShopMessage").hide();
                result = false;
                break;
            } else {
                $("#newShopMsg").hide();
                $("#newShopMessage").hide();
            }
            if (i == 0) {
                shopTypeVal = shopType[0].options[shopType[0].selectedIndex].value;
                shopNumberVal = shopNumber[0].value;
                shopUrlVal = shopUrl[0].value;
            } else {
                shopTypeVal += "," + shopType[i].options[shopType[i].selectedIndex].text;
                shopNumberVal += "," + shopNumber[i].value;
                shopUrlVal += "," + shopUrl[i].value;

            }
        }
        if (result) {
            RegisterThridStep(trueName, phone, contectEmail, address, remark, seletctAreaId, shopTypeVal, shopNumberVal, shopUrlVal);

        }
    });




    $("#trueName").focus(function () {

        $("#trueNameError").empty();
        $("#trueNameError").removeClass();
        $("#trueNameError").text("请输入正确联系人名称!");
        $("#trueNameError").addClass("tips01");

    });
    $("#trueName").focusout(function () {
        if ($("#trueName").val() == "") {
            $("#trueNameError").empty();
            $("#trueNameError").removeClass();
            $("#trueNameError").text("请输入正确用户名，用户名在2~16字符之间!");
            $("#trueNameError").addClass("tips01-err");
        }
        else {
            $("#trueNameError").empty();
            $("#trueNameError").removeClass();
            $("#trueNameError").addClass("tips01-icon");
        }
    });
    $("#phone").focus(function () {
        $("#phoneMessage").empty();
        $("#phoneMessage").removeClass();
        $("#phoneMessage").text("请输入正确的电话号码!");
        $("#phoneMessage").addClass("tips01");
    });
    $("#phone").focusout(function () {
        var phone = $("#phone").val();
        if (phone != "") {
            $("#phoneMessage").empty();
            $("#phoneMessage").removeClass();
            $("#phoneMessage").addClass("tips01-icon");
        }
        else {
            $("#phoneMessage").empty();
            $("#phoneMessage").removeClass();
            $("#phoneMessage").text("电话号码不能为空!");
            $("#phoneMessage").addClass("tips01-err");
        }
    });
    $("#contectEmail").focus(function () {
        $("#contectEmailMessage").empty();
        $("#contectEmailMessage").removeClass();
        $("#contectEmailMessage").text("请输入邮箱地址!");
        $("#contectEmailMessage").addClass("tips01");
    });
    $("#contectEmail").focusout(function () {
        var contectEmail = $("#contectEmail").val();
        if (contectEmail != null) {
            var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
            if (myreg.test(contectEmail)) {
                $("#contectEmailMessage").empty();
                $("#contectEmailMessage").removeClass();
                $("#contectEmailMessage").addClass("tips01-icon");
            }
            else {
                $("#contectEmailMessage").empty();
                $("#contectEmailMessage").removeClass();
                $("#contectEmailMessage").text("请输入正确的电子邮箱格式!");
                $("#contectEmailMessage").addClass("tips01-err");
            }
        } else {
            $("#contectEmailMessage").empty();
            $("#contectEmailMessage").removeClass();
            $("#contectEmailMessage").text("电子邮箱不能为空!");
            $("#contectEmailMessage").addClass("tips01-err");
        }
    });
    $("#address").focus(function () {
        $("#addressMessage").empty();
        $("#addressMessage").removeClass();
        $("#addressMessage").text("请输入正确联系地址!");
        $("#addressMessage").addClass("tips01");
    });
    $("#address").focusout(function () {
        var address = $("#address").val();
        if (address == "") {
            $("#addressMessage").empty();
            $("#addressMessage").removeClass();
            $("#addressMessage").text("请输入正确的联系地址！");
            $("#addressMessage").addClass("tips01-err");
        }
        else {
            $("#addressMessage").empty();
            $("#addressMessage").removeClass();
            $("#addressMessage").addClass("tips01-icon");
        }
    });

});





function RegisterThridStep(trueName, phone, contectEmail, address, remark, seletctAreaId, shopTypeVal, shopNumberVal, shopUrlVal) {
    $.ajax({
        url: "Ajax/Register.ashx",
        type: "get",
        data: { action: "RegisterThirdWihtChannle", trueName: escape(trueName), phone: escape(phone), contectEmail: escape(contectEmail),
            address: escape(address), remark: escape(remark), seletctAreaId: escape(seletctAreaId), shopTypeVal: escape(shopTypeVal),
            shopNumberVal: escape(shopNumberVal), shopUrlVal: escape(shopUrlVal)
        },
        success: function (data) {
            data = unescape(data);
            var array = data.split("$");
            if (array[1] == "0") {
                ShowartDialogMessage('', '您当前账户信息已过期!请重新登录!');
                return false;
            }
            else if (array[1] == "1") {
                ShowartDialogMessage('', '确保您是否已经注册过该信息!或系统繁忙,请稍候重试!');
                return false;
            }
            else if (array[1] == "2") {
                window.location.href = "Register4.aspx";
                return false;
            }
            else {
                alert(array[1]);
            }
        }
    });
}


$(function () {
    $("#ComtimetId").click(function () {
        var categoryId = tree1.getAllChecked();
        //$("#categotyId").val(uidstr);
        //var categoryId = $("#categotyId").val();        
        //alert(categoryId);
        RegisterFouthStep(categoryId);
    });

    $("#btnAddCategory").click(function () {
        var categoryId = tree1.getAllCheckedBranches();
        $("#categotyId").val(categoryId);
        //var categoryId = $("#categotyId").val();         
        //alert(categoryId);
        $("#treeboxbox_tree1").html("");
        showselthiscategory();
    });

    $("#btnDelCategory").click(function () {
        var categoryId = tree2.getAllChecked();
        //$("#categotyId").val(uidstr);
        //var categoryId = $("#categotyId").val();         

    });

});


function RegisterFouthStep(categoryId) {
    $.ajax({
        url: "Ajax/Register.ashx",
        type: "get",
        data: { action: "RegisterFouthStep", categoryId: escape(categoryId) },
        success: function (data) {
            data = unescape(data);
            var array = data.split("$");
            if (array[1] == "0") {
                window.location.href = "login.aspx";
                return false;
            }
            else if (array[1] == "1") {

                ShowartDialogMessage('', '您已经注册过了!或系统繁忙,请等待审核!');
                return false;
            }
            else if (array[1] == "2") {
                window.location.href = "Register5.aspx";
                return false;
            }
            else if (array[1] == "3") {

                ShowartDialogMessage('提示', '请选择您要授权的分类!');
                return false;
            }
            else {
                alert(array[1]);
            }
        }
    });
}


$(function () {
    $("#submitGetPwdToemail").click(function () {
        var sendEmail = $("#getPwdtxtEmail").val();
        var yzm1 = $("#getPwdyzm1").val();
        var result = true;
        if (sendEmail != null) {
            var myreg1 = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
            if (!myreg1.test(sendEmail)) {
                $("#getPwdEmailMessage").empty();
                $("#getPwdEmailMessage").removeClass();
                $("#getPwdEmailMessage").text("请输入正确的Email地址!");
                $("#getPwdEmailMessage").addClass("tips01-err");
                result = false;
            }
        }
        else {
            $("#getPwdEmailMessage").empty();
            $("#getPwdEmailMessage").removeClass();
            $("#getPwdEmailMessage").text("请输入正确的注册(用户名)的Email地址!");
            $("#getPwdEmailMessage").addClass("tips01-err");
            result = false;
        }
        if (yzm1 == "") {
            $("#getPwdyanzhengma1").empty();
            $("#getPwdyanzhengma1").removeClass();
            $("#getPwdyanzhengma1").text("请输入验证码!");
            $("#getPwdyanzhengma1").addClass("tips01-err");
            result = false;
        }
        if (result) {
            GetCheckCode1(yzm1);
        }
    });


    $("#getPwdtxtEmail").focus(function () {
        $("#getPwdEmailMessage").empty();
        $("#getPwdEmailMessage").removeClass();
        $("#getPwdEmailMessage").text("请输入正确的注册(用户名)的Email地址");
        $("#getPwdEmailMessage").addClass("tips01");
    });
    $("#getPwdtxtEmail").focusout(function () {
        var getPwdEmail = $("#getPwdtxtEmail").val();
        if (getPwdEmail != null) {
            var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
            if (myreg.test(getPwdEmail)) {

                CheckEmailIsExit(getPwdEmail);


            }
            else {
                $("#getPwdEmailMessage").empty();
                $("#getPwdEmailMessage").removeClass();
                $("#getPwdEmailMessage").text("请输入正确的注册(用户名)的Email地址!");
                $("#getPwdEmailMessage").addClass("tips01-err");
            }
        }
        else {
            $("#getPwdEmailMessage").empty();
            $("#getPwdEmailMessage").removeClass();
            $("#getPwdEmailMessage").text("注册(用户名)的Email地址不能为空!");
            $("#getPwdEmailMessage").addClass("tips01-err");
        }
    });

    $("#getPwdyzm1").focus(function () {
        $("#getPwdyanzhengma1").empty();
        $("#getPwdyanzhengma1").removeClass();
        $("#getPwdyanzhengma1").text("请输入验证码!");
        $("#getPwdyanzhengma1").addClass("tips01");
    });
    $("#getPwdyzm1").focusout(function () {
        var getPwdyzm1 = $("#getPwdyzm1").val();
        if (getPwdyzm1 == "") {
            $("#getPwdyanzhengma1").empty();
            $("#getPwdyanzhengma1").removeClass();
            $("#getPwdyanzhengma1").text("请输入验证码!");
            $("#getPwdyanzhengma1").addClass("tips01-err");
        }
        else {
            GetCheckCode11(getPwdyzm1);
        }

    });
});



$(function () {
    $("#submitSetPwdForget").click(function () {
        var newPassword = $("#NewPassword").val();
        var newPasswordConfirm = $("#NewPasswordConfirm").val();
        var getEmail = $("#getPwdtxtEmail2").val();
        var answer = $("#getPwdanswer").val();

        if (newPassword == "") {
            $("#NewPasswordMessage").empty();
            $("#NewPasswordMessage").removeClass();
            $("#NewPasswordMessage").text("请输入新密码!");
            $("#NewPasswordMessage").addClass("tips01-err");
            return false;
        }
        if (newPasswordConfirm == "") {
            $("#NewPasswordConfirmMessage").empty();
            $("#NewPasswordConfirmMessage").removeClass();
            $("#NewPasswordConfirmMessage").text("请再次确认!");
            $("#NewPasswordConfirmMessage").addClass("tips01-err");
            return false;
        }
        setNewPassWord(getEmail, answer, newPassword);
    });

    $("#NewPassword").focus(function () {
        $("#NewPasswordMessage").empty();
        $("#NewPasswordMessage").removeClass();
        $("#NewPasswordMessage").text("请输入新密码!");
        $("#NewPasswordMessage").addClass("tips01");

    });


    $("#NewPassword").focusout(function () {
        var userName = $("#NewPassword").val();
        if (userName == "") {
            $("#NewPasswordMessage").empty();
            $("#NewPasswordMessage").removeClass();
            $("#NewPasswordMessage").text("请输入新密码!");
            $("#NewPasswordMessage").addClass("tips01-err");
        }
        else {
            $("#NewPasswordMessage").empty();
            $("#NewPasswordMessage").removeClass();
            $("#NewPasswordMessage").addClass("tips01-icon");
        }
    });
    $("#NewPasswordConfirm").focus(function () {
        $("#NewPasswordConfirmMessage").empty();
        $("#NewPasswordConfirmMessage").removeClass();
        $("#NewPasswordConfirmMessage").text("登录密码!");
        $("#NewPasswordConfirmMessage").addClass("tips01");
    });
    $("#NewPasswordConfirm").focusout(function () {
        var newPassword = $("#NewPassword").val();
        var newPasswordConfirm = $("#NewPasswordConfirm").val();

        if (newPasswordConfirm == "") {
            $("#NewPasswordConfirmMessage").empty();
            $("#NewPasswordConfirmMessage").removeClass();
            $("#NewPasswordConfirmMessage").text("请在一次确认密码！");
            $("#NewPasswordConfirmMessage").addClass("tips01-err");
        }
        else {
            if (newPassword != newPasswordConfirm) {
                $("#NewPasswordConfirmMessage").empty();
                $("#NewPasswordConfirmMessage").removeClass();
                $("#NewPasswordConfirmMessage").text("两次输入密码不一致！");
                $("#NewPasswordConfirmMessage").addClass("tips01-err");
            } else {
                $("#NewPasswordConfirmMessage").empty();
                $("#NewPasswordConfirmMessage").removeClass();
                $("#NewPasswordConfirmMessage").addClass("tips01-icon");
            }
            return false;
        }
    });
});


function setNewPassWord(emal, answer, password) {
    $.ajax({
        url: "Ajax/GetPwd.ashx",
        type: "get",
        data: { action: "setNewPassWord", Email: escape(emal), Answer: escape(answer), PassWord: (password) },
        success: function (data) {
            data = unescape(data);
            if (data == "1") {
                art.dialog({
                    title: '',
                    content: '密码重新设置成功！',
                    lock: true,
                    width: '560px',
                    height: '120px',
                    yesText: "确定",
                    yesFn: function () {
                        window.location.href = "login.aspx";
                    }
                });
                return false;
            }
            else {
                $("#getPwdEmailMessage").empty();
                $("#getPwdEmailMessage").removeClass();
                $("#getPwdEmailMessage").text("稍候重试!");
                $("#getPwdEmailMessage").addClass("tips01-err");
                return false;
            }
        }
    });
}












$(function () {
    $("#submitGetPwdForget").click(function () {
        var getEmail = $("#getPwdtxtEmail2").val();
        var yzm2 = $("#getPwdyzm2").val();
        var result = false;
        if (getEmail != null) {
            var myreg1 = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
            if (myreg1.test(getEmail)) {

                result = true;
            }
            else {
                $("#getPwdEmailMessage2").empty();
                $("#getPwdEmailMessage2").removeClass();
                $("#getPwdEmailMessage2").text("请输入正确的注册(用户名)的Email地址!");
                $("#getPwdEmailMessage2").addClass("tips01-err");
                result = false;
            }
        }
        else {
            $("#getPwdEmailMessage2").empty();
            $("#getPwdEmailMessage2").removeClass();
            $("#getPwdEmailMessage2").text("请输入正确的注册(用户名)的Email地址!");
            $("#getPwdEmailMessage2").addClass("tips01-err");
            result = false;

        }
        if (yzm2 == "") {
            $("#getPwdyanzhengma2").empty();
            $("#getPwdyanzhengma2").removeClass();
            $("#getPwdyanzhengma2").text("请输入验证码!");
            $("#getPwdyanzhengma2").addClass("tips01-err");
            result = false;
        }
        if (result) {
            GetCheckCode2(yzm2);


        }
    });

    $("#getPwdtxtEmail2").focus(function () {
        $("#getPwdEmailMessage2").empty();
        $("#getPwdEmailMessage2").removeClass();
        $("#getPwdEmailMessage2").text("请输入正确的注册(用户名)的Email地址");
        $("#getPwdEmailMessage2").addClass("tips01");
    });
    $("#getPwdtxtEmail2").focusout(function () {
        var getEmail2 = $("#getPwdtxtEmail2").val();
        if (getEmail2 != "") {
            var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
            if (myreg.test(getEmail2)) {

                CheckEmailIsExit2(getEmail2);
                CheckEmailGetProblem(getEmail2);


            }
            else {
                $("#getPwdEmailMessage2").empty();
                $("#getPwdEmailMessage2").removeClass();
                $("#getPwdEmailMessage2").text("请输入正确的注册(用户名)的Email地址!");
                $("#getPwdEmailMessage2").addClass("tips01-err");
            }
        }
        else {
            $("#getPwdEmailMessage2").empty();
            $("#getPwdEmailMessage2").removeClass();
            $("#getPwdEmailMessage2").text("注册(用户名)的Email地址不能为空!");
            $("#getPwdEmailMessage2").addClass("tips01-err");
        }
    });

    $("#getPwdyzm2").focus(function () {

        $("#getPwdyanzhengma2").empty();
        $("#getPwdyanzhengma2").removeClass();
        $("#getPwdyanzhengma2").text("请输入验证码!");
        $("#getPwdyanzhengma2").addClass("tips01");
    });
    $("#getPwdyzm2").focusout(function () {
        var getPwdyzm2 = $("#getPwdyzm2").val();
        if (getPwdyzm2 == "") {
            $("#getPwdyanzhengma2").empty();
            $("#getPwdyanzhengma2").removeClass();
            $("#getPwdyanzhengma2").text("请输入验证码!");
            $("#getPwdyanzhengma2").addClass("tips01-err");
        }
        else {
            GetCheckCode22(getPwdyzm2);
        }

    });

    $("#getPwdanswer").focus(function () {

        $("#getPwdanswerMessage").empty();
        $("#getPwdanswerMessage").removeClass();
        $("#getPwdanswerMessage").text("请输入密码保护问题答案!");
        $("#getPwdanswerMessage").addClass("tips01");
    });
    $("#getPwdanswer").focusout(function () {
        var getPwdanswer = $("#getPwdanswer").val();
        if (getPwdanswer == "") {
            $("#getPwdanswerMessage").empty();
            $("#getPwdanswerMessage").removeClass();
            $("#getPwdanswerMessage").text("请输入密码保护问题答案!");
            $("#getPwdanswerMessage").addClass("tips01-err");
            return false;
        }
        else {
            CheckProblemAnswer(getPwdanswer, $("#getPwdtxtEmail2").val());

        }


    });

});



///zhagnSecond
$(function () {
    $("#submitGetPwdSecond").click(function () {
        var getEmail = $("#getPwdtxtEmail2").val();
        //var yzm2 = $("#getPwdyzm2").val();
        var answer = $("#getPwdanswer").val();

        var result = false;
        if (getEmail != null) {
            var myreg1 = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
            if (myreg1.test(getEmail)) {

                result = true;
            }
            else {
                $("#getPwdEmailMessage2").empty();
                $("#getPwdEmailMessage2").removeClass();
                $("#getPwdEmailMessage2").text("请输入正确的注册(用户名)的Email地址!");
                $("#getPwdEmailMessage2").addClass("tips01-err");
                result = false;
            }
        }
        else {
            $("#getPwdEmailMessage2").empty();
            $("#getPwdEmailMessage2").removeClass();
            $("#getPwdEmailMessage2").text("请输入正确的注册(用户名)的Email地址!");
            $("#getPwdEmailMessage2").addClass("tips01-err");
            result = false;

        }
        if (answer == "") {
            $("#getPwdEmailMessage2").empty();
            $("#getPwdEmailMessage2").removeClass();
            $("#getPwdEmailMessage2").text("请输入正确的注册(用户名)的Email地址!");
            $("#getPwdEmailMessage2").addClass("tips01-err");
            result = false;
        } else {
            $("#getPwdEmailMessage").empty();
            $("#getPwdEmailMessage").removeClass();
            $("#getPwdEmailMessage").addClass("tips01-icon");
            result = true;
        }
        CheckProblemAnswer(answer, getEmail);
    });

    $("#getPwdanswer").focus(function () {

        $("#getPwdanswerMessage").empty();
        $("#getPwdanswerMessage").removeClass();
        $("#getPwdanswerMessage").text("请输入密码保护问题答案!");
        $("#getPwdanswerMessage").addClass("tips01");
    });
    $("#getPwdanswer").focusout(function () {
        var getPwdanswer = $("#getPwdanswer").val();
        if (getPwdanswer == "") {
            $("#getPwdanswerMessage").empty();
            $("#getPwdanswerMessage").removeClass();
            $("#getPwdanswerMessage").text("请输入密码保护问题答案!");
            $("#getPwdanswerMessage").addClass("tips01-err");
            return false;
        }
        else {
            CheckProblemAnswer(getPwdanswer, $("#getPwdtxtEmail2").val());

        }
    });
});









function CheckEmailIsExit(obj) {
    $.ajax({
        url: "Ajax/GetPwd.ashx",
        type: "get",
        data: { action: "check", email: escape(obj) },
        success: function (data) {
            data = unescape(data);
            if (data == "1") {
                $("#getPwdEmailMessage").empty();
                $("#getPwdEmailMessage").removeClass();
                $("#getPwdEmailMessage").addClass("tips01-icon");
                return false;
            }
            else {
                $("#getPwdEmailMessage").empty();
                $("#getPwdEmailMessage").removeClass();
                $("#getPwdEmailMessage").text("不存在此账号或者账号输入有误!");
                $("#getPwdEmailMessage").addClass("tips01-err");
                return false;
            }
        }
    });
}

function CheckEmailIsExit2(obj) {
    $.ajax({
        url: "Ajax/GetPwd.ashx",
        type: "get",
        data: { action: "check", email: escape(obj) },
        success: function (data) {
            data = unescape(data);
            if (data == "1") {
                $("#getPwdEmailMessage2").empty();
                $("#getPwdEmailMessage2").removeClass();
                $("#getPwdEmailMessage2").addClass("tips01-icon");
                return true;

            }

            else {
                $("#getPwdEmailMessage2").empty();
                $("#getPwdEmailMessage2").removeClass();
                $("#getPwdEmailMessage2").text("不存在此账号或者账号输入有误!");
                $("#getPwdEmailMessage2").addClass("tips01-err");
                return false;
            }

        }
    });
}

function CheckEmailGetProblem(obj) {
    $.ajax({
        url: "Ajax/GetPwd.ashx",
        type: "get",
        data: { action: "getquestion", email: escape(obj) },
        success: function (data) {
            data = unescape(data);
            if (data == "") {
                $("#getPwdProblem").empty();
                $("#getPwdProblem").removeClass();
                $("#getPwdProblem").text("密保问题还没有设置，无法使用此功能!");
                $("#getPwdProblem").addClass("tips01-err");
                return false;
            }

            else {
                $("#getPwdProblem").empty();
                $("#getPwdProblem").removeClass();
                $("#getPwdProblem").text(data);
                $("#getPwdProblem").addClass("tips01");
                return true;
            }

        }
    });
}

function CheckProblemAnswer(objanswer, objemail) {

    $.ajax({
        url: "Ajax/GetPwd.ashx",
        type: "get",
        data: { action: "ExisYesOrNo", email: escape(objemail), Answer: escape(objanswer) },
        success: function (data) {
            data = unescape(data);

            if (data == "1") {
                $("#getPwdanswerMessage").empty();
                $("#getPwdanswerMessage").removeClass();
                $("#getPwdanswerMessage").addClass("tips01-icon");

                $("#getPwdProblemContent1").attr("style", "display:none;");
                $("#GetProSecond").attr("style", "display:none;");
                $("#getPwdProblemContent2").attr("style", "display:block;");
            }

            else {
                $("#getPwdanswerMessage").empty();
                $("#getPwdanswerMessage").removeClass();
                $("#getPwdanswerMessage").text("密码保护问题回答错误，无法继续操作!");
                $("#getPwdanswerMessage").addClass("tips01-err");
            }
        }
    });

}


function SendEmailIsExit(obj) {
    $.ajax({
        url: "Ajax/GetPwd.ashx",
        type: "get",
        data: { action: "xiugai", Email: escape(obj) },
        success: function (data) {
            data = unescape(data);
            if (data == "1") {

                ShowartDialogMessage('', '您已经成功找回密码,请登录邮箱查看重新设置后的密码！');
                return false;
            }
            else {
                $("#getPwdEmailMessage").empty();
                $("#getPwdEmailMessage").removeClass();
                $("#getPwdEmailMessage").text("不存在此账号或者账号输入有误!");
                $("#getPwdEmailMessage").addClass("tips01-err");
                return false;
            }

        }
    });
}

function GetCheckCode1(checkCode) {

    $.ajax({
        url: "CheckCode.aspx",
        type: "get",
        data: { actioncode: "GetCheckCode", checkCode: escape(checkCode) },
        success: function (data) {
            data = unescape(data);
            if (data == "0") {
                $("#getPwdyanzhengma1").empty();
                $("#getPwdyanzhengma1").removeClass();
                $("#getPwdyanzhengma1").text("请输入正确的验证码!");
                $("#getPwdyanzhengma1").addClass("tips01-err");
                return false;
            }
            else if (data == "1") {

                $("#getPwdyanzhengma1").empty();
                $("#getPwdyanzhengma1").removeClass();
                $("#getPwdyanzhengma1").addClass("tips01-icon");
                var sendEmail = $("#getPwdtxtEmail").val();
                SendEmailIsExit(sendEmail);
                return true;
            }
        }
    });
}
function GetCheckCode11(checkCode) {

    $.ajax({
        url: "CheckCode.aspx",
        type: "get",
        data: { actioncode: "GetCheckCode", checkCode: escape(checkCode) },
        success: function (data) {
            data = unescape(data);
            if (data == "0") {
                $("#getPwdyanzhengma1").empty();
                $("#getPwdyanzhengma1").removeClass();
                $("#getPwdyanzhengma1").text("请输入正确的验证码!");
                $("#getPwdyanzhengma1").addClass("tips01-err");
                return false;
            }
            else if (data == "1") {

                $("#getPwdyanzhengma1").empty();
                $("#getPwdyanzhengma1").removeClass();
                $("#getPwdyanzhengma1").addClass("tips01-icon");
                return true;
            }
        }
    });
}

function GetCheckCode2(checkCode) {
    $.ajax({
        url: "CheckCode.aspx",
        type: "get",
        data: { actioncode: "GetCheckCode", checkCode: escape(checkCode) },
        success: function (data) {
            data = unescape(data);
            if (data == "0") {
                $("#getPwdyanzhengma2").empty();
                $("#getPwdyanzhengma2").removeClass();
                $("#getPwdyanzhengma2").text("请输入正确的验证码!");
                $("#getPwdyanzhengma2").addClass("tips01-err");
                return false;
            }
            else if (data == "1") {

                $("#getPwdyanzhengma2").empty();
                $("#getPwdyanzhengma2").removeClass();
                $("#getPwdyanzhengma2").addClass("tips01-icon");

                $("#getPwdProblemContent1").attr("style", "display:none;");
                $("#GetProSecond").attr("style", "display:block;");
                return true;
            }
        }
    });
}
function GetCheckCode22(checkCode) {
    $.ajax({
        url: "CheckCode.aspx",
        type: "get",
        data: { actioncode: "GetCheckCode", checkCode: escape(checkCode) },
        success: function (data) {
            data = unescape(data);
            if (data == "0") {
                $("#getPwdyanzhengma2").empty();
                $("#getPwdyanzhengma2").removeClass();
                $("#getPwdyanzhengma2").text("请输入正确的验证码!");
                $("#getPwdyanzhengma2").addClass("tips01-err");
                return false;
            }
            else if (data == "1") {

                $("#getPwdyanzhengma2").empty();
                $("#getPwdyanzhengma2").removeClass();
                $("#getPwdyanzhengma2").addClass("tips01-icon");
                return true;
            }
        }
    });
}