<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Communicate.aspx.cs" Inherits="DataInnovations.Raffles.Communicate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="<%: ResolveUrl("~/Dependencies/jquery-2.2.0.min.js")%>"></script>

    <script>
        $(document).ready(function () {
            $('#cb_toggleall').click(function (event) {
                if (this.checked) {
                    // Iterate each checkbox
                    $('.checkbox').each(function () {
                        this.checked = true;
                    });
                } else {
                    $('.checkbox').each(function () {
                        this.checked = false;
                    });
                }
            });
        });
    </script>


</head>
<body>

    <form id="form1" runat="server">
        <br />
        <br />
        <br />
        <br />
        <asp:TextBox ID="tb_message" runat="server" Height="134px" TextMode="MultiLine" Width="874px">Hi ||greeting||


As a reminder: you have ticket number: ||ticketnumber||</asp:TextBox>
        <table>
            <%=html %>
        </table>
        <asp:Button ID="btn_submit" runat="server" Text="Send" OnClick="btn_submit_Click" />
    </form>
</body>
</html>
