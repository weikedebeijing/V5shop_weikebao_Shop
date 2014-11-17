<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonalCenter.aspx.cs" Inherits="V5APP.Store.UI.member.PersonalCenter" %>


<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>个人资料修改</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.alert.js"></script>
    <script src="../../member/js/Common.js"></script>
</head>

<body>
    <!--alert begin-->
    <%-- <div id="myModal" class="reveal-modal alert-header radius" data-reveal>
        <ul class="side-nav">
            <li class="first"><a href="#">拍照</a></li>
            <li class="last"><a href="#">选择本地图片</a></li>
        </ul>
    </div>--%>
    <!--alert end-->
    <!--submit errow tip begin-->
    <div data-alert class="alert-box alert" style="display: none;" id="errerMsg">请选择省！<a href="#" class="close">&times;</a></div>
    <!--submit errow tip end-->
    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small" onclick="backPage()">
                <a class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title" id="title">个人资料</h1>
            </section>
            <section class="right-small right-small-text2" id="saveBtn" style="display: none">
                <a href="javascript:void(0)" onclick="btnsave()" class="button [radius round] top-button">保存</a>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--side nav begin-->
    <div class="personal-center" id="divInfo">
        <ul class="side-nav" id="list">
            <%--<input type="hidden" value="<%=customer.LoginUrl %>" id="LogoUrl" name="LogoUrl" />--%>
            <%--<input id="file_upload" name="file_upload" type="file" style="display: none;" onchange="UploadImage()" accept="image/jpg,image/gif,image/png,image/jpeg" />--%>
            <%--            <li dated="image"><a href="javascript:void(0)" data-reveal-id="myModal">
                <span class="pic-header">
                    <img id="file_upload_img" src="<%=logurl %>"></span><span class="head-text">头像</span><i class="head-arrow"></i></a></li>--%>
            <%if (!isNew)
              { %>
            <li isnew="<%=isNew %>"><a href="javascript:void(0)">
                <div class="title"><i class="icon-name"></i><span class="text" tage="loginname">会员名称</span></div>
                <div class="cont-value">


                    <%--<i class="arrow"></i><span class="value" id="loginname">未设置会员名称 &nbsp;</span>--%>

                    <span class="value"><%=customer.LoginName %>&nbsp;</span>

                </div>
            </a></li>
            <li><a href="javascript:void(0)">
                <div class="title"><i class="icon-clock"></i><span class="text" tage="password">密码</span></div>
                <div class="cont-value">


                    <%--<i class="arrow"></i><span class="value">未设置密码 &nbsp;</span>--%>



                    <i class="arrow"></i><span class="value">&nbsp;</span>

                </div>
            </a></li>
            <%} %>
            <li><a href="javascript:void(0)">
                <div class="title"><i class="icon-tname"></i><span class="text" tage="truename">真实姓名</span></div>
                <div class="cont-value"><i class="arrow"></i><span class="value" id="truename"><%=customer.TrueName %>&nbsp;</span></div>
            </a></li>
            <li><a href="javascript:void(0)">
                <div class="title"><i class="icon-tname"></i><span class="text" tage="qqno">QQ号</span></div>
                <div class="cont-value"><i class="arrow"></i><span class="value" id="qqno"><%=customer.Question %>&nbsp;</span></div>
            </a></li>
            <li><a href="javascript:void(0)">
                <div class="title"><i class="icon-tname"></i><span class="text" tage="wxno">微信号</span></div>
                <div class="cont-value"><i class="arrow"></i><span class="value" id="wxno"><%=customer.Answer %>&nbsp;</span></div>
            </a></li>
            <li><a href="javascript:void(0)">
                <div class="title"><i class="icon-mobile"></i><span class="text" tage="mobilephone">手机</span></div>
                <div class="cont-value"><i class="arrow"></i><span class="value" id="mobilephone"><%=customer.MobilePhone %>&nbsp;</span></div>
            </a></li>
            <%--  <li><a href="javascript:void(0)">
                <div class="title"><i class="icon-tel"></i><span class="text" tage="telephone">电话</span></div>
                <div class="cont-value"><i class="arrow"></i><span class="value"><%=customer.Telephone %>&nbsp;</span></div>
            </a></li>--%>
            <li><a href="javascript:void(0)">
                <div class="title"><i class="icon-address"></i><span class="text" tage="address">收货地址</span></div>
                <div class="cont-value"><i class="arrow"></i><span class="value long-text">&nbsp</span></div>
            </a></li>
        </ul>
    </div>
    <%if (!iswx)
      { %>
    <div class="button-exit" id="exit"><a href="logOut.aspx" class="button [radius red round]">退出登陆</a></div>
    <%} %>

    <!--form begin-->
    <form class="mt-55 mlr-15" id="edit" style="display: none">
        <div class="panel callout radius formstyle">
            <!--01 begin-->
            <div class="row">
                <div class="large-12 columns">
                    <input type="text" id="value" value="" class="last">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--01 end-->
        </div>
    </form>
    <form class="mt-55 mlr-15" id="editpassword" style="display: none">
        <div class="panel callout radius formstyle editpw">
            <!--01 begin-->
            <%--    <%if (isNew)
              { %>
            <div class="row collapse" style="display: none">
                <div class="small-12 large-12 columns">
                    <input type="password" placeholder="原密码" value="123456" id="oldpassword">
                      <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <%}
              else
              { %>--%>
            <div class="row collapse">
                <div class="small-12 large-12 columns">
                    <input type="password" placeholder="原密码" id="oldpassword">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <%--  <%} %>--%>
            <!--01 end-->
            <!--02 begin-->
            <div class="row collapse">
                <div class="small-12 large-12 columns">
                    <input type="password" placeholder="新密码" id="newpassword">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--02 end-->
            <!--03 begin-->
            <div class="row collapse">
                <div class="small-12 large-12 columns">
                    <input type="password" placeholder="确认密码" class="last" id="newpassword2">
                    <span class="close-input" style="display: none;"></span>
                </div>
            </div>
            <!--03 end-->
        </div>
    </form>
    <!--form begin-->
    <!--form end-->
    <!--side nav end-->
    <script>
        $(document).foundation().foundation('joyride', 'start');
    </script>

    <script src="../../member/Js/ajaxFileUpload.js" type="text/javascript"></script>
    <script type="text/javascript">


        function UploadImage() {
            $.ajaxFileUpload({
                url: 'Ajax/LoginHandle.aspx?action=UploadImage', //用于文件上传的服务器端请求地址
                secureuri: false, //一般设置为false
                fileElementId: 'file_upload', //文件上传空间的id属性  <input type="file" id="file" name="file" />
                dataType: 'text', //返回值类型 一般设置为json
                success: function (res) //服务器成功响应处理函数
                {
                    var reg = /\.[a-z]{3,4}/g;
                    if (reg.test(res)) {
                        $("#file_upload_img").attr("src", "../../UploadFile/UserImage/" + res);
                        $("#LogoUrl").val(res);
                        $.ajax({
                            url: "../member/ajax/LoginHandle.aspx",
                            data: { "action": "editlogourl", "LogoUrl": res },
                            async: false,
                            cache: false,
                            dataType: "text",
                            success: function (res) {
                                if (res == "true") {
                                } else {
                                    ShowMsg("头像上传失败");
                                }
                            }
                        })
                    } else {
                        //                        alert(res);
                        ShowMsg(res);
                        return;
                    }
                },
                error: function () //服务器响应失败处理函数
                {
                    ShowMsg("提交过程中出现未知错误");
                }
            });

        }

    </script>

    <script type="text/javascript">
        var title = "";
        var value = "";
        var type = "";
        $(function () {
            $("#list li").click(function () {

                if ($(this).attr("dated") == "image") {
                    $("#file_upload").click();
                } else {

                    var titleTag = this.children[0].children[0].children[1];
                    title = titleTag.innerHTML;
                    type = $(titleTag).attr("tage");
                    value = this.children[0].children[1].children[1].innerHTML;
                    value = value.replace("&nbsp;", "");
                    $("#value").attr("placeholder", "");
                    if (title == "会员名称") {
                        if ($(this).attr("isnew") == "False") {
                            return;
                        } else {
                            $("#value").attr("placeholder", "请输入会员名");
                            $("#title").html(title);
                            $("#saveBtn").toggle();
                            $("#divInfo").toggle();
                            $("#exit").toggle();
                            $("#edit").toggle();
                            return;
                        }
                    }

                    if (title == "密码") {
                        $("#title").html("修改密码");
                        $("#saveBtn").toggle();
                        $("#divInfo").toggle();
                        $("#exit").toggle();
                        $("#editpassword").toggle();
                    } else if (title == "收货地址") {

                        window.location.href = "addresslist.aspx";
                    } else {
                        $("#title").html(title);
                        $("#value").val(value);
                        $("#saveBtn").toggle();
                        $("#divInfo").toggle();
                        $("#exit").toggle();
                        $("#edit").toggle();
                    }
                }  // $("body").scrollTop(0);
            })
        });

        function backPage() {
            $("#title").html("个人资料");
            if ($("#saveBtn").is(":hidden")) {
                window.location.href = "Member.aspx";
            }
            $("#saveBtn").hide();
            $("#divInfo").toggle();
            $("#exit").toggle();
            $("#edit").hide();
            $("#editpassword").hide();
        }
        function btnsave() {
            var url = "../member/ajax/LoginHandle.aspx";
            var value = "";
            switch (type) {
                case "password":
                    //密码(6-16)位
                    var oldpassword = $("#oldpassword").val();
                    var newpassword = $("#newpassword").val();
                    var newpassword2 = $("#newpassword2").val();
                    var reg = /^[\@A-Za-z0-9\!\#\$\%\^\&\*\.\~]{6,16}$/;
                    if (!reg.test(oldpassword)) {
                        ShowMsg("原密码不符合规则");
                        return;
                    }
                    if (!reg.test(newpassword)) {
                        ShowMsg("新密码不符合规则");
                        return;
                    }
                    if (newpassword != newpassword2) {
                        ShowMsg("两次输入的密码不不一致");
                        return;
                    }
                    $.ajax({
                        url: url,
                        data: { "action": "editpassword", "oldpassword": oldpassword, "newpassword": newpassword },
                        async: false,
                        cache: false,
                        dataType: "text",
                        success: function (res) {
                            if (res == "true") {
                                backPage();
                            } else {
                                ShowMsg("原密码错误");
                            }
                        }
                    })
                    break;
                case "truename":
                    var truename = $("#truename").text().trim();
                    value = $("#value").val().trim();
                    if (value == "") {
                        ShowMsg("真实姓名不能为空");
                        return;
                    }
                    if (truename == value) {
                        ShowMsg("与原真实姓名一致,无需修改");
                        return;
                    }
                    $.ajax({
                        url: url,
                        data: { "action": "edittruename", "truename": value },
                        async: false,
                        cache: false,
                        dataType: "text",
                        success: function (res) {
                            if (res == "true") {
                                backPage();
                                $("#truename").text(value);
                            } else {
                                ShowMsg("修改失败");
                            }
                        }
                    })
                    break;
                case "mobilephone":
                    var mobilephone = $("#mobilephone").text().trim();
                    value = $("#value").val().trim();
                    if (value == "") {
                        ShowMsg("手机不能为空");
                        return;
                    }
                    //手机11位
                    var reg = /^\d{11}$/;
                    if (!reg.test(value)) {
                        ShowMsg("手机号码格式不正确");
                        return;
                    }
                    if (mobilephone == value) {
                        ShowMsg("与原手机号码一致,无需修改");
                        return;
                    }
                    $.ajax({
                        url: url,
                        data: { "action": "editmobilephone", "mobilephone": value },
                        async: false,
                        cache: false,
                        dataType: "text",
                        success: function (res) {
                            if (res == "true") {
                                backPage();
                                $("#mobilephone").text(value);
                            } else {
                                ShowMsg("修改失败");
                            }
                        }
                    })
                    break;
                case "loginname":
                    value = $("#value").val().trim();
                    if (value == "") {
                        ShowMsg("会员名称不能为空");
                        return;
                    }
                    $.ajax({
                        url: url,
                        data: { "action": "editloginname", "loginname": value },
                        async: false,
                        cache: false,
                        dataType: "text",
                        success: function (res) {
                            if (res == "true") {
                                backPage();
                                $("#loginname").text(value);
                            } else {
                                ShowMsg("用户名已存在");
                            }
                        }
                    })
                    break;
                case "qqno":
                    value = $("#value").val().trim();
                    if (value == "") {
                        ShowMsg("QQ号不能为空");
                        return;
                    }
                    $.ajax({
                        url: url,
                        data: { "action": "editqqno", "qqno": value },
                        async: false,
                        cache: false,
                        dataType: "text",
                        success: function (res) {
                            if (res == "true") {
                                backPage();
                                $("#qqno").text(value);
                            } else {
                                ShowMsg("修改失败");
                            }
                        }
                    })
                    break;
                case "wxno":
                    value = $("#value").val().trim();
                    if (value == "") {
                        ShowMsg("微信号不能为空");
                        return;
                    }
                    $.ajax({
                        url: url,
                        data: { "action": "editwxno", "wxno": value },
                        async: false,
                        cache: false,
                        dataType: "text",
                        success: function (res) {
                            if (res == "true") {
                                backPage();
                                $("#wxno").text(value);
                            } else {
                                ShowMsg("修改失败");
                            }
                        }
                    })
                    break;
            }







        }
    </script>
</body>
</html>
