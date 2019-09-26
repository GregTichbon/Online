<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Form.aspx.cs" Inherits="DataInnovations.SMS.Send.Form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
     
        <table>
            <tr>
                <td>Recipient(s)<br />
                    <asp:TextBox ID="tb_mobilenumber" runat="server" Width="691px" Height="134px" TextMode="MultiLine"></asp:TextBox>
                </td>
                <td>Enter data in lines.&nbsp;
                    <br />
                    Use commas to delimit the fields.<br />
                    The first field must be the mobile number.<br />
                    You can refer to the fields by their position
                    <br />
                    eg: ||1|| would include the mobile number in the message</td>
            </tr>
        </table>
        <br />
        <br />
        Message:<br />
        <asp:TextBox ID="tb_message" runat="server" Height="134px" TextMode="MultiLine" Width="691px"></asp:TextBox>
        <br />
        <br />
        Send using:<br />
        <asp:DropDownList ID="dd_mode" runat="server">
            <asp:ListItem Value="Local URL">http://192.168.10.???:8080/?number=???&text=???</asp:ListItem>
            <asp:ListItem Value="office.datainn.co.nz URL">http://office.datainn.co.nz/sms/send?O=S&P=???&M=???</asp:ListItem>
            <asp:ListItem>Generic Function</asp:ListItem>


            
        </asp:DropDownList>
        <br />
        <br />
        <br />
        <asp:Button ID="btn_send" runat="server" OnClick="btn_send_Click" Text="Send" />
     

    </form>
</body>
</html>
