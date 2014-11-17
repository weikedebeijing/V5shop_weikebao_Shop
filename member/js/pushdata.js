$(document).ready(function () {

    var openshowPushData = $("#openshowPushData");
    var selpushdatacsv = $("#selpushdatacsv");

    if (openshowPushData.length > 0) {

        openshowPushData.bind('click', function (e) {
            countChecked();
            var proid = $("#proid").val();
            //            if (proid.indexOf(",") > -1) {
            //                proid = proid.replace(",", "#");
            //            }
            if (proid != "") {
                art.dialog.open('ProductToCsv1.aspx?proid=' + proid, {
                    title: '下载商品数据包',
                    lock: true,
                    opacity: .5,
                    width: '560px',
                    height: '165px'
                });
            }
            else {

                checkCom('请先选择需要下载数据包的商品!');
            }
        });
    }



    var btnpushdata = $("#btnpushdata");
    if (btnpushdata.length > 0) {
        btnpushdata.bind('click', function (e) {
            // $("#Divpushdata").hide();

            post();
        });
    }
    var MoreDistion = $("#MoreDistion");
    if (MoreDistion.length > 0) {
        MoreDistion.bind('click', function (e) {
            countChecked();
            var productids = $("#proid").val();
            if (productids == "") {
                checkCom('请选择要代销的商品!');
            }
            else {
                // var ajaxObj = new AJAXRequest;

                //return false;
                //ajaxObj.get("BatchToDis.aspx?productid=" + Product);
                //InsertDistrionName(productids);
                postGetExecute(productids);
            }

        });
    }
    if (selpushdatacsv.length > 0) {

        $("#seltaobaocsv").hide();
        selpushdatacsv.change(function () {

            if (this.value != "") {
                if (this.value == "taobao") {
                    $("#seltaobaocsv").show();
                }
                else {

                    $("#seltaobaocsv").hide();
                }

                $("#datatype").val(this.value);
            }

        });
    }
});

function InsertDistrionName(productId) {
    $.ajax({
        url: "BatchToDis.aspx",
        type: "get",
        data: { actionProduct: "InsertDistrionName", productid: productId },
        success: function (data) {
        
            if (data == "1") {
                checkCom('代销商品成功!');
            }
            else {
                alert(data);
                checkCom('代销商品失败!');
            }
        }
    });
}

function GetCurrentClass(num) {
    for (var id = 0; id <= 2; id++) {
        if (id == num) {
            document.getElementById("CurrentID" + id).className = "current";
        }
        else {
            document.getElementById("CurrentID" + id).className = "";
        }
    }
}

function checkAll(clicker) {
    var allCheckBoxes = document.getElementsByName("chkItem");
    for (var i = 0; i < allCheckBoxes.length; i++) {
        if (allCheckBoxes[i].disabled != true) {
            allCheckBoxes[i].checked = clicker.checked;
        }
       // markChecked(allCheckBoxes[i]);
    }
    countChecked();
}

function markChecked(ele) {
    ele.checked ? ele.parentNode.parentNode.style.backgroundColor = "#fff" : ele.parentNode.parentNode.style.backgroundColor = "";
    countChecked();
}

function countChecked() {

    var allCheckBoxes = document.getElementsByName("chkItem");
    var objProID = document.getElementById("proid");
    objProID.value = "";
    var count = 0;
    var strvalue = objProID.value;

    for (var i = 0; i < allCheckBoxes.length; i++) {
        if (allCheckBoxes[i].checked) {
            count++;

            if (strvalue=="") {
                strvalue = allCheckBoxes[i].value;
            }
            else {
                strvalue += "," + allCheckBoxes[i].value;
            }
        }    

    }
    objProID.value = strvalue;
    if (count < 1) { 
        return false;
    } 
    return true;
}

function post() {


    var product = $("#proid").val();
    var objdatatype = $("#datatype").val();


    if (objdatatype == null | objdatatype == "") {
        $("#showalert").html("<font color='red'>请选择所要下载的数据包类型</font>");
        return false;
    }
    else {

        if (objdatatype == "taobao") {
            objdatatype = "";
            objdatatype = $('input[name="version"]:checked').val();

            if (objdatatype == null | objdatatype == "") {
                $("#showalert").html("<font color='red'>请选择所要下载的数据包类型</font>");
                return false;
            }

        }

        if (product.length > 0) {

            $("#pushcont").hide();
            $("#pushresult").show();
            $("#Divpushdata").hide();
            postExecute(1, product, objdatatype);
            
        }
        else {

            $("#showalert").html("<font color='red'>请选择要下载的商品</font>");
        }
    }

}


//设置进度条 
function setProcessBar(Flag, Downlink) {

    var obj;
    if (Flag == "true") {

        $("#pushresult").hide();
        $("#pushresultComplete").show();
        $("#pushresultClose").show();
        //this.location.href = Downlink;
        this.top.location.href = Downlink;
    }

}


//代销商品
function postGetExecute(Product) {
    if (Product != "") {
        var ajaxObj = new AJAXRequest;
        ajaxObj.get("BatchToDis.aspx?productid=" + Product, callback_getInsertData);

    }
}


function callback_getInsertData(obj) {
    if (obj.responseText) {
        var str = obj.responseText;
        if (str == "1") {
            checkCom('恭喜您！已经成功将您所选的商品设置为：我的分销商品!');
        }
        else {
            checkCom('对不起！您所选择的商品没有成功设置为：我的分销商品!');
        }
    }
}



//生成数据包
function postExecute(Flag, Product, datatype) {
    if (Product != "") {
        var ajaxObj = new AJAXRequest;
        ajaxObj.get("ProductToCsv.aspx?datatype=" + datatype + "&Flag=" + Flag + "&productid=" + Product, callback_InsertData);
        
    }
}

function callback_InsertData(obj) {
    if (obj.responseText) {
        var str = obj.responseText;
        var strarr = str.split("|");
        var isflag = strarr[0];
        var Downlink = strarr[1];

        if (isflag == "true") {
            setProcessBar(isflag, Downlink);
            $("#pushresultClose").hide();
        }
        else {
            $("#pushresult").html("提示：" + Downlink + "");
            $("#pushresultClose").show();
        }
    }
}




function AJAXRequest() {
    var xmlObj = false;
    var CBfunc, ObjSelf;
    ObjSelf = this;
    try { xmlObj = new XMLHttpRequest; }
    catch (e) {
        try { xmlObj = new ActiveXObject("MSXML2.XMLHTTP"); }
        catch (e2) {
            try { xmlObj = new ActiveXObject("Microsoft.XMLHTTP"); }
            catch (e3) { xmlObj = false; }
        }
    }
    if (!xmlObj) return false;
    if (arguments[0]) this.url = arguments[0]; else this.url = "";
    if (arguments[1]) this.callback = arguments[1]; else this.callback = function (obj) { return };
    if (arguments[2]) this.content = arguments[2]; else this.content = "";
    if (arguments[3]) this.method = arguments[3]; else this.method = "POST";
    if (arguments[4]) this.async = arguments[4]; else this.async = true;
    this.send = function () {
        var purl, pcbf, pc, pm, pa;
        if (arguments[0]) purl = arguments[0]; else purl = this.url;
        if (arguments[1]) pc = arguments[1]; else pc = this.content;
        if (arguments[2]) pcbf = arguments[2]; else pcbf = this.callback;
        if (arguments[3]) pm = arguments[3]; else pm = this.method;
        if (arguments[4]) pa = arguments[4]; else pa = this.async;
        if (!pm || !purl || !pa) return false;
        xmlObj.open(pm, purl, pa);
        if (pm == "POST") xmlObj.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlObj.onreadystatechange = function () {
            if (xmlObj.readyState == 4) {
                if (xmlObj.status == 200) {
                    pcbf(xmlObj);
                }
                else {
                    pcbf(null);
                }
            }
        }
        if (pm == "POST")
            xmlObj.send(pc);
        else
            xmlObj.send("");
    }
    this.get = function () {
        var purl, pcbf;
        if (arguments[0]) purl = arguments[0]; else purl = this.url;
        if (arguments[1]) pcbf = arguments[1]; else pcbf = this.callback;
        if (!purl && !pcbf) return false;
        this.send(purl, "", pcbf, "GET", true);
    }
    this.post = function () {
        var fo, pcbf, purl, pc, pm;
        if (arguments[0]) fo = arguments[0]; else return false;
        if (arguments[1]) pcbf = arguments[1]; else pcbf = this.callback;
        if (arguments[2])
            purl = arguments[2];
        else if (fo.action)
            purl = fo.action;
        else
            purl = this.url;
        if (arguments[3])
            pm = arguments[3];
        else if (fo.method)
            pm = fo.method.toLowerCase();
        else
            pm = "post";
        if (!pcbf && !purl) return false;
        pc = this.formToStr(fo);
        if (!pc) return false;
        if (pm) {
            if (pm == "post")
                this.send(purl, pc, pcbf, "POST", true);
            else
                if (purl.indexOf("?") > 0)
                    this.send(purl + "&" + pc, "", pcbf, "GET", true);
                else
                    this.send(purl + "?" + pc, "", pcbf, "GET", true);
        }
        else
            this.send(purl, pc, pcbf, "POST", true);
    }


    this.formToStr = function (fc) {
        var i, query_string = "", and = "";
        for (i = 0; i < fc.length; i++) {
            e = fc[i];
            if (e.name != '') {
                if (e.type == 'select-one') {
                    element_value = e.options[e.selectedIndex].value;
                }
                else if (e.type == 'checkbox' || e.type == 'radio') {
                    if (e.checked == false) {
                        continue;
                    }
                    element_value = e.value;
                }
                else {
                    element_value = e.value;
                }
                element_value = encodeURIComponent(element_value);
                query_string += and + e.name + '=' + element_value;
                and = "&";
            }
        }
        return query_string;
    }
}

