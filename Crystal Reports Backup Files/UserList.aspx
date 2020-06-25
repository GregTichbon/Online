<%@ Page Title="" Language="C#" MasterPageFile="~/Auction.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="Auction.Administration.UserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script>
            $(document).ready(function () {
                $('.itemsbidon').click(function () {
                    user_ctr = $(this).attr("id").substring(5);
                    $('#dialog_itemsbidon').dialog({
                        modal: true,
                        open: function () {
                            $(this).load('useritemsbidon.aspx?user=' + user_ctr);
                        },
                        width: $(window).width() * .75,
                        height: 500,
                        close: function () {
                            $(this).html('');
                        },
                        closeText: false
                    });
                })
            });
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="dialog_itemsbidon" title="Items Bid on"></div>
    <table class="table">
        <tr><th>Fullname</th><th>Email Address</th><th>Mobile Number</th><th>Password</th><th>Text Notifications</th><th>Items bid on</th></tr> 
          <%=html%>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
</asp:Content>
