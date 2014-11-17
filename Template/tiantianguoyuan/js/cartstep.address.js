var ffAlertTxt = "含有非法字符！";
var currentItem = "";
//加载购物车列表
$(document).ready(function () {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=getCurrentAddr",
        success: function (data) {
            if (data != null) {
                if (data.CurrentAddr == "") {
                    $("#closeAddress").show();
                    //ShowAddOrEditDiv();
                    $("#addressTitle").hide();
                    $("#btnSaveAddress").hide();
                    //showAddrList();
                    $("#NoAddress").show();
                }
                else {
                    $("#NoAddress").hide();
                    var addrItemHTML = $("#ShowAddress").html();
                    var NewAddrItemHTML = "";

                    currentItem = data.CurrentAddr[0]; //json 购物项
                    $("#AddressID").val(currentItem.ID);
                    addrItemHTML = addrItemHTML.replace("$AddrID", currentItem.ID);
                    addrItemHTML = addrItemHTML.replace("$AddrName", currentItem.Name);

                    addrItemHTML = addrItemHTML.replace("$AddressInfo", currentItem.AddressInfo);
                    addrItemHTML = addrItemHTML.replace("$AddrPostCode", currentItem.PostCode);
                    addrItemHTML = addrItemHTML.replace("$AddrMoblie", currentItem.Moblie);
                    addrItemHTML = addrItemHTML.replace("$AddrTel", currentItem.Tel);
                    if (currentItem.feeprice != "") {
                        $("#feeprice").text(currentItem.feeprice);
                        $("#OrderFormMoney").html((parseFloat($("#LabelNewMoney").html()) + parseFloat($("#feeprice").html())).toFixed(2))
                    }
                    $("#AddressShow").html(addrItemHTML);
                    $("#Consignee_Hidden_Type").val("0");
                }
            }
            else {
                $("#closeAddress").show();
                //ShowAddOrEditDiv();
                $("#addressTitle").hide();
                $("#NoAddress").show();
            }
        }
    });
});

//删除
function ShowDeleteConfirmDiv(obj) {
    if (confirm('确定删除吗？')) {
        $.ajax({
            dataType: "json",
            type: "POST",
            cache: false,
            data: "act=delAddr&addrid=" + obj,
            url: path + "cartstep.aspx",
            success: function (data) {
                if (data.errCode == "0") {
                    $("#dizhi_list" + obj).remove();
                    ShowAddOrEditDiv();
                } else {
                    alert(data.errMessage);
                }
            }
        });
    }
}

//添加地址或编辑
//function ShowAddOrEditDiv(obj) {
//    if (obj != null) {
//        $.ajax({
//            type: "POST",
//            dataType: "json",
//            url: path + "cartstep.aspx",
//            data: "act=getCurrentAddr&addrid=" + obj,
//            success: function (data) {
//                if (data != null) {
//                    if (data.CurrentAddr == "") {
//                        $("#closeAddress").show();
//                        ShowAddOrEditDiv();
//                        $("#addressTitle").hide();
//                        showAddrList();
//                    }
//                    else {
//                        var addrItemHTML = $("#ShowAddress").html();
//                        var NewAddrItemHTML = "";
//                        var currentItem = "";
//                        currentItem = data.CurrentAddr[0]; //json 购物项

//                        addrItemHTML = addrItemHTML.replace("$AddrID", currentItem.ID);
//                        addrItemHTML = addrItemHTML.replace("$AddrName", currentItem.Name);

//                        addrItemHTML = addrItemHTML.replace("$AddressInfo", currentItem.AddressInfo);
//                        addrItemHTML = addrItemHTML.replace("$AddrPostCode", currentItem.PostCode);
//                        addrItemHTML = addrItemHTML.replace("$AddrMoblie", currentItem.Moblie);
//                        addrItemHTML = addrItemHTML.replace("$AddrTel", currentItem.Tel);
//                        $("#AddressShow").html(addrItemHTML);
//                        $("#Consignee_Hidden_Type").val("0");
//                    }
//                }
//                else {
//                    $("#closeAddress").show();
//                    ShowAddOrEditDiv();
//                    $("#addressTitle").hide();
//                }
//            }
//        });
//    } else {
//        Show_Consignee(data);
//    }
//}

//添加地址或编辑
function ShowAddOrEditDiv(obj) {
    if (obj == null) {
        $("#addNew").attr("checked", true);
        $("#isEditOrAdd").val("Added");
        $("#AddressID").val("");
        var addrItemHTML = $("#EditAddress").html();
        var currentItem = "";
        var NewAddrItemHTML = "";
        addrItemHTML = addrItemHTML.replace("$NewName", "<input id=\"receiverName\" type=\"text\" value=\"请准确填写真实姓名\" style=\"width: 117px;\" onfocus=\"ChangeAddressInputCss('receiverName','请准确填写真实姓名',1)\" onblur=\"ChangeAddressInputCss('receiverName','请准确填写真实姓名',2);ChecktheForm_Name();\" name=\"receiverName\" maxlength=\"20\" />");
        addrItemHTML = addrItemHTML.replace("$ReceiverNameError", "<span id=\"receiverNameError\" class=\"addressEdit\"></span>");
        var NationHTML = "";

        $.ajax({
            type: "POST",
            dataType: "json",
            url: path + "cartstep.aspx",
            data: "areaId=0&level=1&act=getAreaList",
            success: function (data) {
                //初始化地区数据
                NationHTML += "<select name='area_nation' id='area_nation' onchange='changeNation(this)'>";
                NationHTML += "<option value='-1'>请选择</option>";
                if (data != null) {
                    //$(data.AreaItem).each(function (index) {
                    var NationItem = data.AreaItem[0];
                    NationHTML += "<option value='" + NationItem.ID + "'>" + NationItem.Name + "</option>";
                    //});
                }
                NationHTML += "</select>";
                addrItemHTML = addrItemHTML.replace("$NewNation", NationHTML);
                addrItemHTML = addrItemHTML.replace("$NewProvince", "<select id=\"area_province\" name=\"area_province\" onblur=\"\" onchange=\"changeProvince(this);\"><option value=\"-1\">请选择</option></select>");
                addrItemHTML = addrItemHTML.replace("$NewCity", "<select id=\"area_city\" name=\"area_city\" onblur=\"\" onchange=\"changeCity(this);\"><option value=\"-1\">请选择</option></select>");
                addrItemHTML = addrItemHTML.replace("$NewCounty", "<select id=\"area_county\" name=\"area_county\" onblur=\"\" onchange=\"changeCounty(this);\"><option value=\"-1\">请选择</option></select>");

                addrItemHTML = addrItemHTML.replace("$NationError", "<span id=\"nationError\" class=\"addressEdit\" style=\"margin-left: 0pt; margin-top: 2px;\">请选择国家</span>");
                addrItemHTML = addrItemHTML.replace("$ProvinceError", "<span id=\"provinceError\" class=\"addressEdit\" style=\"margin-left: 0pt; margin-top: 2px;\">请选择省份</span>");
                addrItemHTML = addrItemHTML.replace("$CityError", "<span id=\"cityError\" class=\"addressEdit\" style=\"margin-left: 0px; margin-top: 2px;\">请选择市</span>");
                addrItemHTML = addrItemHTML.replace("$AreaError", "<span id=\"areaError\" class=\"addressEdit\" style=\"margin-left: 0px; margin-top: 2px;\">请选择县/区</span>");

                addrItemHTML = addrItemHTML.replace("$HeadNation", "<span id=\"AddressHeadNation\" class=\"hei\"></span>");
                addrItemHTML = addrItemHTML.replace("$HeadProvince", "<span id=\"AddressHeadProvince\" class=\"hei\"></span>");
                addrItemHTML = addrItemHTML.replace("$HeadCity", "<span id=\"AddressHeadCity\" class=\"hei\"></span>");
                addrItemHTML = addrItemHTML.replace("$HeadCounty", "<span id=\"AddressHeadArea\" class=\"hei\"></span>");

                addrItemHTML = addrItemHTML.replace("$NewAddress", "<input id=\"detailAddress\" type=\"text\" value=\"请填写详细路名及门牌号\" style=\"width: 310px;\" onfocus=\"ChangeAddressInputCss('detailAddress','请填写详细路名及门牌号',1)\" onblur=\"ChangeAddressInputCss('detailAddress','请填写详细路名及门牌号',2);ChecktheForm_Address();\" name=\"detailAddress\" maxlength=\"100\" />");
                addrItemHTML = addrItemHTML.replace("$NewPostCode", "<input id=\"postalCode\" type=\"text\" value=\"\" style=\"width: 94px;\" onfocus=\"ChangeAddressInputCss('postalCode','',1)\" onblur=\"ChangeAddressInputCss('postalCode','',2);ChecktheForm_Zip();\" name=\"postalCode\" maxlength=\"6\" />");
                addrItemHTML = addrItemHTML.replace("$NewMobile", "<input id=\"mobile\"  onfocus=\"ChangeAddressInputCss('mobile','',1)\"  onblur=\"ChangeAddressInputCss('mobile','',2);\" type=\"text\" value=\"\" style=\"width: 142px;\" name=\"mobile\" maxlength=\"11\" />");
                addrItemHTML = addrItemHTML.replace("$NewPhone", "<input id=\"phone\"  onfocus=\"ChangeAddressInputCss('phone','',1)\" onblur=\"ChangeAddressInputCss('phone','',2);\"   type=\"text\" value=\"\" style=\"width: 142px;\" name=\"phone\" maxlength=\"20\" />");

                addrItemHTML = addrItemHTML.replace("$DetailAddressError", "<span id=\"detailAddressError\" class=\"addressEdit\">请填写详细地址</span>");
                addrItemHTML = addrItemHTML.replace("$PostalCodeError", "<span id=\"postalCodeError\" class=\"addressEdit\">请填写邮政编码</span>");
                addrItemHTML = addrItemHTML.replace("$MoblieError", "<span id=\"mobileError\" class=\"addressEdit\">请填写手机</span>");
                addrItemHTML = addrItemHTML.replace("$PhoneError", "<span id=\"phoneError\" class=\"addressEdit\">请填写座机</span>");

                $("#AddAddress").html(addrItemHTML);
                $("#AddAddress").show();
                $("#Consignee_Hidden_Type").val("1");
            }
        });
    }
    else {
        $("#AddressID").val(obj);
        $("#AddAddress").hide();
        $("#readio_" + obj + "").attr("checked", true);
        $("#isEditOrAdd").val("Edited");
        $.ajax({
            type: "POST",
            dataType: "json",
            url: path + "cartstep.aspx",
            data: "act=getCurrentAddr&addrid=" + obj + "",
            success: function (data) {
                if (data != null) {
                    var addrItemHTML = $("#ShowAddress").html();
                    var NewAddrItemHTML = "";

                    currentItem = data.CurrentAddr[0]; //json 购物项
                    $("#AddressID").val(currentItem.ID);
                    addrItemHTML = addrItemHTML.replace("$AddrID", currentItem.ID);
                    addrItemHTML = addrItemHTML.replace("$AddrName", currentItem.Name);
                    addrItemHTML = addrItemHTML.replace("$AddressInfo", currentItem.AddressInfo);
                    addrItemHTML = addrItemHTML.replace("$AddrPostCode", currentItem.PostCode);
                    addrItemHTML = addrItemHTML.replace("$AddrMoblie", currentItem.Moblie);
                    addrItemHTML = addrItemHTML.replace("$AddrTel", currentItem.Tel);
                    if (currentItem.feeprice != "") {
                        $("#feeprice").text(currentItem.feeprice);
                        $("#OrderFormMoney").html((parseFloat($("#LabelNewMoney").html()) + parseFloat($("#feeprice").html())).toFixed(2))
                    }
                    $("#AddressShow").html(addrItemHTML);
                    $("#AddressShow").show();
                    $("#closeAddress").hide();
                }
            }
        });
    }
}



function Show_Consignee(data) {
    var currentaddrItem = data.CurrentAddr[0];
    var addrItemHTML = $("#EditAddress").html();
    var NewAddrItemHTML = "";
    var currentItem = "";
    addrItemHTML = addrItemHTML.replace("$NewName", "<input id=\"receiverName\" type=\"text\" value=\"" + currentaddrItem.Name + "\" style=\"width: 117px; color: rgb(0, 0, 0);\" onfocus=\"ChangeAddressInputCss('receiverName','',1)\" onblur=\"ChangeAddressInputCss('receiverName','',2);ChecktheForm_Name();\" name=\"receiverName\" maxlength=\"20\" />");
    addrItemHTML = addrItemHTML.replace("$ReceiverNameError", "<span id=\"receiverNameError\" class=\"addressEdit\"></span>");
    var NationHTML = "";
    var ProvinceHTML = "";
    var CityHTML = "";
    var CountyHTML = "";

    var arr = currentaddrItem.AreaCode.split(',');
    var chk = "selected";
    //初始化地区数据
    NationHTML += "<select name='area_nation' id='area_nation' onchange='changeNation(this)'>\n";
    NationHTML += "<option value='-1'>请选择</option>\n";

    if (arr[0] != "-1") {
        $(data.Nation).each(function (index) {
            var NationItem = data.Nation[index];
            NationHTML += "<option value='" + NationItem.ID + "' " + (arr[0] == NationItem.ID ? chk : "") + " >" + NationItem.Name + "</option>\n";
        });
    }
    NationHTML += "</select>\n";

    ProvinceHTML += "<select name='area_province' id='area_province' onchange='changeProvince(this)' " + (arr[1] == "-1" ? "style='display:none'" : "") + ">\n";
    ProvinceHTML += "<option value='-1'>请选择</option>\n";

    if (arr[1] != "-1") {
        $(data.Province).each(function (index) {
            var ProvinceItem = data.Province[index];
            ProvinceHTML += "<option value='" + ProvinceItem.ID + "' " + (arr[1] == ProvinceItem.ID ? chk : "") + " >" + ProvinceItem.Name + "</option>\n";
        });
    }
    ProvinceHTML += "</select>\n";
    //CityHTML += "<select name='area_city' id='area_city' onchange='changeCity(this)' " + (arr[2] == "-1" ? "style='display:none'" : "") + ">\n";
    CityHTML += "<select name='area_city' id='area_city' onchange='changeCity(this)'>\n";
    CityHTML += "<option value='-1'>请选择</option>\n";

    //if (arr[2] != "-1") {
    $(data.City).each(function (index) {
        var CityItem = data.City[index];
        CityHTML += "<option value='" + CityItem.ID + "' " + (arr[2] == CityItem.ID ? chk : "") + " >" + CityItem.Name + "</option>\n";
    });
    //}
    CityHTML += "</select>\n";
    //CountyHTML += "<select name='area_county' id='area_county' onchange='changeCounty(this)' " + (arr[3] == "-1" ? "style='display:none'" : "") + ">\n";
    CountyHTML += "<select name='area_county' id='area_county' onchange='changeCounty(this)'>\n"; //县区没有选择也给显示出来
    CountyHTML += "<option value='-1'>请选择</option>\n";

    //    if (arr[3] != "-1") {
    $(data.County).each(function (index) {
        var CountyItem = data.County[index];
        CountyHTML += "<option value='" + CountyItem.ID + "' " + (arr[3] == CountyItem.ID ? chk : "") + " >" + CountyItem.Name + "</option>\n";
    });
    //    }
    CountyHTML += "</select>\n";

    addrItemHTML = addrItemHTML.replace("$NationError", "<span id=\"nationError\" class=\"addressEdit\" style=\"margin-left: 0pt; margin-top: 2px;\">请选择国家</span>");
    addrItemHTML = addrItemHTML.replace("$ProvinceError", "<span id=\"provinceError\" class=\"addressEdit\" style=\"margin-left: 0pt; margin-top: 2px;\">请选择省份</span>");
    addrItemHTML = addrItemHTML.replace("$CityError", "<span id=\"cityError\" class=\"addressEdit\" style=\"margin-left: 0px; margin-top: 2px;\">请选择市</span>");
    addrItemHTML = addrItemHTML.replace("$AreaError", "<span id=\"areaError\" class=\"addressEdit\" style=\"margin-left: 0px; margin-top: 2px;\">请选择县/区</span>");

    addrItemHTML = addrItemHTML.replace("$NewNation", NationHTML);
    addrItemHTML = addrItemHTML.replace("$NewProvince", ProvinceHTML);
    addrItemHTML = addrItemHTML.replace("$NewCity", CityHTML);
    addrItemHTML = addrItemHTML.replace("$NewCounty", CountyHTML);

    addrItemHTML = addrItemHTML.replace("$HeadNation", "<span id=\"AddressHeadNation\" class=\"hei\">" + currentaddrItem.NationName + "</span>");
    addrItemHTML = addrItemHTML.replace("$HeadProvince", "<span id=\"AddressHeadProvince\" class=\"hei\">" + currentaddrItem.ProvinceName + "</span>");
    addrItemHTML = addrItemHTML.replace("$HeadCity", "<span id=\"AddressHeadCity\" class=\"hei\">" + currentaddrItem.CityName + "</span>");
    addrItemHTML = addrItemHTML.replace("$HeadCounty", "<span id=\"AddressHeadArea\" class=\"hei\">" + currentaddrItem.CountyName + "</span>");

    addrItemHTML = addrItemHTML.replace("$NewAddress", "<input id=\"detailAddress\" type=\"text\" value=\"" + currentaddrItem.AddressInfo + "\" style=\"width: 310px; color: rgb(0, 0, 0);\" onfocus=\"ChangeAddressInputCss('detailAddress','',1)\" onblur=\"ChangeAddressInputCss('detailAddress','',2);ChecktheForm_Address();\" name=\"detailAddress\" maxlength=\"100\" />");
    addrItemHTML = addrItemHTML.replace("$NewPostCode", "<input id=\"postalCode\" type=\"text\" value=\"" + currentaddrItem.PostCode + "\" style=\"width: 94px; color: rgb(0, 0, 0);\" onfocus=\"ChangeAddressInputCss('postalCode','',1)\" onblur=\"ChangeAddressInputCss('postalCode','',2);ChecktheForm_Zip();\" name=\"postalCode\" maxlength=\"6\" />");
    addrItemHTML = addrItemHTML.replace("$NewMobile", "<input id=\"mobile\"  onfocus=\"ChangeAddressInputCss('mobile','',1)\"  onblur=\"ChangeAddressInputCss('mobile','',2);\" type=\"text\" value=\"" + currentaddrItem.Moblie + "\" style=\"width: 142px; color: rgb(0, 0, 0);\" name=\"mobile\" maxlength=\"11\" />");
    addrItemHTML = addrItemHTML.replace("$NewPhone", "<input id=\"phone\"  onfocus=\"ChangeAddressInputCss('phone','',1)\" onblur=\"ChangeAddressInputCss('phone','',2);\"   type=\"text\" value=\"" + currentaddrItem.Tel + "\" style=\"width: 142px; color: rgb(0, 0, 0);\" name=\"phone\" maxlength=\"20\" />");

    addrItemHTML = addrItemHTML.replace("$DetailAddressError", "<span id=\"detailAddressError\" class=\"addressEdit\">请填写详细地址</span>");
    addrItemHTML = addrItemHTML.replace("$PostalCodeError", "<span id=\"postalCodeError\" class=\"addressEdit\">请填写邮政编码</span>");
    addrItemHTML = addrItemHTML.replace("$MoblieError", "<span id=\"mobileError\" class=\"addressEdit\">请填写手机</span>");
    addrItemHTML = addrItemHTML.replace("$PhoneError", "<span id=\"phoneError\" class=\"addressEdit\">请填写座机</span>");

    $("#AddAddress").html(addrItemHTML);

}

var OldConsignee = "";
//编辑收货人信息
function Edit_Consignee(obj) {
    $("#isEditOrAdd").val("Showed");
    OldConsignee = g("AddressShow").innerHTML;
    g('Consignee_Hidden_Type').value = 1; //设置隐藏编辑状态为打开
    $("#AddressShow").hide();
    $("#closeAddress").show();
    $("#EditAddress").hide();
    showAddrList(obj);
}

//关闭编辑收货人信息
function closeForm_Address() {
    $("#AddressShow").html(OldConsignee);
    $("#AddressShow").show();
    $("#closeAddress").hide();
    $("#EditAddress").show();
}

//常用地址
function changeForm_Address(obj) {
    $("#isEditOrAdd").val("Showed");
    $("#EditAddress").hide();
    $("#AddressID").val(obj);
}

//常用地址
function showAddrList(obj) {
    $("#AddressID").val(obj);
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "act=showAddrlist",
        success: function (data) {
            if (data != "" && data != null) {
                var addrItemHTML = $("#dizhi_list").html();
                var NewAddrItemHTML = "";
                var currentItem = "";
                var index = obj;
                $(data.AddrItem).each(function (index) {
                    currentItem = data.AddrItem[index]; //json 购物项
                    if (obj != null) {
                        if (obj == currentItem.Id) {
                            addrItemHTML = addrItemHTML.replace("$RadioList", "<input id=\"readio_" + currentItem.ID + "\" checked='true' type=\"radio\" value=\"" + currentItem.ID + "\" onclick=\"ShowAddOrEditDiv(" + currentItem.ID + ")\"  name=\"addressRadio\" />");
                        }
                        else {
                            addrItemHTML = addrItemHTML.replace("$RadioList", "<input id=\"readio_" + currentItem.ID + "\" type=\"radio\" value=\"" + currentItem.ID + "\" onclick=\"ShowAddOrEditDiv(" + currentItem.ID + ")\"  name=\"addressRadio\" />");
                        }
                    }
                    else {
                        addrItemHTML = addrItemHTML.replace("$RadioList", "<input id=\"readio_" + currentItem.ID + "\" type=\"radio\" value=\"" + currentItem.ID + "\" onclick=\"ShowAddOrEditDiv(" + currentItem.ID + ")\"  name=\"addressRadio\" />");
                    }

                    addrItemHTML = addrItemHTML.replace("$NameList", currentItem.Remark);
                    addrItemHTML = addrItemHTML.replace("$AddressList", "" + currentItem.Name + " - " + currentItem.AddressInfo + " " + currentItem.PostCode + " " + currentItem.Moblie + " " + currentItem.Tel + "");
                    //                    addrItemHTML = addrItemHTML.replace("$ModifyList", "<a id=\"edit_" + currentItem.ID + "\" class=\"track\" name=\"sp_cart_address_edit\" onclick=\"ShowAddOrEditDiv(" + currentItem.ID + ")\" href=\"javascript:void(0)\" style=\"color: rgb(51, 51, 51);\">编辑</a>");
                    //                    addrItemHTML = addrItemHTML.replace("$DeleList", "<a id=\"cancel_" + currentItem.ID + "\" class=\"track\" name=\"sp_cart_address_delete\" onclick=\"ShowDeleteConfirmDiv(" + currentItem.ID + ")\" href=\"javascript:void(0)\">删除</a>");
                    NewAddrItemHTML += "<tr class=\"dizhi_list\"  id=\"dizhi_list" + currentItem.ID + "\">" + addrItemHTML + "</tr>";
                    addrItemHTML = $("#dizhi_list").html();
                });
                $("#newdizhi_list").html(NewAddrItemHTML);
            }
        }
    });
}








//保存地址信息
function savePart_consignee() {
    var addressID = $("#AddressID").val();
    if (addressID == "") {
        if (!Check_Consignee()) {
            return false;
        }
        var test = $("#AddressHeadNation").html() + $("#AddressHeadProvince").html() + $("#AddressHeadCity").html() + $("#AddressHeadArea").html()

        $.ajax({
            type: "POST",
            dataType: "json",
            url: path + "cartstep.aspx",
            data: "act=saveCurrentAddr&ocName=" + encodeURIComponent(encodeURIComponent(g('receiverName').value)) + "&ocAddress=" + test + encodeURIComponent(encodeURIComponent(g('detailAddress').value)) + "&ocMessage=" + g('mobile').value + "&ocPhone=" + g('phone').value + "&ocPost=" + g('postalCode').value + "&nationId=" + g('area_nation').value + "&provinceId=" + g('area_province').value + "&cityId=" + g('area_city').value + "&countyId=" + g('area_county').value + "",
            success: function (txt) {
                if (txt != null) {
                    if (txt.CurrentAddr[0] != null) {

                        var addrItemHTML = $("#ShowAddress").html();
                        var NewAddrItemHTML = "";
                        var currentItem = "";
                        currentItem = txt.CurrentAddr[0]; //json 购物项

                        addrItemHTML = addrItemHTML.replace("$AddrID", currentItem.ID);
                        addrItemHTML = addrItemHTML.replace("$AddrName", currentItem.Name);

                        addrItemHTML = addrItemHTML.replace("$AddrNationName", currentItem.NationName);
                        addrItemHTML = addrItemHTML.replace("$AddrProvinceName", currentItem.ProvinceName);
                        addrItemHTML = addrItemHTML.replace("$AddrCityName", currentItem.CityName);
                        addrItemHTML = addrItemHTML.replace("$AddrCountyName", currentItem.CountyName);

                        addrItemHTML = addrItemHTML.replace("$AddressInfo", currentItem.AddressInfo);
                        addrItemHTML = addrItemHTML.replace("$AddrPostCode", currentItem.PostCode);
                        addrItemHTML = addrItemHTML.replace("$AddrMoblie", currentItem.Moblie);
                        addrItemHTML = addrItemHTML.replace("$AddrTel", currentItem.Tel);
                        $("#AddressID").val(currentItem.ID);
                        $("#AddressShow").html(addrItemHTML);
                        if (currentItem.feeprice != "") {
                            $("#feeprice").text(currentItem.feeprice);
                            $("#OrderFormMoney").html((parseFloat($("#LabelNewMoney").html()) + parseFloat($("#feeprice").html())).toFixed(2))
                        }
                        g('Consignee_Hidden_Type').value = 0; //设置隐藏编辑状态为关闭
                        $("#AddressShow").show();
                        $("#closeAddress").hide();
                        $("#EditAddress").show();

                        //配送方式
                        //showForm_Dly(currentItem.AreaName);
                    }
                }
            },
            error: function (txt) {
                if (txt.responseText.indexOf("error_") > -1) {
                    alert(txt.responseText.substr(6));
                    return;
                }
            }
        });
    }
    else {
        //        if (!Check_Consignee()) {
        //            return false;
        //        }
        //        $.ajax({
        //            type: "POST",
        //            dataType: "json",
        //            url: path + "cartstep.aspx",
        //            data: "act=saveCurrentAddr&ocName=" + encodeURIComponent(encodeURIComponent(g('receiverName').value)) + "&ocAddress=" + encodeURIComponent(encodeURIComponent(g('detailAddress').value)) + "&ocMessage=" + g('mobile').value + "&ocPhone=" + g('phone').value + "&ocPost=" + g('postalCode').value + "&nationId=" + g('area_nation').value + "&provinceId=" + g('area_province').value + "&cityId=" + g('area_city').value + "&countyId=" + g('area_county').value + "&addressid=" + $("#AddressID").val() + "",
        //            success: function (txt) {
        //                if (txt != null) {
        //                    if (txt.CurrentAddr[0] != null) {
        //                        var addrItemHTML = $("#ShowAddress").html();
        //                        var NewAddrItemHTML = "";
        //                        var currentItem = "";
        //                        currentItem = txt.CurrentAddr[0]; //json 购物项

        //                        addrItemHTML = addrItemHTML.replace("$AddrID", currentItem.Id);
        //                        addrItemHTML = addrItemHTML.replace("$AddrName", currentItem.Name);

        //                        addrItemHTML = addrItemHTML.replace("$AddrNationName", currentItem.NationName);
        //                        addrItemHTML = addrItemHTML.replace("$AddrProvinceName", currentItem.ProvinceName);
        //                        addrItemHTML = addrItemHTML.replace("$AddrCityName", currentItem.CityName);
        //                        addrItemHTML = addrItemHTML.replace("$AddrCountyName", currentItem.CountyName);

        //                        addrItemHTML = addrItemHTML.replace("$AddrAddress", currentItem.Address);
        //                        addrItemHTML = addrItemHTML.replace("$AddrPostCode", currentItem.PostCode);
        //                        addrItemHTML = addrItemHTML.replace("$AddrMoblie", currentItem.Moblie);
        //                        addrItemHTML = addrItemHTML.replace("$AddrTel", currentItem.Tel);
        //                        $("#AddressShow").html(addrItemHTML);
        //                        g('Consignee_Hidden_Type').value = 0; //设置隐藏编辑状态为关闭
        //                        $("#AddressShow").show();
        //                        $("#closeAddress").hide();
        //                        $("#EditAddress").show();

        //                        //配送方式
        //                        showForm_Dly(currentItem.AreaName);
        //                    }
        //                }
        //            },
        //            error: function (txt) {
        //                if (txt.responseText.indexOf("error_") > -1) {
        //                    alert(txt.responseText.substr(6));
        //                    return;
        //                }
        //            }
        //        });
    }
}



//保存地址信息
//function savePart_consignee() {
//    var addressID = $("#AddressID").val();
//    var checkid = $("input[name='addressRadio']:checked").val();
//    if (checkid != "") {
//        $("#AddressID").val(checkid);
//    }
//        g('Consignee_Hidden_Type').value = 0; //设置隐藏编辑状态为关闭
//        $("#AddressShow").show();
//        $("#closeAddress").hide();
//        $("#EditAddress").show();
//        return true;
//    }
//        if (!Check_Consignee()) {
//            return false;
//        }
//        $.ajax({
//            type: "POST",
//            dataType: "json",
//            url: path + "cartstep.aspx",
//            data: "act=saveCurrentAddr&ocName=" + encodeURIComponent(encodeURIComponent(g('receiverName').value)) + "&ocAddress=" + encodeURIComponent(encodeURIComponent(g('detailAddress').value)) + "&ocMessage=" + g('mobile').value + "&ocPhone=" + g('phone').value + "&ocPost=" + g('postalCode').value + "&nationId=" + g('area_nation').value + "&provinceId=" + g('area_province').value + "&cityId=" + g('area_city').value + "&countyId=" + g('area_county').value + "",
//            success: function (txt) {
//                if (txt != null) {
//                    if (txt.CurrentAddr[0] != null) {

//                        var addrItemHTML = $("#ShowAddress").html();
//                        var NewAddrItemHTML = "";
//                        var currentItem = "";
//                        currentItem = txt.CurrentAddr[0]; //json 购物项

//                        addrItemHTML = addrItemHTML.replace("$AddrID", currentItem.ID);
//                        addrItemHTML = addrItemHTML.replace("$AddrName", currentItem.Name);

//                        addrItemHTML = addrItemHTML.replace("$AddrNationName", currentItem.NationName);
//                        addrItemHTML = addrItemHTML.replace("$AddrProvinceName", currentItem.ProvinceName);
//                        addrItemHTML = addrItemHTML.replace("$AddrCityName", currentItem.CityName);
//                        addrItemHTML = addrItemHTML.replace("$AddrCountyName", currentItem.CountyName);

//                        addrItemHTML = addrItemHTML.replace("$AddrAddress", currentItem.Address);
//                        addrItemHTML = addrItemHTML.replace("$AddrPostCode", currentItem.PostCode);
//                        addrItemHTML = addrItemHTML.replace("$AddrMoblie", currentItem.Moblie);
//                        addrItemHTML = addrItemHTML.replace("$AddrTel", currentItem.Tel);
//                        $("#AddressShow").html(addrItemHTML);
//                        g('Consignee_Hidden_Type').value = 0; //设置隐藏编辑状态为关闭
//                        $("#AddressShow").show();
//                        $("#closeAddress").hide();
//                        $("#EditAddress").show();

//                        //配送方式
//                        showForm_Dly(currentItem.AreaName);
//                    }
//                }
//            },
//            error: function (txt) {
//                if (txt.responseText.indexOf("error_") > -1) {
//                    alert(txt.responseText.substr(6));
//                    return;
//                }
//            }
//        });
//    }
//    else {
//        if (!Check_Consignee()) {
//            return false;
//        }
//        $.ajax({
//            type: "POST",
//            dataType: "json",
//            url: path + "cartstep.aspx",
//            data: "act=saveCurrentAddr&ocName=" + encodeURIComponent(encodeURIComponent(g('receiverName').value)) + "&ocAddress=" + encodeURIComponent(encodeURIComponent(g('detailAddress').value)) + "&ocMessage=" + g('mobile').value + "&ocPhone=" + g('phone').value + "&ocPost=" + g('postalCode').value + "&nationId=" + g('area_nation').value + "&provinceId=" + g('area_province').value + "&cityId=" + g('area_city').value + "&countyId=" + g('area_county').value + "&addressid=" + $("#AddressID").val() + "",
//            success: function (txt) {
//                if (txt != null) {
//                    if (txt.CurrentAddr[0] != null) {
//                        var addrItemHTML = $("#ShowAddress").html();
//                        var NewAddrItemHTML = "";
//                        var currentItem = "";
//                        currentItem = txt.CurrentAddr[0]; //json 购物项

//                        addrItemHTML = addrItemHTML.replace("$AddrID", currentItem.ID);
//                        addrItemHTML = addrItemHTML.replace("$AddrName", currentItem.Name);

//                        addrItemHTML = addrItemHTML.replace("$AddrNationName", currentItem.NationName);
//                        addrItemHTML = addrItemHTML.replace("$AddrProvinceName", currentItem.ProvinceName);
//                        addrItemHTML = addrItemHTML.replace("$AddrCityName", currentItem.CityName);
//                        addrItemHTML = addrItemHTML.replace("$AddrCountyName", currentItem.CountyName);

//                        addrItemHTML = addrItemHTML.replace("$AddrAddress", currentItem.Address);
//                        addrItemHTML = addrItemHTML.replace("$AddrPostCode", currentItem.PostCode);
//                        addrItemHTML = addrItemHTML.replace("$AddrMoblie", currentItem.Moblie);
//                        addrItemHTML = addrItemHTML.replace("$AddrTel", currentItem.Tel);
//                        $("#AddressShow").html(addrItemHTML);
//                        g('Consignee_Hidden_Type').value = 0; //设置隐藏编辑状态为关闭
//                        $("#AddressShow").show();
//                        $("#closeAddress").hide();
//                        $("#EditAddress").show();

//                        //配送方式
//                        showForm_Dly(currentItem.AreaName);
//                    }
//                }
//            },
//            error: function (txt) {
//                if (txt.responseText.indexOf("error_") > -1) {
//                    alert(txt.responseText.substr(6));
//                    return;
//                }
//            }
//        });



var focusID = "";

function CheckFocus(inputID) {
    if (focusID == "") {
        focusID = inputID;
        var a = document.getElementById(inputID);
        a.focus();
    }
}

function ChecktheForm_Name() {
    var Name = document.getElementById("receiverName");
    if ($.trim(Name.value) == "" || $.trim(Name.value) == "请准确填写真实姓名") {
        $("#receiverNameError").show();
        $("#receiverNameError").html("请填写收货人");
        return false;
    }
    else if (cnLength(Name.value) > 20) {
        $("#receiverNameError").show();
        $("#receiverNameError").html("收货人姓名过长，请您最多输入10个汉字。");
        return false;
    }
    else {
        $("#receiverNameError").hide();
        focusID = "";
    }
    return true;
}

function ChecktheForm_Address() {
    var Address = document.getElementById("detailAddress");
    if ($.trim(Address.value) == "" || $.trim(Address.value) == "请填写详细路名及门牌号") {
        $("#detailAddressError").show();
        $("#detailAddressError").html("").html("请填写详细地址");
        return false;
    }
    else if (cnLength(Address.value) > 100) {
        $("#detailAddressError").show();
        $("#detailAddressError").html("详细地址过长，请您最多输入50个汉字。");
        return false;
    }
    else {
        $("#detailAddressError").hide();
        focusID = "";
    }
    return true;
}

function ChecktheForm_Zip() {

    var isSpecialProv = false;
    if ($("#ProvinceID").find("option:selected").text().indexOf("台湾") > -1) {
        isSpecialProv = true;
    }

    var Zip = document.getElementById("postalCode");
    if ($.trim(Zip.value) == "") {
        $("#postalCodeError").show();
        $("#postalCodeError").html("邮政编码不能为空");
        return false;
    }
    else if (!Check_Meth($.trim(Zip.value))) {
        $("#postalCodeError").show();
        $("#postalCodeError").html("邮政编码只能为数字");
        return false;
    }
    else if (!isSpecialProv && $.trim(Zip.value).length != 6) {
        $("#postalCodeError").show();
        $("#postalCodeError").html("邮政编码必须为6位");
        return false;
    }
    else {
        $("#postalCodeError").hide();
        focusID = "";
    }
    return true;
}

function ChecktheForm_Tel() {
    var province = $("#ProvinceID").find("option:selected").text();
    var isSpecialProv = false;
    if (province.indexOf("香港") > -1 || province.indexOf("澳门") > -1 || province.indexOf("台湾") > -1) {
        isSpecialProv = true;
    }
    var Tel = document.getElementById("phone");
    var Mobile = document.getElementById("mobile");

    //港澳台
    if (!isSpecialProv) {
        if ($.trim(Mobile.value) != "" && $.trim(Mobile.value) != "手机和座机至少填写一个" && $.trim(Mobile.value).length != 11) {
            $("#mobileError").show();
            $("#mobileError").html("手机号码必须11位");
            return false;
        }
        else if ($.trim(Mobile.value) != "" && $.trim(Mobile.value) != "手机和座机至少填写一个" && Check_Mobiles($.trim(Mobile.value)) == false) {
            $("#mobileError").show();
            $("#mobileError").html("请输入正确的手机号码");
            return false;
        }
        else {
            $("#mobileError").hide();
            focusID = "";
        }

        if ($.trim(Tel.value).length > 20) {
            $("#phoneError").show();
            $("#phoneError").html("电话号码过长");
            return false;
        }
        else if ($.trim(Tel.value) != "" && $.trim(Tel.value) != "手机和座机至少填写一个" && Check_Tel($.trim(Tel.value)) == false) {
            $("#phoneError").show();
            $("#phoneError").html("请输入正确的电话号码");
            return false;
        }
        else {
            $("#phoneError").hide();
            focusID = "";
        }
    }
    else {
        if ($.trim(Mobile.value) != "" && $.trim(Mobile.value) != "手机和座机至少填写一个" && $.trim(Mobile.value).length > 11) {
            $("#mobileError").show();
            $("#mobileError").html("手机号码过长");
            return false;
        }

        if ($.trim(Tel.value).length > 20) {
            $("#phoneError").show();
            $("#phoneError").html("电话号码过长");
            return false;
        }
    }

    if (($.trim(Tel.value) == "" && $.trim(Mobile.value) == "")
    || ($.trim(Tel.value) == "" && $.trim(Mobile.value) == "手机和座机至少填写一个")
    || ($.trim(Tel.value) == "手机和座机至少填写一个" && $.trim(Mobile.value) == "")
    || ($.trim(Tel.value) == "手机和座机至少填写一个" && $.trim(Mobile.value) == "手机和座机至少填写一个")
    ) {
        $("#mobileError").show();
        $("#mobileError").html("手机和电话至少有一项必填");
        return false;
    }
    else {
        $("#mobileError").hide();
    }

    return true;
}

function Check_Tel(theForm) {
    return /^((\d{3,4})\-{0,1}){0,1}(\d{7,8})(\-{0,1}\d{1,6}){0,1}$/.test(theForm);
}

function Check_Tel_HongKong(theForm) {
    return /^(0\d{2,3}-)?[2,3]{1}\d{7}(-\d{1,6})?$/.test(theForm);
}

function Check_Mobiles(theForm) {
    return /^((13|15|18|14)+\d{9})$/.test(theForm);
}

function Check_Mobiles_HongKong(theForm) {
    return /^((5|6|9)+\d{7})$/.test(theForm);
}


function Check_Meth(nodevalue) {
    var checkOK = "0123456789";
    var checkStr = $.trim(nodevalue);
    var allValid = true;
    var validGroups = true;
    for (i = 0; i < checkStr.length; i++) {
        ch = checkStr.charAt(i);
        for (j = 0; j < checkOK.length; j++) {
            if (ch == checkOK.charAt(j))
                break;
            if (j == (checkOK.length - 1)) {
                allValid = false;
                break;
            }
        }
    }
    return allValid;
}


function Form_Check_ProductArea() {
    if (!CheckNation()) return false;
    if (!CheckProvince()) return false;
    if (!CheckCity()) return false;
    //    if (!CheckArea()) return false; //判断 请选择县/区 注释暂不用到
    return true;
}

function Check_Consignee() {
    if (!ChecktheForm_Name()) return false;
    if (!Form_Check_ProductArea()) return false;
    if (!ChecktheForm_Address()) return false;
    if (!ChecktheForm_Zip()) return false;
    if (!ChecktheForm_Tel()) return false;
    return true;
}

function CheckNation() {
    var nationChoosed = $("#area_nation").val();
    if (nationChoosed == "0" || nationChoosed == "" || nationChoosed == "-1") {
        $("#nationError").show();
        RegionLinkage.showAddressHead('AddressHeadNation', "");
        RegionLinkage.showAddressHead('AddressHeadProvince', "");
        RegionLinkage.showAddressHead('AddressHeadCity', "");
        RegionLinkage.showAddressHead("AddressHeadArea", "");
        return (false);
    }
    else {
        $("#nationError").hide();
    }
    return (true);
};


function CheckProvince() {
    var provinceChoosed = $("#area_province").val();
    if (provinceChoosed == "0" || provinceChoosed == "" || provinceChoosed == "-1") {
        $("#provinceError").show();
        RegionLinkage.showAddressHead('AddressHeadProvince', "");
        RegionLinkage.showAddressHead('AddressHeadCity', "");
        RegionLinkage.showAddressHead("AddressHeadArea", "");
        return (false);
    }
    else {
        $("#provinceError").hide();
    }
    return (true);
};

function CheckCity() {
    var cityChoosed = $("#area_city").val();
    if (cityChoosed == "0" || cityChoosed == "" || cityChoosed == "-1") {
        $("#cityError").show();
        //RegionLinkage.showAddressHead('AddressHeadCity', "");
        //RegionLinkage.showAddressHead("AddressHeadArea", "");
        return (false);
    }
    else {
        $("#cityError").hide();
    }
    return (true);
};

function CheckArea() {
    var areaChoosed = $("#area_county").val();
    if (areaChoosed == "0" || areaChoosed == "" || areaChoosed == "-1") {
        $("#areaError").show();
        RegionLinkage.showAddressHead("AddressHeadArea", "");
        return (false);
    }
    else {
        $("#areaError").hide();
    }
    return (true);
};

//添加或修改送货地址是，点击每个对话框，转换Css样式
//status = 1 点击状态
//status = 2 失去焦点
function ChangeAddressInputCss(inputID, defaultValue, status) {
    if (status == 1) {
        var currentValue = $("#" + inputID).val();
        if (currentValue == defaultValue) {
            $("#" + inputID).val("");
            $("#" + inputID).css("color", "#000000");
        }
    }

    if (status == 2) {
        var currentValue = $("#" + inputID).val();
        if (currentValue == "") {
            $("#" + inputID).val(defaultValue);
            $("#" + inputID).css("color", "#999999");
        }
        else {
            $("#" + inputID).css("color", "#000000");
        }
    }
}

//返回字符串字节数
function cnLength(Str) {
    var escStr = escape(Str);
    var numI = 0;
    var escStrlen = escStr.length;
    for (i = 0; i < escStrlen; i++)
        if (escStr.charAt(i) == '%')
            if (escStr.charAt(++i) == 'u')
                numI++;
    return Str.length + numI;
}



/******************四级联动****************/
//选择国家
function changeNation(obj) {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "areaId=" + obj.value + "&level=2&act=getArea",
        success: function (data) {
            if (data != null) {
                initAreaList($("#area_province"), data);
                changeProvince(document.getElementById("area_province"));
                showAreaName();
            }
        }
    });
}
//选择省份
function changeProvince(obj) {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "areaId=" + obj.value + "&level=3&act=getArea",
        success: function (data) {
            if (data != null) {
                initAreaList($("#area_city"), data);
                changeCity(document.getElementById("area_county"));
                showAreaName();
            }
        }
    });
}
//选择城市
function changeCity(obj) {
    $.ajax({
        type: "POST",
        dataType: "json",
        url: path + "cartstep.aspx",
        data: "areaId=" + obj.value + "&level=4&act=getArea",
        success: function (data) {
            if (data != null) {
                initAreaList($("#area_county"), data);
                showAreaName();
            }
        }
    });
}
//选择区域
function changeCounty() {
    var obj = $("#area_county option:selected");
    if (obj.val() != "") {
        $("#areachild").val("1");
    }
    else {
        $("#areachild").val("0");
    }
    showAreaName();

}
function initAreaList(tmpObj, arr) {
    var obj = tmpObj[0];
    obj.length = 0;
    obj.options.add(new Option("请选择", "-1"));
    if (arr) {
        var has = false;
        $.each(arr, function (i, n) {
            obj.options.add(new Option(i, n));
            has = true;
        })
        if (has) tmpObj.show();
        //else tmpObj.hide();
    } //else tmpObj.hide();
}

//显示当前收货人区域名称
function showAreaName() {
    var area_na = document.getElementById("area_nation");
    var area_p = document.getElementById("area_province");
    var area_c = document.getElementById("area_city");
    var area_ct = document.getElementById("area_county");
    if (area_na.value != -1) {
        $("#AddressHeadNation").text(area_na.options[area_na.selectedIndex].text.replace('*', ''));
    }
    if (area_p.value != -1) {
        $("#AddressHeadProvince").text(area_p.options[area_p.selectedIndex].text.replace('*', ''));
    }
    if (area_c.value != -1) {
        $("#AddressHeadCity").text(area_c.options[area_c.selectedIndex].text.replace('*', ''));
    }
    if (area_ct.value != -1) {
        $("#AddressHeadArea").text(area_ct.options[area_ct.selectedIndex].text.replace('*', ''));
    }
}
/******************END 四级联动****************/




///******************四级联动****************/
////选择国家
//function changeNation(obj) {
//    //    $.ajax({
//    //        type: "POST",
//    //        dataType: "json",
//    //        url: path + "cartstep.aspx",
//    //        data: "areaId=" + obj.value + "&level=2&act=getArea",
//    //        success: function (data) {
//    //            if (data != null) {
//    //                initAreaList($("#area_province"), data);
//    //                changeProvince(document.getElementById("area_province"));
//    //                showAreaName();
//    //            }
//    //        }
//    //    });
//    changeProvince("1")
//}
////选择省份
//function changeProvince(obj) {
//    var str = '';
//    if (obj != "1") {
//        str = "Member/ajax/selearealist.ashx?fatherid=" + obj.value;
//    } else {
//        str = "Member/ajax/selearealist.ashx?fatherid=" + obj;
//    }
//    $.ajax({
//        type: "POST",
//        dataType: "xml",
//        url: path + str,
//        success: function (data) {
//            if (data != null) {
//                initAreaList($("#area_city"), data);
//                changeCity(document.getElementById("area_county"));
//                showAreaName();
//            }
//        }
//    });
//}
////选择城市
//function changeCity(obj) {
//    $.ajax({
//        type: "POST",
//        dataType: "json",
//        url: path + "cartstep.aspx",
//        data: "areaId=" + obj.value + "&level=4&act=getArea",
//        success: function (data) {
//            if (data != null) {
//                initAreaList($("#area_county"), data);
//                showAreaName();
//            }
//        }
//    });
//}
////选择区域
//function changeCounty() {
//    var obj = $("#area_county option:selected");
//    if (obj.val() != "") {
//        $("#areachild").val("1");
//    }
//    else {
//        $("#areachild").val("0");
//    }
//    showAreaName();

//}
//function initAreaList(tmpObj, arr) {
//    var obj = tmpObj[0];
//    obj.length = 0;
//    obj.options.add(new Option("请选择", "-1"));
//    if (arr) {
//        var has = false;
//        $.each(arr, function (i, n) {
//            obj.options.add(new Option(i, n));
//            has = true;
//        })
//        if (has) tmpObj.show();
//        //else tmpObj.hide();
//    } //else tmpObj.hide();
//}

////显示当前收货人区域名称
//function showAreaName() {
//    var area_na = document.getElementById("area_nation");
//    var area_p = document.getElementById("area_province");
//    var area_c = document.getElementById("area_city");
//    var area_ct = document.getElementById("area_county");
//    if (area_na.value != -1) {
//        $("#AddressHeadNation").text(area_na.options[area_na.selectedIndex].text.replace('*', ''));
//    }
//    if (area_p.value != -1) {
//        $("#AddressHeadProvince").text(area_p.options[area_p.selectedIndex].text.replace('*', ''));
//    }
//    if (area_c.value != -1) {
//        $("#AddressHeadCity").text(area_c.options[area_c.selectedIndex].text.replace('*', ''));
//    }
//    if (area_ct.value != -1) {
//        $("#AddressHeadArea").text(area_ct.options[area_ct.selectedIndex].text.replace('*', ''));
//    }
//}
///******************END 四级联动****************/

//获取Object
function g(nodeId) {
    return document.getElementById(nodeId);
}

//根据name获取对象数组
function gn(tag, eltname) {
    var elts = document.getElementsByTagName(tag);
    var count = 0;
    var elements = [];
    for (var i = 0; i < elts.length; i++) {
        if (elts[i].getAttribute("name") == eltname) {
            elements[count++] = elts[i];
        }
    }
    return elements;
}