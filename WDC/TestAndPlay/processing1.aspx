<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="processing1.aspx.cs" Inherits="Online.TestAndPlay.processing1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">

         $(document).ready(function () {
             $("#Button1").click(function () {
                 $("#div_processing").show();
                 alert('Here');
             });
         })
         </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="div_processing" style="display:none"></div>
    <input id="Button1" type="button" value="button" />
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
