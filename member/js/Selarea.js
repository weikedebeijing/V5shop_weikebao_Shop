$(document).ready(function () {
    selectNextarea(1)
});

////区域选择
//function selectFirstarea() {
//    $.ajax({ url: "/MemberShip/ajax/selearealist.ashx?fatherid=0",
//        success: function (xml) {
//            $("#selFirstarea").empty();
//            $("#selFirstarea").prepend("<option value=''>请选择</option>");
//            var strs = "";
//            $(xml).find("node").each(function () {
//                var name = $(this).attr("name"); //this->
//                var thisid = $(this).attr("id");

//                strs += "<option value='" + thisid + "'>" + name + "</option>";

//            });

//            $("#selFirstarea").append(strs);
//            $("#selFirstarea").change(function () {

//                $("#SeletctAreaId").val(this.value);
//                selectNextarea(this.value); 
//            });
//        }
//    });
//}

//二级区域选择
function selectNextarea(objvalue) {
    $("#SeletctAreaId").val(objvalue);
    if (objvalue != "") {
        $("#seleAreaNext").css("display", "");
        $.ajax({ url: "/MemberShip/ajax/selearealist.ashx?fatherid=" + objvalue,
            success: function (xml) {
                var strs = "";
                $(xml).find("node").each(function () {
                    var name = $(this).attr("name"); //this->
                    var thisid = $(this).attr("id");
                    strs += "<option value='" + thisid + "'>" + name + "</option>";
                });
                $("#seleAreaNext").empty();
                $("#seleAreaNext").prepend("<option value=''>请选择</option>");
                $("#seleAreaNext").append(strs);
                $("#seleAreaNext").change(function () {
                    $("#SeletctAreaId").val(this.value);
                    selectThirarea(this.value);
                });
            }
        });
    }
    else {
        $("#seleAreaNext").empty();
        $("#seleAreaNext").css("display", "none");
        $("#seleAreaThird").empty();
        $("#seleAreaThird").css("display", "none");
        $("#seleAreaFouth").empty();
        $("#seleAreaFouth").css("display", "none");
    }
}


//三级区域选择
function selectThirarea(objvalue) {
    $("#seleAreaThird").empty();
    if (objvalue != "") {
        $("#seleAreaThird").css("display", "");
        $.ajax({ url: "/MemberShip/ajax/selearealist.ashx?fatherid=" + objvalue,
            success: function (xml) {
                var strs = "";
                $(xml).find("node").each(function () {
                    var name = $(this).attr("name"); //this->
                    var thisid = $(this).attr("id");
                    strs += "<option value='" + thisid + "'>" + name + "</option>";
                });
                $("#seleAreaThird").empty();
                $("#seleAreaThird").append("<option value=''>请选择</option>");
                $("#seleAreaThird").append(strs);
                $("#seleAreaThird").change(function () {
                    $("#SeletctAreaId").val(this.value);                  
                    selectFoutharea(this.value);
                });
            }
        });
    }
    else {
        $("#seleAreaThird").empty();
        $("#seleAreaThird").css("display", "none");
        $("#seleAreaFouth").empty();
        $("#seleAreaFouth").css("display", "none");
    }
}



//四级区域选择
function selectFoutharea(objvalue) {
    if (objvalue != "") {
        $("#seleAreaFouth").css("display", "");
        $.ajax({ url: "/MemberShip/ajax/selearealist.ashx?fatherid=" + objvalue,
            success: function (xml) {
                var strs = "";
                $(xml).find("node").each(function () {
                    var name = $(this).attr("name"); //this->
                    var thisid = $(this).attr("id");

                    strs += "<option value='" + thisid + "'>" + name + "</option>";

                });
                $("#seleAreaFouth").empty();
                $("#seleAreaFouth").append("<option value=''>请选择</option>");
                if (strs == "") {                  
                    $("#seleAreaFouth").css("display", "none");
                }
                else {
                    $("#seleAreaFouth").append(strs);
                    $("#seleAreaFouth").change(function () {
                        $("#SeletctAreaId").val(this.value);
                    });
                }
            }
        });
    }
    else {
        $("#seleAreaFouth").empty();
        $("#seleAreaFouth").css("display", "none");
    }
}