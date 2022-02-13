<%@ page contentType="text/html;charset=UTF-8" %>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>报告查询</title>
    <meta name="viewport" content="width=width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <link rel="stylesheet" href="/css/main.css">
    <link rel="stylesheet" href="/css/viewer.css">
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/css/bootstrap-combined.min.css" rel="stylesheet">
    <script type="text/javascript" src="/js/jquery.min.js"></script>
    <script>
        (function (doc, win) {
            var docEl = win.document.documentElement;
            var resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize';
            var metaEl = doc.querySelector('meta[name="viewport"]');
            var dpr = 0;
            var scale = 0;

            // 对iOS设备进行dpr的判断，对于Android系列，始终认为其dpr为1
            if (!dpr && !scale) {
                var isAndroid = win.navigator.appVersion.match(/android/gi);
                var isIPhone = win.navigator.appVersion.match(/[iphone|ipad]/gi);
                var devicePixelRatio = win.devicePixelRatio;

                if(isIPhone) {
                    dpr = devicePixelRatio;
                } else {
                    drp = 1;
                }

                scale = 1 / dpr;
            }

            /**
             * ================================================
             *   设置data-dpr和viewport
             × ================================================
             */

            docEl.setAttribute('data-dpr', dpr);
            // 动态改写meta:viewport标签
            if (!metaEl) {
                metaEl = doc.createElement('meta');
                metaEl.setAttribute('name', 'viewport');
                metaEl.setAttribute('content', 'width=device-width, initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');
                document.documentElement.firstElementChild.appendChild(metaEl);
            } else {
                metaEl.setAttribute('content', 'width=device-width, initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');
            }

        })(document, window);
    </script>
</head>

<body topmargin="0" leftmargin="0" onblur="GSubmitting = false;"
      style="overflow-x: hidden; padding-left: 2px; padding-right: 2px; text-align: center;">
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header" style="padding-left:20px">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
<%--            <a class="navbar-brand" href=""><img src="/pic/title_bg4.png" style="height:25px"></a>--%>
            <a class="navbar-brand" href="" style="height: 50px"><span class="fontt">报告查询</span></a>
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
            </ul>

            <ul class="nav navbar-nav navbar-right">

            </ul>
        </div>
    </div>
</div>
<div style="width: 100%;height: 100%;margin-top: 50px;margin-bottom: 40px;">
    <iframe src="/web/viewer.html?file=${filePath}" style="width: 100%;height: 100%;"></iframe>
</div>

<footer>
    <h6 style="text-align: center;font-size: 18px;"></h6>
</footer>
</body>
</html>
