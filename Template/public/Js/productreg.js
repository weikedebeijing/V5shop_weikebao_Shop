function check_str() {
    if ($("#Count")[0].value == "") {
        alert("数量不能为空");
        $("#Count")[0].focus();
        return false;
    }

    if ($("#Date")[0].value == "") {
        alert("最晚到货时间不能为空");
        $("#Date")[0].focus();
        return false;
    }
    
    if ($("#TrueName")[0].value == "") {
        alert("真实姓名不能为空");
        $("#TrueName")[0].focus();
        return false;
    }

    if ($("#Address")[0].value == "") {
        alert("联系地址不能为空");
        $("#TrueName")[0].focus();
        return false;
    }

    if ($("#Telephone")[0].value == "") {
        alert("联系电话不能为空");
        $("#TrueName")[0].focus();
        return false;
    }

    if ($("#Email")[0].value == "") {
        alert("Email不能为空");
        $("#TrueName")[0].focus();
        return false;
    }
}