<%@ Page validateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="Notify.aspx.cs" Inherits="DataInnovations.MeetingScheduler.Notify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        Meeting CTR:
        <asp:DropDownList ID="fld_meeting" runat="server">
            <asp:ListItem>Please Select</asp:ListItem>
        </asp:DropDownList>
        <br />
        <br />
        Use ||link|| to include the link, it will be displayed as &quot;here&quot; in the body of the email.<br />
        Also can use ||greeting||, ||title||, ||description||<br />
        <br />
        Email messages will not be sent where there is no email subject<br />
        Txt messages will not be sent where there is no text body.<br />
        <br />
        Email Subject:
        <asp:TextBox ID="tb_subject" runat="server" Width="512px">Meeting Scheduler request: ||title||</asp:TextBox><br />
        <br />
        Email Body (HTML):
        <asp:TextBox ID="tb_htmlbody" runat="server" Height="110px" TextMode="MultiLine" Width="523px" >&lt;p&gt;Hi ||greeting||&lt;/p&gt;
&lt;p&gt;Would you please click ||link|| and complete the meeting scheduler grid to indicate your availability for our upcoming meeting.&lt;/p&gt;
&lt;p&gt;Thanks&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;-Greg&lt;/p&gt;</asp:TextBox><br />
 <br />
        Email Body (Text):
        <asp:TextBox ID="tb_textbody" runat="server" Height="110px" TextMode="MultiLine" Width="523px">Hi ||greeting||

Would you please click ||link|| and complete the meeting scheduler grid to indicate your availability for our upcoming meeting.

Thanks


-Greg</asp:TextBox><br />
        <br />
         Email Reply-To Address:
        <asp:TextBox ID="tb_replyto" runat="server" Width="512px">Not currently used</asp:TextBox><br />
        <br />
        Text Body:
        <asp:TextBox ID="tb_txt" runat="server" Height="82px" TextMode="MultiLine" Width="521px">Hi ||greeting||

Would you please click ||link|| and complete the meeting scheduler grid to indicate your availability for our upcoming meeting.

-Greg</asp:TextBox><br />
        <br />

        <asp:Button ID="btn_submit" runat="server" Text="Show recipients" OnClick="btn_submit_Click" /><br />
        <hr />
        <table>
            
            <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
        </table>

                    <asp:Literal ID="Lit_social" runat="server"></asp:Literal>


    </form>
</body>
</html>
