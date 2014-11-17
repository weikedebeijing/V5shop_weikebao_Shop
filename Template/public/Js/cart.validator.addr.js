// JScript 文件
$(document).ready(function(){

	$("#addrForm").validate({
		rules: {
			txtName: "required",
			area_nation: {
				required: "-1"
			},
			txtAddress: "required",
			txtPostCode: "zipcode",
			txtTel: "tel",
			txtMoblie: {
				mobile: true,
				hasOne: "#txtTel"
			},
			txtEmail: "email"
		},
		messages: {
			txtName: "收货人姓名不能为空！",
			area_nation: {
				required: "地区信息不完整！"	
			},
			txtAddress: "收货地址不能为空！",
			txtPostCode: "邮政编码格式不正确！",
			txtTel: "电话号码格式不正确！",
			txtMoblie: {
				mobile: "手机号格式不正确！",
				hasOne: "电话和手机号码必须至少填写一项"	
			},
			txtEmail: "email格式不正确！"
		},
		errorPlacement: function(error, element) {
			element.parent().append(error);
			//error.appendTo( element.next() );
		},
		// specifying a submitHandler prevents the default submit, good for the demo
		submitHandler: function() {
			CartOrder.savePart_Address();
		}	
	});
	
});