<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DataInnovations.SMS._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My SMS</title>
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <strong><span class="auto-style1">021 1777 870</span></strong>
            <asp:textbox runat="server" ID="tb_message" Width="100%"></asp:textbox>

            <asp:CheckBoxList ID="cbl_recipients" runat="server">
                <asp:ListItem Value="0274266494">Judy Kumeroa - 0274266494</asp:ListItem>
                <asp:ListItem Value="0272495088">Greg Tichbon - 0272495088</asp:ListItem>
                <asp:ListItem Value="0211127942">Aimee Matthews - 0211127942</asp:ListItem>
                <asp:ListItem Value="0275225411">Jordi Haami-Rerekura - 0275225411</asp:ListItem>
                <asp:ListItem Value="0204075271">Charlie-Boy Williams - 0204075271</asp:ListItem>
                <asp:ListItem Value="0278438576">Keegan Easton - 0278438576</asp:ListItem>
                <asp:ListItem Value="0272433561">Mahanga Williams - 0272433561</asp:ListItem>
                <asp:ListItem Value="0270445755">Kathy Parnell - 0270445755</asp:ListItem>
                <asp:ListItem Value="0272511611">Sue Kumeroa - 0272511611</asp:ListItem>
                <asp:ListItem Value="0223505170">Nate Haami-Rerekura - 0223505170</asp:ListItem>
                <asp:ListItem Value="0273746182">Keith Ramage - 0273746182</asp:ListItem>
                <asp:ListItem Value="0211342167">Watson Matthews - 0211342167</asp:ListItem>
                <asp:ListItem Value="0284056828">Mary Tafilipepe - 0284056828</asp:ListItem>
                <asp:ListItem Value="0273977501">Dan Chadfield - 0273977501</asp:ListItem>
                <asp:ListItem Value="0211328295">Jeida Matthews - 0211328295</asp:ListItem>
                <asp:ListItem Value="0226266166">Corey-Lee Robertson - 0226266166</asp:ListItem>
                <asp:ListItem Value="0279774023">Te Paerata Tichbon - 0279774023</asp:ListItem>
                <asp:ListItem Value="0211226723">Neo Tichbon - 0211226723</asp:ListItem>

                <asp:ListItem Value="0274420256">Darryl - 0274420256</asp:ListItem>
                <asp:ListItem Value="xxxxxx">Bob - xxxxxx</asp:ListItem>
                <asp:ListItem Value="xxxxxx">Rae - xxxxxx</asp:ListItem>
                <asp:ListItem Value="xxxxxx">Grant - xxxxxx</asp:ListItem>
                <asp:ListItem Value="xxxxxx">Xavier - 0279362413</asp:ListItem>
                <asp:ListItem Value="0272795180">Kurt - 0272795180</asp:ListItem>
                <asp:ListItem Value="02102873434">Donny - 02102873434</asp:ListItem>
                <asp:ListItem Value="0273939118">Brennan - 0273939118</asp:ListItem>
                <asp:ListItem Value="0279186365">Steph - 0279186365</asp:ListItem>
                <asp:ListItem Value="0274808695">Eliza - 0274808695</asp:ListItem>
                <asp:ListItem Value="0278815431">Alley - 0278815431</asp:ListItem>
                <asp:ListItem Value="0224152485">Jade - 0224152485</asp:ListItem>
                <asp:ListItem Value="0274980842">Tomasi - 0274980842</asp:ListItem>
                <asp:ListItem Value="0276439949">Cameron - 0276439949</asp:ListItem>
                <asp:ListItem Value="0224291036">JJ - 0224291036</asp:ListItem>
                <asp:ListItem Value="0274612490">Milley - 0274612490</asp:ListItem>
                <asp:ListItem Value="0274133221">Sienna - 0274133221</asp:ListItem>
                <asp:ListItem Value="0273400477">Britney - 0273400477</asp:ListItem>
                <asp:ListItem Value="0224660864">Leah - 0224660864</asp:ListItem>
                <asp:ListItem Value="0273593671">Piper - 0273593671</asp:ListItem>
                <asp:ListItem Value="xxxxxx">Bella - xxxxxx</asp:ListItem>


            </asp:CheckBoxList>

            <asp:Button ID="btn_send" runat="server" Text="Send" OnClick="btn_send_Click" />
            <br />
            <br />
            <asp:Label ID="lbl_response" runat="server"></asp:Label>
        </div>
    </form>
</body>

</html>
