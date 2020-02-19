<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TOHRowing.aspx.cs" Inherits="DataInnovations.SMS.TOHRowing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TOH Rowing</title>
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
        }

        input[type=checkbox] {
        }

        body {
            font-size: 30px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <div>
            <strong><span class="auto-style1">021 1777 870</span></strong>
            <asp:TextBox runat="server" ID="tb_message" Width="100%"></asp:TextBox>

            <asp:CheckBoxList ID="cbl_recipients" runat="server">
                <asp:ListItem Value="0274266494" Selected="True">Judy - 0274266494</asp:ListItem>
                <asp:ListItem Value="0272495088" Selected="True">Greg - 0272495088</asp:ListItem>
                <asp:ListItem Value="0275225411" Selected="True">Jordi - 0275225411</asp:ListItem>
                <asp:ListItem Value="0274300678" Selected="True">Jay - 0274300678</asp:ListItem>
                <asp:ListItem Value="0272354110" Selected="True">Dan - 0272354110</asp:ListItem>
                <asp:ListItem Value="0273717229" Selected="True">Baillie - 0273717229</asp:ListItem>
                <asp:ListItem Value="0211127942" Selected="True">Aimee - 0211127942</asp:ListItem>
                <asp:ListItem Value="0223680221" Selected="True">Chris - 0223680221</asp:ListItem>
                <asp:ListItem Value="02040752751" Selected="True">Charlie - 02040752751</asp:ListItem>

            </asp:CheckBoxList>

            <asp:Button ID="btn_send" runat="server" Text="Send" OnClick="btn_send_Click" />
            <br />
            <br />
            <asp:Label ID="lbl_response" runat="server"></asp:Label>
        </div>
    </form>
</body>

</html>
