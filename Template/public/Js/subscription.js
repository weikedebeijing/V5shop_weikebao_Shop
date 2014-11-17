function InsertSubmit(){
	var act = document.getElementById("act");
	act.value = "subscribe";
	return CheckForm();
}

function DeleteSubmit(){
	var act = document.getElementById("act");
	act.value = "unsubscribe";
	return CheckForm();
}

function CheckForm(){
	var form = document.getElementById("subform");
	
	var email = document.getElementById("email");
	if(!ValidateEmail(email.value)){
		alert("邮件格式不正确");	
		email.focus();
		return false;
	}
	
	var username = document.getElementById("username");
	if(username.value == ""){
		alert("请输入您的姓名");	
		username.focus();
		return false;
	}
	return true;
}

function   ValidateEmail(j) 
{ 
	var   emailReg=/^([a-zA-Z0-9_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/; 
	return   emailReg.test(j); 
}