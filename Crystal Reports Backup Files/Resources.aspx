<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Resources.aspx.cs" Inherits="UBC.People.Resources" %>
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
        <div class="toprighticon">
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Resources
        </h1>
        <p>&nbsp;</p>
  
        <p><a href="https://www.youtube.com/watch?v=cP0bMkApHT0" target="Recources">Video - Tips from an Olympic Coach on how to improve your sculling crew (8/4/2019)</a></p>
        <p><a href="https://www.decentrowing.com/howtostopgrabbingatthecatch.html" target="Recources">Video - How to stop grabbing at the catch (16/2/2019)</a></p>
        <p><a href="https://www.decentrowing.com/listentotherowingstroke.html" target="Recources">Video - Listen to the rowing stroke (15/2/2019)</a></p>
        <p><a href="https://youtu.be/3ODyZKeq4Kkhttps://youtu.be/OpZbV8LyT_c" target="Recources">Video - The mental strength of a rower (8/2/2019)</a></p>
        <p><a href="https://www.youtube.com/watch?v=yKTmtGuxLu0" target="Recources">Video - Improve the Catch in 10 mins (17/1/2019)</a></p>
        <p><a href="https://www.youtube.com/watch?v=1fmZmKsL5eE&feature=youtu.be" target="Recources">Video - Rowing inches (27/11/2018)</a></p>

    </div>
</asp:Content>
