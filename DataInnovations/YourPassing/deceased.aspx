<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="deceased.aspx.cs" Inherits="DataInnovations.YourPassing.deceased" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(document).ready(function () {


            $('#btn_message').click(function () {
                $('#dialog_message').dialog({
                    modal: true,
                    width: $(window).width() * .5,
                    height: 600,
                    position: { my: "top", at: "centre top" }
                });
            });

            $('#btn_support').click(function () {
                $('#dialog_support').dialog({
                    modal: true,
                    width: $(window).width() * .5,
                    height: 600,
                    position: { my: "top", at: "centre top" }
                });
            });

        }); //$(document).ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html %>
    <div id="dialog_message" style="display: none">
        Enter a message with photos if they have been allowed<br />
        <br />
        Could do it anonymous or require signon.  If signed on could view/amend previous message and see koha history and status<br />
        <br />
        Offer option to support again<br />
        <br />
        On confirmation that message has been submitted, Offer option to support again<br />
        <br />
        Messages are moderated, ie: the agent must authorise
        

    </div>

    <div id="dialog_support" style="display: none">
        Could do it anonymous or require signon.  If signed on could view/amend previous message and see koha history and status<br />
        <br />
        Ask amount<br />
        <br />
        Perhaps ask for message again
    </div>
</asp:Content>
