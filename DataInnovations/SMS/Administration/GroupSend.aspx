<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupSend.aspx.cs" Inherits="DataInnovations.SMS.Administration.GroupSend" %>

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
        <asp:TextBox ID="tb_message" runat="server" Height="134px" TextMode="MultiLine" Width="874px" OnTextChanged="tb_message_TextChanged">Hi ||greeting||
      </asp:TextBox>
   
       <%=html%>  
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    </form>
</body>
</html>
