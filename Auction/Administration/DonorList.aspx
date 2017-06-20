<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="DonorList.aspx.cs" Inherits="Auction.Administration.DonorList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <link href="../_Includes/Scripts/Cycle2/Default.css" rel="stylesheet" />

    <script src="http://www.datainn.co.nz/Javascript/jquery.cycle2/jquery.cycle2.min.js"></script>
    <script src="http://www.datainn.co.nz/Javascript/jquery.cycle2/jquery.cycle2.shuffle.min.js"></script>
    <script src="http://www.datainn.co.nz/Javascript/jquery.cycle2/jquery.cycle2.center.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            //$.fn.cycle.defaults.autoSelector = '.slideshow';
        }); //document.ready

    </script>
    <style type="text/css">
        <!--

        -->
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a href="donor.aspx" class="btn btn-info" role="button">Create</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="default.aspx" class="btn btn-info" role="button">Menu</a><br />
    <table class="table">
        <tr><th>Donor</th><th>Item(s)</th><th>Images(s)</th></tr>
        <%=get_donorlist(MapPath("..//images") )%>
    </table>
<br />
<a href="default.aspx" class="btn btn-info" role="button">Menu</a>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
