<%@ Page Language="C#" AutoEventWireup="true" Debug="true" CodeBehind="EditCard.aspx.cs" Inherits="V5APP.Store.UI.member.EditCard" %>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>名片</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/edit-card.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="../../member/js/address.select.area.js"></script>

    <script src="../../member/js/Common.js"></script>
    <script src="../../member/js/webuploader.js"></script>
    <script src="../../member/js/demo2.js"></script>
    <script type="text/javascript" language="JavaScript"> 
<!-- 
    var flag = false;
    function DrawImage(ImgD) {
        $(ImgD).height($(ImgD).width());
    }
    //--> 
    </script>
</head>

<body class="body-gray">


    <!--topbar begin-->
    <div class="fixed">
        <nav class="tab-bar">
            <section class="left-small">
                <a href="javascript:javascript:history.go(-1)" class="menu-icon"><span></span></a>
            </section>
            <section class="middle tab-bar-section">

                <h1 class="title">编辑名片</h1>
            </section>
            <section class="right-small right-small-text2">
                <a href="javascript:void(0)" onclick="btnSave()" class="button [radius round] top-button">保存</a>
            </section>
        </nav>
    </div>
    <!--submit errow tip begin-->
    <div data-alert class="alert-box alert" style="display: none;" id="errerMsg"><a href="#" class="close">&times;</a></div>
    <!--submit errow tip end-->
    <!--topbar end-->
    <form class="edit-card" action="Ajax/LoginHandle.aspx?Action=EditCard" method="post" id="cardForm" name="cardForm">
        <% if (card != null)
           { %>

        <!--form begin-->

        <input name="id" type="hidden" value="<%=card.ID %>" />
        <div class="row">
            <div class="large-12 columns">
                <h4>基本信息</h4>
                <%--<input type="hidden" name="HeadUrl" id="HeadUrl" value="<%=card.HeadUrl %>" />--%>
                <a href="javascript:void(0)" class="update-header" id="uploader-demo">
                    <span class="span-header">
                        <div id="fileList" class="uploader-list"></div>
                        <div id="filePicker" class="upbtn">上传按钮</div>
                    </span><span class="span-text">点击上传头像</span>
                </a>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <input type="text" placeholder="姓名" value="<%=card.Name %>" id="Name" name="Name" class="radius" />
                <small class="error" style="display: none;">请填写姓名</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <input type="text" class="radius" placeholder="手机" name="MPhoneNo" id="MPhoneNo" value="<%=card.MPhoneNo %>" />
                <small class="error" style="display: none;">请填写手机号</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <h4>职业信息</h4>
                <input type="text" class="radius" placeholder="职位" id="Position" name="Position" value="<%=card.Position %>" />
                <small class="error" style="display: none;">请填写职位</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <input type="text" class="radius" placeholder="所在公司" id="Company" name="Company" value="<%=card.Company %>" />
                <small class="error" style="display: none;">请填写公司名称</small>
            </div>
        </div>
        <input type="hidden" id="AreaCode" name="AreaCode" value="<%=card.AddressCode %>" />
        <input type="hidden" id="SeletctAreaId" name="SeletctAreaId" value="" />
        <input type="hidden" id="AddressInfo" name="AddressInfo" value="" />
        <div class="row">
            <div class="large-12 columns">
                <select class="radius" id="seleAreaNext">
                    <option value="-1">省</option>
                </select>
                <small class="error" style="display: none;">请选择省</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <select class="radius" id="seleAreaThird">
                    <option value="-1">市</option>
                </select>
                <small class="error" style="display: none;">请选择市</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <select class="radius" id="seleAreaFouth">
                    <option value="-1">区/县</option>
                </select>
                <small class="error" style="display: none;">请选择区/县</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <textarea class="radius" placeholder="地址" name="ShortAddressInfo" id="ShortAddressInfo"><%=card.ShortAddressInfo %></textarea>
                <small class="error" style="display: none;">请填写地址</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <textarea class="radius" placeholder="主营业务" name="Business" id="Business"><%=card.Business %></textarea>
                <small class="error" style="display: none;">请填写主营业务</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <h4>相册</h4>
                <h6 class="subheader">建议尺寸120px*120px，支付.jpg、.gif格式，大小不超过2M</h6>
                <!--pic begin-->
                <div class="uppic">
                    <ul class="uppic-ul" id="lilist">
                        <li>
                            <div id="uploader-demo02">
                                <!--用来存放item-->
                                <div id="fileList02" class="uploader-list"></div>
                                <div id="filePicker02">上传图片</div>
                            </div>
                        </li>
                        <li class="middle">
                            <div id="uploader-demo03">
                                <!--用来存放item-->
                                <div id="fileList03" class="uploader-list"></div>
                                <div id="filePicker03">上传图片</div>
                            </div>
                        </li>
                        <li>
                            <div id="uploader-demo04">
                                <!--用来存放item-->
                                <div id="fileList04" class="uploader-list"></div>
                                <div id="filePicker04">上传图片</div>
                            </div>
                        </li>

                    </ul>
                </div>
                <!--pic end-->
            </div>
        </div>

        <%}
           else
           { %>
        <!--form begin-->
        <div class="row">
            <div class="large-12 columns">
                <h4>基本信息</h4>
                <input type="hidden" name="HeadUrl" id="HeadUrl" value="" />
                <a href="javascript:void(0)" class="update-header" id="uploader-demo">
                    <span class="span-header">
                        <div id="fileList" class="uploader-list"></div>
                        <div id="filePicker" class="upbtn">上传按钮</div>
                    </span><span class="span-text">点击上传头像</span>
                </a>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <input type="text" placeholder="姓名" value="" id="Name" name="Name" class="radius" />
                <small class="error" style="display: none;">请填写姓名</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <input type="text" class="radius" placeholder="手机" name="MPhoneNo" id="MPhoneNo" value="" />
                <small class="error" style="display: none;">请填写手机号</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <h4>职业信息</h4>
                <input type="text" class="radius" placeholder="职位" id="Position" name="Position" value="" />
                <small class="error" style="display: none;">请填写职位</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <input type="text" class="radius" placeholder="所在公司" id="Company" name="Company" value="" />
                <small class="error" style="display: none;">请填写公司名称</small>
            </div>
        </div>
        <input type="hidden" id="AreaCode" name="AreaCode" />
        <input type="hidden" id="SeletctAreaId" name="SeletctAreaId" value="" />
        <input type="hidden" id="AddressInfo" name="AddressInfo" value="" />
        <input type="hidden" id="CustomerID" name="CustomerID" value="<%=CustomerID %>" />
        <div class="row">
            <div class="large-12 columns">
                <select class="radius" id="seleAreaNext">
                    <option value="-1">省</option>
                </select>
                <small class="error" style="display: none;">请选择省</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <select class="radius" id="seleAreaThird">
                    <option value="-1">市</option>
                </select>
                <small class="error" style="display: none;">请选择市</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <select class="radius" id="seleAreaFouth">
                    <option value="-1">区/县</option>
                </select>
                <small class="error" style="display: none;">请选择区/县</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <textarea class="radius" placeholder="地址" name="ShortAddressInfo" id="ShortAddressInfo"></textarea>
                <small class="error" style="display: none;">请填写地址</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <textarea class="radius" placeholder="主营业务" name="Business" id="Textarea2"></textarea>
                <small class="error" style="display: none;">请填写主营业务</small>
            </div>
        </div>
        <div class="row">
            <div class="large-12 columns">
                <h4>相册</h4>
                <h6 class="subheader">建议尺寸120px*120px，支付.jpg、.gif格式，大小不超过2M</h6>
                <!--pic begin-->
                <div class="uppic">
                    <ul class="uppic-ul">
                        <li>
                            <div id="uploader-demo02">
                                <!--用来存放item-->
                                <div id="fileList02" class="uploader-list"></div>
                                <div id="filePicker02">上传图片</div>
                            </div>
                        </li>
                        <li class="middle">
                            <div id="uploader-demo03">
                                <!--用来存放item-->
                                <div id="fileList03" class="uploader-list"></div>
                                <div id="filePicker03">上传图片</div>
                            </div>
                        </li>
                        <li>
                            <div id="uploader-demo04">
                                <!--用来存放item-->
                                <div id="fileList04" class="uploader-list"></div>
                                <div id="filePicker04">上传图片</div>
                            </div>
                        </li>

                    </ul>
                </div>
                <!--pic end-->
            </div>
        </div>



        <%} %>
    </form>
    <script src="../../member/Js/ajaxFileUpload.js" type="text/javascript"></script>
    <script type="text/javascript">

        $("#file_upload").on("change", function () {
            var oFile = this.files[0],
                sName,
                sFileType = oFile.type;
            // Android下读不到type信息，从文件名中解析
            if (!sFileType) {
                sFileType = "image/" + sName.split(".").pop().toLowerCase();

            }
            // 读取文件大小、修改时间等信息
            var oUploadInfo = {
                name: oFile.name || oFile.fileName,
                size: oFile.size || oFile.fileSize,
                modTime: oFile.lastModifiedDate.valueOf(),
                blob: oFile,
                img: null
            };
            // 使用FileReader读取
            var oReader = new FileReader();
            oReader.onload = function (e) {
                var sBase64 = e.target.result;
                // 部分Android下base64字符串格式不完整
                if (window.gIsAndroid && sBase64.indexOf("data:image/") != 0) {
                    var sMime = sName.split(".").pop().toLowerCase();
                    sBase64 = sBase64.replace("base64,", "image/" + sMime + ";base64,");
                }
                //oImg.src = sBase64;;
                //sBase64 = null;
                //具体上传逻辑，视具体服务器端接口而定
                $.ajax({
                    url: "../member/ajax/LoginHandle.aspx",
                    data: { "action": "privateuploadimage", "imgbest64": sBase64 },
                    type: "post",
                    async: false,
                    cache: false,
                    success: function (res) {
                        var reg = /\.[a-z]{3,4}/g;
                        if (reg.test(res)) {
                            $("#file_upload_img").attr("src", "../../UploadFile/UserImage/" + res);
                            $("#HeadUrl").val(res);

                        } else {
                            //                        alert(res);
                            ShowMsg("上传失败,请稍候重试");
                            return;
                        }
                    },
                    error: function () //服务器响应失败处理函数
                    {
                        ShowMsg("提交过程中出现未知错误");
                    }

                })
            }
            oReader.readAsDataURL(oFile);
        })

        $("#image1_file").on("change", function () {
            var oFile = this.files[0],
                sName,
                sFileType = oFile.type;
            // Android下读不到type信息，从文件名中解析
            if (!sFileType) {
                sFileType = "image/" + sName.split(".").pop().toLowerCase();

            }
            // 读取文件大小、修改时间等信息
            var oUploadInfo = {
                name: oFile.name || oFile.fileName,
                size: oFile.size || oFile.fileSize,
                modTime: oFile.lastModifiedDate.valueOf(),
                blob: oFile,
                img: null
            };
            // 使用FileReader读取
            var oReader = new FileReader();
            oReader.onload = function (e) {
                var sBase64 = e.target.result;
                // 部分Android下base64字符串格式不完整
                if (window.gIsAndroid && sBase64.indexOf("data:image/") != 0) {
                    var sMime = sName.split(".").pop().toLowerCase();
                    sBase64 = sBase64.replace("base64,", "image/" + sMime + ";base64,");
                }
                //oImg.src = sBase64;;
                //sBase64 = null;
                //具体上传逻辑，视具体服务器端接口而定
                $.ajax({
                    url: "../member/ajax/LoginHandle.aspx",
                    data: { "action": "privateuploadimage", "imgbest64": sBase64 },
                    type: "post",
                    async: false,
                    cache: false,
                    success: function (res) //服务器成功响应处理函数
                    {
                        var reg = /\.[a-z]{3,4}/g;
                        if (reg.test(res)) {
                            $("#imgurl1").attr("src", "../../UploadFile/UserImage/" + res);
                            $("#Image1").val(res);
                        } else {
                            //                        alert(res);
                            ShowMsg("上传失败,请稍候重试");
                            return;
                        }
                    },
                    error: function () //服务器响应失败处理函数
                    {
                        ShowMsg("提交过程中出现未知错误");
                    }

                })
            }
            oReader.readAsDataURL(oFile);
        })
        $("#image2_file").on("change", function () {
            var oFile = this.files[0],
                sName,
                sFileType = oFile.type;
            // Android下读不到type信息，从文件名中解析
            if (!sFileType) {
                sFileType = "image/" + sName.split(".").pop().toLowerCase();

            }
            // 读取文件大小、修改时间等信息
            var oUploadInfo = {
                name: oFile.name || oFile.fileName,
                size: oFile.size || oFile.fileSize,
                modTime: oFile.lastModifiedDate.valueOf(),
                blob: oFile,
                img: null
            };
            // 使用FileReader读取
            var oReader = new FileReader();
            oReader.onload = function (e) {
                var sBase64 = e.target.result;
                // 部分Android下base64字符串格式不完整
                if (window.gIsAndroid && sBase64.indexOf("data:image/") != 0) {
                    var sMime = sName.split(".").pop().toLowerCase();
                    sBase64 = sBase64.replace("base64,", "image/" + sMime + ";base64,");
                }
                //oImg.src = sBase64;;
                //sBase64 = null;
                //具体上传逻辑，视具体服务器端接口而定
                $.ajax({
                    url: "../member/ajax/LoginHandle.aspx",
                    data: { "action": "privateuploadimage", "imgbest64": sBase64 },
                    type: "post",
                    async: false,
                    cache: false,
                    success: function (res) //服务器成功响应处理函数
                    {
                        var reg = /\.[a-z]{3,4}/g;
                        if (reg.test(res)) {
                            $("#imgurl2").attr("src", "../../UploadFile/UserImage/" + res);
                            $("#Image2").val(res);
                        } else {
                            //                        alert(res);
                            ShowMsg("上传失败,请稍候重试");
                            return;
                        }
                    },
                    error: function () //服务器响应失败处理函数
                    {
                        ShowMsg("提交过程中出现未知错误");
                    }

                })
            }
            oReader.readAsDataURL(oFile);
        })
        $("#image3_file").on("change", function () {
            var oFile = this.files[0],
                sName,
                sFileType = oFile.type;
            // Android下读不到type信息，从文件名中解析
            if (!sFileType) {
                sFileType = "image/" + sName.split(".").pop().toLowerCase();

            }
            // 读取文件大小、修改时间等信息
            var oUploadInfo = {
                name: oFile.name || oFile.fileName,
                size: oFile.size || oFile.fileSize,
                modTime: oFile.lastModifiedDate.valueOf(),
                blob: oFile,
                img: null
            };
            // 使用FileReader读取
            var oReader = new FileReader();
            oReader.onload = function (e) {
                var sBase64 = e.target.result;
                // 部分Android下base64字符串格式不完整
                if (window.gIsAndroid && sBase64.indexOf("data:image/") != 0) {
                    var sMime = sName.split(".").pop().toLowerCase();
                    sBase64 = sBase64.replace("base64,", "image/" + sMime + ";base64,");
                }
                //oImg.src = sBase64;;
                //sBase64 = null;
                //具体上传逻辑，视具体服务器端接口而定
                $.ajax({
                    url: "../member/ajax/LoginHandle.aspx",
                    data: { "action": "privateuploadimage", "imgbest64": sBase64 },
                    type: "post",
                    async: false,
                    cache: false,
                    success: function (res) //服务器成功响应处理函数
                    {
                        var reg = /\.[a-z]{3,4}/g;
                        if (reg.test(res)) {
                            $("#imgurl3").attr("src", "../../UploadFile/UserImage/" + res);
                            $("#Image3").val(res);
                        } else {
                            //                        alert(res);
                            ShowMsg("上传失败,请稍候重试");
                            return;
                        }
                    },
                    error: function () //服务器响应失败处理函数
                    {
                        ShowMsg("提交过程中出现未知错误");
                    }

                })
            }
            oReader.readAsDataURL(oFile);
        })




    </script>


    <!--form end-->
    <script type="text/javascript">
        function btnSave() {
            $("small").hide();
            var name = $("#Name").val().trim();
            if (name == "") {
                ShowMsg("请填写姓名");
                //  $("#Name").next().show();
                return false;
            }
            var MPhoneNo = $("#MPhoneNo").val().trim();

            if (MPhoneNo == "") {
                // $("#MPhoneNo").next().text("手机号码不能为空");
                // $("#MPhoneNo").next().show();
                ShowMsg("手机号码不能为空");
                return false;
            }
            //手机11位
            reg = /^\d{11}$/;
            if (!reg.test(MPhoneNo)) {
                ShowMsg("手机号码格式不正确");
                $("#MPhoneNo").focus();

                //$("#MPhoneNo").next().text("手机号码格式不正确");
                //$("#MPhoneNo").next().show();
                return false;
            }

            if ($("#seleAreaFouth").val() != "-1" && $("#seleAreaFouth").val() != "" && $("#seleAreaFouth").val() != null) {
                var addressinfo = $("#seleAreaNext").find("option:selected").text() + $("#seleAreaThird").find("option:selected").text() + $("#seleAreaFouth").find("option:selected").text() + $("#ShortAddressInfo").val();
                $("#AddressInfo").val(addressinfo);
                var AreaCode = "1," + $("#seleAreaNext").val() + "," + $("#seleAreaThird").val() + "," + $("#seleAreaFouth").val();
                $("#AreaCode").val(AreaCode);
            }
            $("#cardForm").submit();
        }

        function imgerror(obj) {
            $(obj).attr("src", "../../member/images/none-pic.png");
        }


    </script>
</body>
</html>


