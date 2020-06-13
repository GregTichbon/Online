<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test1.aspx.cs" Inherits="TOHW.ComingandGoing.Test1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Coming and Going</title>
    <link rel="icon" type="image/png" href="favicon.png" />
    <link rel="stylesheet" href="style.css" />
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/webrtc-adapter/3.3.3/adapter.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.1.10/vue.min.js"></script>
    <script type="text/javascript" src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <object id="iembedflash" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0" width="320" height="240">
            <param name="movie" value="camcanvas.swf" />
            <param name="quality" value="high" />
            <param name="allowScriptAccess" value="always" />
            <embed allowscriptaccess="always" id="embedflash" src="camcanvas.swf" quality="high" width="320" height="240" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" mayscript="true" />
        </object>

        </div>
        <button onclick="captureToCanvas()">Capture</button><br>
        <canvas id="qr-canvas" width="640" height="480"></canvas>
    </form>
</body>
</html>
