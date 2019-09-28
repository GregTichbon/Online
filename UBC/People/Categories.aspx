<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="UBC.People.Categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>

    <style>
        .notcurrent {color:red;}
    </style>

    <script>
        $(document).ready(function () {

        }) //document.ready
    </script>

</asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="container" style="background-color: #FCF7EA">
            <div class="toprighticon">
            
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - People Categories
        </h1>
            <p>To do:  Options to choose categories and non-current ones to show, option to add category to a person.  Database update.</p>
            <table class="table">
                <thead>
                    <tr>
                        <th>Person</th>
                        <th>Category</th>
                        <th>Start</th>
                        <th>End</th>
                        <th>Note</th>
                        <th>Maintain</th>
                    </tr>
                </thead>
                <tbody><%=html %></tbody>
            </table>
        </div>
    </asp:Content>
