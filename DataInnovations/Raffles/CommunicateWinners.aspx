<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CommunicateWinners.aspx.cs" Inherits="DataInnovations.Raffles.CommunicateWinners" %>

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
Your ticket, number ||ticketnumber||, is a winner in the Union Boat Club rowing raffle.
Please go to: http://office.datainn.co.nz/raffles/ubc2019awinner.aspx?id=||guid|| to claim your prize or contact Greg on (027) 2495088.</asp:TextBox>
        <table style="width:100%">
            <%=html %>
        </table>
        <asp:Button ID="btn_submit" runat="server" Text="Send" OnClick="btn_submit_Click" />
    </form>
</body>
</html>

