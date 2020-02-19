<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RP7Import.aspx.cs" Inherits="DataInnovations.Row.RP7Import" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:FileUpload ID="fu_file" runat="server" />
        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />
    </form>
</body>
</html>
