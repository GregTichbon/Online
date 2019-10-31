<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UBC.People.Reports.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />


    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="<%: ResolveUrl("~/Dependencies/fittext.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script>
        $(document).ready(function () {
            $("#div_menu").fitText(1.1, {
                minFontSize: '20px',
                maxFontSize: '75px'
            });

            <%=script%>

            $(document).tooltip({
                position: {
                    my: "right center",
                    at: "left center"
                },
                content: function () {
                    return $(this).prop('title');
                }
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
            <%= html %>
            <br />
            <a href="../../default.aspx">MAIN MENU</a>
        </div>
    </form>
</body>
</html>
