function ShowDiv(show_div, bg_div) {
    document.getElementById(show_div).style.display = 'block';
    document.getElementById(bg_div).style.display = 'block';
    var bgdiv = document.getElementById(bg_div);
    bgdiv.style.width = document.body.scrollWidth;
    $("#" + bg_div).height($(document).height());
};
//关闭弹出层
function CloseDiv(show_div, bg_div) {
    document.getElementById(show_div).style.display = 'none';
    document.getElementById(bg_div).style.display = 'none';
};




function ShowDivBei(show_div, bg_div, id, value) {
    document.getElementById(show_div).style.display = 'block';
    document.getElementById(bg_div).style.display = 'block';
    var bgdiv = document.getElementById(bg_div);

    bgdiv.style.width = document.body.scrollWidth;
     
    $("#ReMark").val(value);
    $("#Id").val(id);
    $("#" + bg_div).height($(document).height());
    return false;
};

function ShowMessage(title, msg, cancelName) {
    strHtml = "<div id='fade' class='black_overlay'></div><div id='showDiv' class='white_content' style='width:500px; height:200px;'>";
    strHtml += "<div class='layer-box01 alert-cart email_edit'>";
    strHtml += "<div class='title'>" + title + "</div>";
    strHtml += "<ul><li style='padding-top:0;'>" + msg;
    strHtml += "<span class='c02 ml5' id='Span2'></span></li>"
    strHtml += " <li><a href='javascript:void(0)' class='btn-edit ml130' onclick='CloseDiv('showDiv','fade')'>";
    strHtml += cancelName + "</a>";
    strHtml += "</li>";
    strHtml += "</ul>";
    strHtml += "</div>";
    strHtml += "</div>";
    document.writeln(strHtml);
   
}
