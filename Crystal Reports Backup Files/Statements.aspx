<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Statements.aspx.cs" Inherits="DataInnovations.Accounts.StatementsReport" %>

<%@ Register assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <CR:CrystalReportViewer ID="crv_report" runat="server" AutoDataBind="true" />
    </form>
</body>
</html>
