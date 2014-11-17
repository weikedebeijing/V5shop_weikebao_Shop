<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Explanation.aspx.cs" Inherits="V5APP.Store.UI.member.Explanation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="app-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <script src="http://html.v5portal.com/distribution/foundation/js/vendor/jquery.js"></script>
    <title>微信分销火热招募中.....</title>
    <style>
        body
        {
            font-family: "微软雅黑";
            margin: 0;
            padding: 0;
            background: #c00500;
            overflow: hidden;
        }

        figure
        {
            position: relative;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

            figure img
            {
                width: 100%;
                height: auto;
            }

        button
        {
            position: absolute;
            bottom: -14px;
            left: 15%;
            width: 70%;
            display: block;
            margin: 15px auto;
            height: 50px;
            background: #f03737;
            border: 1px solid #e02626;
            color: #fff;
            font-size: 18px;
            text-align: center;
            border-radius: 3px;
            border-bottom-left-radius: 0;
            border-bottom-right-radius: 0;
            box-shadow: 0 3px 3px rgba(0,0,0,.2);
            outline: none;
        }
    </style>
    <script>
        
    </script>
</head>

<body>
    <figure>
        <img src="<%=openedPath+recruit.ImgUrl%>">
        <button onclick="window.open('../../Member/AddStore.aspx?recruit=1')">立即开微店</button>
    </figure>

</body>
</html>
