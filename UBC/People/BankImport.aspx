<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="BankImport.aspx.cs" Inherits="UBC.People.BankImport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />
   
    <link href="Dependencies/UBC.css" rel="stylesheet" />

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


    <script>


        $(document).ready(function () {

             $('#menu').click(function () {
                window.location.href = "<%: ResolveUrl("~/default.aspx")%>";
            })
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">

         <div class="toprighticon">
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Bank Transaction Import
        </h1>

        <div class="form-group">
            <div class="col-sm-4">
                Please upload the bank file
            </div>
            <div class="col-sm-8">
                <asp:FileUpload ID="fu_bankfile" runat="server" />
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-4">
                What format is it
            </div>
            <div class="col-sm-8">
                <asp:DropDownList ID="dd_format" runat="server">
                    <asp:ListItem Selected="True">Kiwibank Friends - Full CSV</asp:ListItem>
                </asp:DropDownList>

            </div>
        </div>


        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>

    </div>

</asp:Content>
