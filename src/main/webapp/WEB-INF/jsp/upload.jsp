<%@ page contentType="text/html;charset=UTF-8" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta content="text/html;charset=UTF-8"/>
    <title>文件上传</title>
    <link rel="stylesheet" href="/css/main.css">
    <script type="text/javascript" src="/js/jquery.min.js"></script>
</head>

<body>
    <div class="main">
        <form action="/qrCode" onsubmit="return submit_sure()" method="post" enctype="multipart/form-data">
            <div class="file shadow">
                <input type="file" name="file" id="file" /><label for="file" id="file_label">选择文件</label>
            </div>
            <div style="height: 9px"></div>
            <input class="submit-button shadow" type="submit" name="submit" id="submit" value="上传" />
        </form>
    </div>

    <script>
        $(".file").on("change", "input[type='file']", function() {
            let filePath = $(this).val();
            if ("" === filePath || filePath === undefined) {
                $("label").html("选择文件");
                return;
            }
            let arr = filePath.split('\\');
            let fileName = arr[arr.length - 1];
            $("label").html(fileName);

        });

    </script>
    <script type="text/javascript">
        function submit_sure() {
            let isFileExist = true;
            let filePath = $("input[type='file']").val();
            if ("" === filePath || filePath === undefined) {
                isFileExist = false;
            }
            if (!isFileExist) {
                alert("未选择文件");
                return false;
            }
            let flag = confirm("确定要提交？");
            return flag === true;
        }
    </script>
</body>

</html>
