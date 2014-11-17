<!---------------------------------------------------------------
// 文件名称: payment.js  
// 描   述: 脚本语言
// 修改标识: Modify By 李传 2008-11-17
// 修改内容: 不强制选择配送 
//          删除判断
//------------------------------------------------------------->
<!---------------------------------------------------------------
// 文件名称: payment.js
// 描   述: 脚本语言
// 修改标识: Modify By 李传 2008-11-19
// 修改内容: 无配送选择 没信息 
//          添加默认信息
//------------------------------------------------------------->
// JavaScript Document
var templevel;
//修改购物车数量并直接进入下一步
function gotopay(){
	document.getElementById("direct").value = "go";
	$("form1").submit();
}
//判断配送方式
function changecat(obj, level, gid){
	var id = obj.options[obj.options.selectedIndex].value;
	 if(id == "")return;
	 //李传 2008-11-19
	//$('weightmoney').innerHTML = "该地区未选择配送，运费为0！！";	
	var url = baseurl + "groupbuystep.aspx?act=delivery&id=" + id + "&gid=" + gid + "&d=" + escape(Date());
	$('weightlist').innerHTML = "loading...";

	//Ajax请求
	new Request.HTML({update:$("weightlist"),onComplete:recorddeliverycache}).get(url);
	
	$('areafid_' + level + "_cache").value = $('areafid_' + level).innerHTML;	
	
	level = level + 1;
	url = baseurl + "groupbuystep.aspx?act=area&id=" + id + "&level=" + level + "&gid=" + gid + "&d=" + escape(Date());

	$('areafid_' + level).style.display = "";
	$('areafid_' + level).innerHTML = "loading...";
	templevel = level;
	
	//Ajax请求
	$('areafid_' + level).load(url);
}

//判断配送方式-团购用
function changecatgroupbuy(obj, level, gid){
	var id = obj.options[obj.options.selectedIndex].value;
	if(id == "") return;
	//$('weightmoney').innerHTML = "该地区无配送选择，运费为0！！";
	var url = baseurl + "groupbuystep.aspx?act=delivery&id=" + id + "&gid=" + gid + "&d=" + escape(Date());
	$('weightlist').innerHTML = "loading...";

	//ajax请求
	$("weightlist").load(url);   
	
	$('areafid_' + level + "_cache").value = $('areafid_' + level).innerHTML;	
	
	level = level + 1;
	url = baseurl + "groupbuystep.aspx?act=area&id=" + id + "&level=" + level + "&gid=" + gid +  "&d=" + escape(Date());

	$('areafid_' + level).style.display = "";
	$('areafid_' + level).innerHTML = "loading...";
	templevel = level;
	
	//ajax请求
	$('areafid_' + level).load(url);    
}

//记录选中地区缓存
function mmmmm(){
	$('areafid_' + templevel + '_cache').value = $('areafid_' + templevel).innerHTML;	
}
//记录计算公式缓存
function recorddeliverycache(){
	$('weightlist_cache').value = $('weightlist').innerHTML;	
}
//加载STEP1页面缓存
function initcache(){
	$('areafid_2').innerHTML = $('areafid_2_cache').value;
	$('areafid_3').innerHTML = $('areafid_3_cache').value;
	$('areafid_4').innerHTML = $('areafid_4_cache').value;
	$('weightlist').innerHTML = $('weightlist_cache').value;
	$('weightmoney').innerHTML = $('weightmoney_cache').value;
}
//加载STEP2页面缓存
function initcache2(){
	var cache = $("page_cache").value.split(",");

	//$('usedscore').value = cache[0];
	//$('usedmoney').value = cache[1];
	if($('couponlist')){
		$('couponlist').style.display = cache[0];
	}
	if(cache[1] == "1"){
		$("ok").style.display = ""
	}else if(cache[1] == "2"){
		$("error").style.display = ""
	}
	$('newtotalprice').innerHTML = cache[2];
	
	if(cache[3] == "1") $("verify").disabled = false;
	//优惠券价格
	$('couponmoney').innerHTML = cache[4];
}
//生成STEP2页面缓存
function CreateCache2(){
	var index = 0;
	var verify = 0;
	//提示
	if($("ok").style.display == ""){
		index = 1;
	}else if($("error").style.display == ""){
		index = 2;
	}
	//是否启用
	if($("verify").disabled == false)
		verify = 1;
			
	var cache = $('couponlist').style.display + "," + index + "," + $('newtotalprice').innerHTML + "," + verify + "," + $('couponmoney').innerHTML;
	$("page_cache").value = cache;
	//alert(cache);
}
//更换配送方式得出计算公式
function changedelivery(obj, gid){
	var count = document.getElementById("groupbuycount").value;
	
	var query = $(obj).get("query");
	var dll = obj.value;
	var url = baseurl + "groupbuystep.aspx?act=groupbuypayment&query=" + query + "&gid=" + gid + "&count="+count+"&dll=" + dll + "&d=" + escape(Date());
	$('weightmoney').innerHTML = "loading...";
	recorddeliverycache();
	
	//Ajax请求
	new Request.HTML({update:$("weightmoney"),onComplete:recordmoneycache}).get(url);
	
}
//记录运费金额并保存到INPUT里面
function recordmoneycache(){
	$('weightmoney_cache').value = $('weightmoney').innerHTML;	
}
//STEP1页面提交判断
function checkstep1form(){
	//判断配送方式
	if(!CheckSelected("delivery")){
		alert("请选择配送方式");	
		return false;
	}		
	//判断配送地区
	if(document.getElementById('areafid_1').options[0].selected)
	{
		alert("请选择配送地区");	
		return false;
	}
	//判断支付方式
	if(!CheckSelected("paymethod")){
		alert("请选择支付方式");	
		return false;
	}	
	
	//判断收货人
	if($("receiver").value == ""){
		alert("请填写收货人");	
		$("receiver").focus();
		return false;
	}	
	//判断收货人
	if($("addr").value == ""){
		alert("请填写收货地址");
		$("addr").focus();	
		return false;
	}	
	//判断邮政编码
	/*if($("post").value == ""){
		alert("请填写收货地址");
		$("post").focus();	
		return false;
	}	*/
	//判断至少一个联系方式
	if($("tel").value == "" && $("mobile").value == ""){
		alert("请至少填写一个联系方式");
		if($("tel").value == ""){
			$("tel").focus();	
		}
		if($("mobile").value == ""){
			$("mobile").focus();	
		}
		return false;
	}	
	
	//判断Email
	if($("email").value == ""){
		alert("请填写EMAIL");
		$("email").focus();	
		return false;
	}	
	//EMAIL格式验证
	if(!ValidateEmail($("email").value)){
		alert("EMAIL格式不正确");
		$("email").focus();	
		return false;
	}

	return true;
}
//判断RADIO是否选中
function CheckSelected(id)
{
   var eless = document.getElementsByName(id);
   for(var i=0;i<eless.length;i++){
     if(eless[i].checked){
     	return true;
     }
   }
   return false;
} 

function   ValidateEmail(j) 
{ 
	var   emailReg=/^([a-zA-Z0-9_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/; 
	return   emailReg.test(j); 
}

//根据CHECKBOX显示或隐藏区域
function ShowHiddenInfo(cid, areaid, status){
	if($(""+cid).checked == status){
		$(""+areaid).style.display = "none";
	}else{
		$(""+areaid).style.display = "";
	}	
}
//加载地址缓存
function InitAddress(obj){
	var ary = obj.value.split("|");
	try{
		$("receiver").value = ary[0];
		$("addr").value = ary[1];
		$("post").value = ary[2];
		$("tel").value = ary[3];
		$("mobile").value = ary[4];
		$("email").value = ary[5];
		$("building").value = ary[6];
	}catch(e){}
}
//把选中的优惠券加入
function InitCoupon(obj){
	var ary = obj.value.split("-");
	try{
		$("coupon1").value = ary[0];
		$("coupon2").value = ary[1];
		$("coupon3").value = ary[2];
		$("coupon4").value = ary[3];
		
		verifycoupon();
	}catch(e){}
}
//优惠券输入直接到下一个INPUT
function movenext(obj, index){
	obj.value = obj.value.toUpperCase();
	if(obj.value.length == 4 && index != 4){
		$("coupon" + (index+1)).select();
		$("coupon" + (index+1)).focus();
	}
}
//验证优惠券是否可用
function verifycoupon(){
	var coupon = $("coupon1").value + "-" + $("coupon2").value + "-" + $("coupon3").value + "-" + $("coupon4").value;
	var url = baseurl + "groupbuystep.aspx?act=coupon&coupon=" + coupon + "&d=" + escape(Date());
	
	$("load").style.display = "";
	$("ok").style.display = "none";
	$("error").style.display = "none";
		
	//Ajax请求
    new Request.HTML({update:$("ispasstxt"),onComplete:showcouponmsg}).get(url);	
	
	$("verify").checked = false;
	$("verify").disabled = true;
	MathPrice();
	$("couponprice").value = "0";
}
//提示优惠券判断结果
function showcouponmsg(){
	var ispass = $("ispasstxt").innerHTML;
	$("load").style.display = "none";

	if(isNaN(ispass)){
		if(ispass == "none"){
			$("ok").style.display = "none";
			$("error").style.display = "";
			$("errmsg").innerHTML = "× 验证错误，使用该券不存在或已被使用";
		}else{
			$("ok").style.display = "none";
			$("error").style.display = "";
			$("errmsg").innerHTML = "× 验证错误，" + ispass;
		}
	}else{
		$("ok").style.display = "";
		$("error").style.display = "none";
		$("couponmoney").innerHTML = ispass;
		$("verify").disabled = false;
	}
	CreateCache2();
}
//根据积分计算抵扣金额
function changemoney(){
	if($("changebutton").value == "取消积分抵扣"){
		$("usedscore").value = 0;
		$("usedmoney").value = 0;
		$("changebutton").value = "积分抵扣";
	}else{
		var score = $("usedscore").value;
		var money = score / scorepercent;
		
		$("usedmoney").value = money;
		if(money != 0){
			//$("changebutton").value = "取消积分抵扣";
		}
	}
	
	MathPrice();
}
//根据积分变动重新计算总价格
function MathPrice(){
	var newprice = Math.round(($("totalprice").value/10)*1000)/100 - Math.round(($("usedmoney").value/10)*1000)/100;
	newprice = Math.round((newprice/10)*1000)/100;
	$("newtotalprice").innerHTML = newprice;	
}
//判断输入的积分是否合法
function checkscore(obj){
	var score = $("userscore").value;
	var maxscore = $("maxscore").value;
	var cscore = obj.value;
	
	if(isNaN(cscore) || cscore.indexOf('.') != -1 || cscore.indexOf('-') != -1){
		alert("您的积分输入不合法");
		obj.focus();
		return false;
	}
	
	if(parseInt(score) < parseInt(cscore)){
		alert("您最多能使用"+score+"积分");
		obj.focus();
		return false;
	}
	
	if(parseInt(cscore) > parseInt(maxscore)){
		if(maxscore == "0"){
			alert("该订单不可使用积分");
			obj.focus();
			return false;
		}else{
			alert("该订单您最多可以使用"+maxscore+"积分");
			obj.focus();
			return false;
		}
	}
	
	changemoney();
	usecoupon();
	
	CreateCache2();
	return true;
}
//根据选择的优惠券重新计算价格
function usecoupon(){
	if($("verify").checked == true){
		var newprice = Math.round(($("totalprice").value/10)*1000)/100 - Math.round(($("couponmoney").innerHTML/10)*1000)/100 - Math.round(($("usedmoney").value/10)*1000)/100;
		newprice = Math.round((newprice/10)*1000)/100;
		if(newprice < 0) newprice = 0;
		$("newtotalprice").innerHTML = newprice;
		$("couponprice").value = $("couponmoney").innerHTML;
	}else{
		MathPrice();	
		$("couponprice").value = "0";
	}
	
	CreateCache2();
}
//STEP2提交验证
function checkform2(){
	$("usedmoney").disabled = false;
	return true;	
}

//显示隐藏包装方式
