<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebCamTest.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.WebCamTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="results"></div>
        <div id="my_camera"></div>
        <script src="../Dependencies/WebCam/webcam.js"></script>
        <script>
            Webcam.set({
                width: 320,
                height: 240,
                image_format: 'jpeg',
                jpeg_quality: 90
            });
            Webcam.attach('#my_camera');
        </script>
        <input type="button" value="Take Snapshot" onclick="take_snapshot()" />
        <script>
            function take_snapshot() {
                Webcam.snap(function (data_uri) {
                    document.getElementById('results').innerHTML = '<img src="' + data_uri + '"/>';
                });
            }
        </script>
    </form>
</body>
</html>
