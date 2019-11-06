<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Masonry2.aspx.cs" Inherits="BadHagrid.Masonry2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Scripts/plugins/galereya/css/jquery.galereya.css" rel="stylesheet" />
    <link href="Scripts/plugins/galereya/css/jquery.galereya.ie.css" rel="stylesheet" />
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="Scripts/plugins/galereya/js/jquery.galereya.min.js"></script>

    <script>
        $(function () {
            $('#gal1').galereya({
                load: function (next) {
                    $.getJSON('https://vodkabears.github.io/galereya/images.json', function (data) {
                        next(data);
                    });
                }
            });
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
