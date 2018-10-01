<%@ Page Title="Union Boat Club - Event" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Event.aspx.cs" Inherits="UBC.People.Event" %>

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
            $('#cb_allday').change(function () {
                if ($(this).is(":checked")) {
                    $('.usetime').text('');
                } else {
                    $('.usetime').text('/time');
                }
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color:#FCF7EA">
     
        <h1>Union Boat Club - Event
        </h1>

        
        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_title">Title</label>
            <div class="col-sm-8">
                <input id="tb_title" name="tb_title" type="text" class="form-control" value="<%: title %>" maxlength="20" />
            </div>
        </div>

       <div class="form-group">
            <label class="control-label col-sm-4" for="cb_allday">All day</label>
            <div class="col-sm-8">
                <input id="cb_allday" name="cb_allday" type="checkbox" style="width:auto" value="Yes" <%:allday_checked %>class="form-control" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_startdatetime">Start date<span class="usetime"><%:datetime %></span></label>
            <div class="col-sm-8">
                <input id="tb_startdatetime" name="tb_startdatetime" type="text" class="form-control" value="<%: startdatetime %>" maxlength="20" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_enddatetime">End date<span class="usetime"><%:datetime %></span></label>
            <div class="col-sm-8">
                <input id="tb_enddatetime" name="tb_enddatetime" type="text" class="form-control" value="<%: enddatetime %>" maxlength="20" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-4" for="tb_description">Description</label>
            <div class="col-sm-8">
                <textarea id="tb_description" name="tb_description" class="form-control"><%: description %></textarea>
            </div>
        </div>

      
       

        <table class="table table-hover">
            <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
        </table>


        <asp:Button ID="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" />

    </div>


</asp:Content>
