<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UBC.People.Response.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        div {
            height: 10em;
            position: relative
        }

            div p {
                font-size:xx-large;
                margin: 0;
                background: yellow;
                position: absolute;
                top: 50%;
                left: 50%;
                margin-right: -50%;
                transform: translate(-50%, -50%)
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>Thanks for that!</p>
        </div>
    </form>
</body>
</html>
