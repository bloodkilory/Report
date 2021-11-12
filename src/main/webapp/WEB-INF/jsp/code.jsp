<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>二维码</title>
    <link rel="stylesheet" href="/css/main.css">
    <script type="text/javascript" src="/js/jquery.min.js"></script>
</head>
<body>
<div class="main">
    <img src="${image}">
    <div style="height: 9px"></div>
    <input type="hidden" value="${fileName}" id="fineName">
    <input type="hidden" value="${url}" id="url">
    <input class="submit-button" type="button" id="download" onclick="download()" value="下载二维码" />
    <div style="height: 9px"></div>
<%--    <form action="#" onsubmit="return submit_sure()" method="post" enctype="multipart/form-data">--%>
<%--        <div class="file">--%>
<%--            <input type="file" name="file" id="file" /><label for="file" id="file_label">重新选择文件</label>--%>
<%--        </div>--%>
<%--        <div style="height: 5px"></div>--%>
<%--        <input class="submit-button" style="width: 220px" type="submit" name="submit" id="submit" value="重新上传添加过二维码的文件" />--%>
<%--    </form>--%>
    <input class="submit-button" type="button" id="back" onclick="goback()" value="返回上传页面" />
</div>
<script>
    function download() {
        let file = $("#fineName").val();
        let url = $("#url").val();
        window.open(url + "/download" + "?fileName=" + file);
    }

    function goback() {
        let url = $("#url").val();
        location.href = url + "/upload";
    }
</script>
</body>
</html>