<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="domSaveRestore.aspx.cs" Inherits="Online.TestAndPlay.domSaveRestore" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

       <script type="text/javascript">
           $(document).ready(function () {
               //alert('loaded');
               $("#Button1").click(function () {
                   //alert('append');
                   $("#mydiv").append("<p>Hello</p>");
               });
               $("#Button2").click(function () {


               });
           });
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <input id="Button1" type="button" value="button" />
        <input id="Button2" type="submit" value="button" />
    <div id="mydiv"></div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
