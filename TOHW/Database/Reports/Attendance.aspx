<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="TOHW.Database.Reports.Attendance1" %>

<%@ Register assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        From Date&nbsp;
        <asp:TextBox ID="tb_fromdate" runat="server"></asp:TextBox>
        <br />
        To Date&nbsp;
        <asp:TextBox ID="tb_todate" runat="server"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
        <CR:CrystalReportViewer ID="crv_report" runat="server" AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="50px" ToolbarImagesFolderUrl="" ToolPanelView="None" ToolPanelWidth="200px" Width="350px" />


    </form>
</body>
</html>