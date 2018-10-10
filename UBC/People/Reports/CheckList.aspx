<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="CheckList.aspx.cs" Inherits="UBC.People.Reports.CheckList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="table">
        <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
    </table>
</asp:Content>
