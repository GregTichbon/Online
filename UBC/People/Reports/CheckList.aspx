<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="CheckList.aspx.cs" Inherits="UBC.People.Reports.CheckList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>

    <style>
        table {
            border-collapse: collapse;
            width: 100%
        }

        th, td {
            border: 1px solid black;
            width: 25%;
            text-align: center;
        }

      @media print
{
  table { page-break-after:auto }
  tr    { page-break-inside:avoid; page-break-after:auto }
  td    { page-break-inside:avoid; page-break-after:auto }
  thead { display:table-header-group }
  tfoot { display:table-footer-group }
}
    </style>

   <script>
       $(document).ready(function () {
           $('.span_name').click(function () {
               id = $(this).attr('id');
               window.open("../maint.aspx?id=" + id, "_ubc_people_maint");

           });

       });

   </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="table">
       <%=html %>
    </table>
</asp:Content>
