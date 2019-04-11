<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UBC2019AMessage.aspx.cs" Inherits="DataInnovations.Raffles.UBC2019AMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Union Boat Club Rowing Fundraiser</title>
    <style>
        body {
            font-family: Arial;
            font-size: 24px;
        }
    </style>


</head>
<body style="background-color: peru">
    <form id="form1" runat="server">
        <div style="width: 770px; margin: 0 auto; padding: 20px; background-color: aquamarine">
            <p style="text-align: center">
                <img alt="" style="width: 654px" src="Images/ChefsChoice%20Logo.PNG" />
            </p>
            <p style="text-align: center">
            <%= Session["raffleMessage"] %>
                </p>
            <br />
            <img src="Images/3logos.jpg" style="width: 770px;" />
        </div>
    </form>
</body>
</html>
