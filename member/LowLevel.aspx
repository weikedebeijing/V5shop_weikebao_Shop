<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LowLevel.aspx.cs" Inherits="V5APP.Store.UI.member.LowLevel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<title>我的子店管理</title>
<link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/foundation.css" />
<link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/foundation/css/normalize.css" />
<link rel="stylesheet" type="text/css" href="http://html.v5portal.com/distribution/css/common.css" />
<script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
<script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.js"></script>
<script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.tab.js"></script>
<script src="http://html.v5portal.com/distribution/foundation/js/foundation/foundation.accordion.js"></script>
    <script>
        $(function () {
            $("#NextCustomer dd a").click(function () {
                //隐藏所有下级信息
                var className = $(this).parent(0).attr("class");
                $("#NextCustomer dd").removeClass("current");
                if (className.indexOf("current") >= 0) {
                    $(this).parent(0).removeClass("current");
                }
                else {
                    $(this).parent(0).addClass("current");
                }
               
            });
        });

  </script>
</head>

<body>
  <!--topbar begin-->
  <div class="fixed">
    <nav class="tab-bar">
      <section class="left-small">
        <a class="menu-icon" href="./Member.aspx" ><span></span></a>
      </section>
      <section class="middle tab-bar-section">
        <h1 class="title">我的子店管理</h1>
      </section>
    </nav>
  </div>
  <!--topbar end-->
  <!--content begin-->
  <div class="tabs-content mt-55">
    <!--commission begin-->
    <div class="content active" id="panel2-1">
        <!--button add begin-->
        <div class="listAdd-btn02" style="display:none;">
          <a href="lowLevel-add.html" class="button [radius round]"><i>+</i>添加我的子店</a>
        </div>
  <!--button add begin-->
      <div>    
     
        <dl class="accordion bAccordion employees" data-accordion id="NextCustomer">
          <!--01 begin-->
                 <%var i = 1;
                     foreach(var customerLower in customerLowers){
                         var loginName = customerLower.Status == customerStatus ? "未绑定帐号" : customerLower.LoginName;
                         %>
                    
          <dd class="<%=i==1?"current":""%>">
            <a href="#panel<%=i %>"><span class="employees-number"><%=customerLower.TrueName %></span><span class="employees-name"><%=loginName%></span><i class="icon-arrow"></i></a>
              <div id="panel<%=i %>" class="content <%=i==1? "active":"" %>">
                <ul class="employee-ul">
                  <li><span class="infor-title">姓名：</span><span class="info-content"><%=customerLower.TrueName %></span></li>
                  <li><span class="infor-title">登录账号：</span><span class="info-content"><%=loginName %></span></li>
                  <li><span class="infor-title">店铺名称：</span><span class="info-content"><%=customerLower.Title %></span><%--<i class="icon-eye-gray"><!--hidden class="icon-eye-gray-no"---></i>--%></li>
                  <li><span class="infor-title">累计销售：</span><span class="info-content">￥<%=customerLower.SumPriceAmount.ToString("0.00") %></span><a href="DRPOrderList.aspx?user_id=<%=customerLower.ID %>">查看详细</a></li>
                  <li><span class="infor-title">累计拥金：</span><span class="info-content">￥<%=customerLower.SumCommissionAmount.ToString("0.00") %></span><a href="Brokeragelog.aspx?user_id=<%=customerLower.ID %>">查看详细</a></li>
                </ul>
              </div>
          </dd>
            <%i++;
                     } %>
          <!--01 end-->
        </dl>
      </div>
    </div>
    <!--commission end-->
  </div>
  <!--content begin-->
  <script>
      $(document).foundation().foundation('joyride', 'start');
  </script>
</body>
</html>
