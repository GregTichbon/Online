<%@ Page Title="Union Boat Club - Current Categories Matrix" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="CurrentCategoriesMatrix.aspx.cs" Inherits="UBC.People.Reports.CurrentCategoriesMatrix" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   
 <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>



    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <link href="<%: ResolveUrl("~/Dependencies/StickyTableCells/jquery.stickytable.css")%>" rel="stylesheet" />
    <script src="<%: ResolveUrl("~/Dependencies/StickyTableCells/jquery.stickytable.js")%>"></script>

    <style>
        td, th {
            text-align: center;
            vertical-align: middle;
             border: 1px #eee solid;
        }
        .me {
            background-color:chartreuse;
        }
        .selectedrow, .selectedcol {
            background-color:orange;

        }
                            
    </style>

    <script>
        $(document).ready(function () {

            $('td').click(function () {
                $(this).parent().toggleClass('selectedrow');
            })
            $('th').click(function () {
                var pattern = /c[0-9]*/;
                thisclass = $(this).attr('class');
                thisclass = thisclass.match(pattern);
                $('.' + thisclass).toggleClass('selectedcol');
            })

        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="button" id="menu" class="toprighticon btn btn-info" value="MENU" /> 

        <h1>Union Boat Club - Current Categories Matrix
        </h1>

        <%= html%>
</asp:Content>
