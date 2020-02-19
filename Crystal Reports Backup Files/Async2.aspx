<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Async2.aspx.cs" Inherits="UBC.People.TestAndPlay.Async2" %>

<html>
<head>
    <title></title>
    <script type="text/javascript">
        function MakeVisible(strElementID, i, ms) {
            i++;
            var objElement = document.getElementById(strElementID);
            objElement.append("x");
            if (i < 10) setTimeout(function () { MakeVisible(strElementID, i, ms); }, ms);
        }

    </script>
</head>
<body>
    <div onclick="MakeVisible('container',0,500)" style="cursor: pointer;">Click</div>

    <div id="container" style="border: solid 1px black; width: 200px; height: 200px;">
    </div>
</body>
</html>
