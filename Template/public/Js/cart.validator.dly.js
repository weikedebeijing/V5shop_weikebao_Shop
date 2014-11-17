// JScript 文件
$(document).ready(function(){

	$("#pdForm").validate({
		rules: {
			paymethod: "required",
			delivery: "required"
		},
		messages: {
			paymethod: "请选择支付方式",
			delivery: "请选择配送方式"
		},	
		errorPlacement: function(error, element) {
			element.parent().append(error);
			//error.appendTo( element.next() );
		},		
		// specifying a submitHandler prevents the default submit, good for the demo
		submitHandler: function() {
			CartOrder.savePart_PayAndDly();
		},
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").removeClass("jQueryValidatorError");
		}		
	});
	
	$("input[name='paymethod']").click(CartOrder.checkCod);	
});