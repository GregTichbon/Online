﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form.aspx.cs" Inherits="DataInnovations.SMS.Send.Form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     

        Mobile Number:
        <br />
        <asp:TextBox ID="tb_mobilenumber" runat="server" Width="301px"></asp:TextBox>
        <br />
        <br />
        Message:<br />
        <asp:TextBox ID="tb_message" runat="server" Height="134px" TextMode="MultiLine" Width="691px"></asp:TextBox>
        <br />
        <br />
        Send using:<br />
        <asp:DropDownList ID="dd_mode" runat="server">
            <asp:ListItem Value="Local URL">http://192.168.10.???:8080/?number=???&text=???</asp:ListItem>
            <asp:ListItem Value="office.datainn.co.nz URL">http://office.datainn.co.nz/sms/send?O=S&P=???&M=???</asp:ListItem>
            <asp:ListItem>Generic Function</asp:ListItem>


            
        </asp:DropDownList>
        <br />
        <br />
        <br />
        <asp:Button ID="btn_send" runat="server" OnClick="btn_send_Click" Text="Send" />
     

    </form>
</body>
</html>