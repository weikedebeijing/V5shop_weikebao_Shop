/// <reference path="v5messages.js" />
///<reference path="jquery-1.6.2.min.js" />
///<reference path="artDialog.js" />
///<reference path="artDialog.iframeTools.js" />
///<reference path="api.js" />
/**/
//document.write("<script type=\"text/javascript\" src="+ "/"+"script/jquery-1.6.2-vsdoc.js></script>");
document.write("<script type=\"text/javascript\" src=" + "/" + "scripts/api.js></script>");
//document.write("<script type=\"text/javascript\" src=" + "/" + "script/json2/cycle.js></script>");
//document.write("<script type=\"text/javascript\" src=" + "/" + "script/json2/json.js></script>");
//document.write("<script type=\"text/javascript\" src=" + "/" + "script/json2/json_parse.js></script>");
//document.write("<script type=\"text/javascript\" src=" + "/" + "script/json2/json_parse_state.js></script>");
document.write("<script type=\"text/javascript\" src=" + "/" + "scripts/json2/json2.js></script>");
var _W;
///<summary>
///窗体宽度
///</summary>
var _H;
///<summary>
///窗体高度
///</summary>




///<summary>
///URL参数数组
///</summary>
var urlParameters = null;
///<summary>URL参数数组///</summary>


$(document).ready(function () {
    ///<summary>
    ///初始化窗体的宽高值
    ///</summary>
    _W = $(window).width();
    _H = $(window).height();

});
$(window).resize(function () {
    ///<summary>
    ///当窗体改变大小时重新获取当前窗体的宽高值
    ///</summary>
    _W = $(window).width();
    _H = $(window).height();
});


function getUrlParameters() {
    ///<summary>
    ///获取URL参数值，设置数组值到urlParameters，通过urlParameters读取URL参数值。
    ///</summary>

    var _search = decodeURIComponent(location.search).toString();
    //alert(_search);
    if (_search.indexOf('?undefined') != -1) {
        _search = _search.replace("?undefined", "");
        _search = _search.substring(1, _search.length);
    }
    urlParameters = _search.split('&');

}


var grid = {
    ///<summary>
    ///定义表格
    ///</summary>
    list: "",
    ///<summary>
    ///列表容器ID
    ///</summary>
    pager: "",
    ///<summary>
    ///无列表数据的容器ID
    ///</summary>
    nolist: "",

    ///<summary>
    ///要跳转的页码的TextBox ID
    ///</summary>
    jumpbox: "",
    ///<summary>
    ///显示记录总数容器ID
    ///</summary>
    totalPanel: "",
    ///<summary>
    ///显示当前每页显示记录条数容器ID
    ///</summary>
    pagesizelabel: "",
    ///<summary>
    ///列表分页按钮容器ID
    ///</summary>
    pagebuttoncontainer: "",
    ///<summary>
    ///当前页码
    ///</summary>
    pageindex: 1,
    ///<summary>
    ///当前每页显示记录条数
    ///</summary>
    pagesize: 20,
    ///<summary>
    ///表格总页数
    ///</summary>
    pagecount: 0,
    ///<summary>
    ///获取数据入口点(API方法)
    ///</summary>
    entrypoint: "",
    ///<summary>
    ///调用API的基地址
    ///对于不同的业务可能有不同的基地址
    ///</summary>
    baseUrl: "",

    method: "",
    ///<summary>
    ///获取方法(GET/POST),如果为""(即不初始化值),则以POST方式获取数据
    ///</summary>
    rowTemplates: {
        ///<summary>
        ///列表行模版
        ///odd:奇数行模版
        ///even:偶数行模版
        ///</summary>
        odd: "", even: ""
    },
    ///<summary>
    ///数据加载成功的处理事件,如果为null,则内部处理,如果不为null,则根据定义的事件进行处理.
    ///</summary>
    onloadsuccess: null,

    Keywords: null,

    loading: function (b) {
        ///<summary>
        ///显示或关闭Loading效果
        ///</summary>
        $(".Loading").css("visibility", (b ? "visible" : "hidden"));
    },

    getload: function () { },

    postload: function () { },

    load: function () {
        grid.loading(true);
        var jData = {};
        var container = $("#" + this.list);
        //jData.searcher = { PageIndex: grid.pageindex, PageSize: grid.pagesize, Keywords: JSON.stringify({ productcategoryid: 1, b: "b", c: "" }), Filter: null };
        jData.searcher = { PageIndex: grid.pageindex, PageSize: grid.pagesize, Keywords: JSON.stringify(grid.Keywords), Filter: null };

        if (grid.method == "GET") {
            $.get(this.baseUrl + this.entrypoint + "?r=" + Math.random(), function (data) {
                var result = webhelper.converttojsonobject(data);
                //如果没有定义外部事件,则内部处理
                if (grid.onloadsuccess == null) {
                    var _html = "";

                    if (result.Value.List.length > 0) {
                        grid.pagecount = result.Value.PageCount;
                        for (var i = 0; i < result.Value.List.length; i++) {
                            var rowHtml = "";
                            if (i % 2 == 0) {
                                rowHtml = grid.rowTemplates.odd.toLowerCase();
                            }
                            else {
                                rowHtml = grid.rowTemplates.even.toLowerCase();
                            }
                            for (var k in result.Value.List[i]) {
                                var _val = eval("result.Value.List[" + i + "]." + k) + "&nbsp;";
                                if (_val.indexOf("Date") != -1) {
                                    _val = webhelper.convertjsondate(_val, true);
                                }
                                var reg = new RegExp("\\{\\$" + k.toLowerCase() + "\\$\\}", "g");
                                rowHtml = rowHtml.replace(reg, _val);
                            }
                            _html += rowHtml;
                        }
                        $(container).html(_html);
                        $(container).css("display", "");
                        $("#" + grid.nolist).css("display", "none");

                        //create paging button
                        var ten = parseInt(grid.pagecount / 10);
                        var endIndex = grid.pageindex - ten * 10;
                        endIndex = (ten + 1) * 10;
                        if (endIndex > grid.pagecount)
                            endIndex = grid.pagecount;
                        var pagingButtonHTML = "";
                        if (grid.pageindex <= 1) {
                            pagingButtonHTML = "<a>«</a>";
                        } else {
                            pagingButtonHTML = "<a href=\"javascript:grid.jump(1);\">«</a>";
                        }
                        for (var m = (ten * 10 + 1); m <= endIndex; m++) {
                            if (m == grid.pageindex) {
                                pagingButtonHTML += "<span class=\"current\">" + m.toString() + "</span>";
                            } else {
                                pagingButtonHTML += "<a href=\"javascript:grid.jump(" + m.toString() + ")\">" + m.toString() + "</a>";
                            }
                        }
                        if (endIndex == grid.pagecount) {
                            pagingButtonHTML += "<a>»</a>";
                        } else {
                            pagingButtonHTML += "<a href=\"javascript:grid.jump(" + (endIndex + 1).toString() + ");\">»</a>";
                        }
                        $("#" + grid.pagebuttoncontainer).html(pagingButtonHTML);
                        $("#" + grid.totalPanel).html("共有" + result.Value.RecordCount + "条记录");

                    } else {
                        $(container).css("display", "none");
                        $("#" + grid.nolist).css("display", "");
                    }
                    grid.loading(false);
                } else {
                    //如果定义了外部事件,则调用定义的外部事件.
                    grid.onloadsuccess(result);
                }
            });
        } else {
            $.ajax({
                cache: false,
                type: "POST",
                async: false,
                url: this.baseUrl + this.entrypoint + "?r=" + Math.random(),
                data: JSON.stringify(jData),
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    var result = webhelper.converttojsonobject(data);
                    //如果没有定义外部事件,则内部处理
                    if (grid.onloadsuccess == null) {
                        var _html = "";

                        if (result.Value.List.length > 0) {
                            grid.pagecount = result.Value.PageCount;
                            for (var i = 0; i < result.Value.List.length; i++) {
                                var rowHtml = "";
                                if (i % 2 == 0) {
                                    rowHtml = grid.rowTemplates.odd;
                                }
                                else {
                                    rowHtml = grid.rowTemplates.even;
                                }
                                for (var k in result.Value.List[i]) {
                                    var _val = eval("result.Value.List[" + i + "]." + k) + "&nbsp;";
                                    if (_val.indexOf("Date") != -1) {
                                        _val = webhelper.convertjsondate(_val, true);
                                    }
                                    var reg = new RegExp("\\{\\$" + k + "\\$\\}", "g");
                                    rowHtml = rowHtml.replace(reg, _val);
                                }
                                _html += rowHtml;
                            }
                            $(container).html(_html);
                            $(container).css("display", "");
                            $("#" + grid.nolist).css("display", "none");

                            //create paging button
                            var ten = parseInt(grid.pagecount / 10);
                            var endIndex = grid.pageindex - ten * 10;
                            endIndex = (ten + 1) * 10;
                            if (endIndex > grid.pagecount)
                                endIndex = grid.pagecount;
                            var pagingButtonHTML = "";
                            if (grid.pageindex <= 1) {
                                pagingButtonHTML = "<a>«</a>";
                            } else {
                                pagingButtonHTML = "<a href=\"javascript:grid.jump(1);\">«</a>";
                            }
                            for (var m = (ten * 10 + 1); m <= endIndex; m++) {
                                if (m == grid.pageindex) {
                                    pagingButtonHTML += "<span class=\"current\">" + m.toString() + "</span>";
                                } else {
                                    pagingButtonHTML += "<a href=\"javascript:grid.jump(" + m.toString() + ")\">" + m.toString() + "</a>";
                                }
                            }
                            if (endIndex == grid.pagecount) {
                                pagingButtonHTML += "<a>»</a>";
                            } else {
                                pagingButtonHTML += "<a href=\"javascript:grid.jump(" + (endIndex + 1).toString() + ");\">»</a>";
                            }
                            $("#" + grid.pagebuttoncontainer).html(pagingButtonHTML);
                            $("#" + grid.totalPanel).html("共有" + result.Value.RecordCount + "条记录");

                        } else {
                            $(container).css("display", "none");
                            $("#" + grid.nolist).css("display", "");
                        }
                        grid.loading(false);
                    } else {
                        //如果定义了外部事件,则调用定义的外部事件.
                        grid.onloadsuccess(result);
                    }





                },
                error: function (xhr) {
                    //alert(xhr);
                    // alert("ERROR:" + xhr.responseText);
                    // alert(xhr.responseText);
                }
            });




        }
    },


    first: function () {
        ///<summary>
        ///转跳到第一页
        ///</summary>
        this.pageindex = 1;
        this.load();
    },

    prev: function () {
        ///<summary>
        ///转跳到上一页
        ///</summary>
        if (this.pageindex > 1) {
            this.pageindex--;
            this.load();
        }
    },

    next: function () {
        ///<summary>
        ///转跳到下一页
        ///</summary>
        if (this.pageindex < this.pagecount) {
            this.pageindex++;
            this.load();
        }
    },

    last: function () {
        ///<summary>
        ///转跳到最后一页
        ///</summary>
        if (this.pageindex < this.pagecount) {
            this.pageindex = this.pagecount;
            this.load();
        }
    },

    jump: function (n) {
        ///<summary>
        ///转跳到指定的页码
        ///</summary>
        grid.pageindex = n;
        grid.load();
    },

    jumpto: function () {
        ///<summary>
        ///根据输入的页码执行转跳
        ///</summary>
        var n = $("#" + grid.jumpbox).val();
        if (isNaN(n)) {
            alert('请输入要转跳到页码');
        } else {
            n = parseInt(n);
            if (n < 1 || n > grid.pagecount) {
                alert('页码必须在1和' + grid.pagecount + "之间");

            } else {
                grid.jump(n);
            }
        }
    },

    setpagesize: function (n) {
        ///<summary>
        ///设置当前每页显示记录条数
        ///</summary>
        $("#" + grid.pagesizelabel).html(n.toString() + "条");
        this.pagesize = n;
        this.pageindex = 1;
        this.load();
    },

    initEvent: function () {
        ///<summary>
        ///初始化事件
        ///</summary>
        $(arguments).each(function () {
            $("#" + this.toString()).click(function () {
                grid.process();
            });

        });

        $("#spnCurrent").bind("mouseenter", function () {
            $(this).addClass("current");
            $("#dvPageSizePanel").css("visibility", "visible");
        });

        $("#dvPageSizePanel").bind("mouseleave", function () {
            $("#spnCurrent").removeClass("current");
            $(this).css("visibility", "hidden");
        });

    },

    process: function () {
        var param = arguments[0];

    },


    add: function () {
        ///<summary>
        ///添加
        ///</summary>
        var param = arguments[0];
        var url = param.url;
        if (typeof param.params != 'undefined') {
            url = url + '?' + param.params;
        }
        //url = 'http://www.baidu.com';
        $.dialog.open(url, {
            title: param.title, lock: true, opacity: 0.5, width: param.width, height: param.height
        });

    },

    edit: function () {
        ///<summary>
        ///编辑
        ///</summary>
        var param = arguments[0];
        var url = param.url;
        $.dialog.open(url, {
            title: param.title, lock: true, opacity: 0.5, width: param.width, height: param.height
        });
    },

    showexpand: function (isShow) {


    },
    closedialog: function () {
        art.dialog.close();
    }
}


///<summary>
///数据编辑函数
///</summary>
var v5editor = {
    ///<summary>
    ///数据基地址
    ///</summary>
    baseUrl: "",
    ///<summary>
    ///参数名称
    ///</summary>
    paramName: "",
    ///<summary>
    ///要编辑的数据(JSON格式)
    ///</summary>
    entity: {},
    ///<summary>
    ///获取要编辑的数据的入口点
    ///</summary>
    getentrypoint: "",
    ///<summary>
    ///提交处理的方法(方法名) -- 2012-12-06 vickie 
    ///</summary>
    method: "",
    ///<summary>
    ///提交数据入口点 -- 2012-12-06 vickie id值
    ///</summary>
    postentrypoint: "",
    onloadsuccess: null,
    onsubmitsuccess: null,
    onloaderror: null,
    onsumiterror: null,

    load: function () {
        ///<summary>
        ///加载要编辑的数据
        ///</summary>
        $.get("/gateway.aspx?method=" + this.method + "&id=" + this.getentrypoint + "&" + Math.random(), function (data) {
            data = webhelper.converttojsonobject(data);
            v5editor.onloadsuccess(data);
        });
    },

    submit: function () {
        ///<summary>
        ///提交数据
        ///</summary>
        ajaxPost.paramName = this.paramName;
        ajaxPost.paramVal = this.entity;
        ajaxPost.entrypoint = this.postentrypoint;
        ajaxPost.onsuccess = v5editor.onsubmitsuccess;
        ajaxPost.post();

    }

};


var ajaxPost = {
    ///<summary>
    ///统一POST提交数据函数
    ///<summary>
    onsuccess: null,
    onerror: null,
    paramVal: null,
    paramName: "",
    entrypoint: "",
    processing: false,
    post: function () {
        ///<summary>
        ///提交数据
        ///<summary>
        var jData = {};
        eval("(" + "jData." + this.paramName + "=" + JSON.stringify(this.paramVal) + "" + ")");
        $.ajax({
            cache: false,
            type: "POST",
            async: false,
            url: "/gateway.aspx?method=" + this.entrypoint,
            data: "entity=" + encodeURIComponent(JSON.stringify(jData.entity)),
            contentType: "application/x-www-form-urlencoded",
            //url: "/gateway.aspx?method=SaveBrand",
            //data: "entity=" + encodeURIComponent(JSON.stringify(entity)),
            //contentType: "application/x-www-form-urlencoded",
            //dataType: "json",
            success: function (data) {
                data = webhelper.converttojsonobject(data);
                ajaxPost.onsuccess(data);
            },
            error: function (xhr) {
                if (ajaxPost.onerror != null) {
                    ajaxPost.onerror(xhr.responseText);
                }
                // alert(xhr.responseText);
            }
        });
    }
};

var delitem = {
    ///<summary>
    ///删除选中的项目
    ///point为服务的入口点
    ///</summary>
    delitem: function (point) {
        var idlist = new Array();
        //从item-list中取得已经选中的项目
        var checkbox = $("#gridView").find("input[type=checkbox]");
        $(checkbox).each(function () {
            if ($(this).attr("checked")) {
                id = $(this).attr("value");
                idlist.push(id);
            }
        });
        var itl = null;
        //如果列表中没有选中项目的提示
        if (idlist.length == 0) {
            art.dialog({
                title: "提示",
                content: "亲,你还没有选择需要删除的项目哟!",
                icon: "face-smile",
                time: 2
            });
        } else {
            art.dialog.confirm("确定删除所选项？",
                            function () {
                                var l = 0;
                                var c = true;
                                $.dialog.tips("正在删除,请稍后!", 50);
                                itl = setInterval(function () {
                                    if (l >= idlist.length) {
                                        clearInterval(itl);
                                        $.dialog.tips("删除成功").time(3);
                                        setTimeout(function () {
                                            artDialog.open.origin.location.reload();
                                            //v5ui.GirdView.CRMOptaion.init;
                                            return;
                                        }, 1000);

                                    }
                                    //循环删除选择的项
                                    if (l < idlist.length) {
                                        if (c) {
                                            c = false;
                                            $.get(serviceBaseUrl + point + "(" + $.trim(idlist[l].toString()) + ")?" + Math.random(), function (data) {
                                                data = webhelper.converttojsonobject(data);
                                                if (data.IsSuccess) {
                                                    l++;
                                                    c = true;
                                                }

                                            });
                                        }
                                    }
                                }, 1000);
                                //添加成功的提示框
                            }, function () {
                                return true;
                            });
        }
    }
};



var tab = {
    currentTab: 0,
    tabs: null,
    tabpages: null,
    init: function (a, b) {
        this.tabs = $(a).children().eq(0).children();
        this.tabpages = $(b);
        $(this.tabs).each(function (idx, domEle) {
            $(domEle).click(function () {
                tab.currentTab = idx;
                $(tab.tabs).each(function (j, x) {
                    if (j == idx) {
                        $(tab.tabpages[j]).css("display", "");
                        $(x).addClass("Current");
                    }
                    else {
                        $(x).removeClass("Current");
                        $(tab.tabpages[j]).css("display", "none");
                    }
                });


            });
        });
    },
    setDefault: function () {
        $(tab.tabs).each(function (idx, domEle) {
            if ($(domEle).css("display") == "" || $(domEle).css("display") == "list-item") {
                $(domEle).addClass("Current");
                $(domEle).click();
                return;
            }
        });
    }
};

var partial =
{
    entrypoint: "",
    baseurl: "",
    onsuccess: null,
    get: function () {

    },
    post: function () {

    }
}




var webhelper = {
    converttojsonobject: function (data) {
        ///<summary>
        ///将JSON字符串转换成JSON对象
        ///</summary>

        var result = data;
        try {
            if (typeof result != "object")
                result = eval('(' + result + ')');
            while (typeof result != "object") {
                result = webhelper.converttojsonobject(result);
            }
        } catch (e) {
            alert(e);
        }
        return result;
    },

    fillselect: function (c, s, l, d) {
        ///<summary>填充select数据</summary>
        ///<param name="c">select id</param>
        ///<param name="s">数据源</param>
        ///<param name="l">级别深度</param>
        ///<param name="d">默认项,当为null时,如果列表长度大于零,则条填充第一项,如果不为null,则以:<option value="0">==请选择==</option> 类似的字符串填充</param>

        var level = l;
        var preContent = "";
        if (level != 0) {
            preContent = "├";
            for (var x = 0; x < level; x++) {
                preContent += "──";
            }
        }

        for (var i = 0; i < s.length; i++) {

            $("#" + c).append("<option level=\"" + level + "\" id=\"op" + s[i].ID + "\" value=\"" + s[i].ID + "\">" + preContent + s[i].Name + "</option>")
            if (s[i].Children != null) {
                webhelper.fillselect(c, s[i].Children, l + 1, null);
            }
        }
        if (l == 0) {
            if (d != null)
                $("#" + c).prepend(d);
            else {
                if ($("#" + c).children().length > 0) {
                    $("#" + c).attr("selectedIndex", 0);
                }
            }
        }

    },

    createselector: function (h, s, l, d) {
        //if (l == 0 && d != null)
        //{
        //    h += d;
        //}

        var level = l;
        var preContent = "";
        if (level != 0) {
            preContent = "├";
            for (var x = 0; x < level; x++) {
                preContent += "──";
            }
        }

        for (var i = 0; i < s.length; i++) {
            var hasChild = s[i].Children != null && s[i].Children.length > 0;
            hasChild = true;
            h += "<option catname=\"" + s[i].Name + "\" idx=\"" + i.toString() + "\" haschild=\"" + hasChild.toString() + "\" level=\"" + level + "\" id=\"op" + s[i].ID + "\" value=\"" + s[i].ID + "\">" + preContent + s[i].Name + "</option>";
            if (hasChild) {

                h = webhelper.createselector(h, s[i].Children, l + 1, null);
            }
        }
        if (l == 0 && d != null) {
            h += d;
        }


        return h;

    },

    createselectoroptions: function (h, s, l, d, v) {
        ///<summary>创建下拉框选项</summary>
        var level = l;
        var preContent = "";
        if (level != 0) {
            preContent = "├";
            for (var x = 0; x < level; x++) {
                preContent += "──";
            }
        }

        for (var i = 0; i < s.length; i++) {
            var hasChild = s[i].Children != null && s[i].Children.length > 0;
            var _selected = "";
            var _isincluded = false;
            if (v == null) {

            } else {
                var arrSellCids = v.split(',');
                for (var _i = 0; _i < arrSellCids.length; _i++) {
                    if (s[i].Cid == arrSellCids[_i]) {
                        _isincluded = true;
                        break;
                    }
                }

            }

            //if (s[i].Cid == v) {
            if (_isincluded) {
                _selected = "selected = \"selected\"";
                c = true;
            } else {
                if (l == 0 && i == 0)
                    _selected = "selected = \"selected\"";
            }
            h += "<option catname=\"" + s[i].Name + "\"  " + _selected + " idx=\"" + i.toString() + "\" haschild=\"" + hasChild.toString() + "\" level=\"" + level + "\" id=\"op" + s[i].localid + "\" value=\"" + s[i].localid + "\">" + preContent + s[i].displayname + "</option>";
            if (hasChild) {

                h = webhelper.createselectoroptions(h, s[i].Children, l + 1, null, v);
            }
        }
        if (l == 0 && h.indexOf("selected = \"selected\"") == -1)
            h += d;


        return h;

    },


    convertjsondate: function (jsonvalue, includetime) {
        ///<summary>
        ///将JSON日期值转换成日期格式
        ///</summary>
        ///<param name="jsonvalue">JSON日期值</param>
        ///<param name="includetime">返回值是否包括时间</param>

        var value = jsonvalue.replace("Date(", "").replace("/", "").replace("+0800)\/", "").replace(")\/", "");

        var d = new Date(parseInt(value, 10));

        var dval = d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + (d.getDay() + 3);
        if (includetime)
            dval += " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
        return dval;

    },

    createselect: function (s, l, d) {
        ///<summary>创建select选项列表HTML</summary>
        ///<param name="s">数据源</param>
        ///<param name="l">级别深度</param>
        ///<param name="d">默认项,当为null时,如果列表长度大于零,则条填充第一项,如果不为null,则以:<option value="0">==请选择==</option> 类似的字符串填充</param>
        var opHTML = "";
        if (l == 0) {
            if (d != null) {
                opHTML = d;
            }

        }
        var level = l;
        var preContent = "";
        if (level != 0) {
            preContent = "├";
            for (var x = 0; x < level; x++) {
                preContent += "──";
            }
        }

        for (var i = 0; i < s.length; i++) {
            if (opHTML == "" && level == 0) {
                opHTML += "<option value=\"" + s[i].ID + "\" selected=\"selected\">" + preContent + s[i].Name + "</option>";
            } else {
                opHTML += "<option value=\"" + s[i].ID + "\">" + preContent + s[i].Name + "</option>";
            }

            if (s[i].Children != null) {
                opHTML += webhelper.createselect(s[i].Children, l + 1, null);
            }
        }

        return opHTML;

    },

    createtree: function (s, l) {
        ///<summary>
        ///创建树形
        ///</summary>
        ///<param name="s">数据源</param>
        ///<param name="l">等级/深度</param>
        var menuHTML = "";

        for (var i = 0; i < s.length; i++) {
            menuHTML += "<li class=\"bbit-tree-node\">";
            var preContent = "";
            for (var j = 0; j < l; j++) {
                preContent += "<img  class=\"bbit-tree-icon\"  src=\"../Images/tree/s.gif\">";
            }
            if (s[i].Children != null) {
                menuHTML += "<div id=\"tree_" + s[i].ID + "\" tpath=\"" + l + "\" unselectable=\"on\" title=\"" + s[i].Name + "\" class=\"bbit-tree-node-el bbit-tree-node-collapsed\"> <span class=\"bbit-tree-node-indent\">" + preContent + "</span> <img name=\"imgbtn\" state=\"off\" cid=\"" + s[i].ID + "\" class=\"bbit-tree-ec-icon bbit-tree-elbow-plus\" src=\"../Images/tree/s.gif\"><img class=\"bbit-tree-node-icon\" src=\"../Images/tree/s.gif\"><a hidefocus=\"\" class=\"bbit-tree-node-anchor\" tabindex=\"1\" href=\"/product/products.aspx?c=" + s[i].ID + "\" target=\"right\"><span unselectable=\"on\">" + s[i].Name + "</span> </a></div>";

                menuHTML += " <ul id=\"treeul_" + s[i].ID + "\" style=\"z-index: 0; position: static; visibility: visible; top: auto; left: auto; display:none; \" class=\"bbit-tree-node-ct\">"

                menuHTML += webhelper.createtree(s[i].Children, l + 1);

                menuHTML += "</ul>";

            } else {
                menuHTML += "<div id=\"tree_" + s[i].ID + "\" tpath=\"" + l + "\" unselectable=\"on\" title=\"" + s[i].Name + "\" class=\"bbit-tree-node-el bbit-tree-node-collapsed\"> <span class=\"bbit-tree-node-indent\">" + preContent + "</span> <img class=\"bbit-tree-ec-icon \" src=\"../Images/tree/s.gif\"><img class=\"bbit-tree-node-icon\" src=\"../Images/tree/s.gif\"><a hidefocus=\"\" class=\"bbit-tree-node-anchor\" tabindex=\"1\" href=\"/product/products.aspx?c=" + s[i].ID + "\" target=\"right\"><span unselectable=\"on\">" + s[i].Name + "</span> </a></div>";

                menuHTML += "<ul style=\"display: none;\"></ul>";
            }


            menuHTML += "</li>";
        }

        return menuHTML;
    }


};


function pageY(el) {
    var ot = 0;
    while (el && el.offsetParent != el) {
        ot += el.offsetTop ? el.offsetTop : 0;
        el = el.offsetParent;
    }
    return ot;
}

function pageX(el) {
    var ol = 0;
    while (el && el.offsetParent != el) {
        ol += el.offsetLeft ? el.offsetLeft : 0;
        el = el.offsetParent;
    }
    return ol;
}

function fileMove() {
    if (navigator.appName == "Microsoft Internet Explorer") {
        return; // Don't need to do this in IE.
    }
    var link = document.getElementById("fileLink");
    var form = document.getElementById("uploadForm");
    var x = pageX(link);
    var y = pageY(link);
    form.style.position = 'absolute';
    form.style.left = x + 'px';
    form.style.top = y + 'px';
}


//function checkImage(selectId, selectPath) {
//    var origin = artDialog.open.origin;
//    var aValue = selectId;
//    var input = origin.document.getElementById('selectImageId');
//    origin.document.getElementById("selectetImage").src = "../" + selectPath;
//    input.value = aValue;
//    input.select();
//    art.dialog.close();
//};




function combineProducts(CombinList) {
    ///<summary>
    ///合并生成规格产品
    ///</summary>
    var Result = new Array();

    var CombineCount = 1;
    for (i in CombinList) {
        CombineCount *= CombinList[i].Values.length;
    }

    var RepeatTime = CombineCount;
    if (RepeatTime == 1) {
        var arr = new Array();
        for (var j = 0; j < CombinList.length; j++) {
            var _p = { SpecificationID: 0, SpecificationName: "", Val: 0 };
            _p.SpecificationID = CombinList[j].SpecificationID;
            _p.SpecificationName = CombinList[j].SpecificationName;
            _p.Val = CombinList[j].Values[0];
            arr.push(_p);
        }
        Result.push(arr);
    } else {
        for (i in CombinList) {
            var ClassNo = i;
            var StudentList = CombinList[i];
            RepeatTime = RepeatTime / StudentList.Values.length;
            var StartPosition = 0;

            for (j in StudentList.Values) {
                var TempStartPosition = StartPosition;
                var SpaceCount = CombineCount / StudentList.Values.length / RepeatTime;
                for (var J = 1; J <= SpaceCount; J++) {

                    for (var I = 0; I < RepeatTime; I++) {
                        if (typeof (Result[TempStartPosition + I]) == 'undefined') {
                            Result[TempStartPosition + I] = new Array();
                        }
                        Result[TempStartPosition + I].push({ SpecificationID: CombinList[i].SpecificationID, SpecificationName: CombinList[i].SpecificationName, Val: StudentList.Values[j] });
                    }
                    TempStartPosition += RepeatTime * StudentList.Values.length;
                }
                StartPosition += RepeatTime;
            }

        }
    }
    return Result;
}




var uploader = {
    ///<summary>
    ///文件上传组件
    ///</summary>
    form: null,
    container: "",
    fileinput: null,
    params: new Array(),
    files: new Array(),
    formats: new Array("jpg", "png", "gif", "bmp"),
    message: "",
    onsuccess: null,
    onerror: null,

    init: function () {
        ///<summary>初始化上传组件</summary>
        $("#" + this.container).append("<iframe src='/fileupload.aspx?" + Math.random() + "' style='width:100%; border:0px; height:35px;'></iframe>");
    },

    validation: function (F) {
        ///<summary>
        ///文件验证
        ///<summary>
        ///<param name="F">文件路径</param>
        F = $.trim(F);
        var isValid = false;

        if (F.length == "") {
            this.message = "请选择要上传的文件.";
            isValid = false;
        }
        else if (F.length < 4) {
            this.message = "不合法文件.";
            isValid = false;
        } else {
            var ext = F.substring(F.length - 3, F.length).toLowerCase();
            for (var i = 0; i < this.formats.length; i++) {
                if (ext == this.formats[i]) {
                    isValid = true;
                    break;
                }
            }
            if (isValid == false) {
                this.message = "文件格式不允许.";
            }
        }

        return isValid;
    },
    submit: function () {
        ///<summary>
        ///提交上传图片
        ///<summary>
        if (this.validation($(this.fileinput).val()))
            this.form.submit();
        else
            art.dialog({
                title: "错误",
                content: this.message,
                icon: "face-sad",
                time: 2
            });
    }
};



function isEncHTML(str) {
    if (str.search(/&amp;/g) != -1 || str.search(/&lt;/g) != -1 || str.search(/&gt;/g) != -1 || str.search(/&quot;/g) != -1)
        return true;
    else
        return false;
};

function decHTML(str) {
    if (isEncHTML(str))
        return str.replace(/&amp;/g, '&').replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '\\\"');
    return str;
};

function isDecHTML(str) {
    if (str.search(/&/g) != -1 || str.search(/</g) != -1 || str.search(/>/g) != -1 || str.search(/\"/g) != -1)
        return true;
    else
        return false;
};

function encQuot(str) {
    return str.replace(/\"/g, "&quot;");
}


function encHTML(str) {
    if (isEncHTML(str))
        return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\"/g, '&quot;');
    return str;
}