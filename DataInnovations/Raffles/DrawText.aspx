<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DrawText.aspx.cs" Inherits="DataInnovations.Raffles.DrawText" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
        <div>
            <asp:DropDownList ID="dd_raffle" runat="server">
                <asp:ListItem></asp:ListItem>
                <asp:ListItem Value="1">Yellow Meat</asp:ListItem>
                <asp:ListItem Value="2">Outdoor Table</asp:ListItem>
                <asp:ListItem Value="3">Red Meat</asp:ListItem>
                <asp:ListItem Value="4">White Meat</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            Messages will start with &quot;Hi &lt;name&gt;, &quot;<br />
            <br />
            <asp:TextBox ID="tb_message" runat="server" Height="113px" Rows="2" Width="762px" TextMode="MultiLine"></asp:TextBox>

            <br />
            <br />
            Only mobile numbers
            <asp:TextBox ID="tb_onlynumbers" runat="server" Width="672px"></asp:TextBox>
            <br />
            <br />

            <asp:CheckBox ID="cb_live" runat="server" Text="Live" />

            <br />
            <br />
            <asp:Button ID="btn_send" runat="server" Text="Send" OnClick="btn_send_Click" />

            <asp:Literal ID="LitRows" runat="server"></asp:Literal>
        </div>
    </form>
</body>
</html>
