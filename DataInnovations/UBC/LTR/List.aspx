<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="DataInnovations.UBC.LTR.List" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script >
$(document).ready(function(){
   
});
</script>


</head>
<body>
    <form id="form1" runat="server">



        <table border="1">

            <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
        </table>
        <asp:Button ID="btn_submit" runat="server" Text="Send" OnClick="btn_submit_Click" /><br />

    </form>
</body>
</html>
