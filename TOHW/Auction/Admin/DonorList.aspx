<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="donorlist.aspx.cs" Inherits="TOHW.Auction.Admin.donorlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $.fn.cycle.defaults.autoSelector = '.slideshow';
        }); //document.ready

    </script>
    <style type="text/css">
        <!--
        .mycentered {
            text-align: center;
        }

        .slideshow {
            width: 120px;
            height: 80px;
            margin: auto;
        }

            .slideshow img {
                opacity: 0;
                filter: alpha(opacity=0);
                max-width: 100%;
                max-height: 100%;
            }
        -->
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <a href="donor.aspx">Create</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="default.aspx">Menu</a>
    <table>
        <%=get_donorlist(MapPath("..//images") )%>
    </table>
    <a href="default.aspx">Menu</a>
</asp:Content>
