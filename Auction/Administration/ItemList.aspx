<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="ItemList.aspx.cs" Inherits="Auction.Administration.ItemList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
       <style>
          .cycle-slideshow {
            height: 150px;
        }

            .cycle-slideshow img {
                width: auto;
                height: 100%;
            }
    </style>

    <script src="<%: ResolveUrl("~/_Includes/Scripts/cycle2/jquery.cycle2.min.js")%>"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            //$.fn.cycle.defaults.autoSelector = '.slideshow';
        }); //document.ready

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <a href="Item.aspx" class="btn btn-info" role="button">Create</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="default.aspx" class="btn btn-info" role="button">Menu</a><br />
    <table class="table">
        <tr><th>Item</th><th>Seq</th><th>Hide</th><th>Donor(s)</th><th>Images(s)</th></tr>
        <%=html%>
    </table>
<br />
<a href="default.aspx" class="btn btn-info" role="button">Menu</a>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
