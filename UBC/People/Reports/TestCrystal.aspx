<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestCrystal.aspx.cs" Inherits="UBC.People.Reports.TestCrystal" %>

<%@ Register assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
            <CR:CrystalReportViewer ID="crv_report" runat="server" GroupTreeImagesFolderUrl="" Height="50px" ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="350px" />
        </div>

    </form>
</body>
</html>
