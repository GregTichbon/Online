<%@ Page Title="Union Boat Club - Attendance Matrix" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="AttendanceMatrix.aspx.cs" Inherits="UBC.People.Reports.AttendanceMatrix" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
 <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <link href="<%: ResolveUrl("~/Dependencies/StickyTableCells/jquery.stickytable.min.css")%>" rel="stylesheet" />
    <script src="<%: ResolveUrl("~/Dependencies/StickyTableCells/jquery.stickytable.min.js")%>"></script>

    <style>
        td, th {
            text-align: center;
            vertical-align: middle;
             border: 1px #eee solid;
        }

                            
    </style>

    <script>
        $(document).ready(function () {

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   

        <h1>Union Boat Club - Attendance Matrix
        </h1>

        <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
  

</asp:Content>
