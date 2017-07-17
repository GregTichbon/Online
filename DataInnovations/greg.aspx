<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="greg.aspx.cs" Inherits="DataInnovations.greg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:textbox runat="server" ID="tb_message" Width="100%"></asp:textbox>
            <asp:CheckBoxList ID="cbl_recipients" runat="server">
                <asp:ListItem Value="027466494">Judy Kumeroa - 027466494</asp:ListItem>
                <asp:ListItem Value="0272495088">Greg Tichbon - 0212495088</asp:ListItem>
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
                <asp:ListItem Value="027 xxx">X Mary Tafilipepe - xx</asp:ListItem>
                <asp:ListItem Value="0273977501">Dan Chadfield - 0273977501</asp:ListItem>
                <asp:ListItem Value="0211328295">Jeida Matthews - 0211328295</asp:ListItem>
                <asp:ListItem Value="0226266166">Corey-Lee Robertson - 0226266166</asp:ListItem>
                <asp:ListItem Value="0279774023">Te Paerata Tichbon - 0279774023</asp:ListItem>
                <asp:ListItem Value="0211226723">Neo Tichbon - 0211226723</asp:ListItem>

            </asp:CheckBoxList>

            <asp:Button ID="btn_send" runat="server" Text="Send" OnClick="btn_send_Click" />
            <br />
            <br />
            <asp:Label ID="lbl_response" runat="server" Text="Label"></asp:Label>
        </div>
    </form>
</body>

</html>
