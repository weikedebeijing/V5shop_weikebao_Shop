
(function ($) {
    $.fn.extend({
        'imgbox': function (options) {
            var defaultSetting = {
                'changeTime': 5
            };
            options = $.extend(defaultSetting, options || {})
            return this.each(function () {
                var $obj = $(this);
                $obj.css('position', 'relative');
                var $list = $('div.list', $obj).find('a');
                var t = 2;
                var len = $list.length;
                var i = len;
                var w = parseInt($obj.css('width'));
                var h = parseInt($obj.css('height')) - 30;
                show_imgbox();
                var tid = window.setInterval(function () {
                    show_imgbox();
                }, t * 1000);
                function show_imgbox() {
                    i += 1;
                    if (i >= len) i = 0;
                    var $img = $($list[i]);
                    var title = $img.attr('title');
                    var url = $img.attr('href');
                    var src = $img.find('img').attr('src');
                    var $panel = $('div.imgbox_panel', $obj);
                    if ($panel.length == 0) {
                        $panel = $('<div><a href="javascript:void(0);"><img src="" border="0" /></a></div>').attr('class', 'imgbox_panel');
                        $panel.find('img').css({
                            'width': w + 'px',
                            'height': h + 25 + 'px',
                            'border': 0
                        }).attr('width', w + 'px').attr('height', h + 'px');
                        $obj.append($panel);
                        $panel.mouseover(function (e) {
                            window.clearInterval(tid);
                        }).mouseout(function (e) {
                            tid = window.setInterval(function () {
                                show_imgbox();
                            }, t * 1000);
                        });
                    }
                    $panel.find('img').attr('src', src);
                                            $panel.find('a').attr('href', url).attr('title', title);
                    //                        $panel.find('a:last').html(title);
                    var $u = $('ul.imgbox_num', $obj);
                    if ($u.length == 0) {
                        $u = $('<ul style="display:block;list-style-type:none;overflow:hidden;zoom:1;position:absolute;left:0;top:0;visibility:hidden;text-align:left;padding:0;margin:0;" />').attr('class', 'imgbox_num').css('width', len * 29 + 'px');
                        for (var i2 = 1; i2 <= len; i2++) {
                            $('<li style="display:block;width:20px;height:20px;line-height:20px;text-align:center;vertical-align:middle;float:left;margin:0 3px;border:1px #777 solid;font-weight:700;color:#000;cursor:pointer;" />').html(i2).appendTo($u);
                        }
                        $u.css({
                            'left': (w - $u.width() - 5) + 'px',
                            'top': (h - $u.height() - $panel.find('p').height() - 0) + 'px',
                            'visibility': 'visible'
                        });
                        $obj.append($u);
                        $u.find('li').mouseover(function (e) {
                            window.clearInterval(tid);
                            i = parseInt($(this).html()) - 2;
                            if (i < 0) i = len;
                            show_imgbox();
                        }).mouseout(function (e) {
                            tid = window.setInterval(function () {
                                show_imgbox();
                            }, t * 1000);
                        });
                    }
                    var $uli = $u.find('li');
                    $uli.css({
                        'border': '1px #777 solid',
                        'color': '#000'
                    });
                    $($uli[i]).css({
                        'border': '1px #F60 solid',
                        'color': '#f60'
                    });
                }
            });
        }
    });

})(jQuery);