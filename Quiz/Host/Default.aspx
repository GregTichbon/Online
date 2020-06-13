<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Quiz.Host.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <select id="fld_quiz" name="fld_quiz">
            <option value="Test">Test</option>
        </select>
        <asp:Button ID="act_selectquiz" runat="server" Text="Go" OnClick="act_selectquiz_Click" />
    </form>
</body>
</html>
