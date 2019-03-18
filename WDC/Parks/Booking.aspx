<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="Online.Parks.Booking" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <script type="text/javascript">

        $(document).ready(function () {

            $("#pagehelp").colorbox({ href: "DirectDebitHelp.html", iframe: true, height: "600", width: "600", overlayClose: false, escKey: false });

            $("#form1").validate();
        }); //document ready

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <a href="http://www.whanganui.govt.nz/our-council/publications/forms/Documents/Parks-Open-Spaces-Application.pdf">http://www.whanganui.govt.nz/our-council/publications/forms/Documents/Parks-Open-Spaces-Application.pdf</a>
    <a id="pagehelp">
        <img id="helpicon" src="http://wdc.whanganui.govt.nz/online/images/question.png" title="Click on me for specific help on this page." /></a>
    <h1>Parks and Open Spaces Booking Application
    </h1>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
