// JScript 文件
$(document).ready(function(){

	$("#packageForm").validate({
		rules: {
			productpackage: "required",
			greetingcard: "required"
		},
		messages: {
			productpackage: "请选择包装",
			greetingcard: "请选择贺卡"
		},	
		errorPlacement: function(error, element) {
			element.parent().append(error);
		},		
		// specifying a submitHandler prevents the default submit, good for the demo
		submitHandler: function() {
			CartOrder.savePart_Package();
		},
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").removeClass("jQueryValidatorError");
		}		
	});
	
});