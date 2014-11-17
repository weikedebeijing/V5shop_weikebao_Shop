// JScript 文件
//----------------------浮动窗口开始--------------------------------
function ShowDetail(obj,htmlContent){

	var conspan=0;//插入图片的深度
	var htmlContent=htmlContent;
	var newObj=GetWH($(obj));
	newObj.left=GetLeftOrTop(obj,"left");
	newObj.top=GetLeftOrTop(obj,"top");
	var objImgWH=GetWH($("#imgICO"));
	var objDialogWH=GetWH($("#detail"));
	var left=newObj.left;
	var broderWidth=1;
	var scrollTop=document.documentElement.scrollTop;
	var autoWidth=0;

	objDialogWH.top =parseInt(document.documentElement.clientHeight)-(newObj.top-scrollTop)-objDialogWH.h;
	if(objDialogWH.top<0){
		objDialogWH.top=newObj.top+objDialogWH.top-3;
		if(objDialogWH.top<0) objDialogWH.top=scrollTop;
	}else{
		objDialogWH.top=newObj.top;
	}
	objImgWH.top=newObj.top+30;
	objDialogWH.left=document.documentElement.clientWidth-left-parseInt(objDialogWH.w)-parseInt($(obj).css("width"))-conspan;
    
	if(left>document.documentElement.clientWidth-left-parseInt($(obj).css("width"))){
		objDialogWH.left=left-objDialogWH.w-objImgWH.w+conspan+broderWidth+1+autoWidth-3;
		objImgWH.left=left-objImgWH.w+conspan+broderWidth*2+autoWidth-3;
		
		$("#detail").html(htmlContent);
		$("#imgICO").css("background-position","0 25px");
	}else{
		objImgWH.left=newObj.left+parseInt($(obj).css("width"))-conspan+autoWidth;

		objDialogWH.left=objImgWH.left+objImgWH.w-broderWidth;
		$("#detail").html(htmlContent);
		$("#imgICO").css("background-position","0 0");
		
	}
    
	$("#imgICO").css("left",objImgWH.left+"px");
	$("#imgICO").css("top",objImgWH.top+"px");

	$("#detail").css("left",objDialogWH.left+"px");
	
	$("#detail").css("top",objDialogWH.top+"px");
	
	if(objdml == null)
    {
        ShowDetailHide();
        return false;
    }
	$("#imgICO").show();
	$("#detail").show();
	$("#detail").bgiframe();
	if(objImgWH.top>(objDialogWH.top+objDialogWH.h-objImgWH.h))
		$("#imgICO").hide();
}
function ShowDetailHide()
{
    $("#imgICO").hide();;
	$("#detail").hide();
}
function GetWH(obj){
	var objwh=new ObjWH();
	objwh.w=parseInt(obj.css("width"));
	objwh.h=parseInt(obj.css("height"));
	return objwh;
}
function ObjWH(){
	this.top=0;
	this.left=0;
	this.w=0;
	this.h=0;
}
function GetLeftOrTop(obj,strName){
    var num=0;
    do
    {
        if(strName=="left")
        {
            num += obj.offsetLeft;
        }
        else
        {
            num+= obj.offsetTop;
        }
        
        obj = obj.offsetParent;
    } while(!(obj==null||obj.tagName=="BODY"));
    return num;
}
function Point(iX, iY){
    this.x = iX;
    this.y = iY;
}
//----------------------浮动窗口结束--------------------------------

function RegisterList()
{
    
}
var objdml = null;
function SetObj(obj)
{
    objdml = obj;
    setTimeout("ShowProductInfo()",500);
}
function PushObj()
{
    objdml = null;
    ShowDetailHide();
}
function ShowProductInfo()
{        
    if(objdml == null)
    {
        return false;
    }
    var obj = objdml;
    var productInfo=new ProductInfo();
    var productObj="";
    var content="";
    var imgWidth=0;
    var imgHeight=0;
    $($(obj).html()).each(function(i) {
        if($(this).attr("class")=="productInfo")
        {
            productObj=$(this);
        }
    });
    if(productObj=="")
        return;
    $(productObj.html()).each(function()
    {
        SetProductInfo($(this),productInfo);
    });
    
    $("#detail").attr("class","fc03");
    content="<div style=\"text-align:center\"><img src=\"../public/jquery/loadimg/loading.gif\"/></div>";
    ShowDetail(obj,content);
    
    $("<img src=\""+productInfo.ProductPic+"\">").load(function(){
        var img=new Image();
        img.src=productInfo.ProductPic;        
        $("#detail").attr("class","fc02");

        content=DetailStr(productInfo);
        
        ShowDetail(obj,content);

    }
    );
    $("<img src=\""+productInfo.ProductPic+"\">").error(function(){
        $("#detail").attr("class","fc02");
        imgWidth=270;
        imgHeight=310;
        content=DetailStr(productInfo);
        ShowDetail(obj,content);
    });

    

}
function ShowDiv()
{
    var s="";
}
function SetProductInfo(obj,productInfo)
{
    switch(obj.attr("class"))
    {
        
        case "prouctCode":
            productInfo.ProductCode=obj.html();
            break;
        case "ProductName":
            productInfo.ProductName=obj.html();
            break;
        case "price":
            productInfo.ProductPrice=obj.html();
            break;
        case "oprice":
            productInfo.ProductOPrice=obj.html();
            break;
        case "mprice":
            productInfo.ProductMPrice=obj.html();
            break;
        case "commentsNumber":
            productInfo.CommentsNumber=obj.html();
            break;
        case "comments":
            productInfo.Comments=obj.html();
            break;
        case "pic":
            productInfo.ProductPic=obj.html();
            break;
    }
}
function ProductInfo()
{
    this.ProductPic="";
    this.ProductCode="";
    this.ProductName="";
    this.ProductPrice="";
    this.ProductMPrice="";
    this.ProductOPrice="";
    this.ProductImgUrl="";
    this.CommentsNumber="";
    this.Comments="";
}
function DetailStr(productInfo)
{
    var s="<p align=\"center\" class=\"jJ\"><img src=\""+productInfo.ProductPic+"\" id=\"driftImg\"  /></p>";
    s+="<div class=\"sd\">"+productInfo.ProductName+"</div>";
    s+="<p class=\"jJ01\">产品编号："+productInfo.ProductCode+"</p>";
    s+="<p class=\"jJ02\"><strong>";
    s+="售价：￥"+productInfo.ProductPrice;
    s+="</strong></p>";
    s+="<p class=\"jJ03\">市场价：<del>￥"+productInfo.ProductMPrice+"</del>　<span>";
    s+="</span></p>";
    s+="<p class=\"jJ04\">用户综合评分："+productInfo.CommentsNumber+"　共有 <strong>"+productInfo.Comments+"</strong> 条评论</p>";
    return s;
}
function IsIE(){
    if(isFirefox=navigator.userAgent.indexOf("MSIE")>0)
        return true;
    return false;
}
