<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CodeGenerator.aspx.cs" Inherits="Online.Administration.CodeGenerator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "CodeGenerator.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });



        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a id="pagehelp">
        <img id="helpicon" src="../Images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Code Generator
    </h1>


    <asp:DropDownList ID="dd_name" runat="server">
        <asp:ListItem></asp:ListItem>
    </asp:DropDownList>




    <asp:Literal ID="lit_html" runat="server"></asp:Literal>

        <asp:Button ID="btn_createcode" runat="server" Text="Create" OnClick="btn_createcode_click" />   


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
