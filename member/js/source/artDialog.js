/*!
* artDialog 5
* Date: 2012-03-21
* http://code.google.com/p/artdialog/
* (c) 2009-2012 TangBin, http://www.planeArt.cn
*
* This is licensed under the GNU LGPL, version 2.1 or later.
* For details, see: http://creativecommons.org/licenses/LGPL/2.1/
*/

;(function (window, undefined) {

var $ = window.art = function (selector, context) {
        return new $.fn.constructor(selector, context);
    },
    quickExpr = /^(?:[^<]*(<[\w\W]+>)[^>]*$|#([\w\-]+)$)/,
    rclass = /[\n\t]/g;

if (window.$ === undefined) {
    window.$ = $;
};

$.fn = $.prototype = {

    constructor: function (selector, context) {
        var match, elem;
        context = context || document;
        
        if (!selector) {
            return this;
        };
        
        if (selector.nodeType) {
            this[0] = selector;
            return this;
        };
            
        if (typeof selector === 'string') {
            match = quickExpr.exec(selector);

            if (match && match[2]) {
                elem = context.getElementById(match[2]);
                if (elem && elem.parentNode) this[0] = elem;
                return this;
            };
        };
        
        this[0] = selector;
        return this;
    },

    /**
    * 判断样式类是否存�?
    * @param	{String}	名称
    * @return	{Boolean}
    */
    hasClass: function (name) {		
        var className = ' ' + name + ' ';
        
        if ((' ' + this[0].className + ' ').replace(rclass, ' ').indexOf(className) > -1) {
            return true;
        };

        return false;
    },

    /**
    * 添加样式�?
    * @param	{String}	名称
    */
    addClass: function (name) {
        if (!this.hasClass(name)) {
            this[0].className += ' ' + name;
        };

        return this;
    },

    /**
    * 移除样式�?
    * @param	{String}	名称
    */
    removeClass: function (name) {
        var elem = this[0];

        if (!name) {
            elem.className = '';
        } else
        if (this.hasClass(name)) {
            elem.className = elem.className.replace(name, ' ');
        };

        return this;
    },

    /**
    * 读写样式<br />
    * css(name) 访问第一个匹配元素的样式属�?br />
    * css(properties) 把一�?�?值对"对象设置为所有匹配元素的样式属�?br />
    * css(name, value) 在所有匹配的元素中，设置一个样式属性的�?br />
    */
    css: function (name, value) {
        var i, elem = this[0], obj = arguments[0];

        if (typeof name === 'string') {
            if (value === undefined) {
                return $.css(elem, name);
            } else {
                elem.style[name] = value;	
            };
        } else {
            for (i in obj) {
                elem.style[i] = obj[i];
            };
        };

        return this;
    },
    
    /** 显示元素 */
    show: function () {
        return this.css('display', 'block');
    },
    
    /** 隐藏元素 */
    hide: function () {
        return this.css('display', 'none');
    },

    /**
    * 获取相对文档的坐�?
    * @return	{Object}	返回left、top的数�?
    */
    offset: function () {
        var elem = this[0],
            box = elem.getBoundingClientRect(),
            doc = elem.ownerDocument,
            body = doc.body,
            docElem = doc.documentElement,
            clientTop = docElem.clientTop || body.clientTop || 0,
            clientLeft = docElem.clientLeft || body.clientLeft || 0,
            top = box.top + (self.pageYOffset || docElem.scrollTop) - clientTop,
            left = box.left + (self.pageXOffset || docElem.scrollLeft) - clientLeft;

        return {
            left: left,
            top: top
        };
    },
    
    /**
    * 读写HTML - (不支持文本框)
    * @param	{String}	内容
    */
    html: function (content) {
        var elem = this[0];
        
        if (content === undefined) return elem.innerHTML;
        $.cleanData(elem.getElementsByTagName('*'));
        elem.innerHTML = content;
        
        return this;
    },
    
    /**
    * 移除节点
    */
    remove: function () {
        var elem = this[0];

        $.cleanData(elem.getElementsByTagName('*'));
        $.cleanData([elem]);
        elem.parentNode.removeChild(elem);
        
        return this;
    },

    /**
    * 事件绑定
    * @param	{String}	类型
    * @param	{Function}	要绑定的函数
    */
    bind: function (type, callback) {
        $.event.add(this[0], type, callback);
        return this;
    },

    /**
    * 移除事件
    * @param	{String}	类型
    * @param	{Function}	要卸载的函数
    */
    unbind: function(type, callback) {
        $.event.remove(this[0], type, callback);
        return this;
    }
    
};

$.fn.constructor.prototype = $.fn;


/** 检测window */
$.isWindow = function (obj) {
    return obj && typeof obj === 'object' && 'setInterval' in obj;
};


/**
* 搜索子元�?
* 注意：只支持nodeName�?className的形式，并且只返回第一个元�?
* @param	{String}
*/
$.fn.find = function (expr) {
    var value, elem = this[0],
        className = expr.split('.')[1];

    if (className) {
        if (document.getElementsByClassName) {
            value = elem.getElementsByClassName(className);
        } else {
            value = getElementsByClassName(className, elem);
        };
    } else {
        value = elem.getElementsByTagName(expr);
    };
    
    return $(value[0]);
};
function getElementsByClassName (className, node, tag) {
    node = node || document;
    tag = tag || '*';
    var i = 0,
        j = 0,
        classElements = [],
        els = node.getElementsByTagName(tag),
        elsLen = els.length,
        pattern = new RegExp("(^|\\s)" + className + "(\\s|$)");
        
    for (; i < elsLen; i ++) {
        if (pattern.test(els[i].className)) {
            classElements[j] = els[i];
            j ++;
        };
    };
    return classElements;
};

/**
* 遍历
* @param {Object}
* @param {Function}
*/
$.each = function (obj, callback) {
    var name, i = 0,
        length = obj.length,
        isObj = length === undefined;

    if (isObj) {
        for (name in obj) {
            if (callback.call(obj[name], name, obj[name]) === false) {
                break;
            };
        };
    } else {
        for (
            var value = obj[0];
            i < length && callback.call(value, i, value) !== false;
            value = obj[++i]
        ) {};
    };
    
    return obj;
};

/**
* 读写缓存
* @param		{HTMLElement}	元素
* @param		{String}		缓存名称
* @param		{Any}			数据
* @return		{Any}			如果无参数data则返回缓存数�?
*/
$.data = function (elem, name, data) {
    var cache = $.cache,
        id = uuid(elem);
    
    if (name === undefined) {
        return cache[id];
    };
    
    if (!cache[id]) {
        cache[id] = {};
    };
    
    if (data !== undefined) {
        cache[id][name] = data;
    };
    
    return cache[id][name];
};

/**
* 删除缓存
* @param		{HTMLElement}	元素
* @param		{String}		缓存名称
*/
$.removeData = function (elem, name) {
    var empty = true,
        expando = $.expando,
        cache = $.cache,
        id = uuid(elem),
        thisCache = id && cache[id];

    if (!thisCache) {
        return;
    };
    
    if (name) {
    
        delete thisCache[name];
        for (var n in thisCache) {
            empty = false;
        };
        
        if (empty) {
            delete $.cache[id];
        };
        
    } else {
    
        delete cache[id];
        
        if (elem.removeAttribute) {
            elem.removeAttribute(expando);
        } else {
            elem[expando] = null;
        };
        
    };
};

$.uuid = 0;
$.cache = {};
$.expando = '@cache' + + new Date;

// 标记元素唯一身份
function uuid (elem) {
    var expando = $.expando,
        id = elem === window ? 0 : elem[expando];
    if (id === undefined) elem[expando] = id = ++ $.uuid;
    return id;
};


/**
* 事件机制
* @namespace
* @requires	[$.data, $.removeData]
*/
$.event = {
    
    /**
    * 添加事件
    * @param		{HTMLElement}	元素
    * @param		{String}		事件类型
    * @param		{Function}		要添加的函数
    */
    add: function (elem, type, callback) {
        var cache, listeners,
            that = $.event,
            data = $.data(elem, '@events') || $.data(elem, '@events', {});
        
        cache = data[type] = data[type] || {};
        listeners = cache.listeners = cache.listeners || [];
        listeners.push(callback);
        
        if (!cache.handler) {
            cache.elem = elem;
            cache.handler = that.handler(cache);
            
            elem.addEventListener
            ? elem.addEventListener(type, cache.handler, false)
            : elem.attachEvent('on' + type, cache.handler);
        };
    },
    
    /**
    * 卸载事件
    * @param		{HTMLElement}	元素
    * @param		{String}		事件类型
    * @param		{Function}		要卸载的函数
    */
    remove: function (elem, type, callback) {
        var i, cache, listeners,
            that = $.event,
            empty = true,
            data = $.data(elem, '@events');
        
        if (!data) {
            return;
        };
        
        if (!type) {
            for (i in data) that.remove(elem, i);
            return;
        };
        
        cache = data[type];
        
        if (!cache) {
            return;
        };
        
        listeners = cache.listeners;
        if (callback) {
            for (i = 0; i < listeners.length; i ++) {
                listeners[i] === callback && listeners.splice(i--, 1);
            };
        } else {
            cache.listeners = [];
        };
        
        if (cache.listeners.length === 0) {
            elem.removeEventListener
            ? elem.removeEventListener(type, cache.handler, false)
            : elem.detachEvent('on' + type, cache.handler);
            
            delete data[type];
            cache = $.data(elem, '@events');
            
            for (var n in cache) {
                empty = false;
            };
            
            if (empty) {
                $.removeData(elem, '@events');
            };
        };
    },
    
    /** @inner 事件句柄 */
    handler: function (cache) {
        return function (event) {
            event = $.event.fix(event || window.event);
            for (var i = 0, list = cache.listeners, fn; fn = list[i++];) {
                if (fn.call(cache.elem, event) === false) {
                    event.preventDefault();
                    event.stopPropagation();
                };
            };
        };
    },
    
    /** @inner Event对象兼容处理 */
    fix: function (event) {
        if (event.target) {
            return event;
        };
        
        var eventObj = {
            target: event.srcElement || document,
            preventDefault: function () {event.returnValue = false},
            stopPropagation: function () {event.cancelBubble = true}
        };
        
        // IE6/7/8 在原生window.event对象写入数据会导致内存无法回收，应当采用拷贝
        for (var i in event) {
            eventObj[i] = event[i];
        }
        
        return eventObj;
    }
    
};

/**
* 清理元素集的事件与缓�?
* @requires	[$.removeData, $.event]
* @param		{HTMLCollection}	元素�?
*/
$.cleanData = function (elems) {
    var i = 0, elem,
        len = elems.length,
        removeEvent = $.event.remove,
        removeData = $.removeData;
    
    for (; i < len; i ++) {
        elem = elems[i];
        removeEvent(elem);
        removeData(elem);
    };
};

// 获取css
$.css = 'defaultView' in document && 'getComputedStyle' in document.defaultView ?
    function (elem, name) {
        return document.defaultView.getComputedStyle(elem, false)[name];
} :
    function (elem, name) {
        return elem.currentStyle[name] || '';
};


/**
* 获取滚动条位�?- [不支持写入]
* $.fn.scrollLeft, $.fn.scrollTop
* @example		获取文档垂直滚动条：$(document).scrollTop()
* @return		{Number}	返回滚动条位�?
*/
$.each(['Left', 'Top'], function (i, name) {
    var method = 'scroll' + name;

    $.fn[method] = function () {
        var elem = this[0], win;

        win = getWindow(elem);
        return win ?
            ('pageXOffset' in win) ?
                win[i ? 'pageYOffset' : 'pageXOffset'] :
                win.document.documentElement[method] || win.document.body[method] :
            elem[method];
    };
});

function getWindow (elem) {
    return $.isWindow(elem) ?
        elem :
        elem.nodeType === 9 ?
            elem.defaultView || elem.parentWindow :
            false;
};

/**
* 获取窗口或文档尺�?- [只支持window与document读取]
* @example 
获取文档宽度�?(document).width()
获取可视范围�?(window).width()
* @return	{Number}
*/
$.each(['Height', 'Width'], function (i, name) {
    var type = name.toLowerCase();

    $.fn[type] = function (size) {
        var elem = this[0];
        if (!elem) {
            return size == null ? null : this;
        };

        return $.isWindow(elem) ?
            elem.document.documentElement['client' + name] || elem.document.body['client' + name] :
            (elem.nodeType === 9) ?
                Math.max(
                    elem.documentElement['client' + name],
                    elem.body['scroll' + name], elem.documentElement['scroll' + name],
                    elem.body['offset' + name], elem.documentElement['offset' + name]
                ) : null;
    };

});

return $}(window));






;(function ($, window, undefined) {

// artDialog 只支�?xhtml 1.0 或者以上的 DOCTYPE 声明
if (document.compatMode === 'BackCompat') {
    throw new Error('artDialog: Document types require more than xhtml1.0');
};

var _singleton,
    _count = 0,
    _expando = 'artDialog' + + new Date,
    _isIE6 = window.VBArray && !window.XMLHttpRequest,
    _isMobile = 'createTouch' in document && !('onmousemove' in document)
        || /(iPhone|iPad|iPod)/i.test(navigator.userAgent),
    _isFixed = !_isIE6 && !_isMobile;

    
var artDialog = function (config, ok, cancel) {

    config = config || {};
    
    if (typeof config === 'string' || config.nodeType === 1) {
    
        config = {content: config, fixed: !_isMobile};
    };
    
    
    var api, defaults = artDialog.defaults;
    var elem = config.follow = this.nodeType === 1 && this || config.follow;
        
    
    // 合并默认配置
    for (var i in defaults) {
        if (config[i] === undefined) {
            config[i] = defaults[i];
        };
    };

    
    config.id = elem && elem[_expando + 'follow'] || config.id || _expando + _count;
    api = artDialog.list[config.id];
    
    
    
    if (api) {
        if (elem) {
            api.follow(elem)
        };
        api.zIndex().focus();
        return api;
    };
    
    
    
    // 目前主流移动设备对fixed支持不好
    if (!_isFixed) {
        config.fixed = false;
    };
    
    // !$.isArray(config.button)
    if (!config.button || !config.button.push) {
        config.button = [];
    };
    
    
    // 确定按钮
    if (ok !== undefined) {
        config.ok = ok;
    };
    
    if (config.ok) {
        config.button.push({
            id: 'ok',
            value: config.okValue,
            callback: config.ok,
            focus: true
        });
    };
    
    
    // 取消按钮
    if (cancel !== undefined) {
        config.cancel = cancel;
    };
    
    if (config.cancel) {
        config.button.push({
            id: 'cancel',
            value: config.cancelValue,
            callback: config.cancel
        });
    };
    
    // 更新 zIndex 全局配置
    artDialog.defaults.zIndex = config.zIndex;
    
    _count ++;

    return artDialog.list[config.id] = _singleton ?
        _singleton.constructor(config) : new artDialog.fn.constructor(config);
};

artDialog.version = '5.0';

artDialog.fn = artDialog.prototype = {
    
    /** @inner */
    constructor: function (config) {
        var dom;
        
        this.closed = false;
        this.config = config;
        this.dom = dom = this.dom || this._getDom();
        
        config.skin && dom.wrap.addClass(config.skin);
        
        dom.wrap.css('position', config.fixed ? 'fixed' : 'absolute');
        dom.close[config.cancel === false ? 'hide' : 'show']();
        dom.content.css('padding', config.padding);
        
        this.button.apply(this, config.button);
        
        this.title(config.title)
        .content(config.content)
        .size(config.width, config.height)
        .time(config.time);
        
        config.follow
        ? this.follow(config.follow)
        : this.position();
        
        this.zIndex();
        config.lock && this.lock();
        
        this._addEvent();
        this[config.visible ? 'visible' : 'hidden']().focus();
        
        _singleton = null;
        
        config.initialize && config.initialize.call(this);
        
        return this;
    },
    
    
    /**
    * 设置内容
    * @param	{String, HTMLElement, Object}	内容 (可�?
    */
    content: function (message) {
    
        var prev, next, parent, display,
            that = this,
            $content = this.dom.content,
            content = $content[0];
        
        
        if (this._elemBack) {
            this._elemBack();
            delete this._elemBack;
        };
        
        
        if (typeof message === 'string') {
        
            $content.html(message);
        } else
        
        if (message && message.nodeType === 1) {
        
            // 让传入的元素在对话框关闭后可以返回到原来的地�?
            display = message.style.display;
            prev = message.previousSibling;
            next = message.nextSibling;
            parent = message.parentNode;
            
            this._elemBack = function () {
                if (prev && prev.parentNode) {
                    prev.parentNode.insertBefore(message, prev.nextSibling);
                } else if (next && next.parentNode) {
                    next.parentNode.insertBefore(message, next);
                } else if (parent) {
                    parent.appendChild(message);
                };
                message.style.display = display;
                that._elemBack = null;
            };
            
            $content.html('');
            content.appendChild(message);
            $(message).show();
            
        };
        
        return this.position();
    },
    
    
    /**
    * 设置标题
    * @param	{String, Boolean}	标题内容. �?false 则隐藏标题栏
    */
    title: function (content) {
    
        var dom = this.dom,
            outer = dom.outer,
            $title = dom.title,
            className = 'd-state-noTitle';
        
        if (content === false) {
            $title.hide().html('');
            outer.addClass(className);
        } else {
            $title.show().html(content);
            outer.removeClass(className);
        };
        
        return this;
    },
    

    /** @inner 位置居中 */
    position: function () {
    
        var dom = this.dom,
            wrap = dom.wrap[0],
            $window = dom.window,
            $document = dom.document,
            fixed = this.config.fixed,
            dl = fixed ? 0 : $document.scrollLeft(),
            dt = fixed ? 0 : $document.scrollTop(),
            ww = $window.width(),
            wh = $window.height(),
            ow = wrap.offsetWidth,
            oh = wrap.offsetHeight,
            left = (ww - ow) / 2 + dl,
            top = top = (oh < 4 * wh / 7 ? wh * 0.382 - oh / 2 : (wh - oh) / 2) + dt,
            style = wrap.style;

        style.left = Math.max(left, dl) + 'px';
        style.top = Math.max(top, dt) + 'px';
        
        return this;
    },
    
    
    /**
    *	尺寸
    *	@param	{Number, String}	宽度
    *	@param	{Number, String}	高度
    */
    size: function (width, height) {
    
        var style = this.dom.main[0].style;
        
        if (typeof width === 'number') {
            width = width + 'px';
        };
        
        if (typeof height === 'number') {
            height = height + 'px';
        };
            
        style.width = width;
        style.height = height;
        
        return this;
    },
    
    
    /**
    * 跟随元素
    * @param	{HTMLElement}
    */
    follow: function (elem) {
    
        var $elem = $(elem),
            config = this.config;
        
        
        // 隐藏元素不可�?
        if (!elem || !elem.offsetWidth && !elem.offsetHeight) {
        
            return this.position(this._left, this._top);
        };
        
        var fixed = config.fixed,
            expando = _expando + 'follow',
            dom = this.dom,
            $window = dom.window,
            $document = dom.document,
            winWidth = $window.width(),
            winHeight = $window.height(),
            docLeft =  $document.scrollLeft(),
            docTop = $document.scrollTop(),
            offset = $elem.offset(),
            width = elem.offsetWidth,
            height = elem.offsetHeight,
            left = fixed ? offset.left - docLeft : offset.left,
            top = fixed ? offset.top - docTop : offset.top,
            wrap = this.dom.wrap[0],
            style = wrap.style,
            wrapWidth = wrap.offsetWidth,
            wrapHeight = wrap.offsetHeight,
            setLeft = left - (wrapWidth - width) / 2,
            setTop = top + height,
            dl = fixed ? 0 : docLeft,
            dt = fixed ? 0 : docTop;
            
            
        setLeft = setLeft < dl ? left :
        (setLeft + wrapWidth > winWidth) && (left - wrapWidth > dl)
        ? left - wrapWidth + width
        : setLeft;

        
        setTop = (setTop + wrapHeight > winHeight + dt)
        && (top - wrapHeight > dt)
        ? top - wrapHeight
        : setTop;
        
        
        style.left = setLeft + 'px';
        style.top = setTop + 'px';
        
        
        this._follow && this._follow.removeAttribute(expando);
        this._follow = elem;
        elem[expando] = config.id;
        
        return this;
    },
    
    
    /**
    * 自定义按�?
    * @example
        button({
            value: 'login',
            callback: function () {},
            disabled: false,
            focus: true
        }, .., ..)
    */
    button: function () {
    
        var dom = this.dom,
            $buttons = dom.buttons,
            elem = $buttons[0],
            strongButton = 'd-state-highlight',
            listeners = this._listeners = this._listeners || {},
            ags = [].slice.call(arguments);
            
        var i = 0, val, value, id, isNewButton, button;
        
        for (; i < ags.length; i ++) {
            
            val = ags[i];
            
            value = val.value;
            id = val.id || value;
            isNewButton = !listeners[id];
            button = !isNewButton ? listeners[id].elem : document.createElement('input');
            
            button.type = 'button';
            button.className = 'd-button';
                    
            if (!listeners[id]) {
                listeners[id] = {};
            };
            
            if (value) {
                button.value = value;
            };
            
            if (val.width) {
                button.style.width = val.width;
            };
            
            if (val.callback) {
                listeners[id].callback = val.callback;
            };
            
            if (val.focus) {
                this._focus && this._focus.removeClass(strongButton);
                this._focus = $(button).addClass(strongButton);
                this.focus();
            };
            
            button[_expando + 'callback'] = id;
            button.disabled = !!val.disabled;
            

            if (isNewButton) {
                listeners[id].elem = button;
                elem.appendChild(button);
            };
        };
        
        $buttons[0].style.display = ags.length ? '' : 'none';
        
        return this;
    },
    
    
    /** 显示对话�?*/
    visible: function () {
        //this.dom.wrap.show();
        this.dom.wrap.css('visibility', 'visible');
        this.dom.outer.addClass('d-state-visible');
        
        if (this._isLock) {
            this._lockMask.show();
        };
        
        return this;
    },
    
    
    /** 隐藏对话�?*/
    hidden: function () {
        //this.dom.wrap.hide();
        this.dom.wrap.css('visibility', 'hidden');
        this.dom.outer.removeClass('d-state-visible');
        
        if (this._isLock) {
            this._lockMask.hide();
        };
        
        return this;
    },
    
    
    /** 关闭对话�?*/
    close: function () {
    
        if (this.closed) {
            return this;
        };
    
        var dom = this.dom,
            $wrap = dom.wrap,
            list = artDialog.list,
            beforeunload = this.config.beforeunload,
            follow = this.config.follow;
        
        if (beforeunload && beforeunload.call(this) === false) {
            return this;
        };
        
        
        if (artDialog.focus === this) {
            artDialog.focus = null;
        };
        
        
        if (follow) {
            follow.removeAttribute(_expando + 'follow');
        };
        
        
        if (this._elemBack) {
            this._elemBack();
        };
        
        
        
        this.time();
        this.unlock();
        this._removeEvent();
        delete list[this.config.id];

        
        if (_singleton) {
        
            $wrap.remove();
        
        // 使用单例模式
        } else {
        
            _singleton = this;
            
            dom.title.html('');
            dom.content.html('');
            dom.buttons.html('');
            
            $wrap[0].className = $wrap[0].style.cssText = '';
            dom.outer[0].className = 'd-outer';
            
            $wrap.css({
                left: 0,
                top: 0,
                position: _isFixed ? 'fixed' : 'absolute'
            });
            
            for (var i in this) {
                if (this.hasOwnProperty(i) && i !== 'dom') {
                    delete this[i];
                };
            };
            
            this.hidden();
            
        };
        
        this.closed = true;
        return this;
    },
    
    
    /**
    * 定时关闭
    * @param	{Number}	单位毫秒, 无参数则停止计时�?
    */
    time: function (time) {
    
        var that = this,
            timer = this._timer;
            
        timer && clearTimeout(timer);
        
        if (time) {
            this._timer = setTimeout(function(){
                that._click('cancel');
            }, time);
        };
        
        
        return this;
    },
    
    /** @inner 设置焦点 */
    focus: function () {

        if (this.config.focus) {
            //setTimeout(function () {
                try {
                    var elem = this._focus && this._focus[0] || this.dom.close[0];
                    elem && elem.focus();
                // IE对不可见元素设置焦点会报�?
                } catch (e) {};
            //}, 0);
        };
        
        return this;
    },
    
    
    /** 置顶对话�?*/
    zIndex: function () {
    
        var dom = this.dom,
            top = artDialog.focus,
            index = artDialog.defaults.zIndex ++;
        
        // 设置叠加高度
        dom.wrap.css('zIndex', index);
        this._lockMask && this._lockMask.css('zIndex', index - 1);
        
        // 设置最高层的样�?
        top && top.dom.outer.removeClass('d-state-focus');
        artDialog.focus = this;
        dom.outer.addClass('d-state-focus');
        
        return this;
    },
    
    
    /** 设置屏锁 */
    lock: function () {
    
        if (this._isLock) {
            return this;
        };
        
        var that = this,
            config = this.config,
            dom = this.dom,
            div = document.createElement('div'),
            $div = $(div),
            index = artDialog.defaults.zIndex - 1;
        
        this.zIndex();
        dom.outer.addClass('d-state-lock');
            
        $div.css({
            zIndex: index,
            position: 'fixed',
            left: 0,
            top: 0,
            width: '100%',
            height: '100%',
            overflow: 'hidden'
        }).addClass('d-mask');
        
        if (!_isFixed) {
            $div.css({
                position: 'absolute',
                width: $(window).width() + 'px',
                height: $(document).height() + 'px'
            });
        };
        
            
        $div.bind('click', function () {
            that._reset();
        }).bind('dblclick', function () {
            that._click('cancel');
        });
        
        document.body.appendChild(div);
        
        this._lockMask = $div;
        this._isLock = true;
        
        return this;
    },
    
    
    /** 解开屏锁 */
    unlock: function () {

        if (!this._isLock) {
            return this;
        };
        
        this._lockMask.unbind();
        this._lockMask.hide();
        this._lockMask.remove();
        
        this.dom.outer.removeClass('d-state-lock');
        this._isLock = false;

        return this;
    },
    
    
    // 获取元素
    _getDom: function () {
    
        var body = document.body;
        
        if (!body) {
            throw new Error('artDialog: "documents.body" not ready');
        };
        
        var wrap = document.createElement('div');
            
        wrap.style.cssText = 'position:absolute;left:0;top:0';
        wrap.innerHTML = artDialog._templates;
        body.insertBefore(wrap, body.firstChild);
        
        var name,
            i = 0,
            dom = {},
            els = wrap.getElementsByTagName('*'),
            elsLen = els.length;
            
        for (; i < elsLen; i ++) {
            name = els[i].className.split('d-')[1];
            if (name) {
                dom[name] = $(els[i]);
            };
        };
        
        dom.window = $(window);
        dom.document = $(document);
        dom.wrap = $(wrap);
        
        return dom;
    },
    
    
    // 按钮回调函数触发
    _click: function (id) {
    
        var fn = this._listeners[id] && this._listeners[id].callback;
            
        return typeof fn !== 'function' || fn.call(this) !== false ?
            this.close() : this;
    },
    
    
    // 重置位置
    _reset: function () {
        var elem = this.config.follow;
        elem ? this.follow(elem) : this.position();
    },
    
    
    // 事件代理
    _addEvent: function () {
    
        var that = this,
            dom = this.dom;
        
        
        // 监听点击
        dom.wrap
        .bind('click', function (event) {
        
            var target = event.target, callbackID;
            
            // IE BUG
            if (target.disabled) {
                return false;
            };
            
            if (target === dom.close[0]) {
                that._click('cancel');
                return false;
            } else {
                callbackID = target[_expando + 'callback'];
                callbackID && that._click(callbackID);
            };
            
        })
        .bind('mousedown', function () {
            that.zIndex();
        });
        
    },
    
    
    // 卸载事件代理
    _removeEvent: function () {
        this.dom.wrap.unbind();
    }
    
};

artDialog.fn.constructor.prototype = artDialog.fn;



$.fn.dialog = $.fn.artDialog = function () {
    var config = arguments;
    this[this.live ? 'live' : 'bind']('click', function () {
        artDialog.apply(this, config);
        return false;
    });
    return this;
};



/** 最顶层的对话框API */
artDialog.focus = null;



/**
* 根据 ID 获取某对话框 API
* @param	{String}	对话�?ID
* @return	{Object}	对话�?API (实例)
*/
artDialog.get = function (id) {
    return id === undefined
    ? artDialog.list
    : artDialog.list[id];
};

artDialog.list = {};



// 全局快捷�?
$(document).bind('keydown', function (event) {
    var target = event.target,
        nodeName = target.nodeName,
        rinput = /^input|textarea$/i,
        api = artDialog.focus,
        keyCode = event.keyCode;

    if (!api || !api.config.esc || rinput.test(nodeName) && target.type !== 'button') {
        return;
    };
    
    // ESC
    keyCode === 27 && api._click('cancel');
});



// 浏览器窗口改变后重置对话框位�?
$(window).bind('resize', function () {
    var dialogs = artDialog.list;
    for (var id in dialogs) {
        dialogs[id]._reset();
    };
});



// XHTML 模板
// 使用 uglifyjs 压缩能够预先处理"+"号合并字符串
// @see	http://marijnhaverbeke.nl/uglifyjs
artDialog._templates = 
'<div class="d-outer">'
+	'<table class="d-border">'
+		'<tbody>'
+			'<tr>'
+				'<td class="d-nw"></td>'
+				'<td class="d-n"></td>'
+				'<td class="d-ne"></td>'
+			'</tr>'
+			'<tr>'
+				'<td class="d-w"></td>'
+				'<td class="d-c">'
+					'<div class="d-inner">'
+					'<table class="d-dialog">'
+						'<tbody>'
+							'<tr>'
+								'<td class="d-header">'
+									'<div class="d-titleBar">'
+										'<div class="d-title"></div>'
+										'<a class="d-close" href="javascript:/*artDialog*/;">'
+											'\xd7'
+										'</a>'
+									'</div>'
+								'</td>'
+							'</tr>'
+							'<tr>'
+								'<td class="d-main">'
+									'<div class="d-content"></div>'
+								'</td>'
+							'</tr>'
+							'<tr>'
+								'<td class="d-footer">'
+									'<div class="d-buttons"></div>'
+								'</td>'
+							'</tr>'
+						'</tbody>'
+					'</table>'
+					'</div>'
+				'</td>'
+				'<td class="d-e"></td>'
+			'</tr>'
+			'<tr>'
+				'<td class="d-sw"></td>'
+				'<td class="d-s"></td>'
+				'<td class="d-se"></td>'
+			'</tr>'
+		'</tbody>'
+	'</table>'
+'</div>';



/**
 * 默认配置
 */
artDialog.defaults = {

    // 消息内容
    content: '<div class="d-loading"><span>loading..</span></div>',
    
    // 标题
    title: 'message',
    
    // 自定义按�?
    button: null,
    
    // 确定按钮回调函数
    ok: null,
    
    // 取消按钮回调函数
    cancel: null,
    
    // 对话框初始化后执行的函数
    initialize: null,
    
    // 对话框关闭前执行的函�?
    beforeunload: null,
    
    // 确定按钮文本
    okValue: 'ok',
    
    // 取消按钮文本
    cancelValue: 'cancel',
    
    // 内容宽度
    width: 'auto',
    
    // 内容高度
    height: 'auto',
    
    // 内容与边界填充距�?
    padding: '0 25px',
    
    // 皮肤�?多皮肤共存预留接�?
    skin: null,
    
    // 自动关闭时间
    time: null,
    
    // 是否支持Esc键关�?
    esc: true,
    
    // 是否支持对话框按钮自动聚�?
    focus: true,
    
    // 初始化后是否显示对话�?
    visible: true,
    
    // 让对话框跟随某元�?
    follow: null,
    
    // 是否锁屏
    lock: false,
    
    // 是否固定定位
    fixed: false,
    
    // 对话框叠加高度�?重要：此值不能超过浏览器最大限�?
    zIndex: 1987
    
};

this.artDialog = $.dialog = $.artDialog = artDialog;
}(this.art || this.jQuery, this));




/* 更新记录

1.  follow 不再支持 String 类型
2.  button 参数只支�?Array 类型
3.  button name 成员改成 value
4.  button 增加 id 成员
5.  okVal 参数更名�?okValue, 默认值由 '确定' 改为 'ok'
6.  cancelVal 参数更名�?cancelValue, 默认值由 '取消' 改为 'cancel'
6.  close 参数更名�?beforeunload
7.  init 参数更名�?initialize
8.  title 参数默认值由 '消息' 改为 'message'
9.  time 参数与方法参数单位由秒改为毫�?
10. hide 参数方法更名�?hidden
11. 内部为皮肤增加动态样�?d-state-visible �?
12. 给遮罩增添样�?d-mask �?
13. background 参数被取�? �?CSS 文件定义
14. opacity 参数被取�? �?CSS 文件定义
15. 取消拖动特性，改由插件支持
16. 取消 left �?top 参数
17. 取消�?ie6 提供 fixed 支持，自动转换为 absolute
18. 取消�?ie6 提供 alpha png 支持
19. 取消�?ie6 提供 select 标签遮盖支持
20. 增加 focus 参数
21. 取消 position 方法
22. 取消�?<script type="text/dialog"></script> 的支�?
23. 取消�?iframe 的支�?
24. title 方法不支持空参数
25. content 方法不支持空参数
26. button 方法的参数不支持数组类型
27. 判断 DOCTYPE, �?xhtml1.0 以下的页面报告错�?
28. 修复 IE8 动态等新内容时没有撑开对话框高度，特意�?ie8 取消 .d-content { display:inline-block }
29. show 参数与方法更名为 visible
30. 修正重复调用 close 方法出现的错�?

*/

