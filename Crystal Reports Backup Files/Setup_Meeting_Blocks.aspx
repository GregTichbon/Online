<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Setup_Meeting_Blocks.aspx.cs" Inherits="DataInnovations.MeetingScheduler.Setup_Meeting_Blocks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table>
<tr><td>Meeting ID:</td><td><asp:TextBox ID="tb_meeting" runat="server"></asp:TextBox></td></tr>
        <tr><td>Start Date:</td><td><asp:TextBox ID="tb_startdate" runat="server"></asp:TextBox></td></tr>
           <tr><td>End Date:</td><td><asp:TextBox ID="tb_enddate" runat="server"></asp:TextBox></td></tr>
           <tr><td>Start Time:</td><td><asp:TextBox ID="tb_startofday" runat="server"></asp:TextBox></td></tr>
            <tr><td>End Time:</td><td><asp:TextBox ID="tb_endofday" runat="server"></asp:TextBox></td></tr>
        </table>

        <br /><asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" /><br /><hr />
        <table>
        <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
            </table>
    </form>
</body>
</html>
