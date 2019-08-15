﻿<%@ Page Title="" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="MastersCommunicate.aspx.cs" Inherits="UBC.People.MastersCommunicate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Style Sheets -->
    <link href="<%: ResolveUrl("~/Dependencies/bootstrap.min.css")%>" rel="stylesheet" />
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css" rel="stylesheet" />


    <!-- Javascript -->
    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

    <script type="text/javascript">
        // Change JQueryUI plugin names to fix name collision with Bootstrap.
        $.widget.bridge('uitooltip', $.ui.tooltip);
        $.widget.bridge('uibutton', $.ui.button);
    </script>

    <script src="<%: ResolveUrl("~/Dependencies/bootstrap.min.js")%>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js"></script>

    <script>

        $(document).ready(function () {
           

        });

        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="background-color: #FCF7EA; width: 100%">
        <input type="button" id="menu" class="toprighticon btn btn-info" value="MENU" />Use ||link|| to include the link, it will be displayed as &quot;here&quot; in the body of the email.<br />
                    Also can use ||firstname||<br />
                    <br />
                    Email messages will not be sent where there is no email subject<br />
                    Txt messages will not be sent where there is no text body.<br />
                    <br />
                    Email Reply-To Address:<br />
                    &nbsp;<asp:TextBox ID="tb_replyto" runat="server" Width="512px">Not currently used</asp:TextBox><br />
                    <br />
                    Email Subject:<br />
                    &nbsp;<asp:TextBox ID="tb_subject" runat="server" Width="512px">Union Boat Club  </asp:TextBox><br />
                    <br />
                    Email Body (HTML):<br />
                    &nbsp;<asp:TextBox ID="tb_htmlbody" runat="server" Height="110px" TextMode="MultiLine" Width="901px">&lt;p&gt;Hi ||firstname||&lt;/p&gt;
&lt;p&gt;
&lt;/p&gt;</asp:TextBox><br />
                    &nbsp;<br />

                    <br />
                    Mobile
                    Text Body:<br />
                    &nbsp;<asp:TextBox ID="tb_txt" runat="server" Height="122px" TextMode="MultiLine" Width="910px">Hi ||firstname||</asp:TextBox>

        <br />
        <br />

        <br />
        <hr />

     




       


        <table class="table table-hover">

            <%=html %>
        </table>
        <div class="form-group">
            <div class="col-sm-4">
            </div>
            <div class="col-sm-8">
                <asp:Button ID="btn_submit" runat="server" OnClick="btn_submit_Click" class="btn btn-info" Text="Send" />
            </div>
        </div>
        <br />
    </div>
</asp:Content>