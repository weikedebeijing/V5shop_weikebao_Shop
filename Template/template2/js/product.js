//*****js交互层 效果*****//
//*on 2012-05-17 
//* @Version    jQuery 1.4+


//****全局变量
//鼠标坐标
var _MOUSE_PAGE_X = 0;
var _MOUSE_PAGE_Y = 0;

//****事件注册
jQuery(document).ready(function(){
	 jQuery(".btn-buy").click(function(event){
      	jQuery(this).parent().parent().find(".overlay").show().parent().addClass("current").siblings().removeClass("current").find(".overlay").hide();
	  	return false;
      });	  
	 jQuery(".overlay .close").click(function(){
      	jQuery(this).parent().hide().parent().removeClass("current");
	  	return false;
      });
	  
	//购买按钮：确定
    jQuery(".detail-btn-buy").bind({
		'click':function(e){
			e.stopPropagation();
		 	_MOUSE_PAGE_X = e.pageX;
			_MOUSE_PAGE_Y = e.pageY;
		}
	});	
	
	//颜色、尺寸选择框
	jQuery("[doinID^=goodsSKU]").bind({
	    'click': function(e) {
			e.stopPropagation();
			goodsSKU_Effect('click',this);
	    },
	    'mouseenter': function(e){	
			e.stopPropagation();
			//goodsSKU_Effect('mouseenter',this);
	    },
	    'mouseleave': function(e){
			e.stopPropagation();
			//goodsSKU_Effect('mouseleave',this);
	    } 
	});
	
	//Thumb大小图关联
	initThumbPic();
	
	//大小图切换
    jQuery('[doinID="Fm_main_switch"]').bind({
		'click':function(){			
			styleSwitcher_Effect('click',this);
		}
	});	
	
	//浮动层窗口关闭
    jQuery('[doinID="MessageFade"]').bind({
		'mouseleave':function(){
			jQuery('[doinID="MessageFade"]').hide();
		}
	});	
    jQuery('[doinID="MessageBox"] .button').bind({
		'click':function(){
			jQuery('[doinID="MessageBox"]').hide();
		}
	});	
    jQuery('[doinID="MessageBox1"] .button').bind({
		'click':function(){
			jQuery('[doinID="MessageBox1"]').hide();
		}
	});	
    jQuery('[doinID="MessageBox2"] .button').bind({
		'click':function(){
			jQuery('[doinID="MessageBox2"]').hide();
		}
	});	
        //放大镜
    jQuery(".jqzoom").jqzoom({
        zoomWidth: 360,
        zoomHeight: 360,
        xOffset: 20,
        yOffset: 0,
        position: "right",
        //preload: 1,
        lens: true,
        title: false,
        preloadText: '加载中...'
    });
    //关闭浏览记录
        jQuery('#closeBtn').bind({
		'click':function(){
			jQuery('#fixright').hide();
		}
	});	
//    //切换商品评论和商品咨询
//        jQuery('#proDetail').bind({
//	'click':function(){
//            selecttab(this,'current','default','','product');
//            $('#reviewFrame').attr('src',path+'template/version_9/page/reviewcontent.aspx?id='+productId);
//	}
//});	

});//end of document ready

//****交互效果
//大小图切换
function styleSwitcher_Effect(_event,_this){
	if('click' == _event){
		srcE = jQuery('[doinID="Fm_main_switch"]');
		if (srcE.html() == "切换到大图") {
			jQuery('[doinID="Fm_main_small"]').css("display","none");
			jQuery('[doinID="Fm_main_big"]').css("display","block");
			jQuery('#Fm_main').removeClass('list-small').addClass('list-big');
		}else{
			jQuery('[doinID="Fm_main_big"]').css("display","none");			
			jQuery('[doinID="Fm_main_small"]').css("display","block");
			jQuery('#Fm_main').removeClass('list-big').addClass('list-small');
		}
		srcE.html( (srcE.html()=="切换到大图")?"切换到小图":"切换到大图" );
	};
};
//颜色、尺寸选择框效果
function goodsSKU_Effect(_event,_this){
	if('click' == _event){
	        if(jQuery(_this).not(".out-of-stock")[0])
	            jQuery(_this).addClass("selected").siblings().removeClass("selected");
//			var _doinID = jQuery(_this).attr("doinID");
//			var _doinValue = jQuery(_this).attr("doinValue");
//			jQuery('[doinID='+_doinID+'][doinValue='+_doinValue+']').removeClass("selected");
//			jQuery(_this).removeClass("out-of-stock");
//			jQuery(_this).toggleClass("selected");
	};
	//MouseOver
	if('un-selected' == _event){
			jQuery(_this).removeClass("selected");
	};
	//缺货
	if('OUT-OF-STOCK' == _event){		
			jQuery(_this).addClass("out-of-stock");
			jQuery(_this).find("em").remove();
			//if(jQuery(_this).parent().attr("doinid") == "goodsSKU_color") jQuery(_this).append("<em>已售空</em>");
	};
	//有货
	if('STOCK' == _event){		
			jQuery(_this).removeClass("out-of-stock");
			jQuery(_this).find("em").remove();
	};
	//if('mouseenter' == _event){		
	//		jQuery(_this).addClass("skuHover");
	//};
	//if('mouseleave' == _event){
	//		jQuery(_this).removeClass("skuHover");
	//};
};
//****通用交互效果
//提示浮动层: 坐标还可以优化，自动居中或跟随鼠标。
function showMessageBox(boxname, info){
	switch(boxname){
		case "MessageBox":
			jQuery('[doinID="MessageBox"] span').html(info);
			jQuery('[doinID="MessageBox"]').show();
			jQuery('[doinID="MessageBox"]').css("top",_MOUSE_PAGE_Y-120);
			jQuery('[doinID="MessageBox"]').css("left",_MOUSE_PAGE_X+40);
			break;
		case "MessageBox1":
			jQuery('[doinID="MessageBox1"]').show();
			jQuery('[doinID="MessageBox1"]').css("top",_MOUSE_PAGE_Y-130);
			jQuery('[doinID="MessageBox1"]').css("left",_MOUSE_PAGE_X-100);
			break;
		case "MessageBox2":
			jQuery('[doinID="MessageBox2"]').show();
			window.location.hash="#";
			jQuery("#cartproductid").fadeTo("normal",0.5).fadeTo("normal",1);			
			break;
	}
};
function showFadeOutMessage(time,info,x,y ){
	with (jQuery('[doinID="MessageFade"]')) {
			html(info);
			if(y & x)
				css("top",y).css("left",x);
			else
				css("top",_MOUSE_PAGE_Y-80).css("left",_MOUSE_PAGE_X+10);
			stop().fadeIn("fast").delay(time).fadeOut("fast");
	}
};
//商品已购标记
function markGoodsSelected(goodsID,flag){
	//(需要统计该商品各个SKU被选中的数量 by alvin.liu@doin.cn, 2011-3-10）
	var item = jQuery("[doinID=goodsInfo][doinvalue="+goodsID+"] div[doinID=selected_mark]");
	var countSpan = jQuery(item).children("span");
	var count = Number(countSpan.html());
	with(item){
		if(flag){
			count = Number(count) + 1;
			countSpan.html(count);
			show();
		}else{
			count = Number(count) - 1;
			countSpan.html(count);
			if(Number(count) <= 0){
				count=0
				hide();
			}
		}
	}
	
	if(flag){
		showFadeOutMessage(2000,
		"<div style=\"text-algin:center;\"><span style=\"color:red;font-weight:bold;font-size:14pt;\">选择成功！</span><br/>已加入右侧的确认清单。</div>"
		,_MOUSE_PAGE_X-165,_MOUSE_PAGE_Y-120);
	}
};
//闪动新选的商品
function shakeGoodsSelected(goodsID){
	jQuery("li[doinID="+goodsID+"]").fadeTo("normal",0.5).fadeTo("normal",1);
}

//thumb小图大图关联：
var _MAX=5, ThumbColorFlag = "", $ThumPics = null;
//初始化
function initThumbPic()
{
    //判断是否需要绑定事件。
    if(jQuery('[doinID=picThumbUp]').length < 1) return;
    
	//设置参数
	$ThumPics = $('[doinID="picThumb"] li');
	
    //绑定事件
	jQuery('[doinID=picThumbUp]').bind({
	    'click':function(e){
	        e.stopPropagation();
	        moveThumbPic('UP',this);}
	});
	
	jQuery('[doinID=picThumbDown]').bind({
	    'click':function(e){
	        e.stopPropagation();
	        moveThumbPic('DOWN',this);}
	});
	
    jQuery('[doinID="picThumb"] li').bind({
		'click':function(e){
			e.stopPropagation();	
			showThumbPic('click',this);
		},
	    'mouseenter': function(e){	
			e.stopPropagation();
			showThumbPic('mouseenter',this);
	    },
	    'mouseleave': function(e){
			e.stopPropagation();
			showThumbPic('mouseleave',this);
	    } 
	});	
	
	//选中第一个
	$ThumPics.filter(':visible').first().trigger("click");
	setThumbArrow();
}
//点击Thumb图片
function showThumbPic(_event,_this)
{
    var $pic = jQuery('[doinID="picDetail"]');
    var $picBig = jQuery('[doinID="picDetailBig"]');
    
    var $thumb = jQuery(_this).find('a');
    var $thumbOld  = $ThumPics.filter(':visible .selected').find('a');
    
	if('click' == _event){
		$(_this).addClass("selected").siblings().removeClass("selected");
	    $pic.attr("src",    $thumb.attr("imgsmall"))
	        .attr("jqimg",  $thumb.attr("imgbig"));
	    $picBig.attr("href",$thumb.attr("imgbig"));
	};
	if('mouseenter' == _event){		
		$pic.attr("src",    $thumb.attr("imgsmall"))
	};
	if('mouseleave' == _event){
	    $pic.attr("src",    $thumbOld.attr("imgsmall"))
	        .attr("jqimg",  $thumbOld.attr("imgbig"));
	    $picBig.attr("href",$thumbOld.attr("imgbig"));
	};
}
//重置(更换颜色时）
function resetThumPicByColor(_colorID)
{
    //全局变量，当前颜色： ThumbColorFlag,ThumPics
    ThumbColorFlag = _colorID
    $ThumPics = ThumbColorFlag ? 
                  $('[doinID="picThumb"] li[colorid='+ThumbColorFlag+']')
                : $('[doinID="picThumb"] li') ;
                
    $ThumPics.siblings().hide();
    $ThumPics.show();
	
	//选中第一个
	$ThumPics.filter(':visible').first().trigger("click");
	setThumbArrow();
}
//点击滚动箭头
function moveThumbPic(_event,_this)
{
	if('UP' == _event)
	{
	    if( $('[doinID=picThumbUp]').hasClass('prev-null') ) return;
	
	    $ThumPics.filter(':hidden').first().show();
	}
	else if('DOWN' == _event)
	{
	    if( $('[doinID=picThumbDown]').hasClass('next-null') ) return;
	
	    $ThumPics.filter(':visible').first().hide();
	}
	
	//选中第一个
	$ThumPics.filter(':visible').first().trigger("click");
	setThumbArrow();
}
//设置滚动箭头
function setThumbArrow()
{
    _count = $ThumPics.length;
    _countShow = $ThumPics.filter(':visible').length;
    
    if(_countShow==_count)
        $('[doinID=picThumbUp]').removeClass().addClass("prev-null");  
    else
        $('[doinID=picThumbUp]').removeClass().addClass("prev");
    
    if(_countShow>_MAX)
        $('[doinID=picThumbDown]').removeClass().addClass("next");
    else
        $('[doinID=picThumbDown]').removeClass().addClass("next-null");  
}

//用户提交提问
function StyleQuestion(pid)
{
    var content = "";
    var menuid = "";
    
    if($("txtstylequestion"))
    {
        content = $("#txtstylequestion").attr("value");
    }
    if (content.replace(" ","") == "")
    {
             art.dialog({
                time:3000,
                lock:true,
                title:'提示消息',
                content: '请先输入提问内容！'
                        });
        return false; 
    }
    if(content.length > 200 || content.length < 5)
    {   
            art.dialog({
                time:3000,
                lock:true,
                title:'提示消息',
                content: '提问内容的字数请限制在5-200之内！'
                        });
        return false; 
    }
	//content = escape(content);
    menuid = $("input[name^=MenuID]:checked");
    if(menuid == null)
    {
            art.dialog({
                time:3000,
                lock:true,
                title:'提示消息',
                content: '请选择所要提问的问题类型！'
                        });
        return false; 
    }
    menuid = menuid.attr("value");
    //[$syspath]stylequestionlist.aspx?id={cid}
    //post: act, content, menuid
    var url = '/stylequestionlist.aspx?id='+pid;
    var data = {act:"stylequestionlist",txtstylequestion:content.toString(),menuid:menuid.toString()};
    jQuery.post(url,data,function(e){
				eval(e);
				$("#txtstylequestion").attr("value","")
			});
}

//统计评论数字:GBook_TextCount
function GBook_SumCount(_this){
	var MAX = 200;
	var $this = jQuery(_this);
	var text = $this.attr("value");
	vkeyWords=/[`~#$%^&()+=|/\\\][\]\{\}:'<>]/g; 
	$this.attr("value",text.replace(vkeyWords,""));
	if (text.length > MAX){
		$this.attr("value",text.substring(0,MAX));
		jQuery("#GBook_TextCount").html(0);
	}
	else{
		jQuery("#GBook_TextCount").html(MAX-text.length);
	}
}

//统计购买咨询数字:GBook_TextCount
function Comment_SumCount(_this){
	var MAX = 200;
	var $this = jQuery(_this);
	var text = $this.attr("value");
	vkeyWords=/[`~#$%^&()+=|/\\\][\]\{\}:'<>]/g; 
	$this.attr("value",text.replace(vkeyWords,""));
	if (text.length > MAX){
		$this.attr("value",text.substring(0,MAX));
		jQuery("#CommentText_SumCount").html(0);
	}
	else{
		jQuery("#CommentText_SumCount").html(MAX-text.length);
	}
}

//尺码对照表
var goToSizeDetail = function () {
	var sizeDetail = jQuery(".sizeinfo");
	if(sizeDetail[0])
	{
	    jQuery("#J_DetailTabs li:first").click();
		jQuery(document).scrollTop(sizeDetail.offset().top);
	}
}
//收藏商品
function collectProduct(cid) {
    $.ajax({
        type: "POST",
        url: path + "cart.aspx",
        cache: false,
        data: "id=" + cid + "&act=collect",
        success: function(data) {
            if (data == "1") {
            art.dialog({
                time:3000,
                lock:true,
                title:'提示消息',
                content: '收藏成功！'
                        });
            } else if (data == "-1") {
                window.location.href = path + "login.aspx?url="+window.location.href;
            }else
            {
            art.dialog({
                time:3000,
                lock:true,
                title:'提示消息',
                content: '您已经收藏过该商品！'
                        });
            }
        }
    });
}


function Contrast(obj,store,i)
{
    if (!Check_Meth($.trim(obj.value))) {
     art.dialog({
                time:3000,
                lock:true,
                fixed:true,
                title:'提示消息',
                content: "第"+parseFloat(i) +"行采购数量只能为数字！"
                        });
        obj.value="0";
        return false;
    }

    if(parseFloat(obj.value) > parseFloat(store))
    {
         art.dialog({
                time:3000,
                lock:true,
                fixed:true,
                title:'提示消息',
                content: '采购数量不能大于库存!'
                        });
        obj.value=store;
        return false;
    }
}

//判断批量采购总数量
function upperCaseAll(StarCount, i) {
    var cartPCount = $("#cartPCount").val();
    
    var buyallnumber = 0;
    for (var t = 1; t < i; t++) {
        buyallnumber = parseFloat(buyallnumber) + parseFloat($("#Count_" + t).val());
    }
    if (cartPCount == "")//判断购物车中的数量
    {
        cartPCount = 0;
    }
//    alert(parseFloat(buyallnumber) + parseFloat(cartPCount));
//    alert("StarCount=== "+StarCount);
    if (parseFloat(buyallnumber) + parseFloat(cartPCount) < parseFloat(StarCount)) {
        art.dialog({
            time: 3000,
            lock: true,
            fixed: true,
            title: '提示消息',
            content: '采购数量不能小于最低起购数量!'
        });
        return false;
    } else {
        return true;
    }
}

function Check_Meth(nodevalue) {
    var checkOK = "0123456789";
    var checkStr = $.trim(nodevalue);
    var allValid = true;
    var validGroups = true;
    for (i = 0; i < checkStr.length; i++) {
        ch = checkStr.charAt(i);
        for (j = 0; j < checkOK.length; j++) {
            if (ch == checkOK.charAt(j))
                break;
            if (j == (checkOK.length - 1)) {
                allValid = false;
                break;
            }
        }
    }
    return allValid;
}

//用户提交提问
function StyleQuestion(pid)
{
    var content = "";
    var menuid = "";
    if($("txtstylequestion"))
    {
        content = $("#txtstylequestion").val();
    }
    if (content.replace(" ","") == "")
    {
           art.dialog({
                time:3000,
                lock:true,
                fixed:true,
                title:'提示消息',
                content: '请先输入提问内容！'
                        });
        return false;
    }
    if(content.length > 200 || content.length < 5)
    {
               art.dialog({
                time:3000,
                lock:true,
                fixed:true,
                title:'提示消息',
                content: '提问内容的字数请限制在5-200之内！'
                        });
        return false;
    }
    menuid = $("input[name^=MenuID]:checked");
    if(menuid == null)
    {
         art.dialog({
            time:3000,
            lock:true,
            fixed:true,
            title:'提示消息',
            content: '请选择所要提问的问题类型！'
                    });
        return false;
    }
    menuid = menuid.attr("value");
    var url = '/product.aspx?id='+pid;
    var data = {act:"saveproductask",txtstylequestion:content.toString(),menuid:menuid.toString()};
    $.post(url,data,function(e){
        if (parseFloat(e) > 0 ) {
         art.dialog({
            time:3000,
            lock:true,
            fixed:true,
            title:'提示消息',
            content: '您的咨询已经提交成功！请等待工作人员的回复！'
                    });
        }
        else{
         art.dialog({
            time:3000,
            lock:true,
            fixed:true,
            title:'提示消息',
            content: '咨询提交失败！'
                    });
        }
        window.location.href = path +"product.aspx?id="+pid;
    });
}

//统计数字:GBook_TextCount
function GBook_SumCount(_this){
    var MAX = 200;
    var $this = jQuery(_this);
    var text = $this.attr("value");
    vkeyWords=/[`~#$%^&()+=|/\\\][\]\{\}:'<>]/g;
    $this.attr("value",text.replace(vkeyWords,""));
    if (text.length > MAX){
        $this.attr("value",text.substring(0,MAX));
        jQuery("#GBook_TextCount").html(0);
    }
    else{
        jQuery("#GBook_TextCount").html(MAX-text.length);
    }
}

//用户提交评论
function StyleReview(pid)
{
    var content = "";
    var title = "";
    var start = "";

    if($("txtReview"))
    {
        content = $("#txtReview").attr("value");
    }
    if (content.replace(" ","") == "")
    {
         art.dialog({
            time:3000,
            lock:true,
            fixed:true,
            title:'提示消息',
            content: '请先输入评论内容！'
                    });
        return false;
    }
    if(content.length > 200 || content.length < 5)
    {
         art.dialog({
            time:3000,
            lock:true,
            fixed:true,
            title:'提示消息',
            content: '评论内容的字数请限制在5-200之内！'
                    });
        return false;
    }
    if($("title"))
    {
        title = $("#title").val();
    }
    if ($("#title").val().replace(" ","") == "")
    {
         art.dialog({
            time:3000,
            lock:true,
            fixed:true,
            title:'提示消息',
            content: '请先输入评论标题！'
                    });
        return false;
    }

    start = $("input[name^=start]:checked");

    start = start.attr("value");
    var url = '/product.aspx?id='+pid;
    var data = {act:"saveproductreview",title:title.toString(),content:content.toString(),start:start.toString()};
    $.post(url,data,function(e){
        if (parseFloat(e) > 0 ) {
         art.dialog({
            time:3000,
            lock:true,
            fixed:true,
            title:'提示消息',
            content: '您的评论已经提交成功！'
                    });
        }
        else{
            alert(e);
        }
        window.location.href = path +"product.aspx?id="+pid;
    });
}