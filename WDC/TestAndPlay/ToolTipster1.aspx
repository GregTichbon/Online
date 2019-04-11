<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ToolTipster1.aspx.cs" Inherits="Online.TestAndPlay.ToolTipster1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Scripts/tooltipster.master/dist/css/tooltipster.bundle.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-2.2.0.min.js"></script>
    <script src="../Scripts/tooltipster.master/dist/js/tooltipster.bundle.min.js"></script>

    <script>
        $(document).ready(function() {
            $('.tooltip').tooltipster();
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
<span class="tooltip" title="This is my span's tooltip message!">Some text</span>
    </div>
    </form>
</body>
</html>
