function CheckLogin(){
	if(document.getElementById("username").value == ""){
		alert("请输入用户名!");	
		document.getElementById("username").focus();
		return false;
	}
	if(document.getElementById("password").value == ""){
		alert("请输入密码!");	
		document.getElementById("password").focus();
		return false;
	}
	if(document.getElementById("checkcode").value == ""){
		alert("请输入验证码!");	
		document.getElementById("checkcode").focus();
		return false;
	}
	return true;
}