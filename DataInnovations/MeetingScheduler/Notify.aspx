<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Notify.aspx.cs" Inherits="DataInnovations.MeetingScheduler.Notify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:TextBox ID="tb_meeting" runat="server"></asp:TextBox>
        <asp:Button ID="btn_submit" runat="server" Text="Button" OnClick="btn_submit_Click" /><br /><hr />
        <table>
        <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
            </table>
    </form>
</body>
</html>
