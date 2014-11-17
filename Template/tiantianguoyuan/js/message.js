//初始化验证码
//$(document).ready(function () {
//    ChangeVerifyImg();
//});
////切换验证码
//function ChangeVerifyImg() {
//    document.getElementById("verifyimg").src = '/membership/verifyimg.aspx?d=' + Date();
//}
//提交表单
function CheckGbookForm() {
    //    var obj = document.getElementById("title");
    //    if (obj.value == "") {
    //        art.dialog({
    //            time: 3000,
    //            lock: true,
    //            title: '提示消息',
    //            content: '请填写主题！'
    //        });
    //        obj.focus();
    //        return false;
    //    }

    //    obj = document.getElementById("content");
    //    if (obj.value == "") {
    //        art.dialog({
    //            time: 3000,
    //            lock: true,
    //            title: '提示消息',
    //            content: '请填写留言内容！'
    //        });
    //        obj.focus();
    //        return false;
    //    }



    var title = document.getElementById("title");
    if (title.value == "") {
        alert("标题不能为空！");
        title.focus();
        return false;
    }

    var content = document.getElementById("content");
    if (content.value == "") {
        alert("内容不能为空！");
        content.focus();
        return false;
    }
    var email = document.getElementById("email");
    var myreg = new RegExp(/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/);
    if (myreg.test(email)) {
        alert("请输入正确的邮箱格式！");
        email.focus();
        return false;
    }

    var phone = document.getElementById("telephone");
    var patrn = /(^0{0,1}1[3|4|5|6|7|8|9][0-9]{9}$)/;
    if (patrn.test(phone)) {
        alert("请输入正确的电话号码！");
        phone.focus();
        return false;
    }
    
}