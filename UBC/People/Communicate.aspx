<%@ Page validateRequest="false" Title="Union Boat Club Communicate" Language="C#" MasterPageFile="~/UBC.Master" AutoEventWireup="true" CodeBehind="Communicate.aspx.cs" Inherits="UBC.People.Communicate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.fb_clipboard').click(function () {
                link = $(this).data('link');
                //alert(link);
                textarea = $(this).next();
                $(textarea).focus();
                $(textarea).select();
                document.execCommand('copy');

                window.open(link, 'facebook');
                //alert("Copied to clipboard");
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Use ||link|| to include the link, it will be displayed as &quot;here&quot; in the body of the email.<br />
    Also can use ||firstname||, ||caregivername||<br />
    <br />
    Email messages will not be sent where there is no email subject<br />
    Txt messages will not be sent where there is no text body.<br />
    <br />
    Email Subject:<br />
    &nbsp;<asp:TextBox ID="tb_subject" runat="server" Width="512px">Union Boat Club Learn to Row 21 - 23 Sep</asp:TextBox><br />
    <br />
    Email Body (HTML):<br />
    &nbsp;<asp:TextBox ID="tb_htmlbody" runat="server" Height="110px" TextMode="MultiLine" Width="901px">&lt;p&gt;Hi ||firstname||&lt;/p&gt;
&lt;p&gt;Just a reminder of the Learn to Row Weekend this weekend.&lt;/p&gt;&lt;p&gt;For more information, to check and maintain your details,  and to confirm you are coming please go to ||link||.&lt;/p&gt;&lt;p&gt;Thanks&lt;/p&gt;</asp:TextBox><br />
    <br />
    Email/Facebook Body (Text):<br />
    &nbsp;<asp:TextBox ID="tb_textbody" runat="server" Height="110px" TextMode="MultiLine" Width="902px">Hi ||firstname||

Just a reminder of the Learn to Row Weekend this weekend.

For more information, to check and maintain your details,  and to confirm you are coming please go to ||link||.</asp:TextBox><br />
    <br />
    Email Reply-To Address:<br />
    &nbsp;<asp:TextBox ID="tb_replyto" runat="server" Width="512px">Not currently used</asp:TextBox><br />
    <br />
    Text Body:<br />
    &nbsp;<asp:TextBox ID="tb_txt" runat="server" Height="122px" TextMode="MultiLine" Width="910px">Hi ||firstname||

Just a reminder of the Learn to Row Weekend this weekend.

For more information, to check and maintain your details,  and to confirm you are coming please go to ||link||.</asp:TextBox><br />
    <br />

    <br />
    <hr />

    <asp:Literal ID="Lit_facebook" runat="server"></asp:Literal>



    <table border="1">

        <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
    </table>
    <asp:Button ID="btn_submit" runat="server" Text="Send" OnClick="btn_submit_Click" /><br />
</asp:Content>
