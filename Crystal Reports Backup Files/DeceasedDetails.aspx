<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="DeceasedDetails.aspx.cs" Inherits="DataInnovations.YourPassing.DeceasedDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <script src="_Includes/tinymce/js/tinymce/tinymce.min.js"></script>
    <script>
        $(document).ready(function () {
            tinymce.init({ selector: "textarea" });

             $('[data-id="dd_amount"]').change(function () {
                if ($(this).val() == 'Other') {
                    $('[data-id="tb_amount"]').show();
                } else {
                    $('[data-id="tb_amount"]').val('');
                    $('[data-id="tb_amount"]').hide();
                }
            })
        }); //$(document).ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html %>
    <br />
    <hr />
    <br />
    Could do it anonymous or require signon.  If signed on could view/amend previous message and see koha history and status<br />
    <br />
    <table>
        <thead></thead>
        <tbody>
            <tr>
                <td>Amount</td>
                <td>
                    <asp:DropDownList ID="dd_amount" data-id="dd_amount" runat="server">
                        <asp:ListItem Value="20.00">$20.00</asp:ListItem>
                        <asp:ListItem Value="50.00" Selected="True">$50.00</asp:ListItem>
                        <asp:ListItem Value="100.00">$100.00</asp:ListItem>
                        <asp:ListItem Value="Other">Other - Please  state</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="tb_amount" data-id="tb_amount" runat="server" Style="display: none"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Message</td>
                <td>
                    <asp:TextBox ID="tb_message" data-id="tb_message" runat="server" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btn_submit" data-id="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" /></td>
            </tr>
        </tbody>
    </table>
</asp:Content>
