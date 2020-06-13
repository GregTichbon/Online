<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="deceased.aspx.cs" Inherits="DataInnovations.YourPassing.deceased" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src='//cdn.tinymce.com/4/tinymce.min.js'></script>
    <script>
        $(document).ready(function () {

            tinymce.init({selector: "textarea"});
  
            $('#btn_support').click(function () {
            //$('body').on('click', '#btn_support', function() {
                $('#dialog_support').dialog({
                    modal: true,
                    width: $(window).width() * .8,
                    height: 500,
                    position: { my: "top+50", at: "centre top" },
                    buttons: [
                        {
                            text: "Submit",
                            click: function () {
                                alert('to do: save to database, go to Payment Express processing.')
                                $(this).dialog("close");
                            }
                        }
                    ]
                });
            });

            $('[data-id="dd_amount"]').change(function () {
                if ($(this).val() == 'Other') {
                    alert(1);
                    $('[data-id="tb_amount"]').show();
                } else {
                    $('[data-id="tb_amount"]').val('');
                    $('[data-id="tb_amount"]').hide();
                }
            })
            /*
               $('[data-id="btn_submit"]').click(function () {
                   alert('to do Update');
            });
            */


        }); //$(document).ready
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%=html %>
    <%string none = "none"; %>
    

    <div id="dialog_support" title="Your support and message" style="display:<%=none%>">
        Could do it anonymous or require signon.  If signed on could view/amend previous message and see koha history and status<br />
        <table><thead></thead><tbody>
        <tr><td>Amount</td><td>
            <asp:DropDownList ID="dd_amount" data-id="dd_amount" runat="server">
                <asp:ListItem Value="20.00">$20.00</asp:ListItem>
                <asp:ListItem Value="50.00" Selected="True">$50.00</asp:ListItem>
                <asp:ListItem Value="100.00">$100.00</asp:ListItem>
                 <asp:ListItem Value="Other">Other - Please  state</asp:ListItem>
           </asp:DropDownList>
        <asp:TextBox ID="tb_amount" data-id="tb_amount" runat="server" style="display:none" ></asp:TextBox>


                           </td></tr>
        <tr><td>Message</td><td><asp:TextBox ID="tb_message" data-id="tb_message" runat="server" TextMode="MultiLine"></asp:TextBox></td></tr>
        <tr><td colspan="2"><asp:Button ID="btn_submit" data-id="btn_submit" runat="server" Text="Submit" OnClick="btn_submit_Click" /></td></tr> 
        </tbody></table>
        
    </div>
</asp:Content>
