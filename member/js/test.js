define('module/newthread', ['module/emotion', 'module/gps'],
function (require, exports, module) {
    "require:nomunge,exports:nomunge,module:nomunge";
    var gps = require('module/gps');
    var emotion = require('module/emotion');
    module.exports = {
        maxUpload: 8,
        uploadInfo: {},
        uploadQueue: [],
        previewQueue: [],
        xhr: {},
        isBusy: false,
        getgps: 1,
        contentHeight: 0,
        countUpload: function () {
            var num = 0;
            jq.each(module.exports.uploadInfo,
			function (i, n) {
			    if (n) {
			        ++num;
			    }
			});
            return num;
        },
        uploadPreview: function (id) {
            var reader = new FileReader();
            var uploadBase64;
            var conf = {},
			file = module.exports.uploadInfo[id].file;
            if (window.NETTYPE == window.NETTYPE_WIFI) {
                conf = {
                    maxW: 3000,
                    maxH: 1280,
                    quality: 0.8,
                };
            }
            reader.onload = function (e) {
                var result = this.result;
                if (file.type == 'image/jpeg') {
                    try {
                        var jpg = new JpegMeta.JpegFile(result, file.name);
                    } catch (e) {
                        jq.DIC.dialog({
                            content: '图片不是正确的图片数据',
                            autoClose: true
                        });
                        jq('#li' + id).remove();
                        return false;
                    }
                    if (jpg.tiff && jpg.tiff.Orientation) {
                        conf = jq.extend(conf, {
                            orien: jpg.tiff.Orientation.value
                        });
                    }
                }
                if (ImageCompresser.support()) {
                    var img = new Image();
                    img.onload = function () {
                        console.log(conf);
                        try {
                            uploadBase64 = ImageCompresser.getImageBase64(this, conf);
                        } catch (e) {
                            jq.DIC.dialog({
                                content: '压缩图片失败',
                                autoClose: true
                            });
                            jq('#li' + id).remove();
                            return false;
                        }
                        if (uploadBase64.indexOf('data:image') < 0) {
                            jq.DIC.dialog({
                                content: '上传照片格式不支持',
                                autoClose: true
                            });
                            jq('#li' + id).remove();
                            return false;
                        }
                        module.exports.uploadInfo[id].file = uploadBase64;
                        jq('#li' + id).find('img').attr('src', uploadBase64);
                        module.exports.uploadQueue.push(id);
                    }
                    img.onerror = function () {
                        jq.DIC.dialog({
                            content: '解析图片数据失败',
                            autoClose: true
                        });
                        jq('#li' + id).remove();
                        return false;
                    }
                    img.src = ImageCompresser.getFileObjectURL(file);
                } else {
                    uploadBase64 = result;
                    if (uploadBase64.indexOf('data:image') < 0) {
                        jq.DIC.dialog({
                            content: '上传照片格式不支持',
                            autoClose: true
                        });
                        jq('#li' + id).remove();
                        return false;
                    }
                    module.exports.uploadInfo[id].file = uploadBase64;
                    jq('#li' + id).find('img').attr('src', uploadBase64);
                    module.exports.uploadQueue.push(id);
                }
            }
            reader.readAsBinaryString(module.exports.uploadInfo[id].file);
        },
        createUpload: function (id) {
            if (!module.exports.uploadInfo[id]) {
                return false;
            }
            var uploadUrl = DOMAIN + sId + '/pic/upload?isAjax=true&resType=json';
            var progressHtml = '<div class="progress brSmall pr" id="progress' + id + '"><div class="proBar" style="width:0%;"></div></div>';
            jq('#li' + id).find('.maskLay').after(progressHtml);
            var formData = new FormData();
            formData.append('pic', module.exports.uploadInfo[id].file);
            formData.append('CSRFToken', CSRFToken);
            formData.append('sId', sId);
            formData.append('id', id);
            var progress = function (e) {
                if (e.target.response) {
                    var result = jq.parseJSON(e.target.response);
                    if (result.errCode != 0) {
                        jq.DIC.dialog({
                            content: '网络不稳定，请稍后重新操作',
                            autoClose: true
                        });
                        removePic(id);
                        module.exports.uploadRemaining();
                        return false;
                    }
                }
                var progress = jq('#progress' + id).find('.proBar');
                if (e.total == e.loaded) {
                    var percent = 100;
                } else {
                    var percent = 100 * (e.loaded / e.total);
                }
                if (percent > 100) {
                    percent = 100;
                }
                progress.css('width', percent + '%');
                setTimeout(function () {
                    if (percent == 100) {
                        jq('#li' + id).find('.maskLay').remove();
                        jq('#li' + id).find('.progress').remove();
                        donePic(id);
                    }
                },
				400);
            }
            var removePic = function (id) {
                donePic(id);
                jq('#li' + id).remove();
            }
            var donePic = function (id) {
                module.exports.isBusy = false;
                if (typeof module.exports.uploadInfo[id] != 'undefined') {
                    module.exports.uploadInfo[id].isDone = true;
                }
                if (typeof module.exports.xhr[id] != 'undefined') {
                    module.exports.xhr[id] = null;
                }
            }
            var complete = function (e) {
                var progress = jq('#progress' + id).find('.proBar');
                progress.css('width', '100%');
                jq('#li' + id).find('.maskLay').remove();
                jq('#li' + id).find('.progress').remove();
                donePic(id);
                var result = jq.parseJSON(e.target.response);
                if (result.errCode == 0) {
                    var input = '<input type="hidden" id="input' + result.data.id + '" name="picIds[]" value="' + result.data.picId + '">';
                    jq('#newthread').append(input);
                } else {
                    jq.DIC.dialog({
                        content: '网络不稳定，请稍后重新操作',
                        autoClose: true
                    });
                    removePic(id);
                    module.exports.uploadRemaining();
                }
            }
            var failed = function () {
                jq.DIC.dialog({
                    content: '网络断开，请稍后重新操作',
                    autoClose: true
                });
                removePic(id)
            }
            var abort = function () {
                jq.DIC.dialog({
                    content: '上传已取消',
                    autoClose: true
                });
                removePic(id)
            }
            module.exports.xhr[id] = new XMLHttpRequest();
            module.exports.xhr[id].addEventListener("progress", progress, false);
            module.exports.xhr[id].upload.addEventListener("progress", progress, false);
            module.exports.xhr[id].addEventListener("load", complete, false);
            module.exports.xhr[id].addEventListener("abort", abort, false);
            module.exports.xhr[id].addEventListener("error", failed, false);
            module.exports.xhr[id].open("POST", uploadUrl + '&t=' + Date.now());
            module.exports.xhr[id].send(formData);
        },
        checkUploadBySysVer: function () {
            if (jQuery.os.android) {
                var MQQBrowser = navigator.userAgent.match(/MQQBrowser\/([^\s]+)/);
                if (!MQQBrowser || MQQBrowser && MQQBrowser[1] < '5.2') {
                    if (jQuery.os.version.toString().indexOf('4.4') === 0 || jQuery.os.version.toString() <= '2.1') {
                        jq.DIC.dialog({
                            'content': '您的手机系统暂不支持传图',
                            'autoClose': true
                        });
                        return false;
                    }
                }
            } else if (jQuery.os.ios && jQuery.os.version.toString() < '6.0') {
                jq.DIC.dialog({
                    'content': '手机系统不支持传图，请升级到ios6.0以上',
                    'autoClose': true
                });
                return false;
            }
            if (jQuery.os.wx && jQuery.os.wxVersion.toString() < '5.2') {
                jq.DIC.dialog({
                    'content': '当前微信版本不支持传图，请升级到最新版',
                    'autoClose': true
                });
                return false;
            }
            return true;
        },
        initUpload: function () {
            jq('#addPic, .uploadPicBox').on('click',
			function () {
			    if (!module.exports.checkUploadBySysVer()) {
			        return false;
			    }
			});
            jq('#uploadFile, #fistUploadFile').on('click',
			function () {
			    var thisObj = jq(this);
			    if (jq('.photoList').find('#livideo').length > 0) {
			        jq.DIC.dialog({
			            id: 'addWsTips',
			            content: '图片和微视只能发一种哦~',
			            autoClose: 2000
			        });
			        return false;
			    }
			    if (module.exports.isBusy) {
			        jq.DIC.dialog({
			            content: '上传中，请稍后添加',
			            autoClose: true
			        });
			        return false;
			    }
			    if (thisObj.attr('id') == 'fistUploadFile') {
			        if (jq('.iconSendImg').hasClass('fail')) {
			            jq.DIC.dialog({
			                content: '不能再上传了，最多只能上传8张图片哦~',
			                autoClose: true
			            });
			            return false;
			        }
			    }
			});
            jq('body').on('click', '.iconSendImg, .iconArrowR',
			function (e) {
			    var thisObj = jq(this);
			    var photoList = jq('.photoList');
			    if (thisObj.hasClass('iconSendImg')) {
			        if (photoList.is(':hidden')) {
			            jq('.sendCon').css('height', '60');
			            photoList.show();
			        }
			    }
			    if (thisObj.hasClass('iconArrowR')) {
			        var expressionMenu = jq('.expressionMenu').find('a');
			        var haveMenuWidth = expressionMenu.length * 76;
			        var expressionTabWidth = jq('.expressionTab').width();
			        if (haveMenuWidth > expressionTabWidth) {
			            var firstChild = jq(expressionMenu[0]);
			            jq('.expressionMenu').append(firstChild.clone());
			            firstChild.remove();
			        } else {
			            jq.DIC.dialog({
			                id: 'haveMoreExpression',
			                content: '没有更多表情了哦~',
			                autoClose: true
			            });
			        }
			    }
			});
            jq('body').on('change', '#fistUploadFile',
			function (e) {
			    var content = jq('#content')[0];
			    jq('.photoList').show();
			    jq('.operatList').hide();
			    jq('.photoTipsBox').show();
			    jq('.operatIcon').removeClass('on');
			    jq('.iconSendImg').addClass('on');
			    if (jq('.sendCon').height() != 60) {
			        jq('.sendCon').css('height', '60');
			    }
			    content.scrollTop = content.scrollHeight
			});
            jq('body').on('change', '#uploadFile, #fistUploadFile',
			function (e) {
			    e = e || window.event;
			    var fileList = e.target.files;
			    if (!fileList.length) {
			        return false;
			    }
			    for (var i = 0; i < fileList.length; i++) {
			        if (module.exports.countUpload() >= module.exports.maxUpload) {
			            jq.DIC.dialog({
			                content: '你最多只能上传8张照片',
			                autoClose: true
			            });
			            break;
			        }
			        var file = fileList[i];
			        if (!module.exports.checkPicType(file)) {
			            jq.DIC.dialog({
			                content: '上传照片格式不支持',
			                autoClose: true
			            });
			            continue;
			        }
			        if (!module.exports.checkPicSize(file)) {
			            jq.DIC.dialog({
			                content: '图片体积过大',
			                autoClose: true
			            });
			            continue;
			        }
			        var id = Date.now() + i;
			        module.exports.uploadInfo[id] = {
			            file: file,
			            isDone: false,
			        };
			        var html = '<li id="li' + id + '"><div class="photoCut"><img src="http://dzqun.gtimg.cn/quan/images/defaultImg.png" class="attchImg" alt="photo"></div>' + '<div class="maskLay"></div>' + '<a href="javascript:;" class="cBtn cBtnOn pa db" title="" _id="' + id + '">关闭</a></li>';
			        jq('#addPic').before(html);
			        module.exports.previewQueue.push(id);
			        if (module.exports.countUpload() >= module.exports.maxUpload) {
			            jq('#addPic').hide();
			            jq('.iconSendImg').addClass('fail');
			        }
			        setTimeout(function () {
			            module.exports.uploadRemaining();
			        },
					400);
			    }
			    jq(this).val('');
			});
            jq('.photoList').on('click', '.cBtn',
			function () {
			    var id = jq(this).attr('_id');
			    if (module.exports.xhr[id]) {
			        module.exports.xhr[id].abort();
			    }
			    jq('#li' + id).remove();
			    jq('#input' + id).remove();
			    module.exports.uploadInfo[id] = null;
			    if (id == 'video') {
			        jq('.iconVideo').addClass('iconVideoOn');
			    }
			    if (module.exports.countUpload() < module.exports.maxUpload) {
			        jq('#addPic').show();
			        jq('.iconSendImg').removeClass('fail');
			    }
			    module.exports.uploadRemaining();
			    if (jq('.photoList').find('li').length < 2) {
			        jq('.photoList').hide();
			        jq('.sendCon').css('height', module.exports.contentHeight);
			    }
			});
            setInterval(function () {
                setTimeout(function () {
                    if (module.exports.previewQueue.length) {
                        var jobId = module.exports.previewQueue.shift();
                        module.exports.uploadPreview(jobId);
                    }
                },
				1);
                setTimeout(function () {
                    if (!module.exports.isBusy && module.exports.uploadQueue.length) {
                        var jobId = module.exports.uploadQueue.shift();
                        module.exports.isBusy = true;
                        module.exports.createUpload(jobId);
                    }
                },
				10);
            },
			300);
        },
        init: function () {
            module.exports.contentHeight = jq('.sendCon').height();
            var storageKey = sId + "thread_content";
            jq('#content').val(localStorage.getItem(storageKey));
            timer = setInterval(function () {
                localStorage.removeItem(storageKey);
                localStorage.setItem(storageKey, jq('#content').val());
            },
			500);
            var isSubmitButtonClicked = false;
            jq('#submitButton').bind('click',
			function () {
			    if (module.exports.isBusy) {
			        jq.DIC.dialog({
			            content: '上传中，请稍后发帖',
			            autoClose: true
			        });
			        return false;
			    }
			    if (isSubmitButtonClicked || !module.exports.checkForm()) {
			        return false;
			    }
			    var opt = {
			        'noMsg': true,
			        success: function (re) {
			            var status = parseInt(re.errCode);
			            if (status == 0) {
			                clearInterval(timer);
			                localStorage.removeItem(storageKey);
			                if (re.data.subscribeTip && isWX) {
			                    jq.DIC.dialog({
			                        content: '发表成功。是否接收回复提醒？',
			                        okValue: '确定',
			                        cancelValue: '取消',
			                        isMask: true,
			                        ok: function () {
			                            pgvSendClick({
			                                hottag: 'wx.guide.follow.yes'
			                            });
			                            jq.DIC.reload('http://mp.weixin.qq.com/s?__biz=MzA5MTEzMDUyMw==&mid=200420371&idx=1&sn=ff6c7912111f04fa412615094128551c');
			                        },
			                        cancel: function () {
			                            pgvSendClick({
			                                hottag: 'wx.guide.follow.no'
			                            });
			                            jq.DIC.reload(re.jumpURL);
			                        }
			                    });
			                    pgvSendClick({
			                        hottag: 'wx.guide.follow.show'
			                    });
			                } else {
			                    jq.DIC.reload(re.jumpURL);
			                }
			                return false;
			            } else {
			                if (status == 34428) {
			                    module.exports.userGenderPopWin();
			                }
			                isSubmitButtonClicked = false;
			                if (status != 34428) {
			                    jq.DIC.dialog({
			                        content: re.message,
			                        autoClose: true
			                    });
			                }
			            }
			        },
			        error: function (re) {
			            isSubmitButtonClicked = false;
			        },
			        'noJump': true
			    };
			    isSubmitButtonClicked = true;
			    jq.DIC.ajaxForm('newthread', opt, true);
			    return false;
			});
            jq('.cancelBtn').bind('click',
			function () {
			    if (jq('.photoList .attchImg').length > 0) {
			        jq.DIC.dialog({
			            content: '是否放弃当前内容?',
			            okValue: '确定',
			            cancelValue: '取消',
			            isMask: true,
			            ok: function () {
			                history.go(-1);
			            }
			        });
			    } else {
			        history.go(-1);
			    }
			});
            jq('#content').on('focus',
			function () {
			    jq('.bNav').hide();
			}).on('blur',
			function () {
			    jq('.bNav').show();
			});
            module.exports.initUpload();
            module.exports.initModal();
            emotion.init();
            jq(".photoSelect").on("click", emotion.hide);
            jq(".tagBox a").on("click",
			function () {
			    jq(".tagBox").find('a').attr('class', '');
			    jq('.tagTopic').hide();
			    var labelId = jq(this).attr('labelId');
			    if (jq('input[name="fId"]').val() != labelId) {
			        jq(this).attr('class', 'on');
			        jq('.tagTopic').text(jq(this).text()).show();
			        jq('.sendCon').addClass('tagCon');
			        jq('input[name="fId"]').val(labelId);
			    } else {
			        jq('input[name="fId"]').val(0);
			        jq('.sendCon').removeClass('tagCon');
			    }
			});
            var selTagId = jq.DIC.getQuery('filterType');
            if (selTagId) {
                var tagArr = jq('.tagBox').find('a');
                jq.each(tagArr,
				function (key, value) {
				    jq(value).removeClass('on');
				    if (jq(value).attr('labelid') == selTagId) {
				        jq(value).addClass('on');
				        jq(value).click();
				        jq('input[name="fId"]').val(selTagId);
				    }
				})
            }
            if (parseInt(jq('.locationCon').attr('closeStatus')) != 1) {
                module.exports.checkLBS();
            } else {
                jq('.locationCon').removeClass('c1').addClass('c9').html('<i class="iconloc f16 c9 cf"></i>' + '点击开启定位');
                module.exports.getgps = 0;
            }
            jq(".locationCon").on('click',
			function () {
			    if (module.exports.getgps == 1 || module.exports.getgps == 2) {
			        module.exports.getgps = 0;
			        jq('.locationCon').removeClass('c1').addClass('c9').html('<i class="iconloc f16 c9 cf"></i>' + '点击开启定位');
			        jq('#LBSInfoLatitude').val('');
			        jq('#LBSInfoLongitude').val('');
			        jq('#LBSInfoProvince').val('');
			        jq('#LBSInfoCity').val('');
			        jq('#LBSInfoStreet').val('');
			        jq('#cityCode').val('');
			        module.exports.closeLBS();
			    } else if (module.exports.getgps == 0) {
			        module.exports.getgps = 1;
			        jq('.locationCon').html('<i class="iconloc f16 c9 cf"></i>' + '正在定位...');
			        module.exports.checkLBS();
			    }
			});
            var aOperatIcon = jq('.operatIcon');
            aOperatIcon.on('click',
			function () {
			    var thisObj = jq(this);
			    var thisNum = thisObj.attr('data-id');
			    var aOperatList = jq('.operatList');
			    aOperatList.hide();
			    jq(aOperatList[thisNum]).show();
			    if (thisNum == 0) {
			        jq('.expreList').show();
			        jq('.expreBox').show();
			    }
			    aOperatIcon.removeClass('on');
			    thisObj.addClass('on');
			    if (!thisObj.hasClass('iconSendImg')) {
			        var photoList = jq('.photoList');
			        if (photoList.find('li').length < 2) {
			            photoList.hide();
			            jq('.sendCon').css('height', module.exports.contentHeight);
			        }
			    }
			});
            var expressionMenu = jq('.expressionMenu').find('a');
            var haveMenuWidth = expressionMenu.length * 76;
            var operatingBoxWidth = jq('.operatingBox').width();
            if (haveMenuWidth > operatingBoxWidth) {
                jq('.iconArrowR').show();
            };
            if (jq.DIC.getQuery('syncUnionid')) {
                setTimeout(function () {
                    jq('.iconVideo').click();
                },
				300)
            }
            jq('.sendNav').on('click', '.iconVideo',
			function () {
			    var thisObj = jq(this);
			    var photoList = jq('.photoList');
			    if (photoList.find('li').length > 1 && thisObj.hasClass('iconVideoOn')) {
			        jq.DIC.dialog({
			            id: 'addWsTips',
			            content: '图片和微视只能发一种哦~',
			            autoClose: 2000
			        });
			        return false;
			    };
			    if (thisObj.hasClass('iconVideoOn')) {
			        module.exports.addWeishiPop();
			    }
			    return false;
			});
            jq(document).on('click', '.microTab, .weishiList, .close',
			function () {
			    var thisObj = jq(this);
			    if (thisObj.hasClass('close')) {
			        jq('#content').show();
			    }
			    if (thisObj.hasClass('microTab')) {
			        var tabId = thisObj.attr('data-id'),
					microVideoList = jq('.microVideoList'),
					microTab = jq('.microTab');
			        FastClick.attach(this);
			        microVideoList.hide();
			        microTab.removeClass('on');
			        thisObj.addClass('on');
			        jq(microVideoList[tabId]).show();
			    }
			    if (thisObj.hasClass('weishiList')) {
			        var weishiList = jq('.weishiList'),
					weishiSelect = jq('.weishiSelect'),
					wsId = thisObj.attr('data-id') || '',
					wsVid = thisObj.attr('data-vid'),
					wsPlayer = thisObj.attr('data-player'),
					wsInsertTime = thisObj.attr('data-inserttime'),
					wsTimeStamp = thisObj.attr('data-timestamp'),
					wsText = thisObj.find('.mvText').html(),
					wsPicUrl = thisObj.find('.mvImg').attr('src');
			        jq('#content').show();
			        weishiList.removeClass('on');
			        thisObj.addClass('on');
			        weishiSelect.removeClass('iconSelect');
			        thisObj.find('.weishiSelect').addClass('iconSelect');
			        setTimeout(function () {
			            var photoList = jq('.photoList');
			            var hasWeishi = photoList.find('#livideo').length > 0;
			            if (!hasWeishi) {
			                var html = '<li id="livideo"><div class="photoCut"><img src="' + wsPicUrl + '" class="attchImg" alt="photo"></div>' + '<input type="hidden" name="showPicUseableType" value="2">' + '<input type="hidden" name="weishiInfo[id]" value="' + wsId + '">' + '<input type="hidden" name="weishiInfo[vid]" value="' + wsVid + '">' + '<input type="hidden" name="weishiInfo[picUrl]" value="' + wsPicUrl + '">' + '<input type="hidden" name="weishiInfo[player]" value="' + wsPlayer + '">' + '<a href="javascript:;" class="cBtn cBtnOn pa db" title="" _id="video">关闭</a><i class="iconMicroVideo cf imv pa db"></i></li>';
			                jq('#addPic').before(html).hide();
			                jq('.textTip').hide();
			                jq('.sendCon').css('height', '60');
			                photoList.show();
			                jq('.iconVideo').removeClass('iconVideoOn');
			                jq.DIC.dialog({
			                    id: 'weishiPop'
			                });
			            }
			        },
					300);
			    }
			    return false;
			});
        },
        uploadRemaining: function () {
            var uploadNum = 0;
            uploadNum = jq('.photoList').find('li').length;
            if (!jq('#addPic').is(':hidden')) {
                uploadNum--
            }
            var canOnlyUploadNum = 8;
            switch (uploadNum) {
                case 1:
                    canOnlyUploadNum = 7;
                    break;
                case 2:
                    canOnlyUploadNum = 6;
                    break;
                case 3:
                    canOnlyUploadNum = 5;
                    break;
                case 4:
                    canOnlyUploadNum = 4;
                    break;
                case 5:
                    canOnlyUploadNum = 3;
                    break;
                case 6:
                    canOnlyUploadNum = 2;
                    break;
                case 7:
                    canOnlyUploadNum = 1;
                    break;
                case 8:
                    canOnlyUploadNum = 0;
                    break;
                default:
                    canOnlyUploadNum = 0;
                    break;
            }
            jq('#onlyUploadNum').html(canOnlyUploadNum);
        },
        userGenderPopWin: function () {
            var selectGender = '';
            if ((!userGender || userGender == '0') && isFriendSite == '1') {
                var genderForm = template.render('tmpl_setGender');
                jq.DIC.dialog({
                    content: genderForm,
                    id: 'genderForm',
                    isHtml: true,
                    isMask: true,
                    top: 23,
                    callback: function () {
                        jq('#genderForm [id="CSRFToken"]').val(CSRFToken);
                        jq('#comBtnGender').on('click',
						function () {
						    var opt = {
						        success: function (re) {
						            var status = parseInt(re.errCode);
						            if (status == 0) {
						                userGender = selectGender;
						                module.exports.isNoShowToTop = false;
						                jq.DIC.dialog({
						                    id: 'genderForm'
						                });
						                jq('.bNav').show();
						                jq('.floatLayer').show();
						            } else {
						                userGender = '';
						                jq.DIC.dialog({
						                    content: re.message,
						                    autoClose: true
						                });
						            }
						        },
						        error: function (re) {
						            userGender = '';
						        },
						        noJump: true
						    };
						    jq.DIC.ajaxForm('genderForm', opt, true);
						    return false;
						});
                        jq('#cBtnGender').on('click',
						function () {
						    jq('#fwin_dialog_genderForm').hide();
						    jq('.g-mask').css('display', 'none');
						});
                        jq('.friendsCon li').on('click',
						function () {
						    var thisObj = jq(this);
						    if (thisObj.attr('id') == 'iconMan') {
						        selectGender = '1';
						        jq('#genderForm [id="gender"]').val(1);
						        jq('#iconMan').attr('class', 'on');
						        jq('#iconWoman').attr('class', '');
						    } else {
						        selectGender = '2';
						        jq('#genderForm [id="gender"]').val(2);
						        jq('#iconMan').attr('class', '');
						        jq('#iconWoman').attr('class', 'on');
						    }
						    return;
						});
                    }
                });
            }
        },
        addWeishiPop: function () {
            var syncUnionid = jq.DIC.getQuery('syncUnionid');
            if (syncUnionid) {
                var url = '/weishi/my?pageFlag=0&lastId=0&pageTime=0&syncUnionid=' + syncUnionid;
            } else {
                var url = '/weishi/my?pageFlag=0&lastId=0&pageTime=0';
            }
            var opts = {
                'success': function (re) {
                    if (re.errCode == 0 && !re.jumpURL) {
                        var weishiPopTmp = template.render('tmpl_newthread_weishi');
                        var myMicroContent = template.render('tmpl_newthread_weishi_list', {
                            data: re.data
                        });
                        jq.DIC.dialog({
                            content: weishiPopTmp,
                            id: 'weishiPop',
                            isHtml: true,
                            isMask: true,
                            callback: function () {
                                jq('#myMicro').html(myMicroContent);
                                module.exports.addHotMircro();
                                module.exports.getThreadList();
                                jq('#content').hide();
                            }
                        });
                    }
                }
            };
            var data = {
                CSRFToken: CSRFToken
            }
            jq.DIC.ajax(url, data, opts);
        },
        addHotMircro: function () {
            var parentId = jq.DIC.getQuery('parentId');
            var url = '/weishi/recommend?start=0&sId=' + sId + '&parentId=' + parentId;
            var data = {
                CSRFToken: CSRFToken
            };
            var opts = {
                'noShowLoading': true,
                'noMsg': true,
                'success': function (re) {
                    if (re.errCode == 0) {
                        var hotMicroContent = template.render('tmpl_newthread_weishi_list', {
                            data: re.data.list
                        });
                        jq('#hotMicro').html(hotMicroContent);
                    }
                }
            };
            jq.DIC.ajax(url, data, opts);
        },
        getThreadList: function () {
            var noMoreMy = false,
			noMoreHot = false,
			nextStart = 10;
            jq('#myMicro, #hotMicro').scroll(function () {
                var thisObj = jq(this);
                var parentId = jq.DIC.getQuery('parentId');
                var thisHeight = thisObj.height();
                var scrollTop = thisObj.scrollTop();
                var scrollHeight = thisObj[0].scrollHeight;
                var lastChildId = thisObj.find('.weishiList').last().attr('data-id');
                var pageTime = thisObj.find('.weishiList').last().attr('data-timestamp') || thisObj.find('.weishiList').last().attr('data-inserttime');
                document.body.scrollTop = 0;
                if (scrollHeight - thisHeight - scrollTop == 0) {
                    if (thisObj.attr('id') == 'myMicro') {
                        var syncUnionid = jq.DIC.getQuery('syncUnionid');
                        if (syncUnionid) {
                            var url = '/weishi/my?pageFlag=2&lastId=' + lastChildId + '&pageTime=' + pageTime + '&syncUnionid=' + syncUnionid;
                        } else {
                            var url = '/weishi/my?pageFlag=2&lastId=' + lastChildId + '&pageTime=' + pageTime;
                        }
                    } else {
                        var url = '/weishi/recommend?start=' + nextStart + '&sId=' + sId + '&parentId=' + parentId;
                    }
                    var opts = {
                        'success': function (re) {
                            if (re.errCode == 0 && re.data) {
                                if (thisObj.attr('id') == 'myMicro') {
                                    var myMicroContent = template.render('tmpl_newthread_weishi_list', {
                                        data: re.data
                                    });
                                    jq('#myMicro').append(myMicroContent);
                                } else {
                                    if (nextStart != re.data.nextStart) {
                                        nextStart = re.data.nextStart;
                                        var hotMicroContent = template.render('tmpl_newthread_weishi_list', {
                                            data: re.data.list,
                                            type: 'hot'
                                        });
                                        jq('#hotMicro').append(hotMicroContent);
                                    }
                                }
                            }
                            if (!re.data) {
                                if (!noMoreMy && thisObj.attr('id') == 'myMicro' || !noMoreHot && thisObj.attr('id') == 'hotMicro') {
                                    var noMoreHtml = '<li class="showAll" style="height:auto;padding-right:10px;text-align:center;">已显示全部</li>'
                                    if (thisObj.attr('id') == 'myMicro') {
                                        jq('#myMicro').append(noMoreHtml);
                                        noMoreMy = true;
                                    } else {
                                        jq('#hotMicro').append(noMoreHtml);
                                        noMoreHot = true;
                                    }
                                }
                            }
                        }
                    };
                    var data = {
                        CSRFToken: CSRFToken
                    }
                    jq.DIC.ajax(url, data, opts);
                }
            });
        },
        closeLBS: function () {
            jq.DIC.ajax('/closeLBS', {
                'CSRFToken': CSRFToken
            },
			{
			    'noShowLoading': true,
			    'noMsg': true,
			    'success': function (result) { }
			});
        },
        checkLBS: function () {
            gps.getLocation(function (latitude, longitude) {
                jq.DIC.ajax('/checkLBS', {
                    'CSRFToken': CSRFToken,
                    'latitude': latitude,
                    'longitude': longitude
                },
				{
				    'noShowLoading': true,
				    'noMsg': true,
				    'success': function (result) {
				        var status = parseInt(result.errCode);
				        var LBSInfo = result.data.LBSInfo;
				        var cityCode = result.data.cityCode;
				        if (status == 0 && module.exports.getgps == 1) {
				            module.exports.getgps = 2;
				            jq('.locationCon').removeClass('c9').addClass('c1').html('<i class="iconloc f16 c1 cf"></i>' + LBSInfo.city + (LBSInfo.street ? (' ' + LBSInfo.street) : ''));
				            if (cityCode) jq('#cityCode').val(cityCode);
				            if (LBSInfo) {
				                jq('#LBSInfoLatitude').val(LBSInfo.latitude);
				                jq('#LBSInfoLongitude').val(LBSInfo.longitude);
				                jq('#LBSInfoProvince').val(LBSInfo.province);
				                jq('#LBSInfoCity').val(LBSInfo.city);
				                jq('#LBSInfoStreet').val(LBSInfo.street);
				            }
				        } else if (module.exports.getgps == 1) {
				            module.exports.getgps = 0;
				            jq('#LBSInfoLatitude').val('');
				            jq('#LBSInfoLongitude').val('');
				            jq('#LBSInfoProvince').val('');
				            jq('#LBSInfoCity').val('');
				            jq('#LBSInfoStreet').val('');
				            jq('#cityCode').val('');
				            jq('.locationCon').addClass('c9').html('<i class="iconloc f16 c9 cf"></i>' + '获取位置失败');
				        }
				    }
				});
            });
        },
        initModal: function () {
            jq('#submitButton').bind('touchstart',
			function () {
			    jq(this).addClass('sendOn');
			}).bind('touchend',
			function () {
			    jq(this).removeClass('sendOn');
			});
            jq('#cBtn').bind('touchstart',
			function () {
			    jq(this).addClass('cancelOn');
			}).bind('touchend',
			function () {
			    jq(this).removeClass('cancelOn');
			});
        },
        checkForm: function () {
            jq.each(module.exports.uploadInfo,
			function (i, n) {
			    if (n && !n.isDone) {
			        jq.DIC.dialog({
			            content: '图片上传中，请等待',
			            autoClose: true
			        });
			        return false;
			    }
			});
            var content = jq('#content').val();
            var contentLen = jq.DIC.mb_strlen(jq.DIC.trim(content));
            if (contentLen < 15) {
                jq.DIC.dialog({
                    content: '内容过短',
                    autoClose: true
                });
                return false;
            }
            return true;
        },
        checkPicSize: function (file) {
            if (file.size > 10000000) {
                return false;
            }
            return true;
        },
        checkPicType: function (file) {
            var photoReg = (/\.png$|\.bmp$|\.jpg$|\.jpeg$|\.gif$/i);
            if (!photoReg.test(file.name)) {
                return false;
            } else {
                return true;
            }
        }
    };
    module.exports.init();
});
//@ sourceURL=http://dzqun.gtimg.cn/quan/scripts/module/newthread.js
