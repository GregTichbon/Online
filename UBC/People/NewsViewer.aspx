﻿<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="NewsViewer.aspx.cs" Inherits="UBC.People.NewsViewer" %>
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
            $('.title').tooltip({
                content: function () {
                    var element = $(this);
                    return element.attr("title");
                }
            });
            $('#login').click(function () {
                window.location.href = "<%: ResolveUrl("security/login.aspx")%>";
            })
            $('#menu').click(function () {
                window.location.href = "<%: ResolveUrl("default.aspx")%>";
            })
            $("#accordion").accordion({
                collapsible: true,
                active: false,
                heightStyle: "content"
            });

        }); //document.ready
   
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
        <%=html_button %>
        <h1>Union Boat Club - News
        </h1>
        <div id="accordion">
        <!--<table class="table">-->
            <%=html %>
        <!--</table>-->
            </div>
    </div>
</asp:Content>
