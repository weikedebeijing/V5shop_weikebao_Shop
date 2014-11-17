function getobj(id) {
    return document.getElementById(id);
}

function selecttab(obj, act, def, special, areaname) {
    var node = childs(obj.parentNode.parentNode.childNodes);
    for (var i = 0; i < node.length; i++) {
        if (node[i].className != special) {
            node[i].className = def;
            if (getobj(areaname + "_" + i))
                getobj(areaname + "_" + i).style.display = "none";
        }
    }
    obj.parentNode.className = act;
    for (var i = 0; i < node.length; i++) {
        if (node[i].className != special) {
            if (node[i].className == act) {
                if (getobj(areaname + "_" + i))
                    getobj(areaname + "_" + i).style.display = "";
            }
        }
    }
}
//兼容FF下的childNodes
function childs(nodes) {
    if (!nodes.length)
        return [];
    var ret = [];
    for (var i = 0; i < nodes.length; i++) {
        if (nodes[i].nodeType != 1)
            continue;
        ret.push(nodes[i]);
    }
    return ret;
}

//֤
function ChangeVerifyImgNew(url) {
    document.getElementById("verifyimg").src = url + 'member/verifyimg.aspx?d=' + escape(Date());
}

//控制只能输入数字
function isNumber(e) {
    if (navigator.userAgent.indexOf("MSIE") != -1) {
        if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 37 || event.keyCode == 39
			|| (event.keyCode >= 48 && event.keyCode <= 57) || (event.keyCode >= 96 && event.keyCode <= 105)) {
            return true;
        } else {
            return false;
        }
    } else {
        if (e.which == 46 || e.which == 8 || e.which == 37 || e.which == 39
			|| (e.which >= 48 && e.which <= 57) || (e.which >= 96 && e.which <= 105)) {
            return true;
        } else {
            return false;
        }
    }
}


function AskDetail(pid) {
    var acontent = "";
    if ($("txtaskdetail")) {
        acontent = escape($("txtaskdetail").value);
        if (acontent.replace(" ", "") == "") {
            alert("请先输入咨询内容！");
            return;
        }
        else {
            $('askdetail').set('load', { onSuccess: function () { $('askdetail').value = ''; } })
            $('askdetail').load("../../member/AjaxRequest.aspx?Command=ASKADD&APID=" + pid + "&AContent=" + acontent);

            /*$.get("../../member/AjaxRequest.aspx", {Command:"ASKADD",APID: pid, AUserName:"sean",AContent:acontent },
                function(data){
                $("#txtaskdetail").val("");
                $("#askdetail").html(data);
            });*/
        }
    }
}

var isVoted = 0;
//投票满意度
function Pleased(aid, command) {
    if (isVoted == 1) {
        alert("您已经投过票了，请不要重复投票！");
        return;
    }

    var newurl = "../../member/AjaxRequest.aspx?Command=" + command + "&aID=" + aid;
    var myRequest = new Request({
        url: newurl,
        method: 'get',
        onSuccess: function (responseText) {
            if (parseInt(responseText) > 0) {
                if (command == "Pleased") {
                    $("3694916_" + aid).getElement("span").innerHTML = parseInt($("3694916_" + aid).getElement("span").innerHTML) + 1;
                    $("3694916_" + aid).getElement("a").innerHTML = "已投票";
                }
                else {
                    $("3694916_" + aid).getLast("span").innerHTML = parseInt($("3694916_" + aid).getLast("span").innerHTML) + 1;
                    $("3694916_" + aid).getLast("a").innerHTML = "已投票";
                }
                isVoted = 1;
            }
        }
    }).send();
}

//用户提交评论
function SendProductReview(proID) {
    var title = "";
    var content = "";
    var star = 0;

    if ($("txtproductreview")) {
        content = escape($("txtproductreview").value);
    }
    if ($("txttitle")) {
        title = escape($("txttitle").value);
    }
    if (title.replace(" ", "") == "") {
        alert("评论标题不能为空");
        return;
    }
    if (content.replace(" ", "") == "") {
        alert("评论内容不能为空");
        return;
    }
    star = $E("input[name^=star]:checked").value;

    var newurl = "../../member/AjaxRequest.aspx?Command=UserSendProductReview&proID=" + proID + "&Content=" + content + "&Title=" + title + "&Star=" + star;
    //Ajax请求
    var myRequest = new Request({
        url: newurl,
        method: 'get',
        onSuccess: function (responseText) {
            if (responseText > 0) {
                $("ProductReview").innerHTML = "您的评论信息提交成功！";
            }
            else {
                alert("信息提交失败！");
            }
        }
    }).send();

    /* $.get("../../member/AjaxRequest.aspx", {Command: "UserSendProductReview",proID: proID,Content:content,Title:title,Star:star},
     function(data){
         if(data > 0)
         {
             $("ProductReview").innerHTML = "您的评论信息提交成功！";
         }
         else
         {
             alert("信息提交失败！");
         }
     });*/
}

//评论是否有用
function ProductViewPlease(command, reviewID) {
    var newurl = "../../member/AjaxRequest.aspx?Command=ProductViewPlease&Col=" + command + "&reviewID=" + reviewID;
    var myRequest = new Request({
        url: newurl,
        method: 'get',
        onSuccess: function (responseText) {
            if (parseInt(responseText) > 0) {
                if (command == "goodcount") {
                    $("agree_" + reviewID).set("html", "<span style=\"color:blue;\">有用[" + (parseInt($("agree_" + reviewID).get("html").replace("有用[", "").replace("]", "")) + 1) + "]</span>");
                }
                else {
                    $("oppose_" + reviewID).set("html", "<span style=\"color:blue;\">没用[" + (parseInt($("oppose_" + reviewID).get("html").replace("没用[", "").replace("]", "")) + 1) + "]</span>");
                }
                //$("agree_"+reviewID).erase("onclick");
                //$("oppose_"+reviewID).erase("onclick");
                $("agree_" + reviewID).set("onclick", "javascript:void(0)");
                $("oppose_" + reviewID).set("onclick", "javascript:void(0)");
            }
        }
    }).send();


    /*$.get("../../member/AjaxRequest.aspx", {Command: "ProductViewPlease",Col: command,reviewID:reviewID},
    function(data){
        if(parseInt(data) > 0)
        {
            if(command == "goodcount")
            {
                $("agree_"+reviewID).html("<span style=\"color:blue;\">有用["+(parseInt($("#agree_"+reviewID).html().replace("有用[","").replace("]","")) + 1)+"]</span>");
            }
            else
            {
                $("oppose_"+reviewID).html("<span style=\"color:blue;\">没用["+(parseInt($("#oppose_"+reviewID).html().replace("没用[","").replace("]","")) + 1) + "]</span>");
            }
            $("spanproductreview_"+reviewID+" button").removeAttr("onclick");
        }
    });*/
}

//转向提交回复的页面
function ProductReviewToPage(cid, reviewtoID) {
    if ($("hidreviewtoID")) {
        $("hidreviewtoID").value = reviewtoID;
    }
    location.href = "../../productreview.aspx?id=" + cid + "&reviewtoid=" + reviewtoID + "#divproductreviewto";
}

//发送商品评论的回复
function SendProductReviewTo() {
    var content = "";
    var reviewID = 0;
    if ($("txtproductreviewto")) {
        content = escape($("txtproductreviewto").value);
        $("txtproductreviewto").value = "";
    }
    if ($("hidreviewtoID")) {
        reviewID = $("hidreviewtoID").value;
    }

    var newurl = "../../member/AjaxRequest.aspx?Command=SendProductViewTo&Content=" + content + "&reviewID=" + reviewID;
    var myRequest = new Request({
        url: newurl,
        method: 'get',
        onSuccess: function (responseText) {
            if (parseInt(responseText) > 0) {
                $("btnreviewto_" + reviewID).set("html", "<span style=\"color:blue;\">回复[" + (parseInt($("btnreviewto_" + reviewID).get("html").replace("回复[", "").replace("]", "")) + 1) + "]</span>");

                //$("btnreviewto_"+reviewID).erase("onclick");
                $("btnreviewto_" + reviewID).set("onclick", "javascript:void(0)");
                $("divproductreviewto").style.display = "none";

                if ($("ProductReview")) {
                    $("ProductReview").innerHTML = "您的回复信息提交成功！";
                    $("ProductReview").style.display = "block";
                }
            }
        }
    }).send();
}

$(function () {
    $(".add").click(function () {
        var num = $("#num").val() * 1;
        num = num + 1;
        $("#num").val(num);
    })
    $(".reduce").click(function () {
        var num = $("#num").val() * 1;
        if (num > 1) {
            num = num - 1;
        }
        $("#num").val(num);
    })
})

////////////////////////////////微信分享

document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
    WeixinJSBridge.call('showOptionMenu');
    WeixinJSBridge.on("menu:share:timeline",
       function () {

           WeixinJSBridge.invoke("shareTimeline", t(),
           function () { })

       });

    WeixinJSBridge.on("menu:share:appmessage",
      function () {
          WeixinJSBridge.invoke("sendAppMessage", t(),
           function () { })
      })
});

function t() {

    return {
        title: "北京故事",
        link: "http://10001shop.ming-bo.net",
        img_url: "http://20001mcm.ming-bo.net/Images/Drp/20140612122616930474.png",
        desc: "北京故事",
        img_width: "200",
        img_height: "200",
        timeLineTitle: "111"
    }

}