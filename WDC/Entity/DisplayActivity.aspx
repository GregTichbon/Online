<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DisplayActivity.aspx.cs" Inherits="Online.Entity.DisplayActivity" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Whanganui District Council - Activity Details</title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/main.css")%>" rel="stylesheet" />


    <!-- Javascript -->


</head>
<body>
    <form id="form1" runat="server">
        <asp:Literal ID="lit_data" runat="server"></asp:Literal>
    </form>
</body>
</html>
