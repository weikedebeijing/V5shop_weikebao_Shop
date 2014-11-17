var OFFSET = 5;
var page = 1;
var PAGESIZE = 2;

var myScroll,
	pullDownEl, pullDownOffset,
	pullUpEl, pullUpOffset,
	generatedCount = 0;
var maxScrollY = 0;

var hasMoreData = false;

//document.addEventListener('touchmove', function (e) {
//    alert(1);
//    e.preventDefault();
//}, false);

document.addEventListener('DOMContentLoaded', function () {
    $(document).ready(function () {
        loaded();
    });
}, false);

function loaded() {
    pullDownEl = document.getElementById('pullDown');
    pullDownOffset = pullDownEl.offsetHeight;
    pullUpEl = document.getElementById('pullUp');
    pullUpOffset = pullUpEl.offsetHeight;

    hasMoreData = false;
    // $("#thelist").hide();
    $("#pullUp").hide();

    pullDownEl.className = 'loading';
    pullDownEl.querySelector('.pullDownLabel').innerHTML = 'Loading...';

    page = 1;
    $.ajax({
        url: "../../member/Ajax/GateWay.aspx",
        type: "post",
        dataType: "json",
        data: { action: "CATEGORYPAGE", page: page, pagesize: 6 },
        success: function (response) {

            //		    alert(status);
            //		    if (status == "success") {
            $("#thelist").show();

            if (response.list.length < PAGESIZE) {
                hasMoreData = false;
                $("#pullUp").hide();
            } else {
                hasMoreData = true;
                $("#pullUp").show();
            }

            // document.getElementById('wrapper').style.left = '0';

            myScroll = new iScroll('wrapper', {
                useTransition: true,
                topOffset: pullDownOffset,
                onRefresh: function () {
                    if (pullDownEl.className.match('loading')) {
                        pullDownEl.className = 'idle';
                        pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                        this.minScrollY = -pullDownOffset;
                    }
                    if (pullUpEl.className.match('loading')) {
                        pullUpEl.className = 'idle';
                        pullUpEl.querySelector('.pullUpLabel').innerHTML = '正在加载...';
                    }
                },
                onScrollMove: function () {
                    if (this.y > OFFSET && !pullDownEl.className.match('flip')) {
                        pullDownEl.className = 'flip';
                        pullDownEl.querySelector('.pullDownLabel').innerHTML = '释放刷新...';
                        this.minScrollY = 0;
                    } else if (this.y < OFFSET && pullDownEl.className.match('flip')) {
                        pullDownEl.className = 'idle';
                        pullDownEl.querySelector('.pullDownLabel').innerHTML = '下拉刷新...';
                        this.minScrollY = -pullDownOffset;
                    }
                    if (this.y < (maxScrollY - pullUpOffset - OFFSET) && !pullUpEl.className.match('flip')) {
                        if (hasMoreData) {
                            this.maxScrollY = this.maxScrollY - pullUpOffset;
                            pullUpEl.className = 'flip';
                            pullUpEl.querySelector('.pullUpLabel').innerHTML = '释放加载更多...';
                        }
                    } else if (this.y > (maxScrollY - pullUpOffset - OFFSET) && pullUpEl.className.match('flip')) {
                        if (hasMoreData) {
                            this.maxScrollY = maxScrollY;
                            pullUpEl.className = 'idle';
                            pullUpEl.querySelector('.pullUpLabel').innerHTML = '正在加载...';
                        }
                    }
                },
                onScrollEnd: function () {
                  
                    if (pullDownEl.className.match('flip')) {
                        pullDownEl.className = 'loading';
                        pullDownEl.querySelector('.pullDownLabel').innerHTML = 'Loading...';
                        // pullDownAction(); // Execute custom function (ajax call?)
                        refresh();
                    }
                    if (hasMoreData && pullUpEl.className.match('flip')) {
                        pullUpEl.className = 'loading';
                        pullUpEl.querySelector('.pullUpLabel').innerHTML = 'Loading...';
                        // pullUpAction(); // Execute custom function (ajax call?)
                        nextPage();
                    }
                }
            });

            $("#thelist").empty();
            $.each(response.list, function (key, value) {
                $("#thelist").append('<div class="pro-inner"><div class="pro-style"><div class="margin10"><div class="divimg"><a class="img" href="javascript:jumpproduct(' + value.ID + ')"><img src="' + value.DefaultImageData + '" ></a></div><div class="pro-summary"><a  class="name" title="' + value.ProductName + '" href="javascript:jumpproduct(' + value.ID + ')">' + value.ProductName + '</a><span class="price">￥' + value.SalesPrice + '</span></div></div></div>');
                //                $("#thelist").append('');

                //                $("#thelist").append('<div>' + value.Row + '\t' + value.ProductName + '</div>');
            });
            // $("#thelist").listview("refresh");
            myScroll.refresh(); // Remember to refresh when contents are loaded (ie: on ajax completion)
            // pullDownEl.className = 'idle';
            // pullDownEl.querySelector('.pullDownLabel').innerHTML = 'Pull down to refresh...';
            // this.minScrollY = -pullDownOffset;

            if (hasMoreData) {
                myScroll.maxScrollY = myScroll.maxScrollY + pullUpOffset;
            } else {
                myScroll.maxScrollY = myScroll.maxScrollY;
            }
            maxScrollY = myScroll.maxScrollY;
            //		    };
        }
    });

}
//刷新页面
function refresh() {
    page = 1;
    $.ajax({
        url: "../../member/Ajax/GateWay.aspx",
        type: "post",
        dataType: "json",
        data: { action: "CATEGORYPAGE", page: page, pagesize: PAGESIZE },
        success: function (response) {
            $("#thelist").empty();

            myScroll.refresh();

            if (response.list.length < PAGESIZE) {
                hasMoreData = false;
                $("#pullUp").hide();
            } else {
                hasMoreData = true;
                $("#pullUp").show();
            }

            $.each(response.list, function (key, value) {

                $("#thelist").append('<div class="pro-inner"><div class="pro-style"><div class="margin10"><div class="divimg"><a class="img" href="javascript:jumpproduct(' + value.ID + ')"><img src="' + value.DefaultImageData + '" ></a></div><div class="pro-summary"><a  class="name" title="' + value.ProductName + '" href="javascript:jumpproduct(' + value.ID + ')">' + value.ProductName + '</a><span class="price">￥' + value.SalesPrice + '</span></div></div></div>');

            });
            $("#thelist").trigger('create');
            myScroll.refresh(); // Remember to refresh when contents are loaded (ie: on ajax completion)

            if (hasMoreData) {
                myScroll.maxScrollY = myScroll.maxScrollY + pullUpOffset;
            } else {
                myScroll.maxScrollY = myScroll.maxScrollY;
            }
            maxScrollY = myScroll.maxScrollY;
        }
    })

}

function nextPage() {
    page++;

    $.ajax({
        url: "../../member/Ajax/GateWay.aspx",
        type: "post",
        dataType: "json",
        data: { action: "CATEGORYPAGE", page: page, pagesize: PAGESIZE },
        success: function (response) {
           
            if (response.list.length < PAGESIZE) {
                hasMoreData = false;
                $("#pullUp").hide();
            } else {
                hasMoreData = true;
                $("#pullUp").show();
            }

            $.each(response.list, function (key, value) {
           
                $("#thelist").append('<div class="pro-inner"><div class="pro-style"><div class="margin10"><div class="divimg"><a class="img" href="javascript:jumpproduct(' + value.ID + ')"><img src="' + value.DefaultImageData + '" ></a></div><div class="pro-summary"><a  class="name" title="' + value.ProductName + '" href="javascript:jumpproduct(' + value.ID + ')">' + value.ProductName + '</a><span class="price">￥' + value.SalesPrice + '</span></div></div></div>');
            });
            //$("#thelist").listview("refresh");
            myScroll.refresh(); // Remember to refresh when contents are loaded (ie: on ajax completion)
            if (hasMoreData) {
                myScroll.maxScrollY = myScroll.maxScrollY + pullUpOffset;
            } else {
                myScroll.maxScrollY = myScroll.maxScrollY;
            }
            maxScrollY = myScroll.maxScrollY;
        }
    })
}
function jumpproduct(id) {
    window.location.href = "../../product.aspx?id=" + id;
}
function jumpaspx(pagename) {
    window.location.href = pagename;
}