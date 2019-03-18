<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoMaster.aspx.cs" Inherits="Online.Completed.NoMaster" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Content/bootstrap.min.css")%>" rel="stylesheet" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />
    <link href="<%: ResolveUrl("~/Content/main.css")%>" rel="stylesheet" />


</head>
<body class="container" style="background-color: #FCF7EA">
    <div>
        <form runat="server" id="form1" class="form-horizontal" role="form">
            <asp:Label ID="lbl_body" runat="server" Text=""></asp:Label>
        </form>
    </div>
</body>
</html>
