// JScript 文件
function InitData(id){
    //获取当前价格
    var path = $("pathnow").value;
    var url = path + "groupbuy.aspx?act=nowprice&id=" + id + "&d=" + escape(Date());

	//ajax请求
	if($("nowprice")){
		$("nowprice").load(url);  
	}

    //获取当前购买数量
    url = path + "groupbuy.aspx?act=nowcount&id=" + id + "&d=" + escape(Date());
	//ajax请求
	$("nowcount").load(url);  
 
	//获取当前状态
	url = path + "groupbuy.aspx?act=groupstatus&id=" + id + "&d=" + escape(Date());
	//Ajax请求
	$('groupstatus').set('load', {onSuccess : HiddenBuyArea});
	$('groupstatus').load(url);
}

function HiddenBuyArea(){
	if($("groupstatus").innerHTML == "团购已经结束"){
		$("groupbuybutton").style.display = "none";
	}
}

function JoinGroupBuy(id){
    //判断购买数量是否小于限购数量
    var buycount = $("buycount").value;
    var limitcount = $("limitcount").value;
    var path = $("pathnow").value;
    
    if(parseInt(buycount) > parseInt(limitcount) || isNaN(buycount) || buycount.indexOf('.') != -1 || buycount <= 0){
        alert("请输入一个小于等于" + limitcount + "且大于0的整数");
        return false;
    }
    
    var url = path + "groupbuystep.aspx?act=join&count=" + buycount + "&id=" + id;
    window.location.href= url;
}