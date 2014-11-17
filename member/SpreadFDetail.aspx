<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpreadFDetail.aspx.cs" Inherits="V5APP.Store.UI.member.SpreadFDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>会员中心</title>
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css">
    <link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/dis.css">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
</head>

<body>
    <!--topbar begin-->
    <div class="fixed">
        
        <nav class="tab-bar">
            <section class="left-small">
                <a class="menu-icon" href="SpreadFriend-list.aspx"><span></span></a>
            </section>
            <section class="middle tab-bar-section">
                <h1 class="title">朋友圈推广</h1>
            </section>
        </nav>
    </div>
    <!--topbar end-->
    <!--content begin-->
    <div class="spreadFDetail">
        <%if (friendsCircle != null)
          { %>
        <% TimeSpan dateiff = DateTime.Now.Subtract(DateTime.Parse(friendsCircle.ModifyDate.ToString("yyyy-MM-dd")));
           var dateStr="";
           dateStr = dateiff.Days == 0 ? "今天" : dateiff.Days == 1 ? "昨天" : dateiff.Days + "天前";
                    %>
        <div class="annex"><span class="date"><%=dateStr %></span><span class="from">来自：<%=OpendTitle %></span><a class="help" href="spreadFHelp.aspx"><i class="icon-help">？</i>如何转发</a></div>
        <div id="description" style="display:none"><%=friendsCircle.Description %><%=openedPath %></div>
        <div class="text"><%=friendsCircle.Description %>快快访问我的店铺:<%=openedPath %>
            <%--<button class="coptext" onclick="setcopy_gettext();" id="btnCopy">复制文本</button>--%>

        </div>
        <ul class="small-block-grid-3 medium-block-grid-3 large-block-grid-3 pic9" id="imgList">
            <% var imgs = friendsCircle.CircleImg.Split(';');
               for (var i = 0; i < imgs.Length; i++)
               {
            %>
          
                    <li><img data-src="<%=PlantFormPath+imgs[i] %>" src="<%=PlantFormPath+imgs[i] %>"/></li>
               <%-- <img src="<%=PlantFormPath+imgs[i] %>" style="width:88px;height:88px;" />--%>
            <%} %>
        </ul>
        <%} %>
    </div>
    <!--content begin-->
    <script>
        $(document).foundation().foundation('joyride', 'start');

        // 赋值 URL
        //$("#btnCopy").zclip({
        //    path: "js/ZeroClipboard.swf",
        //    copy: function () {
        //       alert("复制成功");
        //        return $('#description').text().trim()+"123";
        //    }
        //});
       
        $(function () {
            //$("#imgList li").each(function () {
            //    var imgurl = $(this).find("img").attr("src");
            //    var newimgUrl = "{gettmpimg2("+imgurl+")}"
            //    $(this).find("img").attr("data-src", newimgUrl);
            //});
           

            //showPreview();
            $("#imgList li").click(function () {
              
                imgview($(this).find("img")[0]);
            });
        });
        function imgview(obj) {

            var arr = "";
            $(obj.parentNode.parentNode.children).each(function () {
                arr += $(this).find("img").attr('data-src') + ",";
            });
            var c = arr.substring(0, arr.length - 1).split(',');
            if (typeof window.WeixinJSBridge != 'undefined') {
                WeixinJSBridge.invoke("imagePreview", {
                    current: c[0],
                    urls: c
                });
            }
        }
       
</script>   
</body>
</html>

