<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="Notify.aspx.cs" Inherits="DataInnovations.MeetingScheduler.Notify" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Dependencies/jquery-2.2.0.min.js"></script>
    <script src="https://cdn.tiny.cloud/1/h8c8vm83eegm7bokpsuicg7w70sce3jm8580mnbfldp7tsxk/tinymce/5/tinymce.min.js" referrerpolicy="origin"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: '.tinymce',
            plugins: "code, paste, lists, advlist",
            menubar: "tools edit format view",
            paste_as_text: true,
            relative_urls: false,
            remove_script_host: false
        });

        $(document).ready(function () {
            $('#<%= fld_meeting.ClientID %>').change(function () {
                showbutton();
            })

            $('#<%= fld_email.ClientID %>').change(function () {
                showbutton();
            })

        });

        function showbutton() {
            if ($('#<%= fld_meeting.ClientID %>').val() != "Please Select" && $('#<%= fld_email.ClientID %>').val() != "Please Select") {
                $('#<%= btn_submit.ClientID %>').show();
            } else {
                $('#<%= btn_submit.ClientID %>').hide();
            }
        }


    </script>
    <style>
        table.blueTable {
            width: 100%;
            border: 1px solid #1C6EA4;
            text-align: left;
            border-collapse: collapse;
        }

            table.blueTable td {
                border: 1px solid #AAAAAA;
                padding: 6px 12px;
                text-align: center;
            }

            table.blueTable tbody td {
                font-size: 13px;
                text-align: left;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table class="blueTable">
            <tr>
                <td style="text-align: right">Meeting</td>
                <td>
                    <asp:DropDownList ID="fld_meeting" runat="server">
                        <asp:ListItem>Please Select</asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="2">Use ||link|| to include the link, it will be displayed as &quot;here&quot; in the body of the email.<br />
                    Also can use ||greeting||, ||title||, ||description||<br />
                    <br />
                    Email messages will not be sent where there is no email subject<br />
                    Txt messages will not be sent where there is no text body.<br />
                    <br />
                    <asp:Literal ID="lit_details" runat="server"></asp:Literal>
                    <br />
                </td>

            </tr>
            <tr>
                <td style="text-align: right">Send from</td>
                <td>
                    <asp:DropDownList ID="fld_email" runat="server">
                        <asp:ListItem>Please Select</asp:ListItem>
                        <asp:ListItem>meetingscheduler@datainn.co.nz</asp:ListItem>
                        <asp:ListItem>info@unionboatclub.co.nz</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    Email addresses used:<br />
                    <a href="mailto:UnionBoatClub@datainn.co.nz">UnionBoatClub@datainn.co.nz</a>&nbsp;
                    <br />
                    <a href="mailto:info@unionboatclub.co.nz">info@unionboatclub.co.nz</a><br />
                    A BCC will also go to these addresses</td>
            </tr>
            <tr>
                <td style="text-align: right">Email Subject:</td>
                <td>
                    <asp:TextBox ID="tb_subject" runat="server" Width="512px">Meeting Scheduler request: ||title||</asp:TextBox><br />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Email Body (HTML):</td>
                <td>
                    <asp:TextBox ID="tb_htmlbody" CssClass="tinymce" runat="server" Height="110px" TextMode="MultiLine" Width="523px">&lt;p&gt;Hi ||greeting||&lt;/p&gt;
&lt;p&gt;Would you please click ||link|| and complete the meeting scheduler grid to indicate your availability for our upcoming meeting.&lt;/p&gt;
&lt;p&gt;Thanks&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;-Greg&lt;/p&gt;</asp:TextBox><br />
                </td>
            </tr>
            <tr style="display: none">
                <td style="text-align: right">Email Body (Text):</td>
                <td>
                    <asp:TextBox ID="tb_textbody" runat="server" Height="110px" TextMode="MultiLine" Width="523px">Hi ||greeting||

Would you please click ||link|| and complete the meeting scheduler grid to indicate your availability for our upcoming meeting.

Thanks


-Greg</asp:TextBox></td>
            </tr>
            <tr>
                <td style="text-align: right">Email Reply-To Address<b /><span class="small">Where not the same as the sending address</span></td>
                <td>
                    <asp:TextBox ID="tb_replyto" runat="server" Width="512px"></asp:TextBox>
                    <br />
                    Not currently used.<br />
                </td>
            </tr>
            <tr>
                <td style="text-align: right">Text Body:</td>
                <td>
                    <asp:TextBox ID="tb_txt" runat="server" Height="82px" TextMode="MultiLine" Width="521px">Hi ||greeting||

Would you please click ||link|| and complete the meeting scheduler grid to indicate your availability for our upcoming meeting.

-Greg</asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="text-align: center">
                    <asp:Button ID="btn_submit" runat="server" Text="Show recipients" OnClick="btn_submit_Click" /></td>
            </tr>
        </table>
        <hr />
        <table class="blueTable">

            <asp:Literal ID="Lit_html" runat="server"></asp:Literal>
        </table>

        <asp:Literal ID="Lit_social" runat="server"></asp:Literal>


    </form>
</body>
</html>
