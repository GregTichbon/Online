<%@ Page Title="" Language="C#" MasterPageFile="~/YourPassing/Main.Master" AutoEventWireup="true" CodeBehind="deceased.aspx.cs" Inherits="DataInnovations.YourPassing.deceased" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="_Includes/tinymce/js/tinymce/tinymce.min.js"></script>
    <script>
        $(document).ready(function () {

            tinymce.init({selector: "textarea"});
  
            $('#btn_support').click(function () {
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
    

    <div id="dialog_support" title="Your support and message" style="display:none">
        Could do it anonymous or require signon.  If signed on could view/amend previous message and see koha history and status<br />
        <table><thead></thead><tbody>
        <tr><td>Amount</td><td><asp:TextBox ID="tb_amount" data-id="tb_amount" runat="server"></asp:TextBox></td></tr>
        <tr><td>Message</td><td><asp:TextBox ID="tb_message" data-id="tb_message" runat="server" TextMode="MultiLine"></asp:TextBox></td></tr>
        <!--<tr><td colspan="2"><asp:Button ID="btn_submit" data-id="btn_submit" runat="server" Text="Submit" /></td></tr>-->
        </tbody></table>
        
    </div>
</asp:Content>
