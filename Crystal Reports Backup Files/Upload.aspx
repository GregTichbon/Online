<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="UBC.People.Upload" %>

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
    <script src="<%: ResolveUrl("~/Dependencies/jquery.validate.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            $(document).uitooltip({
                position: {
                    my: "right center",
                    at: "left center"
                },
                content: function () {
                    return $(this).prop('title');
                }
            });


            $("#form1").validate();




        });



    </script>
    <style type="text/css">
     
               
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA">
        <div class="toprighticon">
            <input type="button" id="menu" class="btn btn-info" value="MENU" />
        </div>
        <h1>Union Boat Club - Upload
        </h1>
        <div class="form-group">
            <label class="control-label col-sm-5" for="uploadto">Upload to</label>
            <div class="col-sm-7">
                <select id="uploadto" name="uploadto" class="form-control" required>
                    <option></option>
                    <option value="documents">People/Documents</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-5" for="files">File(s)</label>
            <div class="col-sm-7">
                <asp:FileUpload ID="files" name="files" runat="server" AllowMultiple="true" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-5">
            </div>
            <div class="col-sm-7">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Submit" />
            </div>
        </div>

    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
