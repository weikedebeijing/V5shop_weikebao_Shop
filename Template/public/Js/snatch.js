// JavaScript Document
function JoinSnatch(id){
    //判断购买数量是否小于限购数量
    var price = document.getElementById("price").value;
    var path = document.getElementById("pathnow").value;
    var maxprice = document.getElementById("maxprice").value;
    var minprice = document.getElementById("minprice").value;
    if((parseInt(price) > parseInt(maxprice)) || (parseInt(price) < parseInt(minprice)) || isNaN(price) || price <= 0){
        alert("您的出价超出了有效的出价范围");
        return false;
    }
    
    var url = path + "snatch.aspx?act=joinsnatch&price=" + price + "&id=" + id;
    window.location.href= url;
}

function InitSnatchData(id){
    var path = $("pathnow").value;
	
	var url = path + "snatch.aspx?act=winuser&id=" + id;
	//Ajax请求
	$('winusername').set('load', {onSuccess : hiddenorshow});
	$('winusername').load(url);
	
	url = path + "snatch.aspx?act=winprice&id=" + id;
	//ajax请求
	$("winprice").load(url);
	
	url = path + "snatch.aspx?act=windate&id=" + id;
	//ajax请求
	$("windate").load(url);
}

function hiddenorshow(){
	if($("winusername").innerHTML == "--"){
		if($("actarea")){
			$("actarea").style.display = "";
		}
	}else{
		if($("winusername").innerHTML == username){
			if($("buyarea")){
				$("buyarea").style.display = "";
			}
		}
	}
}

function BuySnatch(){
	if($("winusername").innerHTML == username){
		var url = path + "cart.aspx?id=" + $("productid").value + "&act=buy&count=1&snatchid="+cid+"&price=" + $("winprice").innerHTML;
		window.location.href = url;
	}
}


//Add By 沈先强 夺宝奇兵倒计时功能
window.addEvent('domready', function(){
    startclock();
});
    var timerID = null;   
    var timerRunning = false;   
    function showtime() 
    {
    var startdatehtml = document.getElementById("startdate").innerHTML;
    var enddatehtml = document.getElementById("enddate").innerHTML;
    var Today = new Date();
    var startdate=new Date(startdatehtml.substring(0,4),parseInt(startdatehtml.substring(5,7),10) - 1,startdatehtml.substring(8,10),startdatehtml.substring(11,13),startdatehtml.substring(14,16),startdatehtml.substring(17,19));
    var enddate = new Date(enddatehtml.substring(0,4),parseInt(enddatehtml.substring(5,7),10) - 1,enddatehtml.substring(8,10),enddatehtml.substring(11,13),enddatehtml.substring(14,16),enddatehtml.substring(17,19));
    var datediff = 0;
    
     

    if(enddate.getTime() < Today.getTime()) 
    {
        //document.getElementById("datedifftitle").innerHTML = "　活动已经结束";
        document.getElementById("datediff").innerHTML = "活动已经结束";
        stopclock();
        return;
    }
    if(startdate.getTime() > Today.getTime()) 
    {
        document.getElementById("datedifftitle").innerHTML = "　距离该次夺宝开始还有";
        datediff = startdate.getTime() - Today.getTime();
        
    }
    else
    {
        document.getElementById("datedifftitle").innerHTML = "　距离该次夺宝结束仅剩";
        datediff = enddate.getTime() - Today.getTime();
    }
    var NowHour = Today.getHours();
    var NowMinute = Today.getMinutes();
    var NowMonth = Today.getMonth();
    var NowDate = Today.getDate();
    var NowYear = Today.getYear();
    var NowSecond = Today.getSeconds();
    if (NowYear <2000)
    NowYear=1900+NowYear;

    //在这里调整到期时间-terry
    Hourleft = Math.floor(datediff/1000/60/60);//
    Minuteleft = Math.floor(datediff/1000/60)-Math.floor(datediff/1000/60/60)*60;
    Secondleft = Math.floor(datediff/1000) - Math.floor(datediff/1000/60/60)*3600 - (Math.floor(datediff/1000/60)-Math.floor(datediff/1000/60/60)*60)*60;
    //在这里调整到期时间-terry

    Yearleft = 2109 - NowYear;
    Monthleft = 12 - NowMonth - 1;
    Dateleft = 31 - NowDate;
    if (Secondleft<0)
    {   
    Secondleft= 59 - Secondleft;   
    Minuteleft=Minuteleft-1;   
    }   
    if (Minuteleft<0)   
    {    
    Minuteleft=60+Minuteleft;   
    Hourleft=Hourleft-1;   
    }   
    if (Hourleft<0)   
    {   
    Hourleft=24+Hourleft;   
    Dateleft=Dateleft-1;   
    }   
    if (Dateleft<0)   
    {   
    Dateleft=31+Dateleft;   
    Monthleft=Monthleft-1;   
    }   
    if (Monthleft<0)   
    {   
    Monthleft=12+Monthleft;   
    Yearleft=Yearleft-1;   
    }   
    //Temp=Yearleft+'年, '+Monthleft+'月, '+Dateleft+'天, '+Hourleft+'小时, '+Minuteleft+'分, '+Secondleft+'秒' 
    Temp = "";
    //Temp += '<font color=#FF0000>'+Hourleft+'</font>小时<font color=#FF0000>'+Minuteleft+'</font>分<font color=#FF0000>'+Secondleft+'</font>秒';
    Temp += "<font>"+Hourleft+"</font>小时<font>"+Minuteleft+"</font>分<font>"+Secondleft+"</font>秒";
    //document.form1.left.value=Temp;  
    document.getElementById("datediff").innerHTML = Temp;

    timerID = setTimeout("showtime()",1000);   
    timerRunning = true;   
    }   
    var timerID = null;   
    var timerRunning = false;   
    function stopclock () {   
    if(timerRunning)   
    clearTimeout(timerID);   
    timerRunning = false;   
    }   
    function startclock() {   
    stopclock();   
    showtime();   
    }