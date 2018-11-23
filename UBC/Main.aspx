<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="UBC.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Dependencies/jquery-2.2.0.min.js"></script>
    <script src="Dependencies/fittext.js"></script>
    <script>
        $(document).ready(function () {
            $("#div_menu").fitText(1.1, {
                minFontSize: 50,
                maxFontSize: '75px'
            });


        });
    </script>

    <style>
        #div_menu {
            position: fixed;
            top: 50%;
            left: 50%;
            /* bring your own prefixes */
            transform: translate(-50%, -50%);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="div_menu">
           <p>We're sorry but the page:<br />
               <%: url %><br />
               you are trying to get to doesn't exist ......
            </p>
           <p> <a href="/default.aspx">Go back to the menu</a></p>
        </div>
    </form>
</body>
</html>
