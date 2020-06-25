<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowAll.aspx.cs" Inherits="TOHW.PhotoHunt11Jun18.ShowAll" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
        <style>
        img {
            width: 22%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Literal ID="Lit_Images" runat="server"></asp:Literal>
        </div>
    </form>
</body>
</html>
