<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestPost1.aspx.cs" Inherits="BadHagrid.TestPost1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>

    <script>
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: "../posts.asmx/HelloWorld1",
                data: "{'param1':'MyUserNameIsRaj'}",
                contentType: "application/json",
                datatype: "json",
                success: function (responseFromServer) {
                    alert(responseFromServer.d)
                }
            });
        }); //document ready

    </script>
</head>
<body>
    <form id="form1" runat="server">
    </form>
</body>
</html>
