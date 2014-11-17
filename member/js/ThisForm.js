$(document).ready(function () {
    var DivFormLiClassName = $(".regist1_cont ul li");
    if (DivFormLiClassName.length > 0) {
        DivFormLiClassName.each(function (i) {
            $(this).hover(function () {
                $(this).addClass('current');
                $(this).removeClass('tiphidden');
            }, function () { $(this).removeClass('current'); $(this).addClass('tiphidden'); });

        });

    }

    var DivFormGetpwdLiClassName = $(".form ul li");
    if (DivFormGetpwdLiClassName.length > 0) {
        DivFormGetpwdLiClassName.each(function (i) {
            $(this).hover(function () {
                $(this).addClass('current');
                $(this).removeClass('tiphidden');
            }, function () { $(this).removeClass('current'); $(this).addClass('tiphidden'); });

        });

    }

    var DivFormLiInputName = $("input");
    var DivFormInputNoInclude = $("input name=[shopfen]");
    if (DivFormLiInputName.length > 0 && DivFormInputNoInclude.lenth==0) {
        DivFormLiInputName.each(function (i) {
            $(this).focus(function () {
                $(this).parent("li").addClass('current');
                $(this).parent("li").removeClass('tiphidden');
            });

            $(this).blur(function () {
                $(this).parent("li").removeClass('current');
                $(this).parent("li").removeClass('tiphidden');
                $(this).parent("li").addClass('tiphidden');
            });

        });

    }


    var DivFormLiClassName2 = $(".storeinfor_form01 ul li");
    if (DivFormLiClassName2.length > 0) {
        DivFormLiClassName2.each(function (i) {
            $(this).hover(function () {
                $(this).addClass('current');
                $(this).removeClass('tiphidden');
            }, function () { $(this).removeClass('current'); $(this).addClass('tiphidden'); });

        });

    }

});

 