﻿<%@ Page Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="List.aspx.cs" Inherits="UBC.People.List" %>

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


    <script>
        $(document).ready(function () {

        });
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
        <input type="button" id="menu" class="toprighticon btn btn-info" value="MENU" />
        <h1>Union Boat Club - Person Selection
        </h1>

        <h2><a href="maint.aspx?id=new" target="edit">New</a></h2>
        <table class="table">
            <%= html %>
        </table>

    </div>
</asp:Content>

