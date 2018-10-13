<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maadi.aspx.cs" Inherits="DataInnovations.SMS.Maadi" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Maadi SMS</title>
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
            <asp:textbox runat="server" ID="tb_message" Width="100%"></asp:textbox>

            <asp:CheckBoxList ID="cbl_recipients" runat="server">
                <asp:ListItem Value="0274266494" Selected="True">Judy - 0274266494</asp:ListItem>
                <asp:ListItem Value="0272495088" Selected="True">Greg - 0272495088</asp:ListItem>
                <asp:ListItem Value="" Selected="False">-----------------------------------------</asp:ListItem>
                <asp:ListItem Value="0274420256" Selected="True">Darryl - 0274420256</asp:ListItem>
                <asp:ListItem Value="0273869876" Selected="True">Rae - 0273869876</asp:ListItem>
                <asp:ListItem Value="" Selected="False">-----------------------------------------</asp:ListItem>
                <asp:ListItem Value="0272904002" Selected="True">Bob - 0272904002</asp:ListItem>
                <asp:ListItem Value="0272264425" Selected="True">Grant - 0272264425</asp:ListItem>
                <asp:ListItem Value="0272904002" Selected="True">Peer - </asp:ListItem>
                <asp:ListItem Value="0272888015" Selected="True">Mike - 0272888015</asp:ListItem>
                <asp:ListItem Value="0272727953" Selected="True">Phillipa - 0272727953</asp:ListItem>
                <asp:ListItem Value="0272904002" Selected="True">John - </asp:ListItem>
                <asp:ListItem Value="" Selected="False">-----------------------------------------</asp:ListItem>
                <asp:ListItem Value="0278815431" Selected="True">Alley - 0278815431</asp:ListItem>
                <asp:ListItem Value="0279084984" Selected="True">Bella - 0279084984</asp:ListItem>
                <asp:ListItem Value="0273939118" Selected="True">Brennan - 0273939118</asp:ListItem>
                <asp:ListItem Value="0273400477" Selected="True">Britney - 0273400477</asp:ListItem>
                <asp:ListItem Value="0276439949" Selected="True">Cameron - 0276439949</asp:ListItem>
                <asp:ListItem Value="02102873434" Selected="True">Donny - 02102873434</asp:ListItem>
                <asp:ListItem Value="0224152485" Selected="True">Jayde - 0224152485</asp:ListItem>
                <asp:ListItem Value="0272795180" Selected="True">Kurt - 0272795180</asp:ListItem>
                <asp:ListItem Value="0272604006" Selected="True">Kyla - 0272604006</asp:ListItem>
                <asp:ListItem Value="0224660864" Selected="True">Leigha - 0224660864</asp:ListItem>
                <asp:ListItem Value="0274612490" Selected="True">Milley - 0274612490</asp:ListItem>
                <asp:ListItem Value="0211226723" Selected="True">Neo - 0211226723</asp:ListItem>
                <asp:ListItem Value="0273593671" Selected="True">Piper - 0273593671</asp:ListItem>
                <asp:ListItem Value="0274133221" Selected="True">Sienna - 0274133221</asp:ListItem>
                <asp:ListItem Value="0274980842" Selected="True">Tomasi - 0274980842</asp:ListItem>
                <asp:ListItem Value="" Selected="False">-----------------------------------------</asp:ListItem>
                <asp:ListItem Value="0274808695" Selected="True">Eliza - 0274808695</asp:ListItem>
                <asp:ListItem Value="0224291036" Selected="True">JJ - 0224291036</asp:ListItem>
                <asp:ListItem Value="0279186365" Selected="True">Steph - 0279186365</asp:ListItem>
                <asp:ListItem Value="0279362413" Selected="True">Xavier - 0279362413</asp:ListItem>

            </asp:CheckBoxList>

            <asp:Button ID="btn_send" runat="server" Text="Send" OnClick="btn_send_Click" />
            <br />
            <br />
            <asp:Label ID="lbl_response" runat="server"></asp:Label>
        </div>
    </form>
</body>

</html>
