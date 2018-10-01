<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="UBC.People.Search" %>

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

            $("#name").autocomplete({
                source: "../data.asmx/person_name_autocomplete",
                minLength: 2,
                select: function (event, ui) {
                    //event.preventDefault();
                    selected = ui.item;
                    //alert(selected.guid);
                    window.open("maint.aspx?id=" + selected.guid + "&returnto=search", "_self");
                    /*
                    $("#category").val(selected ?
                        selected.label : "Nothing selected, input was " + this.value);
                        */
                   
                }
            })
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
        <h1>Union Boat Club - Person Search
        </h1>

        <h2><a href="maint.aspx?id=new" target="edit">New</a></h2>

        <div class="form-group">
            <label class="control-label col-sm-4" for="name">Name</label>
            <div class="col-sm-8">
                <input id="name" name="name" type="text" class="form-control" />
            </div>
        </div>
       <br />
        <br />



    </div>
</asp:Content>
