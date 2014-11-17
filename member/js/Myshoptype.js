//var strs = "";
//$(document).ready(function () {    
//    Getshoptypelist();
//});

//新增店铺
    function myshoptype() {
        $.ajax({ url: "config/webshop.xml",
            success: function (xml) {

                $("#myshoptype").prepend("<option value=''>请选择</option>");
                $(xml).find("node").each(function () {
                    var name = $(this).attr("name"); //this->
                    var code = $(this).attr("code");
                    var strs = "<option value='" + code + "'>" + name + "</option>";
                    $("#myshoptype").append(strs);
                });
            }
        });
    }

    function myAtshoptype(obj) {
        var select_obj = document.getElementById(obj);
        $.ajax({ url: "config/webshop.xml",
            async: false,
            success: function (xml) {
                $(xml).find("node").each(function () {
                    var name = $(this).attr("name"); //this->
                    var code = $(this).attr("code");
                    // strs += "<option value='" + code + "'>" + name + "</option>";
                    var varItem = new Option(name, code);
                    select_obj.add(varItem);

                });
            }
        });

    }
   